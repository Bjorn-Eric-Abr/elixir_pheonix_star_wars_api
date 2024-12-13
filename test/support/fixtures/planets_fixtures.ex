defmodule StarWarsApi.PlanetsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `StarWarsApi.Planets` context.
  """

  @doc """
  Generate a planet.
  """
  def planet_fixture(attrs \\ %{}) do
    {:ok, planet} =
      attrs
      |> Enum.into(%{
        climate: "some climate",
        name: "some name",
        population: 42,
        terrain: "some terrain"
      })
      |> StarWarsApi.Planets.create_planet()

    planet
  end
end
