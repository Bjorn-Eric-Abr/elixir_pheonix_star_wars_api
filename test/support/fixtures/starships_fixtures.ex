defmodule StarWarsApi.StarshipsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `StarWarsApi.Starships` context.
  """

  @doc """
  Generate a starship.
  """
  def starship_fixture(attrs \\ %{}) do
    {:ok, starship} =
      attrs
      |> Enum.into(%{
        cost_in_credits: "120.5",
        manufacturer: "some manufacturer",
        model: "some model",
        name: "some name"
      })
      |> StarWarsApi.Starships.create_starship()

    starship
  end
end
