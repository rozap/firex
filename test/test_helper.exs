defmodule TestHelpers do
  def fixture(name) do
    Path.join([File.cwd!(), "images", name])
  end

  def await(buf, buf), do: :ok

  def await(str, buf) do
    char =
      receive do
        {:stdout, _, bin} -> bin
      end

    buf = buf <> char

    if not String.starts_with?(str, buf) do
      await(str, <<>>)
    else
      await(str, buf)
    end
  end

  def await(str), do: await(str, <<>>)

  def print(t) do
    receive do
      {:stdout, _, b} ->
        IO.write(b)
        print(t)
    after
      t -> :ok
    end
  end
end

ExUnit.start(timeout: 5_000)
