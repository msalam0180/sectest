#!/bin/sh
echo "Building sec.gov"
echo "Adding Acquia remote"
git remote add acquia secgov@svn-19092.prod.hosting.acquia.com:secgov.git
echo "Checking out master"
git clean -fd;
git checkout master -f;
git reset --hard
echo "Pulling latest from Gitlab master"
git pull origin master -f;
echo "Pulling latest from Acquia master"
git pull acquia master;
#echo "Pushing latest to Gitlab master"
#git push origin master;
echo "Pushing latest to Acquia master"
git push acquia master;
echo "git fetch acquia --tags"
git fetch acquia --tags
echo "git push origin --tags"
git push origin --tags
echo "Executing Drush commands"

#ssh -oStrictHostKeyChecking=no secgov.dev@staging-20333.prod.hosting.acquia.com
#drush @secgov.dev updb
#drush @secgov.dev entup -y
#drush @secgov.dev fra -y
