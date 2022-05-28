defmodule MyApp.Survey.Rating do
  use Ecto.Schema
  import Ecto.Changeset

  schema "ratings" do
    field :rating, :integer

    belongs_to :user, MyApp.Accounts.User
    belongs_to :game, MyApp.Catalog.Game
    timestamps()
  end

  @doc false
  def changeset(rating, attrs, _opts \\ []) do
    rating
    |> cast(attrs, [:rating, :user_id, :game_id])
    |> validate_required([:rating, :user_id, :game_id])
  end
end
