# Sweater

Produces clothing reccomendations based upon a yaml specification using the OpenWeatherMap API.

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `sweater` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:sweater, "~> 0.1.0"}
  ]
end
```

## Tests

Run with `mix test`

## Usage

Start with `iex -S mix` and produce reccomendations with one of the following commands:

1. `Sweater.fetch_clothing_recs(city)`
1. `Sweater.fetch_clothing_recs(city, state_code)`
1. `Sweater.fetch_clothing_recs(city, state_code, country_code)`

The various state and country codes have to be from [ISO 3166](https://en.wikipedia.org/wiki/ISO_3166-2:US).

# How it went

Straight forward. Interacting with 3rd party APIs is nothing new.

# Improvements

* More tests, a better understanding of the api, fixing to specific versions, etc. 

* Mocking the API and running tests against the mocks, so on and so forth.

* No YAML. The yaml damage is contained to a single function. I would not want to run yaml blobs like that in production, but rather something perhaps database-based.

* Make this a phoenix application that can be used internally.
