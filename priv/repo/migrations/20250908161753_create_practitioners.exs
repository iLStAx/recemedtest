defmodule Recemedtest.Repo.Migrations.CreatePractitioners do
  use Ecto.Migration

  def change do
    create table(:practitioners) do
      add :first_name, :string, null: false
      add :last_name, :string, null: false
      add :phone, :string, null: false
      add :birthdate, :date, null: false
      add :email, :string, null: false

      timestamps(type: :utc_datetime)
    end
  end
end
