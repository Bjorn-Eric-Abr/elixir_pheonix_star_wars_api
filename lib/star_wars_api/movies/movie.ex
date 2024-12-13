defmodule StarWarsApi.Movies.Movie do
  use Ecto.Schema
  import Ecto.Changeset

  schema "movies" do
    field :title, :string
    field :episode_id, :integer
    field :release_date, :date
    field :director, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(movie, attrs) do
    movie
    |> cast(attrs, [:title, :episode_id, :release_date, :director])
    |> validate_required([:title, :episode_id, :release_date, :director])
  end
end
