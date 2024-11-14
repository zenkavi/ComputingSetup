# Options for virtual env management

I don't like that `conda` (a popular package management system for python) changes the python paths in `{PATH}`. I also don't like the difficulty of installing different versions of Python with it and how it's ability to install from different channels can interfere with dependencies. 

Instead I use `pyenv` and its associated `pyenv-virtualenv` to have the ability to easily install different versions of Python and create virtual environments with adding only one addition to my path.  

Here is a [useful overview](https://stackoverflow.com/questions/41573587/what-is-the-difference-between-venv-pyvenv-pyenv-virtualenv-virtualenvwrappe  
) of different virtual env options.

# Installation

1. Install Homebrew

```zsh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

2. Install pyenv

https://github.com/pyenv/pyenv?tab=readme-ov-file#installation

```zsh
brew update
brew install pyenv
```
3. Set up your shell environment for pyenv; if on MacOS follow instructions for zsh

https://github.com/pyenv/pyenv?tab=readme-ov-file#set-up-your-shell-environment-for-pyenv

```zsh
echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.zshrc
echo '[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.zshrc
echo 'eval "$(pyenv init -)"' >> ~/.zshrc
```

4. Install dependencies for a sane python environment

https://github.com/pyenv/pyenv/wiki#suggested-build-environment

```zsh
xcode-select --install
brew install openssl readline sqlite3 xz zlib tcl-tk
```

5. Add flags for build dependencies in start up script

```zsh
echo 'export LDFLAGS="-L/opt/homebrew/opt/readline/lib -L/opt/homebrew/opt/sqlite/lib -L/opt/homebrew/opt/zlib/lib"' >> ~/.zshrc
echo 'export CPPFLAGS="-I/opt/homebrew/opt/readline/include -I/opt/homebrew/opt/sqlite/include -I/opt/homebrew/opt/zlib/include"' >> ~/.zshrc
echo 'export PATH="/opt/homebrew/opt/sqlite/bin:$PATH"' >> ~/.zshrc
```

6. Install pyenv-virtualenv

https://github.com/pyenv/pyenv-virtualenv  

```zsh
brew install pyenv-virtualenv
echo 'eval "$(pyenv virtualenv-init -)"' >> ~/.zshrc
```

## Installation check

Check that pyenv is in your PATH:  

```zsh
which pyenv
```
should not return an empty string.  

Check that pyenv's shims directory is in your PATH:  

```zsh
echo $PATH | grep --color=auto "$(pyenv root)/shims"
```

Check that python in your session refers to path within pyenv.  

```zsh
which python
```
should return `{HOME}/.pyenv/shims/python`. If this is not the case in a new Terminal window, make sure the start up scripts (e.g. `zshrc` or `z_profile` are loaded with the corect setup commands).

If this is in a VSCode Terminal check `Setting > Extensions > Python` to opt out of 

```json
"python.experiments.optOutFrom": [ 
    "pythonTerminalEnvVarActivation"
    ],
```

Another place to look is `Setting > Features > Terminal`.

# Helpful commands

## Upgrade pyenv

```zsh
brew upgrade pyenv
```

## Install specific python versions

```zsh
pyenv install 3.8.3
```

## Check installed python versions

```zsh
pyenv version
pyenv versions
```

## Check virtualenvs

There are two entries for each virtualenv, and the shorter one is a symlink.

```zsh
pyenv virtualenvs
```

## Create a virtualenv

```zsh
pyenv virtualenv 2.7.10 my-virtual-env-2.7.10
```

## Clone a virtual env

In an active environment, start with 

```zsh
pip freeze > requirements.txt
pyenv virtualenv {PYTHON-VERSION} {VIRTUALENVNAME}
pyenv shell {VIRTUALENVNAME}
pip install -r requirements.txt
```

## Global python version activation

```zsh
pyenv global 3.8.3
```

## Global virtual env activation

```zsh
pyenv global py38
```

## Switch to python version in current session from that point on

```zsh
pyenv shell 3.8.3
```

## Directory specific virtual env activation

This env will always be activated in that path

```zsh
pyenv local py-networkglm
```

## Activate any virtual env from anywhere

```zsh
pyenv activate {VIRTUALENVNAME}
pyenv deactivate
```

