git a## Instalación en macOS

* Elixir y Erlang: brew install elixir
* Phoenix: mix archive.install hex phx_new
* Dependencias: mix deps.get
* Assets: mix assets.deploy
* Base de datos: mix ecto.create
* Migraciones: mix ecto.migrate

## Generación de datos
en consola  `iex -S mix` ejecutar lo siguiente:

* Recemedtest.Patients.loader\0 -> Inserta 100 pacientes en la base de datos
* Recemedtest.Practitioners.loader\0 -> Inserta 100 médicos en la base de datos
* Recemedtest.Prescriptions.loader\0 -> Inserta 100 prescripciones en la base de datos

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
Accounts.register_user_available_to_login(%{
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
