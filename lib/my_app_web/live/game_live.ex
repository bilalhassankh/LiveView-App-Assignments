defmodule MyAppWeb. GameLive do
  use MyAppWeb, :live_view

  def mount(_params, %{"user_token" => _user_token}, socket) do
    {:ok,
     socket
     |> assign(:games, MyApp.Catalog.list_games())}
  end

  def handle_event("Add", %{"game" => name}, socket) do
    MyApp.Catalog.create_game(name)

    {:noreply, assign(socket, games: MyApp.Catalog.list_games())}
  end

  def handle_event("Delete", %{"id" => id}, socket) do
    MyApp.Catalog.get_game!(id)
    |> MyApp.Catalog.delete_game()

    {:noreply, assign(socket, games: MyApp.Catalog.list_games())}
  end
end
