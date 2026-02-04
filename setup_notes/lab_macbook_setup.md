# Lab MacBook Setup Guide
## Configuring System-Wide Access for Student Users

This guide explains how to set up a lab MacBook Pro so that software and tools installed by an admin user are accessible to all student users (who have non-admin institutional credentials).

---

## 1. Homebrew

Homebrew installs to system-wide locations by default:
- **Apple Silicon**: `/opt/homebrew`
- **Intel**: `/usr/local`

### Installation

If Homebrew isn't already installed:

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

### Make Homebrew Available to All Users

Create a system-wide profile script so all users have Homebrew in their PATH:

```bash
sudo nano /etc/profile.d/homebrew.sh
```

Add the following content (choose based on your Mac's architecture):

```bash
# For Apple Silicon Macs
eval "$(/opt/homebrew/bin/brew shellenv)"

# For Intel Macs (comment out the line above and use this instead)
# eval "$(/usr/local/bin/brew shellenv)"
```

Save and exit. This will automatically load for all users on login.

---

## 2. C Libraries via Homebrew

C libraries installed through Homebrew automatically install to system-wide locations:
- **Apple Silicon**: `/opt/homebrew/lib`
- **Intel**: `/usr/local/lib`

Example installation:

```bash
brew install gsl
brew install hdf5
# etc.
```

These will be accessible to all users once Homebrew is in their PATH.

---

## 3. Visual Studio Code

### System-Wide Installation

1. Download VS Code from https://code.visualstudio.com/
2. Extract the downloaded .zip file
3. Move to system Applications folder:

```bash
sudo mv "Visual Studio Code.app" /Applications/
```

All users can now launch VS Code from `/Applications/`.

### Installing Extensions System-Wide

Install commonly needed extensions:

```bash
code --install-extension ms-python.python
code --install-extension ms-toolsai.jupyter
code --install-extension ms-python.vscode-pylance
```

**Note**: Each user will have their own settings and can install additional extensions, but these core extensions will be available to everyone.

---

## 4. Python Version & Virtual Environment Management with pyenv

### Install pyenv and pyenv-virtualenv

```bash
# Install pyenv and pyenv-virtualenv via Homebrew
brew install pyenv pyenv-virtualenv
```

### Configure pyenv for All Users

Create a system-wide configuration file:

```bash
sudo nano /etc/profile.d/pyenv.sh
```

Add the following content:

```bash
# pyenv configuration
export PYENV_ROOT="/opt/pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
```

### Set Up Shared pyenv Root Directory

```bash
# Create shared pyenv root
sudo mkdir -p /opt/pyenv
sudo chown -R $(whoami):admin /opt/pyenv
sudo chmod -R 775 /opt/pyenv

# Set pyenv root for current session
export PYENV_ROOT="/opt/pyenv"

# Initialize pyenv in this directory
pyenv init
```

### Install Python Versions

Install the Python versions you need:

```bash
# Install Python 3.11 (or whatever version you need)
pyenv install 3.11.7

# Install Python 3.10 if needed
pyenv install 3.10.13

# Set global default
pyenv global 3.11.7

# Verify installation
pyenv versions
```

### Create Shared Virtual Environments

```bash
# Create a general lab environment
pyenv virtualenv 3.11.7 lab-env

# Install common packages
pyenv activate lab-env
pip install --upgrade pip
pip install ipykernel numpy pandas matplotlib scipy scikit-learn jupyter
pyenv deactivate

# Create specialized environments as needed
pyenv virtualenv 3.11.7 neuro-env
pyenv activate neuro-env
pip install ipykernel nibabel nilearn fmriprep
pyenv deactivate
```

### Make Kernels Available to Jupyter/VS Code

Register each environment as a Jupyter kernel:

```bash
# For lab-env
/opt/pyenv/versions/lab-env/bin/python -m ipykernel install --name lab-env --display-name "Lab Environment (Python 3.11)"

# For neuro-env
/opt/pyenv/versions/neuro-env/bin/python -m ipykernel install --name neuro-env --display-name "Neuroimaging (Python 3.11)"
```

This installs kernels to `/usr/local/share/jupyter/kernels/` (system-wide location).

### Using Environments in VS Code

Students can:
1. Select kernels from the kernel picker: "Lab Environment", "Neuroimaging", etc.
2. Activate environments in the terminal: `pyenv activate lab-env`
3. VS Code will auto-detect pyenv environments and show them in the Python interpreter selector

### Student Access to Environments

Students can list and activate shared environments:

```bash
# List all available environments
pyenv versions

# Activate an environment
pyenv activate lab-env

# Deactivate
pyenv deactivate
```

Students can also create their own personal environments:

```bash
# Students create their own environments
pyenv virtualenv 3.11.7 my-personal-env
pyenv activate my-personal-env
pip install [packages]
```

---

## 5. Cisco Secure Client

Cisco Secure Client requires admin installation but is then available to all users.

### Installation

1. Download the Cisco Secure Client installer (.pkg file)
2. Double-click the installer and authenticate with your admin credentials
3. Follow the installation wizard

The application installs to `/opt/cisco/` by default (system-wide location).

All users can launch Cisco Secure Client and connect to VPNs without needing admin privileges.

---

## Verification & Troubleshooting

### Check Permissions

After installation, verify that everything is accessible:

```bash
# Homebrew directory permissions
ls -la /opt/homebrew  # or /usr/local for Intel

# Applications folder
ls -la /Applications/ | grep -E "(Visual Studio Code|Cisco)"

# pyenv installation
ls -la /opt/pyenv/

# Python versions and environments
pyenv versions

# Jupyter kernels
ls -la /usr/local/share/jupyter/kernels/
```

### Expected Permissions

- Directories should be readable and executable by all users (755)
- Files should be readable by all users (644)
- Applications should be in `/Applications/` (not `~/Applications/`)

### Common Issues

**Students can't run Homebrew commands:**
- Verify `/etc/profile.d/homebrew.sh` exists and is readable
- Have students restart their terminal or run `source /etc/profile.d/homebrew.sh`

**pyenv not found or environments not accessible:**
- Verify `/etc/profile.d/pyenv.sh` exists and is readable
- Check that `/opt/pyenv` has correct permissions (775)
- Have students restart their terminal or run `source /etc/profile.d/pyenv.sh`
- Verify with: `echo $PYENV_ROOT` (should show `/opt/pyenv`)

**Python kernel not appearing in VS Code:**
- Check kernel installation: `jupyter kernelspec list`
- Ensure ipykernel is installed in the virtual environment
- Restart VS Code
- Verify pyenv environment is active: `pyenv version`

**Permission denied errors:**
- Check ownership of `/opt/pyenv`: should be owned by admin user with group admin
- Fix with: `sudo chown -R $(whoami):admin /opt/pyenv && sudo chmod -R 775 /opt/pyenv`

---

## Maintenance

### Updating Packages

As the admin user, you can update system-wide installations:

```bash
# Update Homebrew and packages (including pyenv)
brew update
brew upgrade

# Update Python packages in shared environments
pyenv activate lab-env
pip install --upgrade [package-name]
pyenv deactivate
```

### Adding New Packages

Students can request packages to be added to shared environments. As admin:

```bash
pyenv activate lab-env
pip install [new-package]
pyenv deactivate
```

### Installing New Python Versions

```bash
# Update pyenv to get latest Python versions
brew upgrade pyenv

# Install new Python version
pyenv install 3.12.1

# Create environment with new version
pyenv virtualenv 3.12.1 lab-env-312
```

### Student-Specific Environments

Students can create their own custom environments:

```bash
# Students run this in their own accounts
pyenv virtualenv 3.11.7 my-env
pyenv activate my-env
pip install ipykernel [packages]
python -m ipykernel install --user --name my-env
pyenv deactivate
```

---

## Notes

- Students will have their own VS Code settings, preferences, and can install additional extensions
- Students can create their own pyenv virtual environments in addition to accessing shared ones
- Students cannot modify shared pyenv environments but can create their own
- System-wide installations require admin privileges to update/modify
- pyenv allows easy switching between Python versions and environments
- Always test access with a non-admin student account before considering setup complete