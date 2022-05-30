defmodule MyAppWeb.MoonLive do
  use Phoenix.LiveView
  alias MyAppWeb.Router.Helpers, as: Routes

  @moons ["🌑", "🌒", "🌓", "🌔", "🌝", "🌖", "🌗", "🌘"]
  @moons_count Enum.count(@moons)

  def render(assigns) do
    ~L"""
    <button phx-click="start">start</button>
    <button phx-click="stop">stop</button>
    """
  end

  def mount(_session, socket) do
    {:ok, socket}
  end

  def handle_params(_, _uri, socket) do
    {:noreply, socket}
  end

  def handle_event("start", _, socket) do
    socket =
      socket
      |> assign(:moon_idx, 0)
      |> assign(:running, true)

    Process.send_after(self(), "next_moon", 100)
    {:noreply, socket}
  end

  def handle_event("stop", _, socket) do
    {:noreply, assign(socket, :running, false)}
  end

  def handle_info("next_moon", socket) do
    idx = rem(socket.assigns.moon_idx, @moons_count)
    moon = Enum.at(@moons, idx)
    socket = assign(socket, :moon_idx, idx + 1)
    if socket.assigns.running, do: Process.send_after(self(), "next_moon", 100)

    {:noreply,
     push_patch(socket,
       to: Routes.live_path(socket, MyAppWeb.MoonLive, moon),
       replace: true
     )}
  end
end
