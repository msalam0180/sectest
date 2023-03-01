#!/bin/sh
#
# Cloud Hook: drush-user-update
#
# Run drush uublk and urol in all non-prod environments.

# Map the script inputs to convenient names.
site=$1
target_env=$2
db_name="$3"
source_env="$4"
drush_alias=$site'.'$target_env

# List of drush command based on site.
drush_sec="drush10 @$drush_alias --uri=sec.gov"
drush_investor="drush10 @$drush_alias --uri=investor.gov"

# Variables USER_SEC and USER_INVESTOR will be pulled from Environment Varialbes from Acquia UI.

# Execute commands if environment is NOT prod.
if [ $target_env != "prod" ]; then
  case $db_name in
    "secgov")
      $drush_sec uublk "$USER_SEC"
      $drush_sec urol administrator "$USER_SEC"
    ;;
    "investorgov")
      $drush_investor uublk "$USER_INVESTOR"
      $drush_investor urol administrator "$USER_INVESTOR"
    ;;
  esac
else
  echo "Did not execute any drush commands."
fi
