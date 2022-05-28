defmodule MyApp.Catalog do
  @moduledoc """
  The Catalog context.
  """

  import Ecto.Query, warn: false
  alias MyApp.Repo
  alias MyApp.Catalog.Game
  alias MyApp.Survey.Rating

  def list_games_with_user_rating(user) do
    query = from(r in Rating, where: r.user_id == ^user.id)

    Game
    |> Repo.all()
    |> Repo.preload(ratings: query)
  end

  def list_games do
    Repo.all(Game)
  end

  def get_game!(id), do: Repo.get!(Game, id)


  def create_game(attrs \\ %{}) do
    %Game{}
    |> Game.changeset(attrs)
    |> Repo.insert()
  end

  def update_game(%Game{} = game, attrs) do
    game
    |> Game.changeset(attrs)
    |> Repo.update()
  end

  def delete_game(%Game{} = game) do
    Repo.delete(game)
  end

  def change_game(%Game{} = game, attrs \\ %{}) do
    Game.changeset(game, attrs)
  end
end
