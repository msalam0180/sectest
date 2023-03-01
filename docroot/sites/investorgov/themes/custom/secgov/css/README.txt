Compiling CSS

#########################################################################
Note: DO NOT edit any files in this directory. These files are compiled.
#########################################################################

# How to compile the CSS on a windows machine

## Install Node

Node can be installed uning the installer found here ->  https://nodejs.org/en

## Install Gulp

1. Open the node.js command prompt
2. Install gulp on your machine globally using the following command.

npm install -g gulp

## Download dependencies

1. Open the node.js command prompt
2. Navigate to the Insider theme directory [YOUR PATH]\docroot\themes\custom\insider
3. Download dependencies using the following command

npm install

## Compile SASS

- Compile a single time

1. Open the node.js command prompt
2. Navigate to the Insider theme directory [YOUR PATH]\docroot\themes\custom\insider
3. Compile using the following command

gulp sass

- Watch files for changes and compile every time there is a change

1. Open the node.js command prompt
2. Navigate to the Insider theme directory [YOUR PATH]\docroot\themes\custom\insider
3. Compile using the following command

gulp watch
