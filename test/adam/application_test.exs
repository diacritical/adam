defmodule Adam.ApplicationTest do
  @moduledoc "Defines an `ExUnit.Case` case."
  @moduledoc since: "0.3.0"

  use AdamCase.Supervisor, async: true

  alias Adam, as: Core

  alias Core.Application

  doctest Application, import: true

  describe "app/0" do
    import Application, only: [app: 0]

    test "success" do
      assert app() == :adam
    end
  end

  describe "start/2" do
    import Application, only: [start: 2]

    setup [:c_init_arg, :c_err]

    setup do
      %{start_type: %{invalid: "normal", valid: :normal}}
    end

    test "FunctionClauseError", %{init_arg: init_arg, start_type: start_type} do
      assert_raise FunctionClauseError, fn ->
        start(start_type.invalid, init_arg.valid)
      end

      assert_raise FunctionClauseError, fn ->
        start(start_type.valid, init_arg.invalid)
      end
    end

    test "success", %{err: err, init_arg: init_arg, start_type: start_type} do
      assert start(start_type.valid, init_arg.valid) == err
    end
  end

  describe "stop/1" do
    import Application, only: [stop: 1]

    test "success" do
      assert stop([]) == :ok
    end
  end
end
