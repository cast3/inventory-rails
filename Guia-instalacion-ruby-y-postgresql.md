# Instalación de Ruby on Rails en Ubuntu 22.04

**Nota: Este tutorial está basado en la documentación GoRails, en el siguiente enlace: https://gorails.com/setup/ubuntu/22.04#final-steps**

## Actualizar el sistema

```bash
sudo apt update
sudo apt upgrade
```
> *Si se desea actualizar el sistema a la última versión de Ubuntu, se puede ejecutar el siguiente comando:*
> ```
> sudo apt dist-upgrade
> ```

> *Podemos revisar la versión de Ubuntu con el siguiente comando:*
> ```
> lsb_release -a
> ```

## Instalamos los paquetes necesarios

```bash
sudo apt-get install git-core zlib1g-dev build-essential libssl-dev libreadline-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev libcurl4-openssl-dev software-properties-common libffi-dev
```

## Para esta guia, se instalará ruby 3.2.1 y rails 7.0.4.3 (últimas versiones al momento de escribir este tutorial) mediante la herramienta asdf.

### Instalamos dependencias necesarias para asdf

```bash
sudo apt-get install git curl autoconf bison patch rustc libyaml-dev libreadline6-dev libgmp-dev libncurses5-dev libgdbm6 libgdbm-dev libdb-dev uuid-dev
```

### Instalamos asdf

```bash
git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.11.3
```

> *Asegurate de estar dentro de tu carpeta home, en este caso, **/home/usuario***
> ```
> cd ~
> ```

### Agregamos asdf al PATH

```bash
. "$HOME/.asdf/asdf.sh"
. "$HOME/.asdf/completions/asdf.bash"
```

## Instalamos ruby

```bash
asdf plugin add ruby https://github.com/asdf-vm/asdf-ruby.git
asdf install ruby 3.2.1
```

## Instalamos NodeJS

```bash
asdf plugin add nodejs https://github.com/asdf-vm/asdf-nodejs.git
asdf install nodejs latest
```

## Globalizamos las versiones de ruby y nodejs

```bash
asdf global ruby 3.2.1
asdf global nodejs latest
```

## Instalamos rails

```bash
gem update --system
gem install rails -v 7.0.4.3
```

## Instalamos bundler

```bash
gem install bundler
```

### Verificamos la instalación de rails, ruby, nodejs y bundler

```bash
rails -v
ruby -v
node -v
bundler -v
```

> *Si presenta algun error instalando Ruby, puede revisar la documentación de rbenv en el siguiente enlace: https://github.com/rbenv/ruby-build/wiki#suggested-build-environment*


> *Si presenta algun error con asdf, puede revisar la documentación en el siguiente enlace: https://asdf-vm.com/guide/getting-started.html*

## Configuramos Git

```bash
git config --global color.ui true
git config --global user.name "Tu nombre"
git config --global user.email "
```


## Instalamos Postgresql

```bash
sudo apt install postgresql libpq-dev
```

### Verificamos que este corriendo el servicio de postgresql

```bash
sudo systemctl status postgresql
# ó
sudo service postgresql status
```
> *Nota: Si el servicio no esta corriendo, se puede iniciar con los siguientes comandos:*

```bash
sudo systemctl start postgresql
# ó
sudo service postgresql start
```

### Configuraciones extras para Postgresql

```bash
sudo -u postgres psql
```

```sql
CREATE ROLE developer WITH LOGIN PASSWORD '0124';
ALTER ROLE developer CREATEDB;
GRANT USAGE, SELECT, UPDATE, INSERT, DELETE ON ALL TABLES IN SCHEMA public TO developer;
GRANT USAGE, SELECT, UPDATE ON ALL SEQUENCES IN SCHEMA public TO developer;
GRANT EXECUTE ON ALL FUNCTIONS IN SCHEMA public TO developer;
\du
\q
```
> *Nota: En el comando anterior, se crea un usuario llamado developer con contraseña 0124, se le otorgan permisos para crear bases de datos y se le otorgan permisos para realizar operaciones CRUD en las tablas de la base de datos.*

> *El comando para ampliar acceso a secuencias es "GRANT USAGE, SELECT, UPDATE, INSERT, DELETE ON ALL SEQUENCES IN SCHEMA public TO developer" Si no tienes secuencias creadas en el esquema "public", entonces no es necesario otorgar esos permisos todavía. Pero si más adelante creas secuencias y deseas otorgar acceso a ellas al rol "developer", entonces deberás otorgar los permisos correspondientes.*

- ### Verificamos el puerto de escucha de postgresql (por defecto es 5432)

```bash
cat /etc/postgresql/15/main/postgresql.conf | grep port
```

- ### Verificamos el usuario de postgresql

```bash
cat /etc/postgresql/15/main/pg_hba.conf | grep local
```
