defmodule MyAppWeb.SampleLive.CounterLive do
  use MyAppWeb, :live_component

  def render(assigns) do
    ~H"""
    <div class="hero">I am content: <%= @content %></div>
    """
  end

  @spec update(atom | %{:content => any, optional(any) => any}, map) :: {:ok, map}
  def update(assigns, socket) do

    {:ok,
    socket
    |> assign(:content, assigns.content)}
  end
end
