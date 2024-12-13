defmodule StarWarsApi.Starships.Starship do
  use Ecto.Schema
  import Ecto.Changeset

  schema "starships" do
    field :name, :string
    field :model, :string
    field :manufacturer, :string
    field :cost_in_credits, :decimal

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(starship, attrs) do
    starship
    |> cast(attrs, [:name, :model, :manufacturer, :cost_in_credits])
    |> validate_required([:name, :model, :manufacturer, :cost_in_credits])
  end
end
