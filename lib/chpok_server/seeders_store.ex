defmodule ChpokServer.SeedersStore do

  @server __MODULE__

  def start_link do
    Agent.start_link(fn -> MapSet.new() end, name: __MODULE__)
  end

  def put(key) do
    Agent.update(@server, &MapSet.put(&1, key))
  end

  def get_names do
    Agent.get(@server, &MapSet.to_list(&1))
  end
end
