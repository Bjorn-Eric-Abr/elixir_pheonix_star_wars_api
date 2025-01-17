defmodule StarWarsApi.MoviesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `StarWarsApi.Movies` context.
  """

  @doc """
  Generate a movie.
  """
  def movie_fixture(attrs \\ %{}) do
    {:ok, movie} =
      attrs
      |> Enum.into(%{
        director: "some director",
        episode_id: 42,
        release_date: ~D[2024-12-12],
        title: "some title"
      })
      |> StarWarsApi.Movies.create_movie()

    movie
  end
end
