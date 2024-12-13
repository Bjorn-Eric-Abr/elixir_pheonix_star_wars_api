defmodule StarWarsApi.Characters.Character do
  use Ecto.Schema
  import Ecto.Changeset

  schema "characters" do
    field :name, :string
    field :species, :string
    field :birth_year, :string

    # This automatically uses planet_id
    belongs_to :planet, StarWarsApi.Planets.Planet
    many_to_many :movies, StarWarsApi.Movies.Movie, join_through: "movies_characters"

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(character, attrs) do
    character
    |> cast(attrs, [:name, :species, :birth_year])
    |> validate_required([:name, :species, :birth_year])
  end
end
