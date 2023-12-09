defmodule ChadWeb.ChadLive do
use ChadWeb, :live_view

def mount(params, _session, socket) do
  user = MnemonicSlugs.generate_slug(2)
  form = to_form(%{"text" => ""}, as: :message)
  {:ok, assign(socket, room: Map.get(params, "room_id"), user: user, form: form)}
end

def render(assigns) do
  ~H"""
  <div class="my-4">
    <h1 class="text-2xl font-bold">Chad</h1>
    <p>Chad is a chat application built with Phoenix LiveView.</p>
  </div>
  <hr/>
  <div class="my-4">
    <h2 class="text-md font-bold italic">Room: <%= @room %></h2>
    <h3 class="text-md font-bold italic">User: <%= @user %></h3>
    <p class="text-gray-500">Messages will appear here...</p>
  </div>
  <.simple_form for={@form}>
    <.input field={@form[:text]} placeholder="Type your message here..." />
  </.simple_form>
  """
end
end
