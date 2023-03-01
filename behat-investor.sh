#!/bin/sh
echo "Deleting previous behat-* test files"
cd ~/sec/secgov/docroot/sites/investorgov/files/
find . -name '\behat-*.*' -type f -delete

cd ~/sec/secgov/test
export BEHAT_PARAMS='{"extensions": {"Behat\\MinkExtension": {"base_url": "http://investor.jiratracker.com"},"Drupal\\DrupalExtension": {"drupal": {"drupal_root": "/home/gitlab-runner/sec/secgov/docroot"}}}}'
echo "Checking for behat installation"
if [ -e bin/behat ]
then
    echo "Behat found, running tests"
    bin/behat --suite=investorgov --tags=~wdio
else
    echo "Behat not found, running composer install"
    composer install
    echo "Running Behat tests"
    bin/behat --suite=investorgov --tags=~wdio
fi
