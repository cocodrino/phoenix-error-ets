defmodule WebsocketCommunicator do
  use WebSockex
  require Logger
  require IEx

  def start_link(opt \\ []) do
    Logger.info("inicializando la tabla")
    :ets.new(:sockets,[:named_table,:public])
    :ets.insert(:sockets, {"shit","crap"})
    [{_k,v}] = :ets.lookup(:sockets,"shit")
    Logger.info("valor es #{v}" )
    WebSockex.start_link("ws://localhost:8999",__MODULE__,:fake_state,opt)
  end

  def init() do
    Logger.info("inicializando la tabla 2")
    :ets.new(:sockets,[:named_table,:public])
    :ets.insert(:sockets, {"shit","crap"})
  end

  def handle_connect(_conn, state) do
    Logger.info("Connected!")
    {:ok, state}
  end

  def translate(client,message,socket) do
    uid = Ecto.UUID.generate()
    Logger.info("hasta aqui funciono")
    IEx.pry()
    :ets.insert(:sockets,{uid,"shitNew"})
    [{_k,v}] = :ets.lookup(:sockets,"shitNew")
    Logger.info("valor es #{v}" )
    #mensaje = Poison.encode!(%{"uid" => uid, "text"=>message})

    #Logger.info("mandando mensaje #{mensaje}")
    WebSockex.send_frame(client, {:text, "hola"})
  end

  def handle_frame({:text,msg},:fake_state) do
    Logger.info("receiving --> #{msg}")
    {:ok, :fake_state}
    # {:reply,{:text,msg},:fake_state}
  end
end
