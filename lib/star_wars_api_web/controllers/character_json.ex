defmodule StarWarsApiWeb.CharacterJSON do
  alias StarWarsApi.Characters.Character

  def index(%{characters: characters}) do
    %{data: for(character <- characters, do: data(character))}
  end

  def show(%{character: character}) do
    %{data: data(character)}
  end

  defp data(%Character{} = character) do
    %{
      id: character.id,
      name: character.name,
      species: character.species,
      birth_year: character.birth_year,
      planet:
        if(Ecto.assoc_loaded?(character.planet) and character.planet) do
          %{
            id: character.planet.id,
            name: character.planet.name,
            climate: character.planet.climate,
            terrain: character.planet.terrain
          }
        end,
      movies:
        if(Ecto.assoc_loaded?(character.movies)) do
          Enum.map(character.movies, fn movie ->
            %{
              id: movie.id,
              title: movie.title,
              episode_id: movie.episode_id
            }
          end)
        end
    }
  end
end
