defmodule AdamWeb.EndpointTest do
  @moduledoc "Defines an `ExUnit.Case` case."
  @moduledoc since: "0.4.0"

  use ExUnit.Case, async: true
  use Plug.Test

  alias Adam, as: Core
  alias AdamCase, as: Case
  alias AdamWeb, as: Web

  alias Web.Endpoint

  @typedoc "Represents the current context."
  @typedoc since: "0.4.0"
  @type context() :: Case.context()

  @typedoc "Represents the context merge value."
  @typedoc since: "0.4.0"
  @type context_merge() :: Case.context_merge()

  @spec c_opt(context()) :: context_merge()
  defp c_opt(c) when is_map(c) do
    %{opt: []}
  end

  @spec c_request_path_hello(context()) :: context_merge()
  defp c_request_path_hello(c) when is_map(c) do
    %{request_path: "/hello"}
  end

  @spec c_conn(context()) :: context_merge()
  defp c_conn(c) when is_map(c) do
    %{conn: %{invalid: %{}, valid: conn(:get, c[:request_path] || "/")}}
  end

  @spec c_status_ok(context()) :: context_merge()
  defp c_status_ok(c) when is_map(c) do
    %{status: %{ok: 200}}
  end

  @spec c_resp_headers_cache_default(context()) :: context_merge()
  defp c_resp_headers_cache_default(c) when is_map(c) do
    %{resp_headers: [{"cache-control", "max-age=0, private, must-revalidate"}]}
  end

  @spec c_resp_headers_content_plaintext(context()) :: context_merge()
  defp c_resp_headers_content_plaintext(%{resp_headers: resp_headers})
       when is_list(resp_headers) do
    key = "content-type"

    %{
      resp_headers:
        List.keystore(resp_headers, key, 0, {key, "text/plain; charset=utf-8"})
    }
  end

  @spec c_resp_body_hello(context()) :: context_merge()
  defp c_resp_body_hello(c) when is_map(c) do
    %{resp_body: %{hello: Core.greet() <> "\n"}}
  end

  doctest Endpoint, import: true

  describe "init/1" do
    import Endpoint, only: [init: 1]

    setup :c_opt

    test "success", %{opt: opt} do
      assert init(opt) == opt
    end
  end

  describe "call/2" do
    import Endpoint, only: [call: 2]

    setup [
      :c_request_path_hello,
      :c_conn,
      :c_opt,
      :c_status_ok,
      :c_resp_headers_cache_default,
      :c_resp_headers_content_plaintext,
      :c_resp_body_hello
    ]

    test "FunctionClauseError", %{conn: conn, opt: opt} do
      assert_raise FunctionClauseError, fn -> call(conn.invalid, opt) end
    end

    test "success", %{
      conn: conn,
      opt: opt,
      resp_body: resp_body,
      resp_headers: resp_headers,
      status: status
    } do
      assert sent_resp(call(conn.valid, opt)) ==
               {status.ok, resp_headers, resp_body.hello}
    end
  end
end
