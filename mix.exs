defmodule Adam.MixProject do
  @moduledoc "Defines a `Mix.Project` project."
  @moduledoc since: "0.1.0"

  use Mix.Project

  @typedoc "Represents the project configuration keyword."
  @typedoc since: "0.1.0"
  @type project_keyword() ::
          {:app, Application.app()}
          | {:version, String.t()}
          | {Keyword.key(), Keyword.value()}

  @typedoc "Represents the project configuration."
  @typedoc since: "0.1.0"
  @type project() :: [project_keyword()]

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
        {:credo, "~> 1.6", only: [:dev, :test], runtime: false}
      ],
      deps_path: "../../dep",
      elixir: "~> 1.14",
      elixirc_options: [warnings_as_errors: true],
      lockfile: "../../mix.lock",
      start_permanent: Mix.env() == :prod,
      version: "0.1.0"
    ]
  end
end
