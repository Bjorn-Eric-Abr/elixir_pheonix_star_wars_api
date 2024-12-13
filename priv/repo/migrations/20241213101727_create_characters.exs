defmodule StarWarsApi.Repo.Migrations.CreateCharacters do
  use Ecto.Migration

  def change do
    create table(:characters) do
      add :name, :string
      add :species, :string
      add :birth_year, :string

      timestamps(type: :utc_datetime)
    end
  end
end
