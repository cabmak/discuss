defmodule DiscussWeb.Plugs.SetUser do
  import Plug.Conn
  import Phoenix.Controller

  # alias Discuss.Repo
  alias Discuss.Users

  def init(_params) do
  end

  def call(conn, _params) do
    user_id = get_session(conn, :user_id)
    conn |> assign(:user, Users.get_user(user_id))
  end
end
