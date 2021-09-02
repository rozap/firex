# NOTE: This class is auto generated by OpenAPI Generator (https://openapi-generator.tech).
# https://openapi-generator.tech
# Do not edit the class manually.

defmodule Firex.FirecrackerAPI.Model.PartialNetworkInterface do
  @moduledoc """
  Defines a partial network interface structure, used to update the rate limiters for that interface, after microvm start.
  """

  @derive [Poison.Encoder]
  defstruct [
    :iface_id,
    :rx_rate_limiter,
    :tx_rate_limiter
  ]

  @type t :: %__MODULE__{
          :iface_id => String.t(),
          :rx_rate_limiter => Firex.FirecrackerAPI.Model.RateLimiter.t() | nil,
          :tx_rate_limiter => Firex.FirecrackerAPI.Model.RateLimiter.t() | nil
        }
end

defimpl Poison.Decoder, for: Firex.FirecrackerAPI.Model.PartialNetworkInterface do
  import Firex.FirecrackerAPI.Deserializer

  def decode(value, options) do
    value
    |> deserialize(:rx_rate_limiter, :struct, Firex.FirecrackerAPI.Model.RateLimiter, options)
    |> deserialize(:tx_rate_limiter, :struct, Firex.FirecrackerAPI.Model.RateLimiter, options)
  end
end
