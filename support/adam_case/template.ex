defmodule AdamCase.Template do
  @moduledoc "Defines an `ExUnit.CaseTemplate` case template."
  @moduledoc since: "0.6.0"

  use AdamCase

  alias AdamCase, as: Case

  @typedoc "Represents the current context."
  @typedoc since: "0.6.0"
  @type context() :: Case.context()

  @typedoc "Represents the context merge value."
  @typedoc since: "0.6.0"
  @type context_merge() :: Case.context_merge()

  @doc """
  Defines a map of fixtures to be merged into an `ExUnit` context.

  ## Example

      iex> %{context: _context} = c_context()

  """
  @doc since: "0.6.0"
  @spec c_context() :: context_merge()
  @spec c_context(context()) :: context_merge()
  def c_context(c \\ %{}) when is_map(c) do
    %{context: %{invalid: [], valid: %{}}}
  end

  using do
    quote do
      import unquote(__MODULE__)
    end
  end
end
