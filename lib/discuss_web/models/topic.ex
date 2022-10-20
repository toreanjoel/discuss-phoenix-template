defmodule DiscussWeb.Topic do
  # phoenix makes a struct for us with the same name as the module that was added
  use DiscussWeb, :model
  # the model is used to relate the struct data from phoenix to post gress
  # we do validation on models
  # 2 things we always need to do
  # schema - informs schema around the postgress
  # def change_set which helps for validation

  # variables in modules
  @topics "topics"

  # what table it maps to and what proeprties are avail
  schema @topics do
    field :title, :string
    field :description, :string
  end

  # validation is done on the model side
  # this is run before it gets inserted into the database
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:title, :description])
    |> validate_required([:title, :description])
  end
end
