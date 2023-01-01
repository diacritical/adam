defmodule AdamWeb.Endpoint do
  @moduledoc "Defines a `Phoenix.Endpoint` endpoint."
  @moduledoc since: "0.4.0"

  use Phoenix.Endpoint, otp_app: :adam

  alias Adam, as: Core
  alias AdamWeb, as: Web

  @typedoc "Represents the connection."
  @typedoc since: "0.4.0"
  @type conn() :: Web.conn()

  @typedoc "Represents the connection option."
  @typedoc since: "0.4.0"
  @type opt() :: Web.opt()

  @doc """
  Greets the world (for the given `conn` and `opt`)!

  ## Example

      iex> c = c_request_path_hello(%{})
      iex> %{conn: %{valid: conn}} = c_conn(c)
      iex> %{opt: opt} = c_opt(%{})
      iex> %{status: %{ok: status}} = c_status_ok(%{})
      iex> %{resp_body: %{hello: resp_body}} = c_resp_body_hello(%{})
      iex>
      iex> text_response(hello(conn, opt), status)
      resp_body

  """
  @doc since: "0.5.0"
  @spec hello(conn(), opt()) :: conn()
  def hello(%Plug.Conn{} = conn, _opt) do
    Phoenix.Controller.text(conn, Core.greet() <> "\n")
  end

  plug :hello
end
