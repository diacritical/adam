defmodule Adam.Supervisor do
  @moduledoc "Defines a `Supervisor` supervisor."
  @moduledoc since: "0.3.0"

  use Supervisor

  @typedoc "Represents the argument used by the start process."
  @typedoc since: "0.3.0"
  @type init_arg() :: Keyword.t()

  @typedoc "Represents the child specification."
  @typedoc since: "0.3.0"
  @type child_spec() :: Supervisor.child_spec()

  @typedoc "Represents the flags and child specs given by the initialization."
  @typedoc since: "0.3.0"
  @type init() :: {Supervisor.sup_flags(), [Supervisor.child_spec()]}

  @typedoc "Represents the initialization confirmation."
  @typedoc since: "0.3.0"
  @type on_init() :: {:ok, init()} | :ignore

  @typedoc "Represents the locally registered name of the supervisor."
  @typedoc since: "0.3.0"
  @type name() :: Supervisor.name()

  @typedoc "Represents the option keyword."
  @typedoc since: "0.3.0"
  @type opt_keyword() :: {:name, name()} | {Keyword.key(), Keyword.value()}

  @typedoc "Represents the option used by the start process."
  @typedoc since: "0.3.0"
  @type opt() :: [opt_keyword()]

  @typedoc "Represents the start process confirmation."
  @typedoc since: "0.3.0"
  @type on_start() :: Supervisor.on_start()

  @doc """
  Defines the child spec used to start a supervisor with the given `init_arg`.

  ## Example

      iex> %{init_arg: %{valid: init_arg}} = c_init_arg(%{})
      iex>
      iex> child_spec(init_arg)
      %{
        id: Supervisor,
        start: {Supervisor, :start_link, [init_arg]},
        type: :supervisor
      }

  """
  @doc since: "0.3.0"
  @spec child_spec(init_arg()) :: child_spec()
  def child_spec(init_arg) when is_list(init_arg) do
    %{
      id: __MODULE__,
      start: {__MODULE__, :start_link, [init_arg]},
      type: :supervisor
    }
  end

  @impl Supervisor
  @doc """
  Initializes a supervisor process with the given `init_arg`.

  Whenever a supervisor process is started using `start_link/2`, this function
  is called by the new process to find out about the supervisor’s restart
  strategy, maximum restart intensity, and child specifications.

  Here, if one child process terminates and is to be restarted, only that child
  process is affected, a restart strategy known as `:one_for_one`. In order to
  prevent a supervisor from getting into an infinite loop of child process
  terminations and restarts, a maximum restart intensity is defined using two
  integer values specified with the keys `:intensity` and `:period`.

  ## Example

      iex> %{init_arg: %{valid: init_arg}} = c_init_arg(%{})
      iex>
      iex> init(init_arg)
      {:ok, {%{intensity: 3, period: 5, strategy: :one_for_one}, []}}

  """
  @doc since: "0.3.0"
  @spec init(init_arg()) :: on_init()
  def init(init_arg) when is_list(init_arg) do
    Supervisor.init(init_arg[:children] || [], strategy: :one_for_one)
  end

  @doc """
  Starts a supervisor process with the given `init_arg` and `opt`.

  If an `opt` list is not given, the function will give, by default, the new
  process this module as its locally registered name. This is often done when
  starting the top-level supervisor of the application’s supervision tree.

  ## Example

      iex> start_supervisor!(%{})
      iex> %{init_arg: %{valid: init_arg}} = c_init_arg(%{})
      iex> %{err: err} = c_err(%{})
      iex>
      iex> start_link(init_arg)
      err

  """
  @doc since: "0.3.0"
  @spec start_link(init_arg()) :: on_start()
  @spec start_link(init_arg(), opt()) :: on_start()
  def start_link(init_arg, opt \\ [name: __MODULE__])
      when is_list(init_arg) and is_list(opt) do
    Supervisor.start_link(__MODULE__, init_arg, opt)
  end
end
