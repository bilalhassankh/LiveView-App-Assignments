defmodule MyAppWeb.PicturesLive do
  use Phoenix.LiveView
  alias MyAppWeb.Router.Helpers, as: Routes

  @pictures %{
    "ySMOWp3oBZk" => %{
      author: "Ludomił",
      img: "https://images.unsplash.com/photo-1515532718572-84a0ef89c998"
    },
    "svEN_5NXO3o" => %{
      author: "George Desipris",
      img: "https://images.unsplash.com/photo-1520765333005-1966cab37761"
    },
    "XesILKdmkwM" => %{
      author: "Ludomił",
      img: "https://images.unsplash.com/photo-1530717449302-271006cdc1bf"
    },
    "rgAAcndHGBc" => %{
      author: "Yuliya Kosolapova",
      img: "https://images.unsplash.com/photo-1547892549-e197e0456244"
    }
  }

  def render(assigns) do
    pictures = @pictures

    ~L"""
    <div class="row">
    <%= for {id, pic} <- pictures do %>
      <%= live_redirect to: Routes.live_path(@socket, MyAppWeb.PicturesLive, id) do %>
          <div class="column"
            phx-click="show" phx-value="<%= id %>">
            <%= pic.author %>
            <img src="<%= picture_url(pic.img, :thumb) %>">
          </div>
     <% end %>
    <% end %>
    </div>

    <%= if @selected_picture do %>
      <hr>
        <label><%= @selected_picture.author %></label>
        <img src="<%= picture_url(@selected_picture.img, :big) %>">
    <% end %>
    """
  end

  def mount(_session, socket) do
    socket = assign(socket, :selected_picture, nil)
    {:ok, socket}
  end

  def handle_params(%{"id" => id}, _uri, socket) do
    picture = @pictures[id]
    {:noreply, assign(socket, :selected_picture, picture)}
  end

  def handle_params(_, _uri, socket) do
    {:noreply, assign(socket, :selected_picture, nil)}
  end

  defp picture_url(img, :thumb),
    do: "#{img}?w=250fit=crop"

  defp picture_url(img, :big),
    do: "#{img}?w=800&h=500fit=crop"
end
