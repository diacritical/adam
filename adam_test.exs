ExUnit.start()

defmodule AdamTest do
  @moduledoc "Defines an `ExUnit.Case` case."
  @moduledoc since: "0.1.0"

  use ExUnit.Case, async: true

  alias Adam, as: Core

  doctest Core, import: true

  describe "greet/0" do
    import Core, only: [greet: 0]

    test "success" do
      assert greet() == "Hello, world!"
    end
  end
end
