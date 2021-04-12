defmodule Sweater do

  alias Sweater.WeatherAPI

  def fetch_clothing_recs(city) do

    {:ok, data} = WeatherAPI.fetch(city)

    recs =
      data
      |> Map.get(:list)
      |> Enum.reduce([], fn item, acc -> produce_recs(acc, item) end)
      |> Map.new()

    recs

  end

  def fetch_clothing_recs(city, state_code) do

    {:ok, data} = WeatherAPI.fetch(city, state_code)

    recs =
      data
      |> Map.get(:list)
      |> Enum.reduce([], fn item, acc -> produce_recs(acc, item) end)
      |> Map.new()

    recs

  end

  def fetch_clothing_recs(city, state_code, country_code) do

    {:ok, data} = WeatherAPI.fetch(city, state_code, country_code)

    recs =
      data
      |> Map.get(:list)
      |> Enum.reduce([], fn item, acc -> produce_recs(acc, item) end)
      |> Map.new()

    recs

  end

  def produce_recs(acc, item) do

    temp = item[:main][:feels_like]
    {:ok, time} = DateTime.from_unix(item[:dt])

    conditions =
      item
      |> Map.get(:weather)
      |> hd()
      |> Map.get(:id)
      |> conditions()

    clothing_rec = clothing_rec(temp, conditions)

    result = %{
      temp: temp,
      conditions: conditions,
      clothing: clothing_rec
    }

    acc ++ [{time, result}]

  end

  def conditions(id) when id >= 200 and id < 300, do: :thunderstorm
  def conditions(id) when id >= 300 and id < 400, do: :drizzle
  def conditions(id) when id >= 500 and id < 600, do: :rain
  def conditions(id) when id >= 600 and id < 700, do: :snow
  def conditions(id) when id >= 700 and id < 800, do: :atmosphere
  def conditions(id) when id == 800, do: :clear
  def conditions(id) when id > 800 and id < 900, do: :clouds
  def conditions(id), do: :unknown

  def clothing_rec(_, :unknown), do: []
  
  def clothing_rec(temp, conditions) do

    yaml_path = Application.get_env(:sweater, :recs_yaml)
    yaml_path = Path.join(File.cwd!(), yaml_path)

    {:ok, %{"available_recommendations" => recs }} = YamlElixir.read_from_file(yaml_path)

    # if you are in this group, you need weatherproof gear.

    weatherproof = [:thunderstorm, :drizzle, :rain, :snow]

    # return everything appropriate for the conditions

    recs
    |> Enum.filter(fn item -> 
      item["waterproof"] == Enum.member?(weatherproof, conditions)
    end)
    |> Enum.reduce([], fn item, acc -> 

      min_temp = item["min_temp"]
      max_temp = item["max_temp"]
      item_name = item["name"]

      # use this item if temperature falls in the appropriate range      
      if temp > min_temp and temp < max_temp do
        acc ++ [item_name]
      else
        acc
      end
    end)

  end
end
