defmodule FirexTest do
  use ExUnit.Case
  import TestHelpers
  alias Firex.FirecrackerAPI.Model
  doctest Firex

  @vmlinux fixture("vmlinux.bin")
  @rootfs fixture("rootfs.ext4")

  test("can start a thing") do
    {:ok, pid} = Firex.start_link()

    {:ok, _} =
      Firex.put_guest_boot_source(pid, %Model.BootSource{
        kernel_image_path: @vmlinux,
        boot_args: "console=ttyS0 reboot=k panic=1 pci=off"
      })

    {:ok, _} =
      Firex.put_guest_drive_by_id(pid, "rootfs", %Model.Drive{
        drive_id: "rootfs",
        is_read_only: false,
        is_root_device: true,
        path_on_host: @rootfs
      })

    {:ok, _} =
      Firex.create_sync_action(pid, %Model.InstanceActionInfo{
        action_type: "InstanceStart"
      })

    Firex.subscribe(pid, self())

    await("root@ubuntu-fc-uvm:~#")

    Firex.stdin(pid, "cat /proc/meminfo\r\n")

    await("MemTotal")
  end
end
