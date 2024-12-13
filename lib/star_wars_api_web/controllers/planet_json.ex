defmodule StarWarsApiWeb.PlanetJSON do
  alias StarWarsApi.Planets.Planet

  @doc """
  Renders a list of planets.
  """
  def index(%{planets: planets}) do
    %{data: for(planet <- planets, do: data(planet))}
  end

  @doc """
  Renders a single planet.
  """
  def show(%{planet: planet}) do
    %{data: data(planet)}
  end

  defp data(%Planet{} = planet) do
    %{
      id: planet.id,
      name: planet.name,
      climate: planet.climate,
      terrain: planet.terrain,
      population: planet.population
    }
  end
end
