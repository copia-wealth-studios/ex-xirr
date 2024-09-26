defmodule ExXirr.Mixfile do
  use Mix.Project

  def project do
    [
      app: :ex_xirr,
      version: "1.0.0",
      elixir: "~> 1.6",
      build_embedded: Mix.env() == :prod,
      start_permanent: Mix.env() == :prod,
      description: description(),
      test_coverage: [tool: ExCoveralls],
      docs: [
        main: "readme",
        extras: ["README.md"]
      ],
      preferred_cli_env: [
        coveralls: :test,
        "coveralls.detail": :test,
        "coveralls.post": :test,
        "coveralls.html": :test
      ],
      package: package(),
      deps: deps()
    ]
  end

  def application do
    [extra_applications: [:logger, :timex]]
  end

  defp description do
    "A library to calculate Xirr using the Newton method using parallel processes."
  end

  defp package do
    [
      files: ["lib", "bench", "mix.exs", "README*"],
      maintainers: ["Shubham Gupta"],
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/scripbox/ex-elixir"}
    ]
  end

  defp deps do
    [
      {:timex, "~> 3.7.11"},
      {:ex_doc, "~> 0.34.2", only: :dev},
      {:benchee, "~> 1.3.1", only: :dev},
      {:benchee_html, "~> 1.0.1", only: :dev},
      {:excoveralls, "~> 0.18.3", only: :test}
    ]
  end
end
