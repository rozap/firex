defmodule Firex do
  use GenServer
  alias Firex.FirecrackerAPI
  alias Firex.FirecrackerAPI.Api.Default, as: Api
  alias Firex.FirecrackerAPI.Model

  defmodule State do
    defstruct [:ospid, :sock, :conn, :subscribers]
  end

  def start_link() do
    GenServer.start_link(__MODULE__, [])
  end

  def init([]) do
    exe = Application.get_env(:firex, :bin)
    sock = "/tmp/#{UUID.uuid4()}"

    args = [
      exe,
      "--api-sock",
      sock
    ]

    {:ok, _, ospid} = :exec.run_link(args, [:stdout, :stderr, :stdin])

    state = %State{
      ospid: ospid,
      sock: sock,
      conn: conn(sock),
      subscribers: []
    }

    {:ok, state}
  end

  defp conn(sock) do
    FirecrackerAPI.Connection.new("http+unix://#{URI.encode_www_form(sock)}")
  end

  def handle_info({name, ospid, bin}, %State{ospid: ospid} = state)
      when name in [:stderr, :stdout] do
    Enum.each(state.subscribers, fn outpid ->
      send(outpid, {name, self(), bin})
    end)

    {:noreply, state}
  end

  def handle_call({:apply, fun, args}, _, state) do
    res = apply(Api, fun, [state.conn | args])
    {:reply, res, state}
  end

  def handle_call({:subscribe, whomst}, _, state) do
    {:reply, :ok, %State{state | subscribers: [whomst | state.subscribers]}}
  end

  def handle_call({:unsubscribe, whomst}, _, state) do
    new_subs = Enum.filter(state.subscribers, fn s -> s != whomst end)
    {:reply, :ok, %State{state | subscribers: new_subs}}
  end

  def handle_cast({:stdin, input}, state) do
    :exec.send(state.ospid, input)
    {:noreply, state}
  end

  def stdin(pid, input) do
    GenServer.cast(pid, {:stdin, input})
  end

  def subscribe(pid, whomst) do
    GenServer.call(pid, {:subscribe, whomst})
  end

  def unsubscribe(pid, whomst) do
    GenServer.call(pid, {:unsubscribe, whomst})
  end

  def create_snapshot(pid, body), do: GenServer.call(pid, {:apply, :create_snapshot, [body]})

  def create_sync_action(pid, info),
    do: GenServer.call(pid, {:apply, :create_sync_action, [info]})

  def describe_balloon_config(pid),
    do: GenServer.call(pid, {:apply, :describe_balloon_config, []})

  def describe_balloon_stats(pid), do: GenServer.call(pid, {:apply, :describe_balloon_stats, []})

  def describe_instance(pid), do: GenServer.call(pid, {:apply, :describe_instance, []})

  def get_export_vm_config(pid), do: GenServer.call(pid, {:apply, :get_export_vm_config, []})

  def get_machine_configuration(pid),
    do: GenServer.call(pid, {:apply, :get_machine_configuration, []})

  def load_snapshot(pid, body), do: GenServer.call(pid, {:apply, :load_snapshot, [body]})

  def mmds_config_put(pid, body), do: GenServer.call(pid, {:apply, :mmds_config_put, [body]})

  def mmds_get(pid), do: GenServer.call(pid, {:apply, :mmds_get, []})

  def mmds_patch(pid, opts \\ []), do: GenServer.call(pid, {:apply, :mmds_patch, [opts]})

  def mmds_put(pid, opts \\ []), do: GenServer.call(pid, {:apply, :mmds_put, [opts]})

  def patch_balloon(pid, body), do: GenServer.call(pid, {:apply, :patch_balloon, [body]})

  def patch_balloon_stats_interval(pid, body),
    do: GenServer.call(pid, {:apply, :patch_balloon_stats_interval, [body]})

  def patch_guest_drive_by_id(pid, drive_id, body),
    do: GenServer.call(pid, {:apply, :patch_guest_drive_by_id, [drive_id, body]})

  def patch_guest_network_interface_by_id(pid, iface_id, body),
    do: GenServer.call(pid, {:apply, :patch_guest_network_interface_by_id, [iface_id, body]})

  def patch_machine_configuration(pid, opts \\ []),
    do: GenServer.call(pid, {:apply, :patch_machine_configuration, [opts]})

  def patch_vm(pid, body), do: GenServer.call(pid, {:apply, :patch_vm, [body]})

  def put_balloon(pid, body), do: GenServer.call(pid, {:apply, :put_balloon, [body]})

  def put_guest_boot_source(pid, body),
    do: GenServer.call(pid, {:apply, :put_guest_boot_source, [body]})

  def put_guest_drive_by_id(pid, drive_id, body),
    do: GenServer.call(pid, {:apply, :put_guest_drive_by_id, [drive_id, body]})

  def put_guest_network_interface_by_id(pid, iface_id, body),
    do: GenServer.call(pid, {:apply, :put_guest_network_interface_by_id, [iface_id, body]})

  def put_guest_vsock(pid, body), do: GenServer.call(pid, {:apply, :put_guest_vsock, [body]})

  def put_logger(pid, body), do: GenServer.call(pid, {:apply, :put_logger, [body]})

  def put_machine_configuration(pid, opts \\ []),
    do: GenServer.call(pid, {:apply, :put_machine_configuration, [opts]})

  def put_metrics(pid, body), do: GenServer.call(pid, {:apply, :put_metrics, [body]})
end
