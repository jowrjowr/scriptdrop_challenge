defmodule Sweater.MixProject do
  use Mix.Project

  def project do
    [
      app: :sweater,
      version: "0.1.0",
      elixir: "~> 1.11",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:jason, "~> 1.0"},
      {:mojito, "~> 0.7.7"},
      {:yaml_elixir, "~> 2.6.0"}
    ]
  end
end
