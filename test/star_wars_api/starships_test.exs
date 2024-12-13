defmodule StarWarsApi.StarshipsTest do
  use StarWarsApi.DataCase

  alias StarWarsApi.Starships

  describe "starships" do
    alias StarWarsApi.Starships.Starship

    import StarWarsApi.StarshipsFixtures

    @invalid_attrs %{name: nil, model: nil, manufacturer: nil, cost_in_credits: nil}

    test "list_starships/0 returns all starships" do
      starship = starship_fixture()
      assert Starships.list_starships() == [starship]
    end

    test "get_starship!/1 returns the starship with given id" do
      starship = starship_fixture()
      assert Starships.get_starship!(starship.id) == starship
    end

    test "create_starship/1 with valid data creates a starship" do
      valid_attrs = %{name: "some name", model: "some model", manufacturer: "some manufacturer", cost_in_credits: "120.5"}

      assert {:ok, %Starship{} = starship} = Starships.create_starship(valid_attrs)
      assert starship.name == "some name"
      assert starship.model == "some model"
      assert starship.manufacturer == "some manufacturer"
      assert starship.cost_in_credits == Decimal.new("120.5")
    end

    test "create_starship/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Starships.create_starship(@invalid_attrs)
    end

    test "update_starship/2 with valid data updates the starship" do
      starship = starship_fixture()
      update_attrs = %{name: "some updated name", model: "some updated model", manufacturer: "some updated manufacturer", cost_in_credits: "456.7"}

      assert {:ok, %Starship{} = starship} = Starships.update_starship(starship, update_attrs)
      assert starship.name == "some updated name"
      assert starship.model == "some updated model"
      assert starship.manufacturer == "some updated manufacturer"
      assert starship.cost_in_credits == Decimal.new("456.7")
    end

    test "update_starship/2 with invalid data returns error changeset" do
      starship = starship_fixture()
      assert {:error, %Ecto.Changeset{}} = Starships.update_starship(starship, @invalid_attrs)
      assert starship == Starships.get_starship!(starship.id)
    end

    test "delete_starship/1 deletes the starship" do
      starship = starship_fixture()
      assert {:ok, %Starship{}} = Starships.delete_starship(starship)
      assert_raise Ecto.NoResultsError, fn -> Starships.get_starship!(starship.id) end
    end

    test "change_starship/1 returns a starship changeset" do
      starship = starship_fixture()
      assert %Ecto.Changeset{} = Starships.change_starship(starship)
    end
  end
end
