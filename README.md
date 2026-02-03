# 0. Ref
* https://www.r-project.org/

# 1. Install
1. Access the mirror site.
2. Download the installer for your operating system

## 1.1. For ubuntu on WSL
### Install R
```bash
sudo apt update
sudo apt upgrade
sudo apt install --no-install-recommends software-properties-common dirmngr
wget -qO- https://cloud.r-project.org/bin/linux/ubuntu/marutter_pubkey.asc | sudo tee -a /etc/apt/trusted.gpg.d/cran_ubuntu_key.asc
sudo add-apt-repository "deb https://cloud.r-project.org/bin/linux/ubuntu $(lsb_release -cs)-cran40/"
sudo apt install --no-install-recommends r-base
```

### Install Dependencies
```bash
sudo apt update
sudo apt install build-essential g++ cmake libssl-dev libxml2-dev \
    libxml2-dev libxslt-dev libssl-dev libmariadb-dev libpq-dev libssl-dev libsasl2-dev libcurl4-openssl-dev gfortran libblas-dev liblapack-dev
```

### Confirm version
```
$ R --version
```

### Install VSCode Extension
* R (REditorSupport)
* R Syntax (REditorSupport)
* R Debugger(R Debugger)

# 2. Install R Packages
## 2.1. Install R Packages
```
$ R
> install.packages("remotes")
> install.packages("vscDebugger", repos = "https://manuelhentschel.r-universe.dev")
> remotes::install_github("ManuelHentschel/vscDebugger")
> install.packages("ggplot2")
> install.packages("dplyr")
> install.packages("jsonlite")
> install.packages("purrr")
> install.packages("httr")
> install.packages("shiny")
> install.packages("lavaan")
> install.packages("neuralnet")
```

## 2.2. Confirm R Packages
```
$ R
> library("remotes")
> library(ggplot2)
> library(dplyr)
> library(jsonlite)
> library("purrr")
> library("httr")
> library("shiny")
> library(lavaan)
> library(neuralnet)
```


# 3. Jupyter Notebook
## 3.1. Install Dependencies
```bash
sudo apt update
sudo apt upgrade
sudo apt install jupyter-notebook jupyter-client jupyter-core
sudo apt install r-base r-base-dev
```

## 3.2. Install R Packages
```
$ R
> install.packages("IRkernel")
> IRkernel::installspec()
```

## 3.3. Confirm
```bash
jupyter notebook --version
jupyter kernelspec list
```

Available kernels are displayed.
* ir
* python3

## 3.4. How to use
Create a new *.ipynb file. Select R as the kernel.