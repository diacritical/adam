defmodule AdamCaseTest do
  @moduledoc "Defines an `ExUnit.Case` case."
  @moduledoc since: "0.3.0"

  use ExUnit.Case, async: true

  alias AdamCase, as: Case

  doctest Case
end
