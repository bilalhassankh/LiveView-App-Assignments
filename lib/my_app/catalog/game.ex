defmodule MyApp.Catalog.Game do
  use Ecto.Schema
  import Ecto.Changeset

  schema "games" do
    field :game_name, :string
    has_many :ratings, MyApp.Survey.Rating

    timestamps()
  end

  @doc false
  def changeset(game, attrs) do
    game
    |> cast(attrs, [:game_name])
    |> validate_required([:game_name])
  end
end
