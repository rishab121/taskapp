defmodule TaskappWeb.TimeBlocksView do
  use TaskappWeb, :view
  alias TaskappWeb.TimeBlocksView

  def render("index.json", %{times: times}) do
    %{data: render_many(times, TimeBlocksView, "time_blocks.json")}
  end

  def render("show.json", %{time_blocks: time_blocks}) do
    %{data: render_one(time_blocks, TimeBlocksView, "time_blocks.json")}
  end

  def render("time_blocks.json", %{time_blocks: time_blocks}) do
    %{id: time_blocks.id,
      start: time_blocks.start,
      end: time_blocks.end}
  end
end
