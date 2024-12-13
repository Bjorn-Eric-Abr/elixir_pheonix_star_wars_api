defmodule StarWarsApi.Repo.Migrations.CreatePlanets do
  use Ecto.Migration

  def change do
    create table(:planets) do
      add :name, :string
      add :climate, :string
      add :terrain, :string
      add :population, :integer

      timestamps(type: :utc_datetime)
    end
  end
end
