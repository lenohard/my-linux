#!/usr/bin/env python3
# -*- coding: utf-8 -*-
import os,re,sys
from html import unescape

# this script is used to edit the bookmark of pdf or djvu file
# first it would extract the bookmark from the file
# output the bookmark to a tmp file using vim to open and edit it
# after quit vim, it would update the bookmark to the file

# the usage: editBm.py filename.pdf/djvu

# first check the file extension, save 1(pdf) or 2(djvu) into 'fileType'
fileType = 0
if re.search(r'\.pdf$',sys.argv[1]):
    fileType = 1
elif re.search(r'\.djvu?$',sys.argv[1]):
    fileType = 2
else:
    print('the file type is not pdf or djvu')
    exit()

# get the file name without extension
fileName = os.path.splitext(sys.argv[1])[0]
print(fileName)
tempName = 'rebellious'

# extract bookmark from the file
if fileType == 1:
    os.system('pdftk '+sys.argv[1]+' dump_data output '+tempName+'.info')
    # the bookmark is stored in the following way (4 lines for every entry):
    # [ multiple lines of other metadata]
    # BookmarkBegin
    # BookmarkTitle: title
    # BookmarkLevel: level
    # BookmarkPageNumber: page number
    # [ other similar entries]
    # [ multiple lines of other metadata]
    # extract the title and page number for all the entries
    # and save them into a array [[title, page number, level],...]
    bmArray = []
    with open(tempName+'.info','r') as f:
        for line in f:
            if re.search(r'^BookmarkTitle:',line):
                titleRegex = re.compile(r'^BookmarkTitle: (.*)$')
                title = unescape(titleRegex.search(line).group(1)) # unescape the html entities
            elif re.search(r'^BookmarkLevel:',line):
                levelRegex = re.compile(r'^BookmarkLevel: (.*)$')
                level = levelRegex.search(line).group(1)
            elif re.search(r'^BookmarkPageNumber:',line):
                pageNumRegex = re.compile(r'^BookmarkPageNumber: (.*)$')
                pageNum = pageNumRegex.search(line).group(1)
                bmArray.append([title,pageNum,level])

    # # save the line number where the first bookmark line starts and save it into 'startLine'
    # startLine = 0
    # with open(tempName+'.info','r') as f:
    #     for i,line in enumerate(f):
    #         if re.search(r'^BookmarkBegin',line):
    #             startLine = i
    #             break
    # # delete the lines start with 'Bookmark' from info file using os system cmd util
    # os.system('sed -i "'+str(startLine)+',/Bookmark/d" '+tempName+'.info')


    # write the bookmark array into a tmp file
    with open(tempName+'.tmp','w') as f:
        for entry in bmArray:
            # using level to indent the entry
            # f.write("    "*(entry[2]-1)+entry[0]+',    '+entry[1]+',    '+entry[2]+'\n') to "".format string
            f.write("    "*(int(entry[2])-1)+"{},    {},    {}\n".format(entry[0],entry[1],entry[2]))
elif fileType == 2:
    # the djvu bookmark is stored in the following rescursive way:
    # (bookmarks
    #  ("Front Cover"
    #   "#1" )
    #  ("PREFACE"
    #   "#5" )
    #  ("CHAPTER I  THE SIMPLEST CURVES AND SURFACES"
    #   "#13"
    #   ("subchapter 1"
    #    "#13"
    #    ("subsubchapter 1"
    #     "#13" ) ) )
    # extract the metadata containing the bookmarks into file tempName.info
    os.system('djvused -e "print-outline" '+"'"+sys.argv[1]+"'"+' > '+tempName+'.info')
    # read the file tempName.info and extract the title and page number
    # display them in the following way:
    # title,    page number,    level
    #     subtitle,    page number,    level
    #         subtitle,    page number,    level
    #         subtitle,    page number,    level
    #     subtitle,    page number,    level
    # title,    page number,    level
    # title,    page number,    level
    # which is corresponding to the original tree structure using brackets
    # save the result into tempName.tmp
    with open(tempName+'.info','r') as f:
        counter = 1;
        with open(tempName+'.tmp','w') as g:
            for line in f:
                # every line starting with '(' is a title except the first line '(bookmark
                # the next line is the "#pagenumber" + one or more ')'
                # the level is the number of unclose brackets before the title
                if re.search(r'^\s*\(',line) and not re.search(r'^\s*\(bookmark',line):
                    titleRegex = re.compile(r'^\s*\("(.*)"$')
                    title = titleRegex.search(line).group(1)
                    nextLine = next(f)
                    pageNumRegex = re.compile(r'^\s*"#(.*)".*$')
                    pageNum = pageNumRegex.search(nextLine).group(1)
                    g.write('    '*(counter-1)+title+',    '+pageNum+',    '+str(counter)+'\n')
                    counter = counter - nextLine.count(')') + 1

# open the bookmark file using vim
os.system('vim '+tempName+'.tmp')

# read the bookmark file and update the bookmark to the file
if fileType == 1:
    bmArray = []
    with open(tempName+'.tmp','r') as f:
        for line in f:
            bmArray.append([i.strip() for i in line.split(',   ')]) # extra space incase there is space in the title
    # write the bookmark array into a tmp file
    with open(tempName+'.info2','w') as f:
        # move cursor to the 'startLine' and insert the bookmark lines
        # f.seek(startLine)
        for entry in bmArray:
            f.write('BookmarkBegin\nBookmarkTitle: {}\nBookmarkLevel: {}\nBookmarkPageNumber: {}\n'.format(entry[0],entry[2],entry[1]))
    # update the bookmark to the file
    # ask for confirmation
    if input('update the bookmark to the file? (y/n)') == 'y':
        os.system('pdftk '+sys.argv[1]+' update_info '+tempName+'.info2 output '+fileName+'_bm.pdf')
        print('done')
        # open the file using evince if the os is linux or using open if the os is mac
        if sys.platform == 'linux':
            os.system('evince '+fileName+'_bm.pdf')
        elif sys.platform == 'darwin':
            os.system('open '+fileName+'_bm.pdf')
elif fileType == 2:
    bmArray = []
    with open(tempName+'.tmp','r') as f:
        for line in f:
            bmArray.append([i.strip() for i in line.split(',   ')])
    # write the bookmark array into a tmp file 'tempName.info2'
    with open(tempName+'.info2','w') as f:
        content = "(bookmarks)"
        current = len(content)-1
        cur_level = 0
        for entry in bmArray:
            level = int(entry[2])
            deep = cur_level - level
            before = content[:current+1+deep]
            after = content[current+1+deep:]
            middle = ' ("{0}" "#{1}")'.format(entry[0], entry[1])
            current = current + len(middle) + deep
            content = before + middle + after
            cur_level = level
        f.write(content)
    if input('update the bookmark to the file? (y/n)') == 'y':
        # copy the original file to a new file wih _bm
        os.system("cp '{}' '{}'".format(sys.argv[1], fileName+'_bm.djvu'))
        os.system("djvused '{}' -e 'set-outline {}' -s".format( fileName+'_bm.djvu', tempName+'.info2'))
        print('done')
        if sys.platform == 'linux':
            os.system("evince '{}'".format(fileName+"_bm.djvu"))
        elif sys.platform == 'darwin':
            os.system("open '{}'".format(fileName+"_bm.djvu"))

# delete the info file
os.system('rm '+tempName+'.info')
# delete the tmp file
os.system('rm '+tempName+'.tmp')
#delete the info2 file
os.system('rm '+tempName+'.info2')
