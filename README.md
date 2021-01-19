# liblists

[![Build Status](https://travis-ci.org/drupal-composer/drupal-project.svg?branch=8.x)](https://travis-ci.org/drupal-composer/drupal-project)

This repo powers the [Gallaudet University Library Guide to Deaf Biographies and Index to Deaf Periodicals](https://liblists.wrlc.org/).

## Local development

Local development/maintenance is performed using [Lando](https://docs.devwithlando.io/), a Docker-based utility for creating containerized stacks for web application development.

This repository contains a Lando configuration file using the Drupal 8 recipe (with PHP 7.0 to match the production server), so there is no need to initialize a Lando project. You just need to install Lando on your machine.

To deploy the site to your local machine:<br />
(The commands below assume you are developing in macOS with the shared WRLC Common drive mounted at `/Volumes/Common`.)

1. Clone the repository:<br />
`git clone git@github.com:WRLC/liblists.git`

1. Start Lando:<br />
`lando start`

1. Copy the site database dump file from the Common drive to your local machine:<br />
`cp /Volumes/Common/lando/liblists/liblists.sql .`

1. Import the database backup into Lando:<br />
`lando db-import liblists.sql`

1. Copy the site's local settings file from the Common drive to your local machine:<br />
`cp /Volumes/Common/lando/liblists/settings.local.php web/sites/default/settings.local.php`

1. Copy the site's `files` folder from the Common drive to your local machine:<br />
`cp -r /Volumes/Common/lando/liblists/files web/sites/default/files`

A working copy of the production site should now be available on your local machine at: https://liblists.lndo.site

## Updating files folder and database dump in Common and local environment

When working on your local copy of the site, it's a good idea to sync the site `files` folder and database with the production site on a regular basis.

Updating this data on the WRLC shared Common drive makes the updated data available to other developers, too.

### Sync Files

To sync files, first copy the `sites/default/files` folder on the production server to `/Volumes/Common/lando/liblists/files` (overwriting the existing `files` folder).

Then copy the files to your local installation:<br />
`rm -r web/sites/default/files`<br />
`cp -r /Volumes/Common/lando/liblists/files web/sites/default/files`

### Sync Database

To sync the database, first get an sql-dump file from the production server:<br />
`drush sql-dump > ~/liblists.sql`

Then copy that dump file to `/Volumes/Common/lando/liblists/liblists.sql` (again overwriting the existing file).

Finally, import the database dump into your local copy of the site:<br />
`cp /Volumes/Common/lando/liblists/liblists.sql .`<br />
`lando db-import liblists.sql`

## Updating Drupal core and contrib modules/themes

Updating Drupal core and any contrib modules or themes should always be performed in a local dev environment for testing, then pushed to Github, and pulled to production.

Before installing updates, make sure you are on the master branch of the site's Git repository and run a `git pull` to make sure you have the latest commits to that branch.

### Update script

The site's includes a shell script that streamlines the update workflow. To install updates, run the following command in your local Lando dev environment:<br />
`vendor/tomboone/d8-scripts/updates.sh`

#### Start Lando?

The script first asks if you want to start Lando. If the Lando site is already running, you don't need to start it here.

#### Create update branch?

Next, it will ask if you want to create an update branch in Git. Answer yes ('y').

#### Machine name to update?

The script with then ask for the machine name of the module/theme you wish to update. If you want to update Drupal core*, type in `core` here.

Otherwise, enter the machine name of the module/theme to update.

(The machine name will contain only lowercase letters and underscores. When in doubt, check the URL of the module's project page on Drupal.org or its folder name in `web/modules/contrib`.)

*Sometimes Drupal core will not update even when there is an available update. When this happens, enter the following as the machine name: `core webflo/drupal-core-require-dev`.

As Drupal installs the update, it will also run any required database updates on your local site.

#### Commit to Git repo?

The script will then ask if you wish commit the update to Git. Answer yes ('y'). This automatically adds a commit comment indicating which module/theme was updated.

#### Update another module?

The script will ask for the machine name of the next module/theme you wish to update. If you have more updates, to install, enter the machine name and the update process above will repeat.

If you are finished installing updates, hit Return/Enter without typing a module name, and the script will exit.

### Push updates to Git

Once finished running local updates, test your local site to make sure none of the updates broke anything.

If everything works as expected, you can push the update branch to Github. The name of the update branch will be based upon the current date: `update/yyyy-mm-dd`. So updates performed on March 17, 2019, will have a branch name of `update/2019-03-17`. This branch will not be in Github yet, so when pushing you must specify an upstream remote and branch:<br />
`git push -u origin feature/2019-03-17`

### Deploying updates to production server

In the Github.com repo, create a Pull Request to merge the updates from your update branch to master.

Assuming there are no conflicts, you can immediately approve the pull request and merge it into master.

On the production server, navigate to the root of the site repository and run the following commands:<br />
`sudo git pull`<br />
`sudo chown -R www-data:www-data ../liblists`<br />
`drush updb`

Then test the production site to make sure everything is working as expected.
