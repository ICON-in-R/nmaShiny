# nmaShiny

Welcome to the `nmaShiny` repository! This project is designed to provide users with an interactive web application using Shiny in R for network meta-analysis. If you are new to Shiny, don't worry – this README will guide you through the basics.

## Table of Contents
- [Introduction](#introduction)
- [Getting Started](#getting-started)
- [Installation](#installation)
- [Running the App](#running-the-app)
- [Using the App](#using-the-app)
- [Contributing](#contributing)
- [License](#license)

## Introduction

Shiny is an R package that makes it easy to build interactive web applications straight from R. The `nmaShiny` project leverages Shiny to create a user-friendly interface for performing network meta-analysis.

## Getting Started

Before you can run the `nmaShiny` application, you need to have R and RStudio installed on your computer. If you haven't installed them yet, you can download them from the following links:
- [R](https://cran.r-project.org/)
- [RStudio](https://rstudio.com/products/rstudio/download/)

## Installation

To install the necessary packages and the `nmaShiny` application, follow these steps:

1. Open RStudio.
2. Install the `shiny` package by running the following command in the R console:
   ```R
   install.packages("shiny")
   ```
3. Clone this repository to your local machine or download the ZIP file and extract it.

## Running the App
Once you have installed the necessary packages and downloaded the nmaShiny repository, you can run the Shiny app by following these steps:

* Open RStudio.
* Set the working directory to the location of the nmaShiny repository. You can do this by using the `setwd()` function or by navigating through the RStudio interface.
* Run the following command in the R console to launch the Shiny app:

```R
shiny::runApp("path/to/nmaShiny")
```
Replace `"path/to/nmaShiny"` with the actual path to the nmaShiny directory.

## Using the App
Once the app is running, a web browser window will open displaying the `nmaShiny` interface. The app is designed to be intuitive and user-friendly. Here are some basic features you can explore:

* Data Input: Upload your data files for network meta-analysis.
* Analysis Settings: Configure the settings for your analysis.
* Results Visualization: View the results of your analysis through interactive plots and tables.

Feel free to explore the app and try out different features. If you have any questions or run into issues, please refer to the `Issues` section of this repository.

## Contributing
We welcome contributions to improve the nmaShiny app. If you would like to contribute, please follow these steps:

* Fork the repository.
* Create a new branch for your feature or bug fix.
* Make your changes and commit them with clear and descriptive messages.
* Push your changes to your forked repository.
* Create a pull request with a description of your changes.

## License
This project is licensed under the MIT License. See the LICENSE file for more details.

Thank you for using nmaShiny! We hope you find it useful for your network meta-analysis needs.
