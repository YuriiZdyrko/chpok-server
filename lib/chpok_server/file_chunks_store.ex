defmodule ChpokServer.FileChunksStore do
  use GenServer
  alias ChpokServer.FileSaver

  @mod __MODULE__

  def start_link do
    GenServer.start_link(__MODULE__, [], [name: @mod])
  end

  def init(_args) do
    {:ok, []}
  end


  def handle_cast(:end, state) do
    FileSaver.save(state)
    {:noreply, []}
  end

  def handle_cast({:chunk, chunk}, state) do
    {:ok, decoded} = Base.decode64(chunk)
    {:noreply, state ++ [decoded]}
  end

  def chunks_end do
    IO.puts("chunks end")
    GenServer.cast(@mod, :end)
  end

  def chunk(chunk) do
    IO.puts("received chunk")
    GenServer.cast(@mod, {:chunk, chunk})
  end
end
