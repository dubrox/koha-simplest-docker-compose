Koha simplest Docker implementation
===================================

> **BEWARE**: Even if I tried to keep it simple and coincise, avoiding any further customization,
this solution still does not work, as `koha-create` seems not to populate the database, so plack is giving the following error: `DBD::mysql::st execute failed: Table 'koha_biblioteca.systempreferences' doesn't exist at /usr/share/koha/lib/Koha/Database.pm line 152.`

This is my best attempt to closely reproduce the instructions on
[the official Koha wiki](https://wiki.koha-community.org/w/index.php?title=Koha_on_Debian&oldid=34094) at the time of writing.

## Try it out
Just get this code repo in your working directory and run:
```sh
docker compose up
```

To try it locally, in your host system, edit the host file (i.e. `/etc/hosts`) to add:
```
127.0.0.1 biblioteca.centrodicultura.org
127.0.0.1 biblioteca-intra.centrodicultura.org
```

If everything just worked, you will have accessible URLs at the follwing endpoints:
- INTRANET: http://biblioteca-intra.centrodicultura.org:8081
- OPAC: http://biblioteca.centrodicultura.org:8080

These and also the username and password are part of the output log in the Koha container.

## Context (and catharsis)

I tried creating after having tried using other approaches that I thought would be easier but
just brought me to unexpected non-working results and frustration, namely:
- [Koha Docker](https://gitlab.com/koha-community/docker/koha-docker/): this seemed exactly what I wanted, but didn't work.
- [Koha Testing Docker](https://gitlab.com/koha-community/koha-testing-docker): seems the most updated one and actively mantained, but following the documentation didn't lead me to any working result. Even trying tweaking things around didn't bring me to any working solution.

I would go into details of what didn't work in each case, 
but I didn't keep a precise record of what error messages where displayed after each attempt. 
Unfortunately just following the instructions didn't lead to the expected working result.
