defmodule Discuss.Topics.Topic do
  use DiscussWeb, :model

  alias Discuss.Comments.Comment
  alias Discuss.Users.User

  schema "topics" do
    field(:title, :string)

    belongs_to(:user, User)
    has_many(:comments, Comment)
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:title])
    |> validate_required([:title])
  end
end
