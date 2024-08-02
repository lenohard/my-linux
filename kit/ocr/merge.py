#!/usr/bin/env python3

import os
import subprocess
import sys
import shutil

def run_command(command):
    result = subprocess.run(command, shell=True, capture_output=True, text=True)
    if result.returncode != 0:
        print(f"Error running command: {command}\n{result.stderr}")
        sys.exit(1)
    return result.stdout

def handle_djvu(file_path):
    run_command('ocr.py djvu')
    run_command(f'djvused "{file_path}" -e "set-outline tmp" -s')
    dest_dir = os.path.expanduser('~/Greek/Front/galileo/BooksWithContentsByOCR')
    shutil.copy(file_path, dest_dir)
    if os.uname().sysname == 'Darwin':
        subprocess.run(['open', os.path.join(dest_dir, os.path.basename(file_path))])

def handle_pdf(file_path):
    run_command('ocr.py pdf')
    name, _ = os.path.splitext(file_path)
    run_command(f'pdftk "{file_path}" dump_data output "{name}.info"')
    run_command(f'gawk \'/BookmarkBegin/,/BookmarkPageNumber/\' "{name}.info" > original.bm')
    run_command(f'gawk \'!/Bookmark/\' "{name}.info" > tmp && mv tmp "{name}.info"')

    if os.path.exists('tmp.bm'):
        answer = input("Do you want to merge the original bookmarks into the scanned bookmarks? (y/n)[n]: ").strip().lower()
        if answer == 'y':
            with open('original.bm', 'r') as original_bm, open('tmp.bm', 'r') as tmp_bm, open('tmp.bm.new', 'w') as tmp_bm_new:
                tmp_bm_new.write(original_bm.read())
                tmp_bm_new.write(tmp_bm.read())
            shutil.move('tmp.bm.new', 'tmp.bm')

    with open(f'{name}.info', 'r') as info_file:
        content = info_file.readlines()

    with open(f'tmp.info', 'w') as tmp_info:
        for line in content:
            tmp_info.write(line)
            if 'NumberOf' in line:
                with open('tmp.bm', 'r') as tmp_bm:
                    tmp_info.write(tmp_bm.read())

    run_command(f'pdftk "{file_path}" update_info tmp.info output "{name}_ocr.pdf"')
    dest_dir = os.path.expanduser('~/Greek/Front/galileo/BooksWithContentsByOCR')
    shutil.copy(f'{name}_ocr.pdf', dest_dir)
    if os.uname().sysname == 'Darwin':
        subprocess.run(['open', os.path.join(dest_dir, f'{name}_ocr.pdf')])

def main():
    if len(sys.argv) < 2:
        print("Usage: script.py <file_path>")
        sys.exit(1)

    file_path = sys.argv[1]

    if not os.path.exists(file_path):
        print(f"File not found: {file_path}")
        sys.exit(1)

    file_type = run_command(f'file "{file_path}"')

    if 'DjVu' in file_type:
        handle_djvu(file_path)
    else:
        handle_pdf(file_path)

if __name__ == "__main__":
    main()
