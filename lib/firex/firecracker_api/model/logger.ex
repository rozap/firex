# NOTE: This class is auto generated by OpenAPI Generator (https://openapi-generator.tech).
# https://openapi-generator.tech
# Do not edit the class manually.

defmodule Firex.FirecrackerAPI.Model.Logger do
  @moduledoc """
  Describes the configuration option for the logging capability.
  """

  @derive [Poison.Encoder]
  defstruct [
    :level,
    :log_path,
    :show_level,
    :show_log_origin
  ]

  @type t :: %__MODULE__{
          :level => String.t() | nil,
          :log_path => String.t(),
          :show_level => boolean() | nil,
          :show_log_origin => boolean() | nil
        }
end

defimpl Poison.Decoder, for: Firex.FirecrackerAPI.Model.Logger do
  def decode(value, _options) do
    value
  end
end
