#!/bin/sh
echo "git remote set-url origin git@jira.jiratracker.com:sec/secgov.git"
git remote set-url origin git@jira.jiratracker.com:sec/secgov.git
echo "Adding Acquia as a remote repository"
git remote add acquia secgov@svn-19092.prod.hosting.acquia.com:secgov.git
echo "git checkout $CI_BUILD_REF_NAME;"
git checkout $CI_BUILD_REF_NAME;
echo "git pull origin $CI_BUILD_REF_NAME;"
git pull origin $CI_BUILD_REF_NAME;
echo "git pull acquia $CI_BUILD_REF_NAME;"
git pull acquia $CI_BUILD_REF_NAME;
echo "git push -u acquia $CI_BUILD_REF_NAME;"
git push -u acquia $CI_BUILD_REF_NAME;
git push acquia $CI_BUILD_REF_NAME;
echo "git fetch acquia --tags"
git fetch acquia --tags
echo "git push origin --tags"
git push origin --tags

echo "****************************"
echo "Executing drush cim sync -y and cr"

#ssh secgov.dcmdev1@staging-20333.prod.hosting.acquia.com 'drush @secgov.dev cr -l sec.gov && drush @secgov.dev cim sync -y -l sec.gov'
#ssh secgov.dcmtest1@staging-20333.prod.hosting.acquia.com 'drush @secgov.dev cr -l investor.gov && drush @secgov.dev cim sync -y -l investor.gov'