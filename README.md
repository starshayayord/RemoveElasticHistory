#Documentation
Delete old indexfiles using elasticsearch api.

###Command line args:
* **-d** or **--days** [int] "days ago" to compartion
* **-p** or **--port** [int] elasticsearch port
* **-h** or **--host** [string]elasticsearch host address without http://

###CRONTAB
```sh
chmod +x /root/Remover.sh
* 5 * * * /root/Remover.s
```