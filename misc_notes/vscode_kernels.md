After updating Julia locally I could not start a Julia kernel in Jupyter notebooks. The problem was that vscode did not know the updated path for the Julia binary.

To debug this I changed the path in `kernel.json` in

```
~/Library/Jupyter/kernels/julia-1.9
```

Normally, adding Julia kernels should work with 

```
]add IJulia
]build IJulia
```

The second command creates a new directory `~/Library/Jupyter/kernels/julia-{VERSION}` if adding a kernel for a new version of Julia. Might need to restart VSCode to see the latest kernels.

This base path is where the `R` kernel for `.ipynb`s are as well. They seem separate from where Python kernels are in various environments (in my case `pyenv virtualenvs`).