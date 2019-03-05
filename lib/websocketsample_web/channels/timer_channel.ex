defmodule WebsocketsampleWeb.TimerChannel do
  # use WebsocketsampleWeb, :channel
  use Phoenix.Channel

  @communicator  WebsocketCommunicator.start_link()
  # call { "topic": "timer", "event": "phx_join","payload":{}, "ref":"1"}
  def join("timer", _msg, socket) do
    IO.puts("recibiendo mensaje")
    {:ok, socket}
  end


  def handle_in("translate",text,socket) do
    {:ok,pid} = @communicator
    WebsocketCommunicator.translate(pid, text, socket)
    {:noreply,socket}
  end

  # {"topic":"timer","event":"hello","payload":"hello","ref":1}
  def handle_in("hello", payload, socket) do
    {:reply, {:ok, %{reply: "hi " <> payload}}, socket}
  end

  def handle_in("new_message", payload, socket) do
    broadcast!(socket, "new_message", payload)
    {:noreply, socket}
  end
end
