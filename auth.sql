CREATE TABLE user (
  uid integer not null primary key,
  login text not null,
  pass text not null,
  fullname text not null default '',
  email text not null default '',
  unique(login),
  unique(email)
);

CREATE TABLE groups (
  gid integer not null primary key,
  name text not null,
  unique(name)
);

CREATE TABLE usergroup (
  uid integer not null,
  gid integer not null,
  primary key (uid, gid)
);

INSERT INTO user (login, pass, fullname, email) VALUES ('clay', '$1$0HpOo1SM$LAUBcLHpnDVfIiyW2q0Kh0', 'Clay Dowling', 'clay@lazarusid.com');
INSERT INTO groups (name) VALUES ('admin');
INSERT INTO groups (name) VALUES ('users');
INSERT INTO usergroup (uid, gid) SELECT (select uid FROM user WHERE login='clay'), gid FROM groups;
