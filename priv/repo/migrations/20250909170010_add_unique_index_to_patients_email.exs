defmodule Recemedtest.Repo.Migrations.AddUniqueIndexToPatientsEmail do
  use Ecto.Migration

  def change do
    create unique_index(:patients, [:email])
  end
end
