# Linux (Ubuntu) and NVIDIA GPU support

If you want to use `tensorflow-gpu`, `Flux.jl` or any other library that benefits from GPU parallelisation, then you need to setup:

1. Appropriate NVIDIA drivers
2. CUDA
3. cuDNN

## Step 1: Installing appropriate drivers

In Linux Mint the appropriate NVIDIA drivers can be hard to determine, as the latest drivers on the NVIDIA website may not necessarily be the most ideal ones, a fact accepted by NVIDIA themselves in the Additional Information section when trying to download drivers [here](https://www.nvidia.com/Download/index.aspx?lang=en-us).

A foolproof method is as follows:

* Fire up the terminal and run `sudo add-apt-repository ppa:graphics-drivers/ppa` followed by `sudo apt-get update`. This allows the system to search for the latest drivers.
* Then run `ubuntu-drivers devices`. The output should mention your graphic card and the recommended driver.
* Install the driver by running `sudo apt-get install nvidia-driver-xxx nvidia-settings nvidia-prime` where `xxx` is the driver number recommended in the previous step. In my case this was `nvidia-driver-410` (ASUS GX531 running RTX 2070, as of April 01, 2019).
* Reboot, if you're able to log in, run `nvidia-smi` in the terminal. If the output mentions the GPU ands the driver you installed, you are done!
    * If you enter a black screen on reboot, press `Ctrl+Shift+F2` to fire up `tty`. Use your login credentials and type 
    `sudo apt-get remove --purge nvidia*` followed by `sudo apt-get install --reinstall xorg xserver-xorg`.
    * Running `reboot` restarts the computer and you should be back to the integrated drivers. Repeat driver installation steps,      but this time with different (lower) driver numbers. For example, the recommended driver for RTX 2070 is 418, but I could only     get 410 to work, which is still compatible with CUDA 10.

**ISSUES:** Although this method always works, it has multiple disadvantages. Firstly, the CUDA installation in the next step can mess up the drivers again. Secondly, the drivers that do work are always outdated. Updating them as you update CUDA and cuDNN can lead to clashes as well.

## Step 2: Install CUDA

Check the appropriate CUDA version for the driver installed in `Step 1` [here](https://docs.nvidia.com/deploy/cuda-compatibility/index.html). Follow the instructions to install from [the CUDA website](https://developer.nvidia.com/cuda-10.0-download-archive).

## Step 3: Install cuDNN
Get cuDNN from [here](https://developer.nvidia.com/cudnn) and follow the installation instructions.

## Final step: Get GPU dependent packages working!

I use `Flux.jl` (julia) and `tensorflow` (python) for GPU-related tasks. Both these packages rely on a proper CUDA installation. In my experience, installing `tensorflow` from [conda](https://docs.conda.io/en/latest/miniconda.html) ensures proper CUDA installation for python. 

You can now check if CUDA works on these two packages.

### 1. Tensorflow
Check using the following code
```python
from tensorflow.python.client import device_lib
print(device_lib.list_local_devices())
```
### 2. Julia
Check with `CUDAnative` and `CuArrays` by first installing with
```julia
import Pkg
Pkg.Add("CUDAnative")
Pkg.Add("CuArrays")
```
and then running
```julia
] test CuArrays
```

