defmodule PaginatorTG.MixProject do
  use Mix.Project

  @version "0.1.2"

  def project do
    [
      app: :paginator_tg,
      version: @version,
      elixir: "~> 1.7",
      elixirc_paths: elixirc_paths(Mix.env()),
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      description: description(),
      package: package(),

      # Docs
      name: "PaginatorTG",
      source_url: "https://github.com/tapgiants/paginator_tg",
      homepage_url: "https://github.com/tapgiants/paginator_tg",
      docs: [
        source_ref: "v#{@version}",
        main: "PaginatorTG",
        canonical: "http://hexdocs.pm/paginator_tg",
        source_url: "https://github.com/tapgiants/paginator_tg"
      ]
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
      {:paginator, github: "duffelhq/paginator"},
      {:ecto, "~> 3.0"},
      {:ecto_sql, "~> 3.0"},
      {:postgrex, ">= 0.0.0", optional: true}
    ]
  end

  defp description do
    """
    Cursor based pagination. An wrapper arount Paginator package.
    """
  end

  defp package do
    [
      maintainers: ["Tap Giants"],
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/tapgiants/paginator_tg"}
    ]
  end
end
