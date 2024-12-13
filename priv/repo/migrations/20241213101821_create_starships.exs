defmodule StarWarsApi.Repo.Migrations.CreateStarships do
  use Ecto.Migration

  def change do
    create table(:starships) do
      add :name, :string
      add :model, :string
      add :manufacturer, :string
      add :cost_in_credits, :decimal

      timestamps(type: :utc_datetime)
    end
  end
end
