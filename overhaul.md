# Complete overhaul

Make sure you have give:
    * Atleast 50G to `/`
    * Atleast 2G to `boot`
    * Atleast 20G to `swap`
## CUDA
1. Follow `.deb` file procedure for installation on CUDA website. The `runfile` option doesn't work well.
2. 

## TeX Live
1. `sudo apt-get install texlive`
2. If for some reason you cannot install packages with `tlmgr`, use: 
```
sudo tlmgr option repository ftp://tug.org/historic/systems/texlive/2017/tlnet-final
```
to go back to add an old repository.
3. Make sure you check the HEAD package on CTAN, in case a package installation fails.

## Python with Anaconda3
1. Install Python with `anaconda` using the `sh` file by running:
```
chmod +x
./Anaconda3-<version>.sh
```
2. If for some reason you need to install again, delete `~/.conda/` before setting a new environment.

