defmodule Discuss.Topic do
  use DiscussWeb, :model

  alias Discuss.Comment
  alias Discuss.User

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
