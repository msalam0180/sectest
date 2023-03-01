#!/bin/bash
echo "Begin CSS compiling"
echo "Adding Acquia as a remote repository"
git remote add acquia secgov@svn-19092.prod.hosting.acquia.com:secgov.git
echo "Checking out $CI_BUILD_REF_NAME"
git clean -fd;
git checkout $CI_BUILD_REF_NAME -f;
git reset --hard
echo "Pulling latest from Gitlab master"
git pull origin $CI_BUILD_REF_NAME -f;
echo "Pulling latest from Acquia master"
git pull acquia $CI_BUILD_REF_NAME;
echo "Compiling the secgov theme SASS using gulp"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
nvm use 14.17.0
cd docroot/themes/custom/secgov
npm install
gulp sass
cd ../../../..
echo "Building uswdssec SASS and Storybook for uswdssec theme"
cd docroot/themes/custom/uswdssec
npm install
npm run build-storybook
cd ../../../..
echo "Compiling the investorgov SASS using gulp"
cd docroot/sites/investorgov/themes/custom/investor
npm install
gulp sass
cd ../../../../../../
echo "Committing the compiled CSS and Storybook."
git add -A
git commit -m "Compiling sass files and building Storybook."
echo "Pushing latest to Acquia master"
git push --force acquia $CI_BUILD_REF_NAME;

