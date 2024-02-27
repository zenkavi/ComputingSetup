After updating Julia locally I could not start a Julia kernel in Jupyter notebooks. The problem was that vscode did not know the updated path for the Julia binary.

To debug this I changed the path in `kernel.json` in

```
~/Library/Jupyter/kernels/julia-1.9
```

This base path is where the `R` kernel for `.ipynb`s are as well. They seem separate from where Python kernels are in various environments (in my case `pyenv virtualenvs`).