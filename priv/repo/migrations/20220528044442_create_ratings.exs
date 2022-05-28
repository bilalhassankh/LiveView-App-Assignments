defmodule MyApp.Repo.Migrations.CreateRatings do
  use Ecto.Migration

  def change do
    create table(:ratings) do
      add :rating, :integer
      add :user_id, references(:users, on_delete: :delete_all), null: false
      add :game_id, references(:games, on_delete: :delete_all), null: false

      timestamps()
    end

    create index(:ratings, [:user_id])
    create index(:ratings, [:game_id])
  end
end
