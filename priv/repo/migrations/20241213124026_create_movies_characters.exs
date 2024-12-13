defmodule StarWarsApi.Repo.Migrations.CreateMoviesCharacters do
  use Ecto.Migration

  def change do
    create table(:movies_characters) do
      add :movie_id, references(:movies)
      add :character_id, references(:characters)

      timestamps()
    end

    # Optionally, you might want to add an index for better query performance
    create index(:movies_characters, [:movie_id])
    create index(:movies_characters, [:character_id])
  end
end
