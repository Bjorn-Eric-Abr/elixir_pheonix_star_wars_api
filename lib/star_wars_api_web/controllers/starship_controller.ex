defmodule StarWarsApiWeb.StarshipController do
  use StarWarsApiWeb, :controller

  alias StarWarsApi.Starships
  alias StarWarsApi.Starships.Starship

  action_fallback StarWarsApiWeb.FallbackController

  def index(conn, _params) do
    starships = Starships.list_starships()
    render(conn, :index, starships: starships)
  end

  def create(conn, %{"starship" => starship_params}) do
    with {:ok, %Starship{} = starship} <- Starships.create_starship(starship_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/starships/#{starship}")
      |> render(:show, starship: starship)
    end
  end

  def show(conn, %{"id" => id}) do
    starship = Starships.get_starship!(id)
    render(conn, :show, starship: starship)
  end

  def update(conn, %{"id" => id, "starship" => starship_params}) do
    starship = Starships.get_starship!(id)

    with {:ok, %Starship{} = starship} <- Starships.update_starship(starship, starship_params) do
      render(conn, :show, starship: starship)
    end
  end

  def delete(conn, %{"id" => id}) do
    starship = Starships.get_starship!(id)

    with {:ok, %Starship{}} <- Starships.delete_starship(starship) do
      send_resp(conn, :no_content, "")
    end
  end
end
