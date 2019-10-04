#!/bin/bash

# create a date variable
TODAY=$(date +"%Y-%m-%d")

mod_up () {

  # Run composer update
  lando composer update drupal/"$MODULE" --with-dependencies

  # Update the Drupal DB
  lando drush updb

  # Optional: add and commit to git branch
  echo -e "Commit to git? [y/n]: \c "
  read -r COMMIT
  if [ "$COMMIT" = 'y' ]; then
    DESC="update $MODULE"
    git add .
    git commit -m "$DESC"
  fi

  # Ask for next module to update
  echo -e "Enter the machine name of the next module to update [leave blank to finish]: \c "
  read -r MODULE
}

# Optional: Start Lando
echo -e "Do you need to start Lando? [y/n]: \c "
read -r LANDO
if [ "$LANDO" = 'y' ]; then
  lando start
fi

# Optional: Create new git branch
echo -e "Do you want to create an update branch [y/n]: \c "
read -r BRANCH
if [ "$BRANCH" = 'y' ]; then
  git checkout -b update/"$TODAY"
fi

# Ask which module to update first
echo -e "Enter the machine name of the module to update: \c "
read -r MODULE

# As long a module continues to be entered, the function will repeat
while [ -n "$MODULE" ]
do
  mod_up
done
