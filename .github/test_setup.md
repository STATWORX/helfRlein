# Test setup

The test setup consists of three workflows for different scenarios. Next to these workflows there is one for lint checks and one for code coverage.

- **R CMD check fix**
  A workflow that checks the package on Windows, Linux and Mac for R versions 3.5, 3.6 and 4.0. It is run on PR to the master branch. This workflow is used for the master branch badge.
- **R CMD check relative**
  A workflow that checks the package on Windows, Linux and Mac for R versions oldrel, release and devel. It is run on PR to the master branch.
- **dev check**
  For the dev branch a lighter and quicker test setup was chosen. Here only R version 4.0 is tested on Windows, Linux and Mac. Also here the used pacakges are loaded via cache and with the [`renv` package](https://github.com/rstudio/renv).


Ubuntu is tested on version 18.04, where for Mac and Windows the latest available build is used. An overview of the specific version on GitHub can be found [here](https://docs.github.com/en/actions/reference/specifications-for-github-hosted-runners#supported-runners-and-hardware-resources).

