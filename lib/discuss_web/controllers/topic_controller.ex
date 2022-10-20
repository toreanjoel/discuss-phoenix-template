defmodule DiscussWeb.TopicController do
  use DiscussWeb, :controller

  alias DiscussWeb.Topic, as: Topic

  # the list of topics of the entire system
  # this is the main root level that renders the template for list of topics
  def index(conn, _params) do
    # we get or query the table here? and render the list?
    topics = Repo.all(Topic) # this will get all by the model
    render(conn, "index.html", topics: topics)
  end

  # the name of the function requires to have a template with the same name
  def new(conn, _params) do
    # here we will create a change set from the model
    changeset = Topic.changeset(%Topic{}, %{})
    # we need to create a form and use the changeset with it
    # it needs to be passed to the Ui
    # we pass variables to the template
    # log(changeset)
    render(conn, "new.html", changeset: changeset)
  end

  # we post to this function through the router
  # this comes from the form using the Router
  def create(conn, %{ "topic" => input }) do
    # the changeset we need to creat to make the data we are about to send to postgress
    changeset = Topic.changeset(%Topic{}, input) # input is the entire map of model key and user form value
    log(changeset)
    # we use the Repo module to save to post gress
    case Repo.insert(changeset) do
      {:ok, _post } ->
        conn
          # message to the client
          |> put_flash(:info, "Successfully created topic")
          # redirect to the
          |> redirect(to: Routes.topic_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  # the render method that knows what topic we want to render form values for
  def edit(conn, %{"id" => id}) do
    topic = Repo.get(Topic, id)
    changeset = Topic.changeset(topic)
    render(conn, "edit.html", changeset: changeset, topic: topic)
  end

  # This is what will be called to update the form for edited topic
  def update(conn, %{ "topic" => topic_values, "id" => topic_id }) do
    current_topic = Repo.get(Topic, topic_id)
    changeset = Topic.changeset(current_topic, topic_values)
    log(current_topic)
    case Repo.update(changeset) do
      {:ok, _struct } ->
        conn
        |> put_flash(:info, "Topic updated")
        |> redirect(to: Routes.topic_path(conn, :index))
      {:error, changeset} ->
        conn
        |> put_flash(:error, "There was a problem updating topic")
        |> render("edit.html", changeset: changeset, topic: topic_id)
    end
  end

  # delete a topic from the database
  def delete(conn, %{"id" => topic_id}) do
    Repo.get!(Topic, topic_id) |> Repo.delete!

    conn
    |> put_flash(:info, "Successfully removed topic")
    |> redirect(to: Routes.topic_path(conn, :index))
  end
end
