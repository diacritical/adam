defmodule AdamCase.Conn do
  @moduledoc "Defines an `ExUnit.CaseTemplate` case template."
  @moduledoc since: "0.6.0"

  use AdamCase

  alias Adam, as: Core
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

      iex> %{config: [static_url: _static_url]} =
      ...>   c_config_static_url(%{config: [url: []]})

  """
  @doc since: "0.6.0"
  @spec c_config_static_url(context()) :: context_merge()
  def c_config_static_url(%{config: [url: url]}) when is_list(url) do
    %{config: [static_url: url]}
  end

  @doc """
  Defines a map of fixtures to be merged into an `ExUnit` context.

  ## Example

      iex> %{config: [url: _url]} = c_config_url()

  """
  @doc since: "0.6.0"
  @spec c_config_url() :: context_merge()
  @spec c_config_url(context()) :: context_merge()
  def c_config_url(c \\ %{}) when is_map(c) do
    %{config: [url: [port: 4_003, scheme: "https"]]}
  end

  @doc """
  Defines a map of fixtures to be merged into an `ExUnit` context.

  ## Example

      iex> %{config: [url: _url]} = c_config_url_host()

  """
  @doc since: "0.6.0"
  @spec c_config_url_host() :: context_merge()
  @spec c_config_url_host(context()) :: context_merge()
  def c_config_url_host(c \\ %{}) when is_map(c) do
    %{config: [url: [{:host, "localhost"} | c[:config][:url] || []]]}
  end

  @doc """
  Defines a map of fixtures to be merged into an `ExUnit` context.

  ## Example

      iex> %{config: [url: _url]} = c_config_url_path()

  """
  @doc since: "0.6.0"
  @spec c_config_url_path() :: context_merge()
  @spec c_config_url_path(context()) :: context_merge()
  def c_config_url_path(c \\ %{}) when is_map(c) do
    %{config: [url: [{:path, "/"} | c[:config][:url] || []]]}
  end

  @doc """
  Defines a map of fixtures to be merged into an `ExUnit` context.

  ## Example

      iex> %{conn: _conn} = c_conn()

  """
  @doc since: "0.6.0"
  @spec c_conn() :: context_merge()
  @spec c_conn(context()) :: context_merge()
  def c_conn(c \\ %{request_path: "/"}) when is_map(c) do
    %{
      conn: %{
        invalid: %{},
        valid:
          Phoenix.ConnTest.build_conn(
            :get,
            c[:uri][:string] || c[:request_path]
          )
      }
    }
  end

  @doc """
  Defines a map of fixtures to be merged into an `ExUnit` context.

  ## Example

      iex> %{conn: _conn} = c_conn_script_name(%{conn: %{invalid: %{}}})

  """
  @doc since: "0.6.0"
  @spec c_conn_script_name(context()) :: context_merge()
  def c_conn_script_name(%{conn: %{invalid: conn} = c}) when is_map(conn) do
    %{conn: %{c | invalid: Map.merge(conn, %{script_name: nil})}}
  end

  @doc """
  Defines a map of fixtures to be merged into an `ExUnit` context.

  ## Example

      iex> %{conn: _conn} = c_conn_secret_key_base(%{conn: %{invalid: %{}}})

  """
  @doc since: "0.6.0"
  @spec c_conn_secret_key_base(context()) :: context_merge()
  def c_conn_secret_key_base(%{conn: %{invalid: conn} = c}) when is_map(conn) do
    %{conn: %{c | invalid: Map.merge(conn, %{secret_key_base: nil})}}
  end

  @doc """
  Defines a map of fixtures to be merged into an `ExUnit` context.

  ## Example

      iex> %{err: _err} = c_err(%{pid: Process.whereis(Supervisor)})

  """
  @doc since: "0.6.0"
  @spec c_err(context()) :: context_merge()
  def c_err(%{pid: pid}) when is_pid(pid) do
    %{err: {:error, {:already_started, pid}}}
  end

  @doc """
  Defines a map of fixtures to be merged into an `ExUnit` context.

  ## Example

      iex> %{event: _event, msg: _msg} = c_event_pubsub()

  """
  @doc since: "0.6.0"
  @spec c_event_pubsub() :: context_merge()
  @spec c_event_pubsub(context()) :: context_merge()
  def c_event_pubsub(c \\ %{}) when is_map(c) do
    %{event: "event", msg: %{id: :rand.uniform(1_000)}}
  end

  @doc """
  Defines a map of fixtures to be merged into an `ExUnit` context.

  ## Example

      iex> %{hash: _hash} = c_hash()

  """
  @doc since: "0.6.0"
  @spec c_hash() :: context_merge()
  @spec c_hash(context()) :: context_merge()
  def c_hash(c \\ %{}) when is_map(c) do
    %{hash: nil}
  end

  @doc """
  Defines a map of fixtures to be merged into an `ExUnit` context.

  ## Example

      iex> %{key: _key} = c_key()

  """
  @doc since: "0.6.0"
  @spec c_key() :: context_merge()
  @spec c_key(context()) :: context_merge()
  def c_key(c \\ %{}) when is_map(c) do
    %{key: :url}
  end

  @doc """
  Defines a map of fixtures to be merged into an `ExUnit` context.

  ## Example

      iex> %{opt: _opt} = c_opt()

  """
  @doc since: "0.6.0"
  @spec c_opt() :: context_merge()
  @spec c_opt(context()) :: context_merge()
  def c_opt(c \\ %{}) when is_map(c) do
    %{opt: %{}}
  end

  @doc """
  Defines a map of fixtures to be merged into an `ExUnit` context.

  ## Example

      iex> %{opt: _opt} = c_opt_init()

  """
  @doc since: "0.6.0"
  @spec c_opt_init() :: context_merge()
  @spec c_opt_init(context()) :: context_merge()
  def c_opt_init(c \\ %{}) when is_map(c) do
    %{opt: []}
  end

  @doc """
  Defines a map of fixtures to be merged into an `ExUnit` context.

  ## Example

      iex> %{path: _path} =
      ...>   c_path(%{config: [url: [path: "/"]], request_path: "/hello"})

  """
  @doc since: "0.6.0"
  @spec c_path(context()) :: context_merge()
  def c_path(%{config: [{key, [path: path]}], request_path: request_path})
      when is_atom(key) and is_binary(path) and is_binary(request_path) do
    %{path: String.replace(path, ~r/^\/$/, "") <> request_path}
  end

  @doc """
  Defines a map of fixtures to be merged into an `ExUnit` context.

  ## Example

      iex> %{pid: _pid} = c_pid_pubsub()

  """
  @doc since: "0.6.0"
  @spec c_pid_pubsub() :: context_merge()
  @spec c_pid_pubsub(context()) :: context_merge()
  def c_pid_pubsub(c \\ %{}) when is_map(c) do
    %{pid: Process.whereis(:"Elixir.Adam.PubSub")}
  end

  @doc """
  Defines a map of fixtures to be merged into an `ExUnit` context.

  ## Example

      iex> %{request_path: _request_path} = c_request_path_hello()

  """
  @doc since: "0.6.0"
  @spec c_request_path_hello() :: context_merge()
  @spec c_request_path_hello(context()) :: context_merge()
  def c_request_path_hello(c \\ %{}) when is_map(c) do
    %{request_path: "/hello"}
  end

  @doc """
  Defines a map of fixtures to be merged into an `ExUnit` context.

  ## Example

      iex> %{resp_body: _resp_body} = c_resp_body_hello()

  """
  @doc since: "0.6.0"
  @spec c_resp_body_hello() :: context_merge()
  @spec c_resp_body_hello(context()) :: context_merge()
  def c_resp_body_hello(c \\ %{}) when is_map(c) do
    %{resp_body: %{hello: Core.greet() <> "\n"}}
  end

  @doc """
  Defines a map of fixtures to be merged into an `ExUnit` context.

  ## Example

      iex> %{status: _status} = c_status_ok()

  """
  @doc since: "0.6.0"
  @spec c_status_ok() :: context_merge()
  @spec c_status_ok(context()) :: context_merge()
  def c_status_ok(c \\ %{}) when is_map(c) do
    %{status: %{ok: 200}}
  end

  @doc """
  Defines a map of fixtures to be merged into an `ExUnit` context.

  ## Example

      iex> %{conf: _conf, topic: _topic} = c_topic_pubsub()

  """
  @doc since: "0.6.0"
  @spec c_topic_pubsub() :: context_merge()
  @spec c_topic_pubsub(context()) :: context_merge()
  def c_topic_pubsub(c \\ %{}) when is_map(c) do
    %{conf: :ok, topic: "topic"}
  end

  @doc """
  Defines a map of fixtures to be merged into an `ExUnit` context.

  ## Example

      iex> c = %{config: [url: [host: "localhost", port: 80, scheme: "http"]]}
      iex>
      iex> %{uri: _uri} = c_uri(c)

  """
  @doc since: "0.6.0"
  @spec c_uri(context()) :: context_merge()
  def c_uri(%{config: [{key, [host: host, port: port, scheme: scheme]}]} = c)
      when is_atom(key) and is_binary(host) and is_integer(port) and
             is_binary(scheme) do
    struct =
      URI.merge(
        %URI{host: host, port: port, scheme: scheme},
        c[:request_path] || ""
      )

    %{uri: %{string: URI.to_string(struct), struct: struct}}
  end

  using do
    quote do
      import unquote(__MODULE__)
      import Phoenix.ConnTest

      @endpoint Endpoint
    end
  end
end
