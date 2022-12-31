defmodule Adam.MixProject do
  @moduledoc "Defines a `Mix.Project` project and an OTP application."
  @moduledoc since: "0.1.0"

  use Mix.Project

  alias Adam, as: Core

  alias Core.Application

  @typedoc "Represents the environment."
  @typedoc since: "0.2.0"
  @type env() :: :dev | :prod | :test | atom()

  @typedoc "Represents the module documentation grouping."
  @typedoc since: "0.2.0"
  @type groups_for_modules() :: Keyword.t([module()]) | nil

  @typedoc "Represents the compilation path."
  @typedoc since: "0.3.0"
  @type elixirc_paths() :: [Path.t()]

  @typedoc "Represents the project configuration keyword."
  @typedoc since: "0.1.0"
  @type project_keyword() ::
          {:app, Application.app()}
          | {:version, String.t()}
          | {Keyword.key(), Keyword.value()}

  @typedoc "Represents the project configuration."
  @typedoc since: "0.1.0"
  @type project() :: [project_keyword()]

  @typedoc "Represents the application configuration keyword."
  @typedoc since: "0.3.0"
  @type application_keyword() ::
          {:mod, {module(), Application.init_arg()}}
          | {Keyword.key(), Keyword.value()}

  @typedoc "Represents the application configuration."
  @typedoc since: "0.3.0"
  @type application() :: [application_keyword()]

  @spec groups_for_modules(env()) :: groups_for_modules()
  defp groups_for_modules(:dev) do
    ".boundary.exs" |> Code.eval_file() |> elem(0)
  end

  defp groups_for_modules(env) when is_atom(env) do
    nil
  end

  @spec elixirc_paths(env()) :: elixirc_paths()
  defp elixirc_paths(:dev) do
    elixirc_paths(:test)
  end

  defp elixirc_paths(:test) do
    ["support" | elixirc_paths(:prod)]
  end

  defp elixirc_paths(env) when is_atom(env) do
    ["lib"]
  end

  @doc """
  Defines the project configuration for `Adam`.

  ## Examples

      iex> project()[:app]
      :adam

      iex> project()[:version]
      "0.2.0"

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
      elixirc_paths: elixirc_paths(Mix.env()),
      homepage_url: "https://diacritical.net",
      lockfile: "../../mix.lock",
      name: "Adam",
      source_url: "https://github.com/diacritical/adam",
      start_permanent: Mix.env() == :prod,
      version: "0.2.0"
    ]
  end

  @doc """
  Defines the application configuration for `Adam`.

  ## Example

      iex> {Application, _init_arg} = application()[:mod]

  """
  @doc since: "0.3.0"
  @spec application() :: application()
  def application() do
    [mod: {Application, []}]
  end
end
