# ABCLTDA Inventory

Si quieres intalar desde 0 puedes leer la guía:
[Guia-instalacion-ruby-y-postgresql.md](Guia-instalacion-ruby-y-postgresql.md)

## Installation
1. git clone https://github.com/cast3/inventory-rails.git
2. `cd inventory-rails && bundle`
3. `rails db:create && rails db:migrate && rails db:seed`
4. `bin/dev`
5. `open http://localhost:3000`
6. `create a new user http://localhost:3000/users/sign_up`

> Si queremos actualizar el usuario a admin podemos hacer lo siguiente, en la consola base de datos:

```ruby
rails db
```
>Revisar si pide contraseña, si es así, la contraseña es la que se encuentra en el archivo config/database.yml
```sql
UPDATE users SET role = 1 WHERE id = 1;
```

## Propósito
El propósito de este proyecto es crear un sistema de inventario para la empresa ABC LTDA. La cual se dedica a la venta de la canasta familiar. Que en su mayoría son productos perecederos.

## Inventory class
Incluye las clases:
- Movements
- Products
- Clients
- Providers
- Categories
- Inventories
- Users

