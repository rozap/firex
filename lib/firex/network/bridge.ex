defmodule Firex.Network.Bridge do
  use GenServer

  def start_link([name, ip]) do
    GenServer.start_link(__MODULE__, [name, ip])
  end

  def init([name, ip]) do
    {_, 0} = System.cmd("ip", ["ip", "link", "add", "name", name, "type", "bridge"])
    {_, 0} = System.cmd("ip", ["address", "add", ip, "dev", name])

    {_, 0} =
      System.cmd("iptables", ["-t", "nat", "-A", "POSTROUTING", "-o", name, "-j", "MASQUERADE"])

    {:ok, %{}}
  end

  # def up(), do: :ok
  # def add(instance), do: :ok
  # def list(), do: :ok
  # def remove(instance), do: :ok
end
