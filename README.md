# Read Replication Demo

This is a docker-compose setup to test Dolt read replication.

## Configuration

Leader pushes to replication remote on Dolt commit:

```
$ dolt config --local --add DOLT_REPLICATE_TO_REMOTE docker_origin
Config successfully updated.
```

Follower reads from common remote before every SQL transaction:

```
$ dolt config --local --add DOLT_READ_REPLICA_REMOTE docker_origin
Config successfully updated.
```

## Setup

Install Dolt:

```
$ sudo bash -c 'curl -L https://github.com/dolthub/dolt/releases/latest/download/install.sh | sudo bash'
```

Configure user info:

```
$ dolt config --local --add user.name "Max Hoffman"
$ dolt config --local --add user.email "max@dolthub.com"
```

Initialize dbs:

```
$ ./reset_dbs.sh
```

Run `docker-compose.yml`:

```
$ docker-compose up
```

Commit data to the leader:

```
$ mysql --user root --host=0.0.0.0 -P 3308 leader
mysql> create table t1 (a int primary key);
Empty set (0.09 sec)

mysql> select dolt_commit('-am', 'cm');
+----------------------------------+
| dolt_commit('-am', 'cm')         |
+----------------------------------+
| 0qoslhbbfqcerrfg8osf08qi8iapjp70 |
+----------------------------------+
1 row in set (0.26 sec)
```

Read data from follower:

```
$ mysql --user root --host=0.0.0.0 -P 3307 follower
mysql> show tables:
+-------+
| Table |
+-------+
| t1    |
+-------+
1 row in set (0.05 sec)
```
