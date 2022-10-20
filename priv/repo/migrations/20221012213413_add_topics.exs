defmodule Discuss.Repo.Migrations.AddTopics do
  use Ecto.Migration

  # we run mix ecto.gen.migration NAME_OF_WHAT_IT_DOES
  # NOTE: remember, atoms are strings but we use them on the system and not strings
  def change do
    # this is where we sinstruct what postgress should have
    create table(:topics) do
      add :title, :string
    end
  end
  # we run mix ecto.migrate - this will take the functions in the change function and run them
end
