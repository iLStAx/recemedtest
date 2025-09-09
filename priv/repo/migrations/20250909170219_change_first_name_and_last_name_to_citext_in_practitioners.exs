defmodule Recemedtest.Repo.Migrations.ChangeFirstNameAndLastNameToCitextInPractitioners do
  use Ecto.Migration

  def change do
    # Enable extension citext if no exists
    execute "CREATE EXTENSION IF NOT EXISTS citext"

    alter table(:practitioners) do
      modify :first_name, :citext
      modify :last_name, :citext
    end
  end
end
