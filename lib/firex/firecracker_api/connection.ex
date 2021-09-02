defmodule Firex.FirecrackerAPI.Connection do
  use Tesla
  plug(Tesla.Middleware.Headers, [{"user-agent", "Elixir"}])
  plug(Tesla.Middleware.EncodeJson, engine: Poison)

  def new(base) do
    Tesla.client(
      [
        {Tesla.Middleware.BaseUrl, base}
      ],
      Tesla.Adapter.Hackney
    )
  end
end
