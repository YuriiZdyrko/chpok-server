defmodule ChpokServer.FileSaver do


  def save(chunks) do

    binary = :erlang.iolist_to_binary(chunks)
    case File.write("/home/yz/Downloads/chpok_dst/slow_motion_drop_hd_stock_video.mp4", binary) do
      :ok -> IO.puts("FileSaver success")
      {:error, reason} -> IO.puts("FileSaver error: #{reason}")
    end
  end
end
