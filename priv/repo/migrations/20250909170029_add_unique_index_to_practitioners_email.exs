defmodule Recemedtest.Repo.Migrations.AddUniqueIndexToPractitionersEmail do
  use Ecto.Migration

  def change do
    create unique_index(:practitioners, [:email])
  end
end
