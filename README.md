# liblists

[![Build Status](https://travis-ci.org/drupal-composer/drupal-project.svg?branch=8.x)](https://travis-ci.org/drupal-composer/drupal-project)

This repo powers the [Gallaudet University Library Guide to Deaf Biographies and Index to Deaf Periodicals](https://liblists.wrlc.org/).

## Local development

Local development/maintenance is performed using [Lando](https://docs.devwithlando.io/), a Docker-based utility for creating containerized stacks for web application development.

This repository already contains a Lando configuration file using the Drupal 8 recipe (with PHP 7.0 to match the production server), so there is no need to initialize a Lando project. You just need to have Lando installed on your machine already.

Before deploying, you need to obtain database and public file backups from the production server. Place the database backup at the top level of this repository and name it `liblists.sql`.

To deploy the site to your local machine:

1. Clone the repository: `git clone git@github.com:WRLC/liblists.git`

2. Start Lando: `lando start`

3. Install Drupal via Composer: `lando composer install`

4. Create a file called `settings.local.php` in `web/sites/default` that looks like this:

   ```php
   <?php
   
   $databases['default']['default'] = array (
     'database' => 'drupal8',
     'username' => 'drupal8',
     'password' => 'drupal8',
     'host' => 'database',
     'port' => '3306',
     'driver' => 'mysql',
     'prefix' => '',
     'collation' => 'utf8mb4_general_ci',
   );
   
   $settings['hash_salt'] = 'INSERT_YOUR_HASH_HERE';
   
   $settings['trusted_host_patterns'] = array(
     '^liblists\.lndo\.site$',
   );
   ```

5. Import the database backup into Lando: `lando db-import liblists.sql`

6. Copy the contents of the production site's public files into `web/sites/default/files`.

7. Load https://liblists.lndo.site in your browser.
