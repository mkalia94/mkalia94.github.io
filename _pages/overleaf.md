---
layout: default
permalink: /Overleaf/
---

#  Syncing with Overleaf (free)

Nowadays I collaborate with a few (too many) authors on Overleaf for a new paper I'm struggling to finish. To make matters worse, I have a free Overleaf account. An easy addition to my list of headaches.
The workaround is to be disciplined in pulling and pushing. You don't want to have the following problem,
```
... o ---- o ---- A ---- B  origin/master (upstream work)
                   \
                    C  master (your work)
```
Here, two separate commits `B` and `C` were made on `remote` and `local` branches respectively. The branches have thus 'diverged'. According to [this StackOverflow post](https://stackoverflow.com/a/3278427), you can either rebase or merge the two branches. This didn't work for me.
In the end, I had to ditch my local changes in favour of remote changes. This can be done by executing
```
 git reset --hard origin/master
```
So for next time, I'll be doing the following:
1. Run `git fetch origin` to get all remote changes. Then run `git log origin`. Compare commits with `git log master` (local).
2. If I observe changes in the previous step, I'll run `git pull`.
3. The latest commit must correspond to my supervisor's. Run `git show HASH:main.tex > main_OLD.tex` where `HASH` refers to the commit hash of a relevant old local commit. `HASH` doesn't have to be the whole string, 5-6 characters will do.
4. Get `latexdiff` from [here](https://ctan.org/pkg/latexdiff). Copy it into the local directory if not already present. Run `cp main.tex latexdiff/main.tex && cp main_OLD.tex latexdiff/main_OLD.tex`.
5. Make sure you have Perl installed. Run `cd latexdiff` and then run `latexdiff -t UNDERLINE main_OLD.tex main.tex > main_DIFF.tex`. 
6. Copy back to local directory by running  `cp main_DIFF.tex ../main_DIFF.tex`.
7. Run `pdftex` on this file and you're good to go!

Long workaround, but one headache less..
