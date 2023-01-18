# Upgrading Kong's Database

## Intro

Kong Gateway uses a database to store configuration information.  From time-to-time, this database needs to be upgraded to stay in support.

This upgrade procedure should be used conjunction with an upgrade of IAM 2.x to IAM 3.x and should be performed *after* running the new version of IAM's `iam-setup.sh` script but *before* starting IAM.

## How to perform the upgrade

Here's the process. 

```
cd scripts

# create and run the specialized container that will run the database migration
docker compose up

# this should take a few minutes and the container will exit when complete

# just in case docker is holding onto any resources
docker compose down
```
