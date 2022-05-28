defmodule MyApp.Survey do
  @moduledoc """
  The Catalog context.
  """

  import Ecto.Query, warn: false
  alias MyApp.Repo
  alias MyApp.Survey.Rating

  def list_ratings do
    Repo.all(Rating)
  end

  def get_rating!(id), do: Repo.get!(Rating, id)

  def create_rating(attrs \\ %{}) do
    %Rating{}
    |> Rating.changeset(attrs)
    |> Repo.insert()
  end

  def update_rating(%Rating{} = rating, attrs) do
    rating
    |> Rating.changeset(attrs)
    |> Repo.update()
  end

  def delete_ratings(%Rating{} = ratings) do
    Repo.delete(ratings)
  end

  def change_rating(%Rating{} = rating, attrs \\ %{}) do
    Rating.changeset(rating, attrs)
  end
end
