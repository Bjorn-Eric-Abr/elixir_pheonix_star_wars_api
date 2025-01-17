defmodule StarWarsApi.CharactersTest do
  use StarWarsApi.DataCase

  alias StarWarsApi.Characters

  describe "characters" do
    alias StarWarsApi.Characters.Character

    import StarWarsApi.CharactersFixtures

    @invalid_attrs %{name: nil, species: nil, birth_year: nil}

    test "list_characters/0 returns all characters" do
      character = character_fixture()
      assert Characters.list_characters() == [character]
    end

    test "get_character!/1 returns the character with given id" do
      character = character_fixture()
      assert Characters.get_character!(character.id) == character
    end

    test "create_character/1 with valid data creates a character" do
      valid_attrs = %{name: "some name", species: "some species", birth_year: "some birth_year"}

      assert {:ok, %Character{} = character} = Characters.create_character(valid_attrs)
      assert character.name == "some name"
      assert character.species == "some species"
      assert character.birth_year == "some birth_year"
    end

    test "create_character/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Characters.create_character(@invalid_attrs)
    end

    test "update_character/2 with valid data updates the character" do
      character = character_fixture()
      update_attrs = %{name: "some updated name", species: "some updated species", birth_year: "some updated birth_year"}

      assert {:ok, %Character{} = character} = Characters.update_character(character, update_attrs)
      assert character.name == "some updated name"
      assert character.species == "some updated species"
      assert character.birth_year == "some updated birth_year"
    end

    test "update_character/2 with invalid data returns error changeset" do
      character = character_fixture()
      assert {:error, %Ecto.Changeset{}} = Characters.update_character(character, @invalid_attrs)
      assert character == Characters.get_character!(character.id)
    end

    test "delete_character/1 deletes the character" do
      character = character_fixture()
      assert {:ok, %Character{}} = Characters.delete_character(character)
      assert_raise Ecto.NoResultsError, fn -> Characters.get_character!(character.id) end
    end

    test "change_character/1 returns a character changeset" do
      character = character_fixture()
      assert %Ecto.Changeset{} = Characters.change_character(character)
    end
  end
end
