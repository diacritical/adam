defmodule AdamWeb do
  @moduledoc "Defines commonalities for `Plug` plugs."
  @moduledoc since: "0.4.0"

  use Boundary, deps: [Adam, Plug]

  @typedoc "Represents the connection."
  @typedoc since: "0.4.0"
  @type conn() :: Plug.Conn.t()

  @typedoc "Represents the connection option."
  @typedoc since: "0.4.0"
  @type opt() :: Plug.opts()
end
