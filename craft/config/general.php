<?php

/**
 * General Configuration
 *
 * All of your system's general configuration settings go in here.
 * You can see a list of the default settings in craft/app/etc/config/defaults/general.php
 */

return array(

  /*
   * Craft config variables
   * ---------------------------------------------------------------------------
   * See: http://buildwithcraft.com/docs/config-settings
   */
  "devMode"                     => true,
  "addTrailingSlashesToUrls"    => true,
  "postCpLoginRedirect"         => "entries",
  "siteUrl"                     => null,
  "cpTrigger"                   => 'admin',
  "useEmailAsUsername"          => true,
  'maxUploadFileSize'           => 67108864,
  'enableCsrfProtection'        => true,
  'convertFilenamesToAscii'     => true,
  'extraAllowedFileExtensions'	=> 'json',
  /*
   * Custom config variables
   * ---------------------------------------------------------------------------
   * Variables set by us for use within the project
   */

  // Site environment
  "env" => "local",

  'environmentVariables' => array(
    'basePath' => './',
    'baseUrl'  => '//localhost:8888/lajava/public/',
	),

  // Template settings
  "tmpl"  => array(
    "css" => "/lajava/public/assets/css",
    "img" => "/lajava/public/assets/img",
    "js"  => "/lajava/public/assets/js"
  ),

);
