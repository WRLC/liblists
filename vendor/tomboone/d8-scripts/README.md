# d8-scripts

An always-under-construction collection of shell scripts to automate various repetitive tasks in developing, deploying, and maintaining Drupal 8 sites in a Lando container.

## Installation

To install d8-scripts in your Drupal 8 project, just run:

```shell script
composer require tomboone/d8-scripts
```

All scripts in the package will now be available to your Drupal 8 project from the following path:

```shell script
vendor/tomboone/d8-scripts
```

You may need to alter the scripts' permissions to make them executable, e.g.:

```shell script
chmod u+x vendor/tomboone/d8-scripts/*.sh
```

## Available scripts

All scripts are designed to be used in a local Drupal 8 development environment running in a Lando container. For that reason, many of the scripts run drush and composer commands as `lando drush ...` and `lando composer ...`. For this reason, many scripts won't work if you aren't developing with Lando.

### updates.sh

The `vendor/tomboone/d8-scripts/updates.sh` script combines the Git, Drush, and Composer aspects of updating Drupal core and contrib modules/themes into a single process.

1. First it asks if you'd like to create a new branch in your Git repository. If you answer `y`, a new branch titled `update/<YYYY-MM-DD> is checked out.
1. You'll then be asked for the machine name of the module or theme you wish to update first. (If you wish to update Drupal core, just enter `core`.) This initiates a `composer update` command.
1. After `composer updates` finishes, the script automatically runs `drush updb` to update the Drupal database.
1. You'll then be asked if you'd like to commit the code to your Git repository. If you respond `y`, a new commit will be added with the updated module/theme name in the commit message.
1. Finally, the script will ask for another module machine name. If you enter one, the script will repeat the above steps for that module. If you hit `Enter` without entering any text, the script will complete and exit.

At this point you'll have all of updates committed to the active branch, with separate commits for each update, thus enabling easy rollback if any update causes problems.
