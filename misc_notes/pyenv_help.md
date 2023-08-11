Useful overview of different virtual env options
https://stackoverflow.com/questions/41573587/what-is-the-difference-between-venv-pyvenv-pyenv-virtualenv-virtualenvwrappe


##################
# To upgrade pyenv
##################
brew upgrade pyenv

##################
# Install specific python versions
##################
pyenv install 3.8.3

##################
# Check installed python versions
##################
pyenv version
pyenv versions

##################
# There are two entries for each virtualenv, and the shorter one is a symlink.
##################
pyenv virtualenvs

##################
# To create a virtualenv
##################
pyenv virtualenv 2.7.10 my-virtual-env-2.7.10

##################
# To clone a virtual env
##################
pip freeze > requirements.txt in the current virtualenv
pyenv virtualenv ...
pyenv shell newvirtualenv
pip install -r requirements.txt

##################
# Global python version activation
##################
pyenv global 3.8.3

##################
# Global virtual env activation
##################
pyenv global py38

##################
# Switch to python version in current session from that point on
##################
pyenv shell 3.8.3

##################
# Directory specific virtual env activation
# This env will always be activated in that path
##################
pyenv local py-networkglm

##################
# Activate any virtual env from anywhere
##################
pyenv activate <name>
pyenv deactivate

##################
# Help links
##################
https://github.com/pyenv/pyenv-virtualenv
https://github.com/pyenv/pyenv
