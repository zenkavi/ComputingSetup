
To install a specific version of a package from homebrew is not always straighforward. This post was particularly helpful.

https://remarkablemark.org/blog/2017/02/03/install-brew-package-version/  

Used this specifically for R version 4.2.0 because the `MASS` package, a dependency of `tidyverse` does not build on 4.3.1 (which is the current most recent release). This post suggested that support for older type definitions used in `MASS` was deprecated in the `R.h`.   

https://stackoverflow.com/questions/76469848/compilation-error-building-archive-version-of-mass-on-macos

So I installed the most recent version I thought all the packages I use would work on. 

The Cask I used to install R 4.2.0 is from this commit:

https://github.com/Homebrew/homebrew-cask/blob/6372986b9c1539e937f47ac86aea30bbaf803c0b/Casks/r.rb