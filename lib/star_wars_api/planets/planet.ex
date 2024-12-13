defmodule StarWarsApi.Planets.Planet do
  use Ecto.Schema
  import Ecto.Changeset

  schema "planets" do
    field :name, :string
    field :climate, :string
    field :terrain, :string
    field :population, :integer

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(planet, attrs) do
    planet
    |> cast(attrs, [:name, :climate, :terrain, :population])
    |> validate_required([:name, :climate, :terrain, :population])
  end
end
