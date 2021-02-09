defmodule Discuss.PageController do
  # using this prevent you to do all this bullshit down
  # use MODULENAME, :SUBSECTION
  use DiscussWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
