defmodule DiscussWeb.AuthController do
  use DiscussWeb, :controller
  alias DiscussWeb.User, as: User;
  # bind controller to another service?
  plug Ueberauth

  # the call back method that gets used when we get a response from auth request
  def callback(%{ assigns: %{ ueberauth_auth: auth } } = conn, _params) do
    user_params =
      %{
        token: auth.credentials.token,
        email: auth.info.email,
        provider: "github" # hardcoded for now
      }
    changeset = User.changeset(%User{}, user_params)

    sign_in(conn, changeset)
  end

  # request to OAuth service
  def request(_conn, _params) do
    log("Request")
  end

  # private method to log out the user from the application and send them to the home page?
  def signout(conn, _params) do
    # we need to remove the user id from the connection
    conn
      |> configure_session(drop: true) # delete the entire session
      |> redirect(to: Routes.topic_path(conn, :index))

  end

  # private method to use the value of change set to find user
  defp get_insert_user_check(changeset) do
    # check changeset and user email we look for in the database
    %{ changes: %{ email: email }} = changeset
    case Repo.get_by(User, email: email) do
      nil ->
        Repo.insert(changeset) # this returns tuple if user does not exist
      user ->
        {:ok, user}
    end
  end

  # this is used to signin after callback logging in happens
  defp sign_in(conn, changeset) do
    case get_insert_user_check(changeset) do
      {:ok, user} ->
        conn
          |> put_flash(:info, "Welcome #{user.email}!")
          |> put_session(:user_id, user.id) # we are adding encrypted data to the browser cookies
          |> redirect(to: Routes.topic_path(conn, :index))
      {:error, _error} ->
        conn
          |> put_flash(:error, "There was an error logging in")
          |> redirect(to: Routes.topic_path(conn, :index))
    end
  end
end
