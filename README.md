# ROCm-5.4.1 for Fedora 42 

ROCM support for GFX803, Polaris including pytorch 2.1 for python 3.10.

RX460, RX470, RX480, RX560, RX570, RX580, RX590

For historical changes see CHANGELOG.MD

Repository goals : ROCm platform, ComfyUI, OpenCL, DaVinci Resolve

## GFX803

AMD dropped support for Polaris GFX803 chips long ago and those with the cards above are now left alone in the dark. It's about time 
you switch to a newer graphics card, but actually, your card is now slow, it's just old. Take a newer RTX 3050 with approx same performance, 
the only difference, is the 3050 is Nvidia and new. Upgrading to the card with the same performance is waste of money and time.

Due to missing gfx803 support quite a few dockers can be found around and these are always a resource if you're completely out of luck.
I started uding these when I wanted to pytorch for GPU enabled computations. Personally I did'nt like this approch. because building dockers
takes forever. It's fine if your are an end-user, but anything more advanced and dockers might not the right solution.

So getting a ROCm installation was my solution, but none provided a new linux platform with gfx803 support for Fedora. If you're are using Ubuntu 
you can find support here: https://github.com/xuhuisheng/rocm-build, if you'r on Fedora you properly have to stick with me. I have tried my 
best to make a working ROCm library and you can find the files here in this git repo. I have more or less resorted to the same strategy as 
xuhuisheng, but on a Fedora platform. You can choose to download the binaries, or take the journey into compiling, but don't expect it to work 
of the shell, you should willing to spend hours to get the compilation completed. The scripts are not completed, it's a work in progress, the
platform is a custom rocm 5.4.1 and not all libraries are present, but enought to get pytorch and pyvision compiled. You might hit error when 
trying to compile other project that needs ROCm, you'll need to resolve those yourself, my advice is skips all the libraries that is not needed, 
less is good.

## ROCm version

This ROCm version is not a true 5.4.1 but really close, some of my repositories (hip) could not be compiled correctly, so it's more like "5.4.1+"

## Installing binaries

There is no garantess my binaries will work on your platform, I'll try to keep mine updated. Before installing you must remove you'r entire
ROCm platform on Fedora 42, as they dont support gfx803, also if your ROCm libraries was used in other programs, you're in trouble, consider
a new gfx card.

Remove the ROCm platform (Fedora) 42:

```
dnf remove rocm* hip*
```

Get the repository (this will take some time):

```
dnf install git
git clone https://github.com/jmheder/gfx803-Rocm-Fedora.git
cd gfx803-Rocm-Fedora
```


Install re-comiled (old) ROCm platform and pytorch. Rocm is placed into /opt/rocm and pytorch/pyvision into virtual environment. Please note
the pytorch wheel uses version 2.1 there are two version one fake (2.0.0) and one real" to make some newer ComfyUI branches happy. Also
please install the torchvision and torchaudio. Torchaudio is only for getting rid of those annoying errors during startup, and it was
compiled to run only on CPU.


```
rpm --install packages/ROCm-5.4.1-1_private_build.fc42.x86_64.rpm 
/usr/bin/python3.10 -m pip install
/usr/bin/python3.10 -m venv venv
source venv/bin/activate
pip install packages/torch-2.1+custom-cp310-cp310-linux_x86_64.whl
pip install packages/torchvision-0.16.0+custom-cp310-cp310-linux_x86_64.whl
pip install packages/torchaudio-2.1.2+custom-cp310-cp310-linux_x86_64.whl
```

Verify that pytorch is working (matrix values will change):

```
export LD_LIBRARY_PATH=/opt/rocm/lib:/opt/rocm/lib64:/opt/rocm/llvm/lib:/opt/rocm/hip/lib:$LD_LIBRARY_PATH
python demos/checkplatform.py

```

The console should say:

```
ROCm available: 5.4.22802-aaa1e3d8
Is ROCm GPU available? True
Device count: 1
Device name: AMD Radeon RX 480 Graphics
Tensor a:
 tensor([[-1.2463,  0.9105, -1.2239],
        [ 0.5914,  0.1759,  0.1282],
        [-0.2121, -0.0624, -0.9687]], device='cuda:0')
Tensor b:
 tensor([[-0.7422, -0.0970,  0.4978],
        [ 0.1455,  1.5842,  1.7835],
        [ 0.7233, -0.4944,  0.6734]], device='cuda:0')
a + b =
 tensor([[-1.9885,  0.8136, -0.7261],
        [ 0.7369,  1.7601,  1.9118],
        [ 0.5112, -0.5568, -0.2953]], device='cuda:0')
```


## LD LIBRARY PATH update 

If everything works you can install pytorch globally (if you want) or just keep on justing vitual onces (I do that). You need to update LD_LIBRARY_PATH and update the system

```
cp rochip.conf /etc/ld.so.conf.d/
sudo ldconfig
```


## Installing ComfyUI 

```
git clone github.com/comfyanonymous/ComfyUI.git
cd ComfyUI
```

Ensure the requirements.txt file has the following lines, "torch=2.1+custom" and torchvision="0.16.0+custom" and torchaudio=2.1.2+custom

```
pip install -r requirements.txt --extra-index-url ./packages
```

This is a neat trick to install all packages needed for ComfyUI and make system understand that the packages it needs is a custom version inside the ./packages directory.
Download a model from somewhere (i.e huggingface.co/models) and place this into the models\ directory, now your ready to run:


```
python main.py # standard start
python main.py --listen 0.0.0.0 # webserver external access
python main.py --cpu-vae --use-split-cross-attention --force-fp16  # Save VRAM, make larger images by dropping some of the minor stuff onto RAM/CPU
```

If you wish to get rid of the missing torchaudio, you can install the version in the packages directory. Open a webbrowser and use the url http://127.0.0.1:8188


## A1111

A1111 is a really nice and have a easy interface, but it's really had for programmers, its a mightmare, it has too many dependencies too other libraries and is extremely hard to get running correctly. After bruteforce I finally got it working using packages/torch-2.1-cp310-cp310-linux_x86_64.whl. I'm not even sure I can reproduce it. Finding a proper way to install is not going to happen anytime soon.

## Torch versions in directory packages

packages/torch-2.1.cheat-cp310-cp310-linux_x86_64.whl
- This is a python "cheat wheel", it's pytorch 2.0.0 (alpha) build with numpy>2.0, but build version was set to 2.1.0
- Works with ComfyUI v0.1.3

packages/torch-2.1+custom+gfx803-cp310-cp310-linux_x86_64.whl
- This is pytorch 2.1.0 (alpha) build with numpy>2.0
- Works with newest ComfyUI (tested 24-07-2025)

packages/torchvision-0.16.0+custom+gfx803-cp310-cp310-linux_x86_64.whl
packages/torchaudio-2.1.2+custom+gfx803-cp310-cp310-linux_x86_64.whl
- Use with torch-2.1+custom package


## OpenCL

Will crash, it's bugged in comggr library module

If you for any reasons any OpenCL to run correctly, you'll need to set ROC_ENABLE_PRE_VEGA=1, then it should work, also verify this with a call to clinfo.
Please add export ROC_ENABLE_PRE_VEGA=1 to your ~/.bashrc or /etc/profile

```
sudo usermod -aG video,render $USER
export ROC_ENABLE_PRE_VEGA=1 
clinfo
```

## Davinci Resolve

if you need Davinci Resolve (20.1) you'll need to download and install it, it might complain about a missing zlib, but will give you a solution to skip this, do that.
The important for me was to remove some specific old(?) libraries inside resolve, due to platform incompabilities : https://www.reddit.com/r/davinciresolve/comments/1d7cr2w/optresolvebinresolve_symbol_lookup_error/

Dont touch anything within the colorgrading tab, it will crash resolve, I known this is a huge disadvantage and make resolve abit useless, but im trying to fix this.


```
cd /opt/resolve/libs
sudo mkdir disabled-libraries
sudo mv libglib* disabled-libraries
sudo mv libgio* disabled-libraries
sudo mv libgmodule* disabled-libraries
```

## TODOs

In prioritized order:

* Get OpenCL fixed (Davinvi Resolve)
* Do more ROCm testing to verify it is running correctly
* Get the scripts to compile correctly

## Compiling

Not yet .. you can see my build scripts in the /scripts folder but its, but bascially it was build using gcc-14 and I experienced 
dozon of issues, 99% of those were compiler warnings. I'll try to see if I can find some time to make it happen. I few places I properly has to change a few lines of 
code because the rules changed from warnings to hard-errors that needed to be fixed.



