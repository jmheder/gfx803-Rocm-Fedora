# Changelog

Changelog for https://github.com/jmheder/gfx803-Rocm-Fedora

## Fedora 42:

18-07-2025 - 23-07-2025 

* Initial commits
* Added compiler scripts and readme
* ROCm for Fedora 42 build (ROCM 5.4.1, GFX803) rpm 
* Compile pytorch 2.0.0 (alpha) wheel created (one 2.0.0, one cheat 2.1.0)
* Pytorch repository : https://github.com/ROCm/pytorch, branch "rocm_upgrade_CI_5.4"
* 2.0 wheel compiled against numpy < 2.0
* 2.1 cheat wheel compiled against numpy > 2.0
* Demos created to verify ROCm platform
* Verified against ComfyUI v0.1.3
* Added changelog
* Tagged Fedora42-ROCM5.4.1-Pytorch2.1.cheat-ComfyUI-v0.1.3

23-07-2025 -

* Pytorch 2.1 wheel created (compiled against numpy < 2.0, GCC-14, cmake3)
* Pytorch repository : https://github.com/ROCm/pytorch, branch "2.1_rocm5.2"
* Verified against ComfyUI master (newest)

