defmodule MyAppWeb.RatingLive.Form do
  use MyAppWeb, :live_component
  alias MyApp.Survey
  alias MyApp.Survey.Rating

  def update(assigns, socket) do
    {:ok,
     socket
     |> assign(assigns)
     |> assign_rating()
     |> assign_changeset()}
  end

  def handle_event("validate", %{"rating" => rating_params}, socket) do
    {:noreply, validate_rating(socket, rating_params)}
  end

  def handle_event("save", %{"rating" => rating_params}, socket) do
    {:noreply, save_rating(socket, rating_params)}
  end

  def assign_rating(%{assigns: %{current_user: user, game: game}} = socket) do
    assign(socket, :rating, %Rating{user_id: user.id, game_id: game.id})
  end

  def assign_changeset(%{assigns: %{rating: rating}} = socket) do
    assign(socket, :changeset, Survey.change_rating(rating))
  end

  def validate_rating(socket, rating_params) do
    changeset =
      socket.assigns.rating
      |> Survey.change_rating(rating_params)
      |> Map.put(:action, :validate)

    assign(socket, :changeset, changeset)
  end

  def save_rating(
        %{assigns: %{game_index: game_index, game: game}} = socket,
        rating_params
      ) do

    case Survey.create_rating(rating_params) do
      {:ok, rating} ->
        game = %{game | ratings: [rating]}
        send(self(), {:created_rating, game, game_index})
        socket

      {:error, %Ecto.Changeset{} = changeset} ->
        assign(socket, changeset: changeset)
    end
  end
end
