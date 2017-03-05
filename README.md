Overview
-------------

To enable LDAP authentication/authorization on Pentaho, it's necessary a LDAP server as well as do some configurations on the BA Server.

This repository allows you to create a fully functional LDAP server using docker.

You will find also a set of files and configurations that will switch the authentication from Jackrabbit to LDAP on Pentaho.

> **Note:**

> - Tested on Pentaho 7.0

----------

LDAP Server
-------------

- Clone or download this repository.

- Build your docker image using the Dockerfile as base, or
 
- Use the docker compose to manage the container based on a built image available on the Hub Docker (https://hub.docker.com/r/kleysonr/openldap/)
> **docker-compose up**
>
>Creates a fresh openldap container.
> 
> **docker-compose stop**
>
>Stops a running openldap container.
>
> **docker-compose start**
>
>Resumes a openldap container.

----------

Pentaho Server
-------------

- Install the pentaho server

- Stops the pentaho server if it's running

- Copy recursively the **pentaho-server** folder to **install_pentaho_folder/pentaho-server** folder

- Clear the jackrabbit repository
> rm -rf **``install_pentaho_folder/pentaho-server/pentaho-solutions/system/jackrabbit/repository/*``**

- Load the users and groups into LDAP server
> ``docker exec -it openldap /bin/bash``
>
> ``ldapadd -x -D "cn=admin,dc=example,dc=com" -w admin -H ldap:// -f /sample.ldif``

#### <i class="icon-folder-open"></i> Users/Groups sub-directories

When it's necessary set some access permission, you can choose the user(s) and/or role(s) from a list.

By default, Pentaho doesn't list those users and groups belonging under sub trees. 

To enable Pentaho search recursively the users and groups, follow the steps:

- Edit the **``install_pentaho_folder/pentaho-solutions/system/pentaho-spring-beans.xml``** file

- Search for the line **``<import resource="pentahoObjects.spring.xml" />``** and add the following configuration before it
>**``<import resource="applicationContext-pentaho-security-ldap-custom.xml" />``**

- Starts Pentaho server

- Logs in using some of the users:
> admin:password
>
> sara:password
>
> maria:password
>
> brain:password
>
> peter:password

----------

Note
-------------

To avoid changing additional config files on Pentaho, was kept on LDAP the same name for the administrator user (admin) and group (Administrator).
