defmodule StarWarsApi.Movies.MovieCharacter do
  use Ecto.Schema
  import Ecto.Changeset

  schema "movies_characters" do
    belongs_to :movie, StarWarsApi.Movies.Movie
    belongs_to :character, StarWarsApi.Characters.Character

    timestamps()
  end

  def changeset(movie_character, attrs) do
    movie_character
    |> cast(attrs, [:movie_id, :character_id])
    |> validate_required([:movie_id, :character_id])
  end
end
