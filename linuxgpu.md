# Linux (Ubuntu) and NVIDIA GPU support

If you want to use `tensorflow-gpu`, `Flux.jl` or any other library that benefits from GPU parallelisation, then you need to setup:

1. Appropriate NVIDIA drivers
2. CUDA
3. cuDNN

## Step 1: Installing appropriate drivers

In Linux Mint the appropriate NVIDIA drivers can be hard to determine, as the latest drivers on the NVIDIA website may not necessarily be the most ideal ones, a fact accepted by NVIDIA themselves in the Additional Information section when trying to download drivers [here](https://www.nvidia.com/Download/index.aspx?lang=en-us).

A foolproof method is as follows:

1. FIre up the terminal and run `sudo add-apt-repository ppa:graphics-drivers/ppa` followed by `sudo apt-get update`. This allows the system to search for the latest drivers.
2. Then run `ubuntu-drivers devices`. The output should mention your graphic card and the recommended driver.
3. Install the driver by running `sudo apt-get install nvidia-driver-xxx nvidia-settings nvidia-prime` where `xxx` is the driver number recommended in the previous step. In my case this was `nvidia-driver-410` (ASUS GX531 running RTX 2070, as of April 01, 2019).
4. Reboot, if you're able to log in, run `nvidia-smi` in the terminal. If the output mentions the GPU ands the driver you installed, you are done!
5. If you enter a black screen on reboot, press `Ctrl+Shift+F2` to fire up `tty`. Use your login credentials and type 
`sudop apt-get remove --purge nvidia*` followed by `sudo apt-get install --reinstall xorg xserver-xorg`.
6. Running `reboot` restarts the computer and you should be back to the integrated drivers. Repeat steps 3 and 4 with different (lower) driver numberstill it works. For example, the recommended driver for RTX 2070 is 418, but I could only get 410 to work, which is still compatible with CUDA 10.

*ISSUES:* Although this method always works, it has multiple disadvantages. Firstly, the CUDA installation in the next step can mess up the drivers again. Secondly, the drivers that do work are always outdated. Updating them as you update CUDA and cuDNN can lead to clashes as well.

## Step 2:
