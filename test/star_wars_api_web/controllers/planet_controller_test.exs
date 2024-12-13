defmodule StarWarsApiWeb.PlanetControllerTest do
  use StarWarsApiWeb.ConnCase

  import StarWarsApi.PlanetsFixtures

  alias StarWarsApi.Planets.Planet

  @create_attrs %{
    name: "some name",
    climate: "some climate",
    terrain: "some terrain",
    population: 42
  }
  @update_attrs %{
    name: "some updated name",
    climate: "some updated climate",
    terrain: "some updated terrain",
    population: 43
  }
  @invalid_attrs %{name: nil, climate: nil, terrain: nil, population: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all planets", %{conn: conn} do
      conn = get(conn, ~p"/api/planets")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create planet" do
    test "renders planet when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/planets", planet: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/planets/#{id}")

      assert %{
               "id" => ^id,
               "climate" => "some climate",
               "name" => "some name",
               "population" => 42,
               "terrain" => "some terrain"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/planets", planet: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update planet" do
    setup [:create_planet]

    test "renders planet when data is valid", %{conn: conn, planet: %Planet{id: id} = planet} do
      conn = put(conn, ~p"/api/planets/#{planet}", planet: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/planets/#{id}")

      assert %{
               "id" => ^id,
               "climate" => "some updated climate",
               "name" => "some updated name",
               "population" => 43,
               "terrain" => "some updated terrain"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, planet: planet} do
      conn = put(conn, ~p"/api/planets/#{planet}", planet: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete planet" do
    setup [:create_planet]

    test "deletes chosen planet", %{conn: conn, planet: planet} do
      conn = delete(conn, ~p"/api/planets/#{planet}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/planets/#{planet}")
      end
    end
  end

  defp create_planet(_) do
    planet = planet_fixture()
    %{planet: planet}
  end
end
