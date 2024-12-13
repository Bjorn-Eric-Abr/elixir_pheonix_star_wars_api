defmodule StarWarsApiWeb.CharacterController do
  use StarWarsApiWeb, :controller

  alias StarWarsApi.Characters
  alias StarWarsApi.Characters.Character

  action_fallback StarWarsApiWeb.FallbackController

  def index(conn, _params) do
    characters = Characters.list_characters() |> StarWarsApi.Repo.preload([:planet, :movies])
    render(conn, :index, characters: characters)
  end

  def create(conn, %{"character" => character_params}) do
    with {:ok, %Character{} = character} <- Characters.create_character(character_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/characters/#{character}")
      |> render(:show, character: character)
    end
  end

  def show(conn, %{"id" => id}) do
    character = Characters.get_character!(id) |> StarWarsApi.Repo.preload([:planet, :movies])
    render(conn, :show, character: character)
  end

  def update(conn, %{"id" => id, "character" => character_params}) do
    character = Characters.get_character!(id)

    with {:ok, %Character{} = character} <-
           Characters.update_character(character, character_params) do
      render(conn, :show, character: character)
    end
  end

  def delete(conn, %{"id" => id}) do
    character = Characters.get_character!(id)

    with {:ok, %Character{}} <- Characters.delete_character(character) do
      send_resp(conn, :no_content, "")
    end
  end
end
