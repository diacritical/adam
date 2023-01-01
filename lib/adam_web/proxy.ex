defmodule AdamWeb.Proxy do
  @moduledoc "Defines a `Phoenix.Endpoint` endpoint."
  @moduledoc since: "0.6.0"

  use Phoenix.Endpoint, otp_app: :adam

  alias AdamWeb, as: Web

  alias Web.Endpoint

  @typedoc "Represents the vhost."
  @typedoc since: "0.6.0"
  @type vhost() :: {atom(), {Application.app(), module()}}

  @typedoc "Represents the host."
  @typedoc since: "0.6.0"
  @type host() :: String.t()

  @typedoc "Represents the connection."
  @typedoc since: "0.6.0"
  @type conn() :: Web.conn()

  @typedoc "Represents the connection option."
  @typedoc since: "0.6.0"
  @type opt() :: Web.opt()

  @vhost Application.compile_env!(:adam, [__MODULE__, :vhost])

  @spec is_host?(vhost(), host()) :: boolean()
  defp is_host?({rfqdn, {_app, _endpoint}}, host) do
    fqdn? = String.trim_trailing(host, ".")

    rfqdn
    |> Atom.to_string()
    |> String.split(".")
    |> Enum.reverse()
    |> Enum.join(".")
    |> String.trim_trailing(".")
    |> Kernel.==(fqdn?)
  end

  @doc """
  Calls the configured endpoint for the `host` of the given `conn`.

  ## Example

      iex> c! = c_config_url()
      iex> c! = c_config_url_host(c!)
      iex> c! = c_uri(c!)
      iex> %{conn: %{valid: conn}} = c_conn(c!)
      iex> %{opt: opt} = c_opt()
      iex>
      iex> reverse(conn, opt)
      Endpoint.call(conn, Endpoint.init(opt))

  """
  @doc since: "0.6.0"
  @spec reverse(conn(), opt()) :: conn()
  def reverse(%Plug.Conn{host: host} = conn, opt) do
    {_rfqdn, {_app, endpoint}} =
      Enum.find(@vhost, {:".localhost", {:adam, Endpoint}}, &is_host?(&1, host))

    endpoint.call(conn, endpoint.init(opt))
  end

  plug :reverse
end
