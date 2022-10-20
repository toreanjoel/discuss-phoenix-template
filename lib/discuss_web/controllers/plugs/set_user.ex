defmodule DiscussWeb.Plugs.SetUser do
  import Plug.Conn
  import Phoenix.Controller

  # look into the connection,
  # grab user id,
  # fetch user from db
  # transform connection object
  # have user model on the conn object across the system

  alias Discuss.Repo
  alias DiscussWeb.User

  # module plug must have 2 functions
  # init - called once
  # call - happens when ever this is called (must take a connection and return it)
  def init(_params) do
    # we can do nothing here and just look at the user id and fetch the user out of the db
  end

  # the params are not the same as what we get from view controllers
  # this is the return value of what comes from the init function
  # if there is no data in the init, we wont have it in the params
  def call(conn, _params) do
    # we have added to the session conn and fetching it here
    user_id = get_session(conn, :user_id)
    cond do
      user = user_id && Repo.get(User, user_id) ->
        assign(conn, :user, user) # adds it to (method built in from plug) -> conn.assigns.user
        # anything after the assign function, will have the data on the assigns property
      true -> assign(conn, :user, nil)
    end
  end
end
