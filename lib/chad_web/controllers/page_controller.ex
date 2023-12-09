defmodule ChadWeb.PageController do
  use ChadWeb, :controller

  def home(conn, _params) do
    # The home page is often custom made,
    # so skip the default app layout.
    # render(conn, :home, layout: false)
    room = MnemonicSlugs.generate_slug(4)
    redirect(conn, to: "/#{room}")
  end
end
