defmodule Discuss.Comments.Comment do
  use DiscussWeb, :model

  alias Discuss.Topics.Topic
  alias Discuss.Users.User

  @derive {Jason.Encoder, only: [:content, :user]}

  schema "comments" do
    field(:content, :string)

    belongs_to(:user, User)
    belongs_to(:topic, Topic)

    timestamps()
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:content])
    |> validate_required([:content])
  end
end
