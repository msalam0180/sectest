#!/bin/sh
#
# Cloud Hook: delete-webfrom-data
#
# Scrub webform submission from all non-prod environments except for stage.

# Map the script inputs to convenient names.
site=$1
target_env=$2
db_name="$3"
source_env="$4"
drush_alias=$site'.'$target_env

# List of drush command based on site.
drush_sec="drush10 @$drush_alias --uri=sec.gov"
drush_investor="drush10 @$drush_alias --uri=investor.gov"

# Execute commands if environment is NOT prod and NOT test(stage).
if [ $target_env != "prod" ] && [ $target_env != "test" ]; then
  case $db_name in
    "secgov")
    echo "$site.$target_env: Scrubbing webform submission on $db_name"
(cat <<EOF
-- Empty webform submissions tables.
TRUNCATE webform_submission;
TRUNCATE webform_submission_data;
TRUNCATE webform_submission_log;
EOF
) | $drush_sec ah-sql-cli --db=$db_name
    ;;
  esac
else
  echo "Did not execute any drush commands."
fi
