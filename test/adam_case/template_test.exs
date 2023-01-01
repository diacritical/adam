defmodule AdamCase.TemplateTest do
  @moduledoc "Defines an `ExUnit.Case` case."
  @moduledoc since: "0.6.0"

  use AdamCase.Template, async: true

  alias AdamCase, as: Case

  alias Case.Template

  doctest Template, import: true

  describe "__ex_unit__/2" do
    setup :c_context

    test ":setup", %{context: context} do
      assert Template.__ex_unit__(:setup, context.valid) == context.valid
    end

    test ":setup_all", %{context: context} do
      assert Template.__ex_unit__(:setup_all, context.valid) == context.valid
    end
  end

  describe "c_context/0" do
    import Template, only: [c_context: 0]

    test "success" do
      assert %{context: _context} = c_context()
    end
  end

  describe "c_context/1" do
    import Template, only: [c_context: 1]

    setup :c_context

    test "FunctionClauseError", %{context: context} do
      assert_raise FunctionClauseError, fn -> c_context(context.invalid) end
    end

    test "success", %{context: context} do
      assert %{context: _context} = c_context(context.valid)
    end
  end
end
