# NOTE: This class is auto generated by OpenAPI Generator (https://openapi-generator.tech).
# https://openapi-generator.tech
# Do not edit the class manually.

defmodule Firex.FirecrackerAPI.Model.FullVmConfiguration do
  @moduledoc """

  """

  @derive [Poison.Encoder]
  defstruct [
    :balloon_device,
    :block_devices,
    :boot_source,
    :logger,
    :machine_config,
    :metrics,
    :mmds_config,
    :net_devices,
    :vsock_device
  ]

  @type t :: %__MODULE__{
          :balloon_device => Firex.FirecrackerAPI.Model.Balloon.t() | nil,
          :block_devices => [Firex.FirecrackerAPI.Model.Drive.t()] | nil,
          :boot_source => Firex.FirecrackerAPI.Model.BootSource.t() | nil,
          :logger => Firex.FirecrackerAPI.Model.Logger.t() | nil,
          :machine_config => Firex.FirecrackerAPI.Model.MachineConfiguration.t() | nil,
          :metrics => Firex.FirecrackerAPI.Model.Metrics.t() | nil,
          :mmds_config => Firex.FirecrackerAPI.Model.MmdsConfig.t() | nil,
          :net_devices => [Firex.FirecrackerAPI.Model.NetworkInterface.t()] | nil,
          :vsock_device => Firex.FirecrackerAPI.Model.Vsock.t() | nil
        }
end

defimpl Poison.Decoder, for: Firex.FirecrackerAPI.Model.FullVmConfiguration do
  import Firex.FirecrackerAPI.Deserializer

  def decode(value, options) do
    value
    |> deserialize(:balloon_device, :struct, Firex.FirecrackerAPI.Model.Balloon, options)
    |> deserialize(:block_devices, :list, Firex.FirecrackerAPI.Model.Drive, options)
    |> deserialize(:boot_source, :struct, Firex.FirecrackerAPI.Model.BootSource, options)
    |> deserialize(:logger, :struct, Firex.FirecrackerAPI.Model.Logger, options)
    |> deserialize(
      :machine_config,
      :struct,
      Firex.FirecrackerAPI.Model.MachineConfiguration,
      options
    )
    |> deserialize(:metrics, :struct, Firex.FirecrackerAPI.Model.Metrics, options)
    |> deserialize(:mmds_config, :struct, Firex.FirecrackerAPI.Model.MmdsConfig, options)
    |> deserialize(:net_devices, :list, Firex.FirecrackerAPI.Model.NetworkInterface, options)
    |> deserialize(:vsock_device, :struct, Firex.FirecrackerAPI.Model.Vsock, options)
  end
end
