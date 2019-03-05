defmodule Websocketsample.Communicator do
  use GenServer
  require Logger

  def start_link() do
    GenEvent.start_link(__MODULE__, %{})
  end

  def broadcast(time, response) do
    WebsocketsampleWeb.Endpoint.broadcast!("timer:update", "new Time", %{
      response: response,
      time: time
    })
  end

  def schedule_timer(time) do
    Process.send_after(self(), :update, time)
  end

  def init(_state) do
    Logger.warn("websocket communicator running")
    broadcast(30, "started time!")
  end

  def handle_info(:update, 0) do
    broadcast(0, "time end")
    {:noreply, 0}
  end

  def handle_info(:update, time) do
    newTime = time - 1
    broadcast(newTime, "tick tock....tick tock")
    schedule_timer(1_000)
  end
end
