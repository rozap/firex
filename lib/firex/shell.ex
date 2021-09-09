defmodule Firex.Shell do
  alias Firex.FirecrackerAPI.Model

  @doc """
    This is mostly just for debugging.
    Just drops you into a shell in the VM.
    Using this for figuring out netns.

    Note that this takes over the IEx session

    iex -S mix
    iex(1)> Firex.Shell.boot("/home/chris/workspace/firex/images/vmlinux.bin", "/home/chris/workspace/firex/images/rootfs.ext4")
    {{the machine boots up...and drops you into a shell}}
    cat /proc/meminfo
  """
  def print(pid, buf) do
    receive do
      {_, ^pid, b} ->
        new = buf <> b

        buf =
          if String.valid?(new) do
            IO.binwrite(new)
            <<>>
          else
            new
          end

        print(pid, buf)
    end
  end

  def boot(vmlinux, rootfs) do
    {:ok, pid} = Firex.start_link()

    spawn_link(fn ->
      Firex.subscribe(pid, self())
      print(pid, <<>>)
    end)

    {:ok, _} =
      Firex.put_guest_boot_source(pid, %Model.BootSource{
        kernel_image_path: vmlinux,
        boot_args: "console=ttyS0 reboot=k panic=1 pci=off"
      })

    {:ok, _} =
      Firex.put_guest_drive_by_id(pid, "rootfs", %Model.Drive{
        drive_id: "rootfs",
        is_read_only: false,
        is_root_device: true,
        path_on_host: rootfs
      })

    {:ok, _} =
      Firex.create_sync_action(pid, %Model.InstanceActionInfo{
        action_type: "InstanceStart"
      })

    loop(pid)
  end

  defp loop(pid) do
    line = IO.gets("")
    Firex.stdin(pid, line)
    loop(pid)
  end
end
