defmodule AdamCase.SupervisorTest do
  @moduledoc "Defines an `ExUnit.Case` case."
  @moduledoc since: "0.3.0"

  use AdamCase.Template, async: true

  alias AdamCase, as: Case

  alias Case.Supervisor

  doctest Supervisor, import: true

  describe "__ex_unit__/2" do
    setup :c_context

    test ":setup", %{context: context} do
      assert Supervisor.__ex_unit__(:setup, context.valid) == context.valid
    end

    test ":setup_all", %{context: context} do
      assert Supervisor.__ex_unit__(:setup_all, context.valid) == context.valid
    end
  end

  describe "c_err/0" do
    import Supervisor, only: [c_err: 0]

    test "success" do
      assert %{err: _err} = c_err()
    end
  end

  describe "c_err/1" do
    import Supervisor, only: [c_err: 1]

    setup :c_context

    test "FunctionClauseError", %{context: context} do
      assert_raise FunctionClauseError, fn -> c_err(context.invalid) end
    end

    test "success", %{context: context} do
      assert %{err: _err} = c_err(context.valid)
    end
  end

  describe "c_init_arg/0" do
    import Supervisor, only: [c_init_arg: 0]

    test "success" do
      assert %{init_arg: _init_arg} = c_init_arg()
    end
  end

  describe "c_init_arg/1" do
    import Supervisor, only: [c_init_arg: 1]

    setup :c_context

    test "FunctionClauseError", %{context: context} do
      assert_raise FunctionClauseError, fn -> c_init_arg(context.invalid) end
    end

    test "success", %{context: context} do
      assert %{init_arg: _init_arg} = c_init_arg(context.valid)
    end
  end
end
