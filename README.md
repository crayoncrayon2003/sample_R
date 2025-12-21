# Ref
* https://www.r-project.org/

# Install
1. Access the mirror site.
2. Download the installer for your operating system

## For ubuntu on WSL
### Install R
```
sudo apt update
sudo apt upgrade
sudo apt install --no-install-recommends software-properties-common dirmngr
wget -qO- https://cloud.r-project.org/bin/linux/ubuntu/marutter_pubkey.asc | sudo tee -a /etc/apt/trusted.gpg.d/cran_ubuntu_key.asc
sudo add-apt-repository "deb https://cloud.r-project.org/bin/linux/ubuntu $(lsb_release -cs)-cran40/"
sudo apt install --no-install-recommends r-base
```

### Confirm version
```
$ R --version
```

### Install VSCode Extension
* R (REditorSupport)
* R Syntax (REditorSupport)
* R Debugger(R Debugger)

# Install R Packages
## Install R Packages
```
$ R
> install.packages("ggplot2")
> install.packages("dplyr")
> install.packages("jsonlite")
> install.packages("purrr")
> install.packages("httr")
> install.packages("shiny")
```

## Confirm R Packages
```
$ R
> library(ggplot2)
> library(dplyr)
> library(jsonlite)
> library("purrr")
> library("httr")
> library("shiny")
```
