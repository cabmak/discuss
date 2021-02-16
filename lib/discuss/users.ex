defmodule Discuss.Users do
  @moduledoc """
  Module responsable for User Context
  """


  alias Discuss.Repo
  alias Discuss.Users.User

  def get_user_by_email(email) do
    Repo.get_by(User, email: email)
  end

  def get_user(nil), do: nil

  def get_user(user_id) do
    Repo.get(User, user_id)
  end

  def insert_or_update_user(%{email: email} = params) do
    case get_user_by_email(email) do
      nil ->
        %User{}

      user ->
        user
    end
    |> User.changeset(params)
    |> Repo.insert_or_update()
  end

  def change_user(%User{} = user, params \\ %{}) do
    User.changeset(user, params)
  end
end
