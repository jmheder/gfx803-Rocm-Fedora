# Changelog

Changelog for https://github.com/jmheder/gfx803-Rocm-Fedora

## Fedora 42:

18-07-2025 - 23-07-2025 

* Initial commits
* Added compiler scripts and readme
* ROCm for Fedora 42 build (ROCM 5.4.1, GFX803) rpm 
* Compile pytorch 2.0.0 (alpha) wheel created (one 2.0.0, one cheat 2.1.0)
* Pytorch repository : https://github.com/ROCm/pytorch, branch "rocm_upgrade_CI_5.4"
* Demos created to verify ROCm platform
* Verified against ComfyUI v0.1.3
* Added changelog
* Tagged Fedora42-ROCM5.4.1-Pytorch2.1.cheat-ComfyUI-v0.1.3

23-07-2025 

* Pytorch 2.1 wheel created
* Pytorch repository : https://github.com/ROCm/pytorch, branch "2.1_rocm5.2"
* Verified against ComfyUI master (newest)
* Rename the wheels, wheels have a "custom-gfx803" in it's name, for easy installtion with --extra-url
* torchaudio 1.0.6+custom for this ROCm platform build
* hipSOLVER included into ROCm build (was missing) - not included in RPM yet
* torchvision compiled with GPU support
* torchaudio compiled for CPU only (atleast for now), too many cmake issues
* Dropped the 2.0 python wheel
* Tagged Fedora42-ROCM5.4.1-Pytorch2.1.ComfyUI-v0.3.45
