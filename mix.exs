defmodule PaginatorTG.MixProject do
  use Mix.Project

  def project do
    [
      app: :paginator_tg,
      version: "0.1.0",
      elixir: "~> 1.7",
      elixirc_paths: elixirc_paths(Mix.env()),
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

  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:earmark, "~> 1.3", only: :dev},
      {:ex_doc, "~> 0.19", only: :dev},
      {:credo, "~> 0.10", only: [:dev, :test], runtime: false},
      {:paginator, "~> 0.6"},
      {:ecto, "~> 3.0"},
      {:ecto_sql, "~> 3.0"},
      {:postgrex, ">= 0.0.0", optional: true}
    ]
  end
end
