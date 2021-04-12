defmodule SweaterTest.WeatherAPI do
  use ExUnit.Case
  doctest Sweater

  describe "conditions" do
    test "thunderstorm" do

      codes = [200, 201, 202, 210, 211, 212, 221, 230, 231, 232]
      expected_condition = :thunderstorm

      for code <- codes, do: assert Sweater.conditions(code) == expected_condition
      
    end

    test "drizzle" do

      codes = [300, 301, 302, 310, 311, 312, 313, 314, 321]
      expected_condition = :drizzle

      for code <- codes, do: assert Sweater.conditions(code) == expected_condition
      
    end

    test "rain" do

      codes = [500, 501, 502, 503, 504, 511, 520, 521, 522, 531]
      expected_condition = :rain

      for code <- codes, do: assert Sweater.conditions(code) == expected_condition
      
    end

    test "snow" do

      codes = [600, 601, 602, 611, 612, 613, 615, 616, 620, 621, 622]
      expected_condition = :snow

      for code <- codes, do: assert Sweater.conditions(code) == expected_condition
      
    end

    test "atmosphere" do

      codes = [701, 711, 721, 731, 741, 751, 761, 762, 771, 781]
      expected_condition = :atmosphere

      for code <- codes, do: assert Sweater.conditions(code) == expected_condition
      
    end

    test "clear" do

      assert Sweater.conditions(800) == :clear
      
    end

    test "clouds" do

      codes = [801, 802, 803, 804]
      expected_condition = :clouds

      for code <- codes, do: assert Sweater.conditions(code) == expected_condition
      
    end

  end

  describe "clothing" do
    test "unknown" do
      temp = 500

      assert Sweater.clothing_rec(temp, :unknown) == []

    end

  end

end
