# RAsterisk - Remote Asterisk

Questo strumento permette di eseguire comandi Astersik da un utente o da una macchina differente da quella in cui è installato Astersik

## Installazione

- Copiare il file `bin/rasterisk` su `/usr/sbin/rasterisk` e data i permessi di esecuzione `chmod +x /usr/sbin/rasterisk`
- Copiare il file `systemd/rasterisk.service` su `/etc/systemd/system/rasterisk.service` ed eseguire il comando `systemctl enable rasterisk.service`

Completare l'installazione con i seguenti comandi

```shell
sudo apt install socat
sudo systemctl start rasterisk.service
rastestik --version
```

## Utilizzo

Il comando `rasterisk` può essere usato come rimpiazzo per il comando classico `asterisk` ad esempio:

```
rasterisk -rx "core show channels"
```

## Licensa

MIT
