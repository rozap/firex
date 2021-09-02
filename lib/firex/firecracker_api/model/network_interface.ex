# NOTE: This class is auto generated by OpenAPI Generator (https://openapi-generator.tech).
# https://openapi-generator.tech
# Do not edit the class manually.

defmodule Firex.FirecrackerAPI.Model.NetworkInterface do
  @moduledoc """
  Defines a network interface.
  """

  @derive [Poison.Encoder]
  defstruct [
    :allow_mmds_requests,
    :guest_mac,
    :host_dev_name,
    :iface_id,
    :rx_rate_limiter,
    :tx_rate_limiter
  ]

  @type t :: %__MODULE__{
          :allow_mmds_requests => boolean() | nil,
          :guest_mac => String.t() | nil,
          :host_dev_name => String.t(),
          :iface_id => String.t(),
          :rx_rate_limiter => Firex.FirecrackerAPI.Model.RateLimiter.t() | nil,
          :tx_rate_limiter => Firex.FirecrackerAPI.Model.RateLimiter.t() | nil
        }
end

defimpl Poison.Decoder, for: Firex.FirecrackerAPI.Model.NetworkInterface do
  import Firex.FirecrackerAPI.Deserializer

  def decode(value, options) do
    value
    |> deserialize(:rx_rate_limiter, :struct, Firex.FirecrackerAPI.Model.RateLimiter, options)
    |> deserialize(:tx_rate_limiter, :struct, Firex.FirecrackerAPI.Model.RateLimiter, options)
  end
end