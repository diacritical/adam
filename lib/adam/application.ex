defmodule Adam.Application do
  @moduledoc "Defines an `Application` application."
  @moduledoc since: "0.3.0"

  use Application

  alias Adam, as: Core

  alias Core.Supervisor

  @typedoc "Represents the application."
  @typedoc since: "0.3.0"
  @type app() :: Application.app()

  @typedoc "Represents the start type."
  @typedoc since: "0.3.0"
  @type start_type() :: Application.start_type()

  @typedoc "Represents the argument used by the start process."
  @typedoc since: "0.3.0"
  @type init_arg() :: Supervisor.init_arg()

  @typedoc "Represents the error given by the start process."
  @typedoc since: "0.3.0"
  @type start_err() :: {:already_started, pid()} | {:shutdown, term()} | term()

  @typedoc "Represents the start process confirmation."
  @typedoc since: "0.3.0"
  @type on_start() :: {:ok, pid()} | {:error, start_err()}

  @typedoc "Represents the state."
  @typedoc since: "0.3.0"
  @type state() :: Application.state()

  @typedoc "Represents the stop confirmation."
  @typedoc since: "0.3.0"
  @type on_stop() :: :ok

  @doc """
  Gets the application for `Adam.Application`.

  ## Example

      iex> app()
      :adam

  """
  @doc since: "0.3.0"
  @spec app() :: app()
  def app() do
    Application.get_application(__MODULE__)
  end

  @impl Application
  @doc """
  Starts the top-level supervisor with the given `start_type` and `init_arg`.

  `Mix` will call this function unless explicitly directed otherwise, such that
  calls to this function will, when the application is running, return a tuple
  in the shape of `{:error, {:already_started, pid}}`, where `pid` is the
  identifier of the already-started top-level supervisor.

  ## Example

      iex> %{init_arg: %{valid: init_arg}} = c_init_arg()
      iex> %{err: err} = c_err()
      iex>
      iex> start(:normal, init_arg)
      err

  """
  @doc since: "0.3.0"
  @spec start(start_type(), init_arg()) :: on_start()
  def start(start_type, init_arg)
      when is_atom(start_type) and is_list(init_arg) do
    Supervisor.start_link(init_arg)
  end

  @impl Application
  @doc """
  Performs cleanup with the given `state` when the application is stopped.

  ## Example

      iex> stop([])
      :ok

  """
  @doc since: "0.3.0"
  @spec stop(state()) :: on_stop()
  def stop(_state) do
    :ok
  end
end
