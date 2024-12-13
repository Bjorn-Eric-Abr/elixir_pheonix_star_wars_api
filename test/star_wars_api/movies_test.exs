defmodule StarWarsApi.MoviesTest do
  use StarWarsApi.DataCase

  alias StarWarsApi.Movies

  describe "movies" do
    alias StarWarsApi.Movies.Movie

    import StarWarsApi.MoviesFixtures

    @invalid_attrs %{title: nil, episode_id: nil, release_date: nil, director: nil}

    test "list_movies/0 returns all movies" do
      movie = movie_fixture()
      assert Movies.list_movies() == [movie]
    end

    test "get_movie!/1 returns the movie with given id" do
      movie = movie_fixture()
      assert Movies.get_movie!(movie.id) == movie
    end

    test "create_movie/1 with valid data creates a movie" do
      valid_attrs = %{title: "some title", episode_id: 42, release_date: ~D[2024-12-12], director: "some director"}

      assert {:ok, %Movie{} = movie} = Movies.create_movie(valid_attrs)
      assert movie.title == "some title"
      assert movie.episode_id == 42
      assert movie.release_date == ~D[2024-12-12]
      assert movie.director == "some director"
    end

    test "create_movie/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Movies.create_movie(@invalid_attrs)
    end

    test "update_movie/2 with valid data updates the movie" do
      movie = movie_fixture()
      update_attrs = %{title: "some updated title", episode_id: 43, release_date: ~D[2024-12-13], director: "some updated director"}

      assert {:ok, %Movie{} = movie} = Movies.update_movie(movie, update_attrs)
      assert movie.title == "some updated title"
      assert movie.episode_id == 43
      assert movie.release_date == ~D[2024-12-13]
      assert movie.director == "some updated director"
    end

    test "update_movie/2 with invalid data returns error changeset" do
      movie = movie_fixture()
      assert {:error, %Ecto.Changeset{}} = Movies.update_movie(movie, @invalid_attrs)
      assert movie == Movies.get_movie!(movie.id)
    end

    test "delete_movie/1 deletes the movie" do
      movie = movie_fixture()
      assert {:ok, %Movie{}} = Movies.delete_movie(movie)
      assert_raise Ecto.NoResultsError, fn -> Movies.get_movie!(movie.id) end
    end

    test "change_movie/1 returns a movie changeset" do
      movie = movie_fixture()
      assert %Ecto.Changeset{} = Movies.change_movie(movie)
    end
  end
end
