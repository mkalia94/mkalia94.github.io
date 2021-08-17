---
layout: default
permalink: /LargeFiles/
---

# Pushing large files on GitHub

A friend encountered the following problem: What if you push a very large file (>100M) and Git throws an error (Large simulation much)? This error often propagates even if you delete the big file. `cd` into the relevant folder and run:
```bash
sudo du -ahx -d 1 . | sort -rh | head -20
```
This gives a list of all large files present in the folder, in descending order. The solution is to delete the local commit history of the file and push again. Note the file name, and run:
```bash
git filter-branch --index-filter 'git rm -r --cached --ignore-unmatch [FILENAME]' HEAD
```
