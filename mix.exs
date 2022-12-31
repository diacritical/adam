defmodule Adam.MixProject do
  @moduledoc "Defines a `Mix.Project` project."
  @moduledoc since: "0.1.0"

  use Mix.Project

  @typedoc "Represents the environment."
  @typedoc since: "0.2.0"
  @type env() :: :dev | :prod | :test | atom()

  @typedoc "Represents the module documentation grouping."
  @typedoc since: "0.2.0"
  @type groups_for_modules() :: Keyword.t([module()]) | nil

  @typedoc "Represents the project configuration keyword."
  @typedoc since: "0.1.0"
  @type project_keyword() ::
          {:app, Application.app()}
          | {:version, String.t()}
          | {Keyword.key(), Keyword.value()}

  @typedoc "Represents the project configuration."
  @typedoc since: "0.1.0"
  @type project() :: [project_keyword()]

  @spec groups_for_modules(env()) :: groups_for_modules()
  defp groups_for_modules(:dev) do
    ".boundary.exs" |> Code.eval_file() |> elem(0)
  end

  defp groups_for_modules(env) when is_atom(env) do
    nil
  end

  @doc """
  Defines the project configuration for `Adam`.

  ## Examples

      iex> project()[:app]
      :adam

      iex> project()[:version]
      "0.1.0"

  """
  @doc since: "0.1.0"
  @spec project() :: project()
  def project() do
    [
      aliases: [
        "boundary.ex_doc_groups": [
          "boundary.ex_doc_groups",
          "cmd tail -n +2 boundary.exs > .boundary.exs",
          "cmd rm boundary.exs"
        ],
        credo: "credo --config-name app"
      ],
      app: :adam,
      boundary: [default: [type: :strict]],
      build_path: "../../_build",
      compilers: [:boundary | Mix.compilers()],
      deps: [
        {:boundary, "~> 0.9", runtime: false},
        {:credo, "~> 1.6", only: [:dev, :test], runtime: false},
        {:dialyxir, "~> 1.2", only: :dev, runtime: false},
        {:ex_doc, "~> 0.29", only: :dev, runtime: false}
      ],
      deps_path: "../../dep",
      dialyzer: [ignore_warnings: ".dialyzer.exs"],
      docs: [groups_for_modules: groups_for_modules(Mix.env())],
      elixir: "~> 1.14",
      elixirc_options: [warnings_as_errors: true],
      homepage_url: "https://diacritical.net",
      lockfile: "../../mix.lock",
      name: "Adam",
      source_url: "https://github.com/diacritical/adam",
      start_permanent: Mix.env() == :prod,
      version: "0.1.0"
    ]
  end
end
