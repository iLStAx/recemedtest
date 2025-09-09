# Recemedtest

To start your Phoenix server:

* Run `mix setup` to install and setup dependencies
* Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

## Learn more

* Official website: https://www.phoenixframework.org/
* Guides: https://hexdocs.pm/phoenix/overview.html
* Docs: https://hexdocs.pm/phoenix
* Forum: https://elixirforum.com/c/phoenix-forum
* Source: https://github.com/phoenixframework/phoenix

## Instalación en macOS

* Elixir y Erlang: brew install elixir
* Phoenix: mix archive.install hex phx_new


## Generadores utilizados

* Pacientes
    * mix phx.gen.html Patient patients first_name:string last_name:string phone:string birthdate:date email:string --web admin
* Médicos
    * mix phx.gen.html Practitioner practitioners first_name:string last_name:string phone:string birthdate:date email:string --web admin
* Recetas
    * mix phx.gen.html Prescription prescriptions detail:text practitioner_id:references:practitioners patient_id:references:patients --web admin


## Creación de Usuario

Ejecutar en consola `iex -S mix` lo siguiente para crear el usuario
```
Accounts.register_user(%{
    email: "admin@recemed.com",
    password: "123456789012",
    password_confirmation: "123456789012"
})
```

## Generadores utilizados para api

* Pacientes
    * mix phx.gen.json Patient patients first_name:string last_name:string phone:string birthdate:date email:string --no-context --no-schema --no-html --web api
* Médicos
    * mix phx.gen.json Practitioner practitioners first_name:string last_name:string phone:string birthdate:date email:string --no-context --no-schema --no-html --web api
* Recetas
    * mix phx.gen.json Prescription prescriptions detail:text practitioner_id:references:practitioners patient_id:references:patients --no-context --no-schema --no-html --web api
