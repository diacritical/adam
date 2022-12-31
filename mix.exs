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
      app: :adam,
      build_path: "../../_build",
      deps: [],
      deps_path: "../../dep",
      elixir: "~> 1.14",
      elixirc_options: [warnings_as_errors: true],
      lockfile: "../../mix.lock",
      start_permanent: Mix.env() == :prod,
      version: "0.1.0"
    ]
  end
end
