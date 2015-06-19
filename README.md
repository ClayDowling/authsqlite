# authsqlite
Authentication mechanism for DokuWiki that uses an SQLite database for
its data store.

This is heavily plagiarismed from authpgsql, because the two database
engines support a similar SQL syntax.

Configuration is similar to PostgreSQL.  In addition to the configuration
options for PostgreSQL, authsqlite allows the %{animal} parameter in all
sql statements.  %{animal} is the animal component of a wiki farm setup, 
and corresponds to the folder where the animal's configuration and data 
files live.

This is the configuration for a farm, where a single authentication
database contains all of the user information, but group membership is
different for each animal.

	$conf['plugin']['authsqlite']['checkPass'] = 
		'SELECT pass FROM usergroup AS ug 
		JOIN user AS u ON u.uid=ug.uid 
		JOIN groups AS g ON g.gid=ug.gid 
		WHERE u.login=\'%{user}\' 
			AND g.name=\'%{dgroup}\'';
	$conf['plugin']['authsqlite']['getUserInfo'] = 
		'SELECT pass, fullname AS name, email AS mail 
		FROM user WHERE login=\'%{user}\'';
	$conf['plugin']['authsqlite']['getGroups'] = 
		'SELECT g.name AS \'group\' FROM groups g, user u, 
		usergroup ug WHERE u.uid = ug.uid 
			AND ug.animal=\'%{animal}\'
			AND g.gid = ug.gid AND u.login=\'%{user}\'';
	$conf['plugin']['authsqlite']['getUsers'] = 
		'SELECT DISTINCT u.login AS user FROM user AS u 
		LEFT JOIN usergroup AS ug ON u.uid=ug.uid AND ug.animal=\'%{animal}\'
		LEFT JOIN groups AS g ON ug.gid=g.gid';
	$conf['plugin']['authsqlite']['FilterLogin'] = 'u.login LIKE \'%{user}\'';
	$conf['plugin']['authsqlite']['FilterName'] = 'u.fullname LIKE \'%{name}\'';
	$conf['plugin']['authsqlite']['FilterEmail'] = 'u.email LIKE \'%{email}\'';
	$conf['plugin']['authsqlite']['FilterGroup'] = 'g.name LIKE \'%{group}\'';
	$conf['plugin']['authsqlite']['SortOrder'] = 'ORDER BY u.login';
	$conf['plugin']['authsqlite']['addUser'] = 
		'INSERT INTO user (login, pass, email, fullname)
		VALUES (\'%{user}\', \'%{pass}\', \'%{email}\', \'%{name}\')';
	$conf['plugin']['authsqlite']['addGroup'] = 
		'INSERT INTO groups (name) VALUES (\'%{group}\')';
	$conf['plugin']['authsqlite']['addUserGroup'] = 
		'INSERT INTO usergroup (uid, gid, animal) VALUES (%{uid}, %{gid}, \'%{animal}\')';
	$conf['plugin']['authsqlite']['delGroup'] = 'DELETE FROM groups WHERE gid=%{gid}';
	$conf['plugin']['authsqlite']['getUserID'] = 
		'SELECT uid AS id FROM user WHERE login=\'%{user}\'';
	$conf['plugin']['authsqlite']['delUser'] = 'DELETE FROM user WHERE uid=%{uid}';
	$conf['plugin']['authsqlite']['delUserRefs'] = 'DELETE FROM usergroup WHERE uid=%{uid}';
	$conf['plugin']['authsqlite']['updateUser'] = 'UPDATE user SET';
	$conf['plugin']['authsqlite']['UpdateLogin'] = 'login=\'%{user}\'';
	$conf['plugin']['authsqlite']['UpdatePass'] = 'pass=\'%{pass}\'';
	$conf['plugin']['authsqlite']['UpdateEmail'] = 'email=\'%{email}\'';
	$conf['plugin']['authsqlite']['UpdateName'] = 'fullname=\'%{name}\'';
	$conf['plugin']['authsqlite']['UpdateTarget'] = 'WHERE uid=%{uid}';
	$conf['plugin']['authsqlite']['delUserGroup'] = 
		'DELETE from usergroup WHERE uid=%{uid} AND gid=%{gid} AND animal=\'%{animal}\'';
