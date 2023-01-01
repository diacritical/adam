defmodule AdamWeb.ProxyTest do
  @moduledoc "Defines an `ExUnit.Case` case."
  @moduledoc since: "0.6.0"

  use AdamCase.Conn, async: true

  alias AdamCase, as: Case
  alias AdamWeb, as: Web

  alias Web.{Endpoint, Proxy}

  @typedoc "Represents the current context."
  @typedoc since: "0.6.0"
  @type context() :: Case.context()

  @typedoc "Represents the context merge value."
  @typedoc since: "0.6.0"
  @type context_merge() :: Case.context_merge()

  @spec c_pid_proxy(context()) :: context_merge()
  defp c_pid_proxy(c) when is_map(c) do
    %{pid: Process.whereis(Proxy)}
  end

  doctest Proxy, import: true

  describe "init/2" do
    import Proxy, only: [init: 2]

    test "success" do
      assert init(:supervisor, []) == {:ok, []}
    end
  end

  describe "config/1" do
    import Proxy, only: [config: 1]

    setup ~w[c_key c_config_url c_config_url_path c_config_url_host]a

    test "success", %{config: config, key: key} do
      assert config(key) == config[key]
    end
  end

  describe "config/2" do
    import Proxy, only: [config: 2]

    setup ~w[c_key c_config_url c_config_url_path c_config_url_host]a

    test "success", %{config: config, key: key} do
      assert config(key, []) == config[key]
    end
  end

  describe "config_change/2" do
    import Proxy, only: [config_change: 2]

    test "success" do
      assert config_change([], []) == :ok
    end
  end

  describe "url/0" do
    import Proxy, only: [url: 0]

    setup ~w[c_config_url c_config_url_host c_uri]a

    test "success", %{uri: uri} do
      assert url() == uri.string
    end
  end

  describe "host/0" do
    import Proxy, only: [host: 0]

    setup [:c_key, :c_config_url_host]

    test "success", %{config: config, key: key} do
      assert host() == config[key][:host]
    end
  end

  describe "path/1" do
    import Proxy, only: [path: 1]

    setup ~w[c_config_url_path c_request_path_hello c_path]a

    test "success", %{path: path, request_path: request_path} do
      assert path(request_path) == path
    end
  end

  describe "script_name/0" do
    import Proxy, only: [script_name: 0]

    test "success" do
      assert script_name() == []
    end
  end

  describe "static_url/0" do
    import Proxy, only: [static_url: 0]

    setup ~w[c_config_url c_config_url_host c_config_static_url c_uri]a

    test "success", %{uri: uri} do
      assert static_url() == uri.string
    end
  end

  describe "struct_url/0" do
    import Proxy, only: [struct_url: 0]

    setup ~w[c_config_url c_config_url_host c_uri]a

    test "success", %{uri: uri} do
      assert struct_url() == uri.struct
    end
  end

  describe "static_path/1" do
    import Proxy, only: [static_path: 1]

    setup ~w[c_config_url_path c_config_static_url c_request_path_hello c_path]a

    test "success", %{path: path, request_path: request_path} do
      assert static_path(request_path) == path
    end
  end

  describe "static_integrity/1" do
    import Proxy, only: [static_integrity: 1]

    setup [:c_request_path_hello, :c_hash]

    test "success", %{hash: hash, request_path: request_path} do
      assert static_integrity(request_path) == hash
    end
  end

  describe "static_lookup/1" do
    import Proxy, only: [static_lookup: 1]

    setup [
      :c_config_url_path,
      :c_config_static_url,
      :c_request_path_hello,
      :c_path,
      :c_hash
    ]

    test "success", %{hash: hash, path: path, request_path: request_path} do
      assert static_lookup(request_path) == {path, hash}
    end
  end

  describe "child_spec/1" do
    import Proxy, only: [child_spec: 1]

    setup :c_opt_init

    test "success", %{opt: opt} do
      assert child_spec(opt) == %{
               id: Proxy,
               start: {Proxy, :start_link, [opt]},
               type: :supervisor
             }
    end
  end

  describe "start_link/0" do
    import Proxy, only: [start_link: 0]

    setup [:c_pid_proxy, :c_err]

    test "success", %{err: err} do
      assert start_link() == err
    end
  end

  describe "start_link/1" do
    import Proxy, only: [start_link: 1]

    setup ~w[c_opt_init c_pid_proxy c_err]a

    test "success", %{err: err, opt: opt} do
      assert start_link(opt) == err
    end
  end

  describe "__sockets__/0" do
    import Proxy, only: [__sockets__: 0]

    test "success" do
      assert __sockets__() == []
    end
  end

  describe "socket_dispatch/2" do
    import Proxy, only: [socket_dispatch: 2]

    setup ~w[c_request_path_hello c_conn c_opt]a

    test "FunctionClauseError", %{conn: conn, opt: opt} do
      assert_raise FunctionClauseError, fn ->
        socket_dispatch(conn.invalid, opt)
      end
    end

    test "success", %{conn: conn, opt: opt} do
      assert socket_dispatch(conn.valid, opt) == conn.valid
    end
  end

  describe "init/1" do
    import Proxy, only: [init: 1]

    setup :c_opt

    test "success", %{opt: opt} do
      assert init(opt) == opt
    end
  end

  describe "call/2" do
    import Proxy, only: [call: 2]

    setup [
      :c_config_url,
      :c_config_url_host,
      :c_uri,
      :c_conn,
      :c_conn_script_name,
      :c_conn_secret_key_base,
      :c_opt,
      :c_status_ok,
      :c_resp_body_hello
    ]

    test "FunctionClauseError", %{conn: conn, opt: opt} do
      assert_raise FunctionClauseError, fn -> call(conn.invalid, opt) end
    end

    test "success", %{
      conn: conn,
      opt: opt,
      resp_body: resp_body,
      status: status
    } do
      assert text_response(call(conn.valid, opt), status.ok) == resp_body.hello
    end
  end

  describe "subscribe/1" do
    import Proxy, only: [subscribe: 1]

    setup :c_topic_pubsub

    test "success", %{conf: conf, topic: topic} do
      assert subscribe(topic) == conf
    end
  end

  describe "subscribe/2" do
    import Proxy, only: [subscribe: 2]

    setup :c_topic_pubsub

    setup do
      %{opt: []}
    end

    test "success", %{conf: conf, opt: opt, topic: topic} do
      assert subscribe(topic, opt) == conf
    end
  end

  describe "unsubscribe/1" do
    import Proxy, only: [unsubscribe: 1]

    setup :c_topic_pubsub

    test "success", %{conf: conf, topic: topic} do
      assert unsubscribe(topic) == conf
    end
  end

  describe "broadcast/3" do
    import Proxy, only: [broadcast: 3]

    setup [:c_topic_pubsub, :c_event_pubsub]

    test "success", %{conf: conf, event: event, msg: msg, topic: topic} do
      assert broadcast(topic, event, msg) == conf
    end
  end

  describe "broadcast!/3" do
    import Proxy, only: [broadcast!: 3]

    setup [:c_topic_pubsub, :c_event_pubsub]

    test "success", %{conf: conf, event: event, msg: msg, topic: topic} do
      assert broadcast!(topic, event, msg) == conf
    end
  end

  describe "broadcast_from/4" do
    import Proxy, only: [broadcast_from: 4]

    setup ~w[c_pid_pubsub c_topic_pubsub c_event_pubsub]a

    test "success", %{
      conf: conf,
      event: event,
      msg: msg,
      pid: pid,
      topic: topic
    } do
      assert broadcast_from(pid, topic, event, msg) == conf
    end
  end

  describe "broadcast_from!/4" do
    import Proxy, only: [broadcast_from!: 4]

    setup ~w[c_pid_pubsub c_topic_pubsub c_event_pubsub]a

    test "success", %{
      conf: conf,
      event: event,
      msg: msg,
      pid: pid,
      topic: topic
    } do
      assert broadcast_from!(pid, topic, event, msg) == conf
    end
  end

  describe "local_broadcast/3" do
    import Proxy, only: [local_broadcast: 3]

    setup [:c_topic_pubsub, :c_event_pubsub]

    test "success", %{conf: conf, event: event, msg: msg, topic: topic} do
      assert local_broadcast(topic, event, msg) == conf
    end
  end

  describe "local_broadcast_from/4" do
    import Proxy, only: [local_broadcast_from: 4]

    setup ~w[c_pid_pubsub c_topic_pubsub c_event_pubsub]a

    test "success", %{
      conf: conf,
      event: event,
      msg: msg,
      pid: pid,
      topic: topic
    } do
      assert local_broadcast_from(pid, topic, event, msg) == conf
    end
  end

  describe "reverse/2" do
    import Proxy, only: [reverse: 2]

    setup ~w[c_config_url c_config_url_host c_uri c_conn c_opt]a

    test "FunctionClauseError", %{conn: conn, opt: opt} do
      assert_raise FunctionClauseError, fn -> reverse(conn.invalid, opt) end
    end

    test "success", %{conn: conn, opt: opt} do
      assert reverse(conn.valid, opt) ==
               Endpoint.call(conn.valid, Endpoint.init(opt))
    end
  end
end
