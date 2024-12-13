defmodule StarWarsApi.Repo.Migrations.CreateMovies do
  use Ecto.Migration

  def change do
    create table(:movies) do
      add :title, :string
      add :episode_id, :integer
      add :release_date, :date
      add :director, :string

      timestamps(type: :utc_datetime)
    end
  end
end
