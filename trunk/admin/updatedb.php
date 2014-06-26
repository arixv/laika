<?php

	// Inicializar el framework
	require_once ($_SERVER ['DOCUMENT_ROOT'] . "/framework/load.php");

	
	$sql = "alter table user_admin change user_alias username varchar(30)";
	Module::exec($sql);
	echo $sql.'<br/>';

	$sql = "alter table object change object_date creation_date datetime not null default '0000-00-00 00:00:00'";
	Module::exec($sql);
	echo $sql.'<br/>';

	$sql = "alter table object change object_userid creation_userid int(11) not null default '0'";
	Module::exec($sql);
	echo $sql.'<br/>';

	
	$sql = "alter table object add creation_usertype varchar(50) not null default '0'";
	Module::exec($sql);
	echo $sql.'<br/>';

	$sql = "alter table object change object_datemod modification_date datetime not null default '0000-00-00 00:00:00'";
	Module::exec($sql);
	echo $sql.'<br/>';
	
	$sql = "alter table object add modification_userid int(11) not null default '0'";
	Module::exec($sql);
	echo $sql.'<br/>';

	$sql = "alter table object add modification_usertype varchar(50) null default ''";
	Module::exec($sql);
	echo $sql.'<br/>';

	$sql = "alter table object add publication_date datetime not null default '0000-00-00 00:00:00'";
	Module::exec($sql);
	echo $sql.'<br/>';
	
	$sql = "alter table object add publication_userid int(11) not null default '0'";
	Module::exec($sql);
	echo $sql.'<br/>';

	$sql = "alter table object add object_shorttitle varchar(255) null default ''";
	Module::exec($sql);
	echo $sql.'<br/>';

	$sql = "alter table object_relation add object_relation_date datetime not null default '0000-00-00 00:00:00'";
	Module::exec($sql);
	echo $sql.'<br/>';


	// Multimedia

	$sql = "alter table multimedia change multimedia_date creation_date datetime not null default '0000-00-00 00:00:00'";
	Module::exec($sql);
	echo $sql.'<br/>';

	$sql = "alter table multimedia change multimedia_userid creation_userid int(11) not null default '0'";
	Module::exec($sql);
	echo $sql.'<br/>';

	$sql = "alter table multimedia add creation_usertype varchar(50) null default ''";
	Module::exec($sql);
	echo $sql.'<br/>';

	$sql = "alter table multimedia change multimedia_datemod modification_date datetime not null default '0000-00-00 00:00:00'";
	Module::exec($sql);
	echo $sql.'<br/>';
	
	$sql = "alter table multimedia add modification_userid int(11) not null default '0'";
	Module::exec($sql);
	echo $sql.'<br/>';

	$sql = "alter table multimedia add modification_usertype varchar(50) null default ''";
	Module::exec($sql);
	echo $sql.'<br/>';

	$sql = "alter table multimedia_object add object_typeid int(11) not null default '0'";
	Module::exec($sql);
	echo $sql.'<br/>';

	$sql = "alter table multimedia_object add multimedia_typeid int(11) not null default '0'";
	Module::exec($sql);
	echo $sql.'<br/>';

	$sql = "alter table multimedia add multimedia_weight int(15) not null default '0'";
	Module::exec($sql);
	echo $sql.'<br/>';
	
	//HOME
	$sql = "alter table home add modification_userid int(11) not null default '0'";
	Module::exec($sql);
	echo $sql.'<br/>';
	$sql = "alter table home add publication_userid int(11) not null default '0'";
	Module::exec($sql);
	echo $sql.'<br/>';
	$sql = "alter table home add modification_date datetime not null default '0000-00-00 00:00:00'";
	Module::exec($sql);
	echo $sql.'<br/>';





?>