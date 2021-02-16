defmodule Discuss.CommentsChannel do
  use DiscussWeb, :channel

  alias Discuss.Comment
  alias Discuss.Repo
  alias Discuss.Topic

  def join("comments:" <> topic_id, _params, socket) do
    topic = get_topic(topic_id)
    {:ok, %{comments: topic.comments}, assign(socket, :topic, topic)}
  end

  def handle_in(_name, %{"content" => _content} = params, socket) do
    case create_comment(socket, params) do
      {:ok, comment} ->
        channel_name = "comments:#{socket.assigns.topic.id}:new"
        data = %{comment: comment}
        broadcast!(socket, channel_name, data)

        {:reply, :ok, socket}

      {:error, changeset} ->
        {:reply, {:error, %{errors: changeset}}, socket}
    end
  end

  def get_topic(topic_id) do
    Topic
    |> Repo.get(String.to_integer(topic_id))
    |> Repo.preload(comments: :user)
  end

  def create_comment(socket, %{"content" => content}) do
    socket.assigns.topic
    |> Ecto.build_assoc(:comments, user_id: socket.assigns.user_id)
    |> Comment.changeset(%{content: content})
    |> Repo.insert()
    |> handle_result()
  end

  def handle_result({:ok, comment}), do: {:ok, Repo.preload(comment, :user)}

  def handle_result({:error, error}), do: {:error, error}
end
