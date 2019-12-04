
#/* ------------------BEGIN------------------------------ */
# ==> Git
#This will unstage all files you might have staged with git add:

git reset
#This will revert all local uncommitted changes (should be executed in repo root):

git checkout .
#You can also revert uncommitted changes only to particular file or directory:

git checkout [some_dir|file.txt]
#Yet another way to revert all uncommitted changes (longer to type, but works from any subdirectory):

git reset --hard HEAD
#This will remove all local untracked files, so only git tracked files remain:

git clean -fdx

#list larger files in history
git rev-list --objects --all \
    | git cat-file --batch-check='%(objecttype) %(objectname) %(objectsize) %(rest)' \
    | sed -n 's/^blob //p' \
    | sort --numeric-sort --key=2 \
    | cut -c 1-12,41- \
    | $(command -v gnumfmt || echo numfmt) --field=2 --to=iec-i --suffix=B --padding=7 --round=nearest

#delete ref from history to shrink size
git filter-branch --index-filter 'git rm -r --cached --ignore-unmatch [unwanted_folename_or_folder]' --prune-empty
#/* ==================END================================ */



# ------------------BEGIN------------------------------
 ==>ls
 # with modified time (content change)
 ls -l
 ls -lt
 ls -ltr
 # ctime (ctime is metadata change and content change)
 ls -lc
 ls -ltc
 ls -ltrc
 # atime (latest access time)
 ls -lu
 ls -ltu
 ls -ltur
# last 4 lines
 tail -n 4
# ==================END================================
