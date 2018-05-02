<?php
defined('VIEWSPATH') || define('VIEWSPATH', __DIR__.DIRECTORY_SEPARATOR.'view');
defined('CLASSPATH') || define('CLASSPATH', __DIR__.DIRECTORY_SEPARATOR.'classes');
/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

require_once (CLASSPATH.DIRECTORY_SEPARATOR.'renderer.php');
//require_once (VIEWSPATH.DIRECTORY_SEPARATOR.'layout.php');
/**
 * @var ZeroBlade Description
 */
$renderer = new ZeroBlade();
extract(['renderer'=>$renderer]);
$renderer->render('grid');
ZB::xd( $renderer->seccontent['calendar']);

