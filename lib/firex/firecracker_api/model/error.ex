# NOTE: This class is auto generated by OpenAPI Generator (https://openapi-generator.tech).
# https://openapi-generator.tech
# Do not edit the class manually.

defmodule Firex.FirecrackerAPI.Model.Error do
  @moduledoc """

  """

  @derive [Poison.Encoder]
  defstruct [
    :fault_message
  ]

  @type t :: %__MODULE__{
          :fault_message => String.t() | nil
        }
end

defimpl Poison.Decoder, for: Firex.FirecrackerAPI.Model.Error do
  def decode(value, _options) do
    value
  end
end
