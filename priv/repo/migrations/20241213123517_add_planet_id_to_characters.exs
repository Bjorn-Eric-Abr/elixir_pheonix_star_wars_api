defmodule StarWarsApi.Repo.Migrations.AddPlanetIdToCharacters do
  use Ecto.Migration

  def change do
    alter table(:characters) do
      add :planet_id, references(:planets)
    end
  end
end
