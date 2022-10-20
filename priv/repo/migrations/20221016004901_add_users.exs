defmodule Discuss.Repo.Migrations.AddUsers do
  use Ecto.Migration

  def change do
    create table :users do
      add :email, :string
      add :provider, :string
      add :token, :string
      # allows us to add a timestamp when something changes
      timestamps()
    end
  end
end
