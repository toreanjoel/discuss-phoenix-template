defmodule Discuss.Repo.Migrations.AddDescription do
  use Ecto.Migration

  def change do
    alter table :topics do
      add :description, :text
    end
  end
end
