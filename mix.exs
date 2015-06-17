defmodule Global.Mixfile do
  use Mix.Project

  def project do
    [app: :global,
     version: "1.0.0",
     elixir: "~> 1.0",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     package: [licenses: ["Apache 2"],
        links: %{"GitHub" => "https://github.com/mgwidmann/global"},
        contributors: ["Matt Widmann"]],
     description: "A wrapper for Erlang's :global module with documentation.",
     deps: deps]
  end

  # Configuration for the OTP application
  #
  # Type `mix help compile.app` for more information
  def application do
    [applications: []]
  end

  # Dependencies can be Hex packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1.0"}
  #
  # Type `mix help deps` for more examples and options
  defp deps do
    []
  end
end
