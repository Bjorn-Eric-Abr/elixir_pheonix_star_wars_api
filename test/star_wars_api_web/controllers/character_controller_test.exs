defmodule StarWarsApiWeb.CharacterControllerTest do
  use StarWarsApiWeb.ConnCase

  import StarWarsApi.CharactersFixtures

  alias StarWarsApi.Characters.Character

  @create_attrs %{
    name: "some name",
    species: "some species",
    birth_year: "some birth_year"
  }
  @update_attrs %{
    name: "some updated name",
    species: "some updated species",
    birth_year: "some updated birth_year"
  }
  @invalid_attrs %{name: nil, species: nil, birth_year: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all characters", %{conn: conn} do
      conn = get(conn, ~p"/api/characters")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create character" do
    test "renders character when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/characters", character: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/characters/#{id}")

      assert %{
               "id" => ^id,
               "birth_year" => "some birth_year",
               "name" => "some name",
               "species" => "some species"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/characters", character: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update character" do
    setup [:create_character]

    test "renders character when data is valid", %{conn: conn, character: %Character{id: id} = character} do
      conn = put(conn, ~p"/api/characters/#{character}", character: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/characters/#{id}")

      assert %{
               "id" => ^id,
               "birth_year" => "some updated birth_year",
               "name" => "some updated name",
               "species" => "some updated species"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, character: character} do
      conn = put(conn, ~p"/api/characters/#{character}", character: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete character" do
    setup [:create_character]

    test "deletes chosen character", %{conn: conn, character: character} do
      conn = delete(conn, ~p"/api/characters/#{character}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/characters/#{character}")
      end
    end
  end

  defp create_character(_) do
    character = character_fixture()
    %{character: character}
  end
end
