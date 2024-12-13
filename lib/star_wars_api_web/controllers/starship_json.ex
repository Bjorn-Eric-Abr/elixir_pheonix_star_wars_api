defmodule StarWarsApiWeb.StarshipJSON do
  alias StarWarsApi.Starships.Starship

  @doc """
  Renders a list of starships.
  """
  def index(%{starships: starships}) do
    %{data: for(starship <- starships, do: data(starship))}
  end

  @doc """
  Renders a single starship.
  """
  def show(%{starship: starship}) do
    %{data: data(starship)}
  end

  defp data(%Starship{} = starship) do
    %{
      id: starship.id,
      name: starship.name,
      model: starship.model,
      manufacturer: starship.manufacturer,
      cost_in_credits: starship.cost_in_credits
    }
  end
end
