## Install concourse CI server

1) get concourse binaries
``` https://concourse.ci/downloads.html```

* 1.1) Move the binary in the dir "/usr/bin/" 


2) Postgres install and setup:


```console
zypper in postgresql
zypper in postgresql-server
systemctl start postgresql.service
systemctl enable postgresql.service
```

3) On the concourse server, init the server with

https://github.com/MalloZup/opensuseconcourse/tree/master/setup/

``` setup/init_concourse.sh ```

4) Start the services

```console
systemctl start concourse.service 
systemctl start concourse_worker.service 
systemctl enable concourse.service
systemctl enable concourse_worker.service
```

5) Modify the psgres file . 

If you get_
```":{"error":"pq: Ident-Authentifizierung für Benutzer »Mallozu« fehlgeschlagen","session":"2"}}```
Modify the file

**var/lib/pgsql/data/pg_hba.conf**

and set  -> set trust to all user **FIXME**: maybe trust is not the optimal security solution.

### go to http://localhost:8080/ and congrat yourself


### to see examples in action

```pipelines-examples/schedule-jobs.sh``` 
