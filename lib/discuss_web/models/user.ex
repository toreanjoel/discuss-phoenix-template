defmodule DiscussWeb.User do
  use DiscussWeb, :model

  # variables in modules
  @users "users"

  # what table it maps to and what proeprties are avail
  schema @users do
    field :email, :string
    field :provider, :string
    field :token, :string

    timestamps()
  end

  # changeset that we use to update the data with the user struct
  # discribes how we want to change the record
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:email, :provider, :token])
    |> validate_required([:email, :provider, :token])
  end
end
