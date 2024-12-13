defmodule StarWarsApiWeb.StarshipControllerTest do
  use StarWarsApiWeb.ConnCase

  import StarWarsApi.StarshipsFixtures

  alias StarWarsApi.Starships.Starship

  @create_attrs %{
    name: "some name",
    model: "some model",
    manufacturer: "some manufacturer",
    cost_in_credits: "120.5"
  }
  @update_attrs %{
    name: "some updated name",
    model: "some updated model",
    manufacturer: "some updated manufacturer",
    cost_in_credits: "456.7"
  }
  @invalid_attrs %{name: nil, model: nil, manufacturer: nil, cost_in_credits: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all starships", %{conn: conn} do
      conn = get(conn, ~p"/api/starships")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create starship" do
    test "renders starship when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/starships", starship: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/starships/#{id}")

      assert %{
               "id" => ^id,
               "cost_in_credits" => "120.5",
               "manufacturer" => "some manufacturer",
               "model" => "some model",
               "name" => "some name"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/starships", starship: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update starship" do
    setup [:create_starship]

    test "renders starship when data is valid", %{conn: conn, starship: %Starship{id: id} = starship} do
      conn = put(conn, ~p"/api/starships/#{starship}", starship: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/starships/#{id}")

      assert %{
               "id" => ^id,
               "cost_in_credits" => "456.7",
               "manufacturer" => "some updated manufacturer",
               "model" => "some updated model",
               "name" => "some updated name"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, starship: starship} do
      conn = put(conn, ~p"/api/starships/#{starship}", starship: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete starship" do
    setup [:create_starship]

    test "deletes chosen starship", %{conn: conn, starship: starship} do
      conn = delete(conn, ~p"/api/starships/#{starship}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/starships/#{starship}")
      end
    end
  end

  defp create_starship(_) do
    starship = starship_fixture()
    %{starship: starship}
  end
end
