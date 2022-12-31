defmodule AdamCase.Supervisor do
  @moduledoc "Defines an `ExUnit.CaseTemplate` case template."
  @moduledoc since: "0.3.0"

  use AdamCase

  alias Adam, as: Core
  alias AdamCase, as: Case

  alias Core.Supervisor

  @typedoc "Represents the current context."
  @typedoc since: "0.3.0"
  @type context() :: Case.context()

  @typedoc "Represents the context merge value."
  @typedoc since: "0.3.0"
  @type context_merge() :: Case.context_merge()

  @doc """
  Defines a map of fixtures to be merged into an `ExUnit` context.

  ## Example

      iex> %{err: _err} = c_err()

  """
  @doc since: "0.3.0"
  @spec c_err() :: context_merge()
  @spec c_err(context()) :: context_merge()
  def c_err(c \\ %{}) when is_map(c) do
    %{err: {:error, {:already_started, Process.whereis(Supervisor)}}}
  end

  @doc """
  Defines a map of fixtures to be merged into an `ExUnit` context.

  ## Example

      iex> %{init_arg: _init_arg} = c_init_arg()

  """
  @doc since: "0.3.0"
  @spec c_init_arg() :: context_merge()
  @spec c_init_arg(context()) :: context_merge()
  def c_init_arg(c \\ %{}) when is_map(c) do
    %{init_arg: %{invalid: %{}, valid: []}}
  end

  using do
    quote do
      import unquote(__MODULE__)
    end
  end
end
