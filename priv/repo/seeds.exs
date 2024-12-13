# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     StarWarsApi.Repo.insert!(%StarWarsApi.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
alias StarWarsApi.Repo
alias StarWarsApi.Movies.Movie
alias StarWarsApi.Characters.Character
alias StarWarsApi.Planets.Planet

# Insert planets
{:ok, tatooine} =
  Repo.insert(%Planet{
    name: "Tatooine",
    climate: "Arid",
    terrain: "Desert",
    population: 200_000
  })

{:ok, alderaan} =
  Repo.insert(%Planet{
    name: "Alderaan",
    climate: "Temperate",
    terrain: "Grasslands, Mountains",
    population: 2_000_000_000
  })

# Insert characters
{:ok, luke} =
  Repo.insert(%Character{
    name: "Luke Skywalker",
    species: "Human",
    birth_year: "19 BBY",
    planet_id: tatooine.id
  })

{:ok, leia} =
  Repo.insert(%Character{
    name: "Leia Organa",
    species: "Human",
    birth_year: "19 BBY",
    planet_id: alderaan.id
  })

# Insert movies
{:ok, new_hope} =
  Repo.insert(%Movie{
    title: "A New Hope",
    episode_id: 4,
    release_date: ~D[1977-05-25],
    director: "George Lucas"
  })

{:ok, empire} =
  Repo.insert(%Movie{
    title: "The Empire Strikes Back",
    episode_id: 5,
    release_date: ~D[1980-05-21],
    director: "Irvin Kershner"
  })

# Add characters to movies through the join table
Repo.insert!(%StarWarsApi.Movies.MovieCharacter{
  movie_id: new_hope.id,
  character_id: luke.id
})

Repo.insert!(%StarWarsApi.Movies.MovieCharacter{
  movie_id: new_hope.id,
  character_id: leia.id
})

Repo.insert!(%StarWarsApi.Movies.MovieCharacter{
  movie_id: empire.id,
  character_id: luke.id
})

Repo.insert!(%StarWarsApi.Movies.MovieCharacter{
  movie_id: empire.id,
  character_id: leia.id
})
