# ROCm-5.4.1 for Fedora 42 

ROCM support for GFX803, Polaris including pytorch 2.0.0 (alpha) for python 3.10.

RX460, RX470, RX480, RX560, RX570, RX580, RX590

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
the pytorch wheel uses version 2.0.0, there is an alternative version "dressed" at "2.1.0" to make some newer ComfyUI branches happy, but it's still
the 2.0.0.


```
rpm --install packages/ROCm-5.4.1-1_private_build.fc42.x86_64.rpm 
/usr/bin/python3.10 -m pip install
/usr/bin/python3.10 -m venv venv
source venv/bin/activate
pip install packages/torch-2.0-cp310-cp310-linux_x86_64.whl
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


## ComfyUI (using this build, 2.1 cheat wheel)

We'll use the pytorch-2.1 (cheat wheel, its actually 2.0) to fool ComfyUI to accept our build. Download ComfuUI and let the system download lots of stuff, which will be compatible with our build, and then tweak it to make ComfyUI happy. This install method is really slow and download a some GB to much, but its the safe and easy way to get ComfyUI running:

```
git clone ComfyUI.git
cd ComfyUI
git checkout -b heads/v0.1.3
pip install -r requirements.txt 
pip install torchvision==0.15.1+rocm5.4.2 --extra-index-url https://download.pytorch.org/whl
pip install ../packages/torch-2.1-cp310-cp310-linux_x86_64.whl
pip install spandrel==0.4.1 --no-deps
```

It might complain against various issues, mostly that spandrel was compiled for torch 2.0.0 but you installed 2.1.0, but since this is a cheat wheel and actually compiled with 2.0.0, it's ok. Now please download tensor model from somewhere and place into \models and when 
your ready launch ComfyUI:

```
python main.py
```

Open a webbrowser and use the url http://127.0.0.1:8188


## TODOs

In prioritized order:

* Compile real pytorch 2.1 (for ComfyUI) and drop the cheat wheel
* Use a newer ComfyUI branch
* Compile torchvision
* Compile torchaudio and include this into packages directory.
* Would be nice to get A1111 running aswell
* Get the scripts to compile correctly

## Compiling

Not yet .. you can see my build scripts in the /scripts folder but its, but bascially it was build using gcc-14 and I experienced 
dozon of issues, 99% of those were compiler warnings. I'll try to see if I can find some time to make it happen. I few places I properly has to change a few lines of 
code because the rules changed from warnings to hard-errors that needed to be fixed.




