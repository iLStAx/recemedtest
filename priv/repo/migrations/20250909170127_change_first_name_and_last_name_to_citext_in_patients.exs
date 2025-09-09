defmodule Recemedtest.Repo.Migrations.ChangeFirstNameAndLastNameToCitextInPatients do
  use Ecto.Migration

  def change do
    # Enable extension citextif not exists
    execute "CREATE EXTENSION IF NOT EXISTS citext"

    alter table(:patients) do
      modify :first_name, :citext
      modify :last_name, :citext
    end
  end
end
