defmodule CountdownWeb.CountdownLive do
  use CountdownWeb, :live_view

  @seconds_amount 5
  def seconds_amount, do: @seconds_amount

  def mount(_params, _session, socket) do
    {:ok, socket |> assign(:seconds, 0)}
  end

  def handle_event("start-clock", _params, %{assigns: %{seconds: seconds}} = socket) do
    if seconds == 0, do: Process.send_after(self(), :tick, 1000)
    {:noreply, socket |> assign(:seconds, seconds + @seconds_amount)}
  end

  def handle_info(:tick, %{assigns: %{seconds: seconds}} = socket) do
    if seconds > 0 do
      Process.send_after(self(), :tick, 1000)
      {:noreply, socket |> assign(:seconds, seconds-1)}
    else
      {:noreply, socket}
    end
  end
end
