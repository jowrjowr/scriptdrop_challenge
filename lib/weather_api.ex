defmodule Sweater.WeatherAPI do
  
  def fetch(city) do
    location = "#{city}"
    fetch_location(location)
  end

  def fetch(city, state_code) do
    location = "#{city},#{state_code}"
    fetch_location(location)
  end

  def fetch(city, state_code, country_code) do
    location = "#{city},#{state_code},#{country_code}"
    fetch_location(location)
  end
  
  defp fetch_location(location) do
    # see https://openweathermap.org/forecast5 for full api documentation

    # note: they are really serious about iso 3166.
    # https://en.wikipedia.org/wiki/ISO_3166-2:US

    api_version = "2.5"

    base_url = "https://api.openweathermap.org/data/#{api_version}/forecast"
    api_key = Application.get_env(:sweater, :openweather_api_key)

    query = %{
      appid: api_key,
      q: location,
      mode: "json",
      units: "imperial",
      lang: "en"
    }

    uri_string =
      base_url
      |> URI.parse()
      |> Map.put(:query, URI.encode_query(query))
      |> URI.to_string()

    {:ok, response} = Mojito.request(method: :get, url: uri_string)

    Jason.decode(response.body, keys: :atoms)

  end
end