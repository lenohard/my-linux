
/* ------------------BEGIN------------------------------ */
 ==> Git
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

/* ==================END================================ */
