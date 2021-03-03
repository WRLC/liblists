INTRODUCTION
------------

Git Deploy lets you develop on a live site and still satisfy version
requirements and get accurate results from the update status system. This makes
it easier to contribute to the projects you use.

Version information is added automatically when the Drupal packaging system
creates a release. If you check out a contributed project from the Drupal
repository with Git, it should not have any version information. Git Deploy gets
the missing version information from the project's Git log.

* Project page: https://www.drupal.org/project/git_deploy
* Issue queue: https://www.drupal.org/project/issues/git_deploy


REQUIREMENTS
------------

* Access to the git command.
* The ability for PHP to execute shell commands.


ALTERNATIVES
------------

A project’s dev release changes whenever a maintainer updates its branch. To
enforce consistency among sites using a dev release, you can lock them to the
same release by checking out a specific Git commit. You would not contribute
changes from these sites back to the project. Drush 8
(https://docs.drush.org/en/8.x/) can automatically add version information to
projects you check out with Git.

* The drush pm-download command with options --package-handler=git_drupalorg
  --gitinfofile performs a Git clone and checkout and adds version information
  to the project info file.
* The drush make command automatically adds version information to the project
  info file without additional options.

Composer Deploy (https://www.drupal.org/project/composer_deploy) gets version
information from Composer metadata for projects installed with Composer.
