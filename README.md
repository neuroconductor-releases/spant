
<!-- README.md is generated from README.Rmd. Please edit that file -->

# Spectroscopy Analysis Tools (spant)

[![Travis Build
Status](https://travis-ci.org/martin3141/spant.svg?branch=master)](https://travis-ci.org/martin3141/spant)
[![AppVeyor Build
Status](https://ci.appveyor.com/api/projects/status/github/martin3141/spant?branch=master&svg=true)](https://ci.appveyor.com/project/martin3141/spant)
[![](http://cranlogs.r-pkg.org/badges/spant)](http://cran.rstudio.com/web/packages/spant/index.html)
[![CRAN\_Status\_Badge](http://www.r-pkg.org/badges/version/spant)](https://cran.r-project.org/package=spant)
[![Coverage
Status](https://coveralls.io/repos/github/martin3141/spant/badge.svg?branch=master)](https://coveralls.io/github/martin3141/spant?branch=master)

## Overview

spant provides a full suite of tools to build automated analysis
pipelines for Magnetic Resonance Spectroscopy (MRS) data. The following
features are included:

  - Raw data import/export.
  - Flexible data types to support single voxel, dynamic and
    spectroscopic imaging data types.
  - Publication quality plotting.
  - Extensive set of pre-processing steps (phasing, coil-combination,
    zero-filling, HSVD filtering…)
  - Quantum mechanical based simulation for experimental design and
    basis-set generation.
  - Set of metabolite, macromolecule and lipid parameters for typical
    brain analyses.
  - VARPRO based fitting and interfaces for TARQUIN and LCModel for
    metabolite quantitation.
  - Voxel registration to anatomical images for partial volume
    concentration corrections.

## Installation

Download and install the latest version of R
(<https://cran.ma.imperial.ac.uk/>), or with your package manager if
using a reasonably modern Linux distribution, eg `sudo apt install
r-base`.

It is also strongly recommended to install RStudio Desktop
(<https://rstudio.com/products/rstudio/>) to provide a modern
environment for interactive data analysis.

Once R and RStudio have been installed, open the RStudio application and
type the following in the Console (lower left panel) to install the
latest stable version of spant:

``` r
install.packages("spant", dependencies = TRUE)
```

Or the the development version from GitHub (requires the `devtools`
package):

``` r
install.packages("devtools")
devtools::install_github("martin3141/spant")
```

## Documentation

Quick introduction to the basic analysis workflow :
<https://martin3141.github.io/spant/articles/spant-intro.html>

Short tutorials : <https://martin3141.github.io/spant/articles/>

Function reference : <https://martin3141.github.io/spant/reference/>

Once the spant library has been loaded with `library(spant)`, type
`?spant` on the console for instructions on how to access the offline
documentation. Note that offline help on the available functions can be
quickly shown in RStudio using `?function_name`, eg `?read_mrs`.
