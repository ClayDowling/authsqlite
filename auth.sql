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
  animal text not null default '',
  primary key (uid, gid, animal)
);

