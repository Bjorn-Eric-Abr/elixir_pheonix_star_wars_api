defmodule StarWarsApi.CharactersFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `StarWarsApi.Characters` context.
  """

  @doc """
  Generate a character.
  """
  def character_fixture(attrs \\ %{}) do
    {:ok, character} =
      attrs
      |> Enum.into(%{
        birth_year: "some birth_year",
        name: "some name",
        species: "some species"
      })
      |> StarWarsApi.Characters.create_character()

    character
  end
end
