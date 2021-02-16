defmodule Discuss.User do
  use DiscussWeb, :model

  alias Discuss.Comment
  alias Discuss.Topic

  @derive {Jason.Encoder, only: [:email]}

  schema "users" do
    field(:email, :string)
    field(:provider, :string)
    field(:token, :string)

    has_many(:topics, Topic)
    has_many(:comments, Comment)

    timestamps()
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:email, :provider, :token])
    |> validate_required([:email, :provider, :token])
  end
end
