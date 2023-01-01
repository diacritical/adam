defmodule AdamCase.ConnTest do
  @moduledoc "Defines an `ExUnit.Case` case."
  @moduledoc since: "0.6.0"

  use AdamCase.Template, async: true

  alias Adam, as: Core
  alias AdamCase, as: Case

  alias Case.Conn
  alias Core.Supervisor

  @typedoc "Represents the current context."
  @typedoc since: "0.6.0"
  @type context() :: Case.context()

  @typedoc "Represents the context merge value."
  @typedoc since: "0.6.0"
  @type context_merge() :: Case.context_merge()

  @spec c_conn_invalid(context()) :: context_merge()
  defp c_conn_invalid(c) when is_map(c) do
    %{context: %{invalid: %{conn: %{}}, valid: %{conn: %{invalid: %{}}}}}
  end

  doctest Conn, import: true

  describe "__ex_unit__/2" do
    setup :c_context

    test ":setup", %{context: context} do
      assert Conn.__ex_unit__(:setup, context.valid) == context.valid
    end

    test ":setup_all", %{context: context} do
      assert Conn.__ex_unit__(:setup_all, context.valid) == context.valid
    end
  end

  describe "c_config_static_url/1" do
    import Conn, only: [c_config_static_url: 1]

    setup do
      %{context: %{invalid: %{config: []}, valid: %{config: [url: []]}}}
    end

    test "FunctionClauseError", %{context: context} do
      assert_raise FunctionClauseError, fn ->
        c_config_static_url(context.invalid)
      end
    end

    test "success", %{context: context} do
      assert %{config: [static_url: _static_url]} =
               c_config_static_url(context.valid)
    end
  end

  describe "c_config_url/0" do
    import Conn, only: [c_config_url: 0]

    test "success" do
      assert %{config: [url: _url]} = c_config_url()
    end
  end

  describe "c_config_url/1" do
    import Conn, only: [c_config_url: 1]

    setup :c_context

    test "FunctionClauseError", %{context: context} do
      assert_raise FunctionClauseError, fn -> c_config_url(context.invalid) end
    end

    test "success", %{context: context} do
      assert %{config: [url: _url]} = c_config_url(context.valid)
    end
  end

  describe "c_config_url_host/0" do
    import Conn, only: [c_config_url_host: 0]

    test "success" do
      assert %{config: [url: _url]} = c_config_url_host()
    end
  end

  describe "c_config_url_host/1" do
    import Conn, only: [c_config_url_host: 1]

    setup :c_context

    test "FunctionClauseError", %{context: context} do
      assert_raise FunctionClauseError, fn ->
        c_config_url_host(context.invalid)
      end
    end

    test "success", %{context: context} do
      assert %{config: [url: _url]} = c_config_url_host(context.valid)
    end
  end

  describe "c_config_url_path/0" do
    import Conn, only: [c_config_url_path: 0]

    test "success" do
      assert %{config: [url: _url]} = c_config_url_path()
    end
  end

  describe "c_config_url_path/1" do
    import Conn, only: [c_config_url_path: 1]

    setup :c_context

    test "FunctionClauseError", %{context: context} do
      assert_raise FunctionClauseError, fn ->
        c_config_url_path(context.invalid)
      end
    end

    test "success", %{context: context} do
      assert %{config: [url: _url]} = c_config_url_path(context.valid)
    end
  end

  describe "c_conn/0" do
    import Conn, only: [c_conn: 0]

    test "success" do
      assert %{conn: _conn} = c_conn()
    end
  end

  describe "c_conn/1" do
    import Conn, only: [c_conn: 1]

    setup do
      %{context: %{invalid: %{request_path: '/'}, valid: %{request_path: "/"}}}
    end

    test "FunctionClauseError", %{context: context} do
      assert_raise FunctionClauseError, fn -> c_conn(context.invalid) end
    end

    test "success", %{context: context} do
      assert %{conn: _conn} = c_conn(context.valid)
    end
  end

  describe "c_conn_script_name/1" do
    import Conn, only: [c_conn_script_name: 1]

    setup :c_conn_invalid

    test "FunctionClauseError", %{context: context} do
      assert_raise FunctionClauseError, fn ->
        c_conn_script_name(context.invalid)
      end
    end

    test "success", %{context: context} do
      assert %{conn: _conn} = c_conn_script_name(context.valid)
    end
  end

  describe "c_conn_secret_key_base/1" do
    import Conn, only: [c_conn_secret_key_base: 1]

    setup :c_conn_invalid

    test "FunctionClauseError", %{context: context} do
      assert_raise FunctionClauseError, fn ->
        c_conn_secret_key_base(context.invalid)
      end
    end

    test "success", %{context: context} do
      assert %{conn: _conn} = c_conn_secret_key_base(context.valid)
    end
  end

  describe "c_err/1" do
    import Conn, only: [c_err: 1]

    setup do
      %{
        context: %{
          invalid: %{pid: []},
          valid: %{pid: Process.whereis(Supervisor)}
        }
      }
    end

    test "FunctionClauseError", %{context: context} do
      assert_raise FunctionClauseError, fn -> c_err(context.invalid) end
    end

    test "success", %{context: context} do
      assert %{err: _err} = c_err(context.valid)
    end
  end

  describe "c_event_pubsub/0" do
    import Conn, only: [c_event_pubsub: 0]

    test "success" do
      assert %{event: _event, msg: _msg} = c_event_pubsub()
    end
  end

  describe "c_event_pubsub/1" do
    import Conn, only: [c_event_pubsub: 1]

    setup :c_context

    test "FunctionClauseError", %{context: context} do
      assert_raise FunctionClauseError, fn ->
        c_event_pubsub(context.invalid)
      end
    end

    test "success", %{context: context} do
      assert %{event: _event, msg: _msg} = c_event_pubsub(context.valid)
    end
  end

  describe "c_hash/0" do
    import Conn, only: [c_hash: 0]

    test "success" do
      assert %{hash: _hash} = c_hash()
    end
  end

  describe "c_hash/1" do
    import Conn, only: [c_hash: 1]

    setup :c_context

    test "FunctionClauseError", %{context: context} do
      assert_raise FunctionClauseError, fn -> c_hash(context.invalid) end
    end

    test "success", %{context: context} do
      assert %{hash: _hash} = c_hash(context.valid)
    end
  end

  describe "c_key/0" do
    import Conn, only: [c_key: 0]

    test "success" do
      assert %{key: _key} = c_key()
    end
  end

  describe "c_key/1" do
    import Conn, only: [c_key: 1]

    setup :c_context

    test "FunctionClauseError", %{context: context} do
      assert_raise FunctionClauseError, fn -> c_key(context.invalid) end
    end

    test "success", %{context: context} do
      assert %{key: _key} = c_key(context.valid)
    end
  end

  describe "c_opt/0" do
    import Conn, only: [c_opt: 0]

    test "success" do
      assert %{opt: _opt} = c_opt()
    end
  end

  describe "c_opt/1" do
    import Conn, only: [c_opt: 1]

    setup :c_context

    test "FunctionClauseError", %{context: context} do
      assert_raise FunctionClauseError, fn -> c_opt(context.invalid) end
    end

    test "success", %{context: context} do
      assert %{opt: _opt} = c_opt(context.valid)
    end
  end

  describe "c_opt_init/0" do
    import Conn, only: [c_opt_init: 0]

    test "success" do
      assert %{opt: _opt} = c_opt_init()
    end
  end

  describe "c_opt_init/1" do
    import Conn, only: [c_opt_init: 1]

    setup :c_context

    test "FunctionClauseError", %{context: context} do
      assert_raise FunctionClauseError, fn -> c_opt_init(context.invalid) end
    end

    test "success", %{context: context} do
      assert %{opt: _opt} = c_opt_init(context.valid)
    end
  end

  describe "c_path/1" do
    import Conn, only: [c_path: 1]

    setup do
      %{
        context: %{
          invalid: %{config: []},
          valid: %{config: [url: [path: "/"]], request_path: "/"}
        }
      }
    end

    test "FunctionClauseError", %{context: context} do
      assert_raise FunctionClauseError, fn -> c_path(context.invalid) end
    end

    test "success", %{context: context} do
      assert %{path: _path} = c_path(context.valid)
    end
  end

  describe "c_pid_pubsub/0" do
    import Conn, only: [c_pid_pubsub: 0]

    test "success" do
      assert %{pid: _pid} = c_pid_pubsub()
    end
  end

  describe "c_pid_pubsub/1" do
    import Conn, only: [c_pid_pubsub: 1]

    setup :c_context

    test "FunctionClauseError", %{context: context} do
      assert_raise FunctionClauseError, fn -> c_pid_pubsub(context.invalid) end
    end

    test "success", %{context: context} do
      assert %{pid: _pid} = c_pid_pubsub(context.valid)
    end
  end

  describe "c_request_path_hello/0" do
    import Conn, only: [c_request_path_hello: 0]

    test "success" do
      assert %{request_path: _request_path} = c_request_path_hello()
    end
  end

  describe "c_request_path_hello/1" do
    import Conn, only: [c_request_path_hello: 1]

    setup :c_context

    test "FunctionClauseError", %{context: context} do
      assert_raise FunctionClauseError, fn ->
        c_request_path_hello(context.invalid)
      end
    end

    test "success", %{context: context} do
      assert %{request_path: _request_path} =
               c_request_path_hello(context.valid)
    end
  end

  describe "c_resp_body_hello/0" do
    import Conn, only: [c_resp_body_hello: 0]

    test "success" do
      assert %{resp_body: _resp_body} = c_resp_body_hello()
    end
  end

  describe "c_resp_body_hello/1" do
    import Conn, only: [c_resp_body_hello: 1]

    setup :c_context

    test "FunctionClauseError", %{context: context} do
      assert_raise FunctionClauseError, fn ->
        c_resp_body_hello(context.invalid)
      end
    end

    test "success", %{context: context} do
      assert %{resp_body: _resp_body} = c_resp_body_hello(context.valid)
    end
  end

  describe "c_status_ok/0" do
    import Conn, only: [c_status_ok: 0]

    test "success" do
      assert %{status: _status} = c_status_ok()
    end
  end

  describe "c_status_ok/1" do
    import Conn, only: [c_status_ok: 1]

    setup :c_context

    test "FunctionClauseError", %{context: context} do
      assert_raise FunctionClauseError, fn -> c_status_ok(context.invalid) end
    end

    test "success", %{context: context} do
      assert %{status: _status} = c_status_ok(context.valid)
    end
  end

  describe "c_topic_pubsub/0" do
    import Conn, only: [c_topic_pubsub: 0]

    test "success" do
      assert %{conf: _conf, topic: _topic} = c_topic_pubsub()
    end
  end

  describe "c_topic_pubsub/1" do
    import Conn, only: [c_topic_pubsub: 1]

    setup :c_context

    test "FunctionClauseError", %{context: context} do
      assert_raise FunctionClauseError, fn ->
        c_topic_pubsub(context.invalid)
      end
    end

    test "success", %{context: context} do
      assert %{conf: _conf, topic: _topic} = c_topic_pubsub(context.valid)
    end
  end

  describe "c_uri/1" do
    import Conn, only: [c_uri: 1]

    setup do
      %{
        context: %{
          invalid: %{config: [url: []]},
          valid: %{config: [url: [host: "localhost", port: 80, scheme: "http"]]}
        }
      }
    end

    test "FunctionClauseError", %{context: context} do
      assert_raise FunctionClauseError, fn -> c_uri(context.invalid) end
    end

    test "success", %{context: context} do
      assert %{uri: _uri} = c_uri(context.valid)
    end
  end
end
