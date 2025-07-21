import torch
from sympy import symbols, solve 

# Check version
print("PyTorch version:", torch.__version__)

# Check if CUDA or ROCm is available
device = "cuda" if torch.cuda.is_available() else "cpu"
print("Using device:", device)

# Basic tensor operations
a = torch.tensor([1.0, 2.0, 3.0])
b = torch.tensor([4.0, 5.0, 6.0])
c = a + b

print("Tensor addition:", c)

# Move tensor to GPU if available
d = c.to(device)
print("Tensor on device:", d)

