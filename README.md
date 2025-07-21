# ROCm-5.4.1 for Fedora 42 

ROCM support for GFX803, Polaris including pytorch 2.2 (alpha) for python 3.10.

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

## Installing binaries

There is no garantess my binaries will work on your platform, I'll try to keep mine updated. Before installing you must remove you'r entire
ROCm platform on Fedora 42, as they dont support gfx803, also if your ROCm libraries was used in other programs, you're in trouble, consider
a new gfx card.


1. Remove the ROCm platform (Fedora)

'''
#bash dnf remove rocm* hip*
'''


2. Get the repository 

'''
#bash dnf install git
#bash git clone github://.....
#cd rocm-gfx803
'''



3. Install new ROCm platform 
The new platform is placed into /opt/rocm so you don't get into huge troubles if you my accident installed the newer ROCm again,

'''
#bash rpm --install github-rocm.5.2.1-jmh-private-build.rpm
'''


3. Update your python 3.10 and install pytorch 
We use a local virtual directory and test it (i.e. check if the works ok).

'''
#bash /usr/bin/python3.10 -m pip install
#bash /usr/bin/python3.10 -m venv venv
#bash source venv/bin/activate
#bash 
'''

and check if everything runs .. 

'''
#bash python checkplatform.py
lkjælfgdfgdsgfgfdgsdfgfdgsdfg
'''


4. Finish Up! - Update your platform - PATH

If everything works you can install pytorch globally (if you want) or just keep on justing vitual onces (I do that).
You new pathes must be correct and update the RPM files did NOT do that.

'''
'''

## Complking

Not yet .. you can see my build scripts in the /scripts folder but its, but bascially it was build using gcc-14 and I experienced 
dozon of issues, 99% of those were compiler warnings, keep in mind Fedora never had rocm 5.2 and the proper Fedora to build this on
was approx 38-39. I'll try to see if I can find some time to make it happen. I few places I properly has to change a few lines of 
code because the rules changed from warnings to hard-errors that needed to be fixed.












