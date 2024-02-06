defmodule CountdownWeb.CountdownFormLive do
  use CountdownWeb, :live_view

  alias Countdown.Timer
  alias Countdown.Timer.TimeAmount

  def mount(_params, _session, socket) do
    {:ok, socket
      |> assign(:seconds, 0)
      |> assign(:time_amount, %TimeAmount{})
      |> clear_form()}
  end

  def clear_form(socket) do
    form = socket.assigns.time_amount
      |> Timer.change_time_amount()
      |> to_form()
    socket |> assign(:form, form)
  end


  def handle_event("start-clock", %{"time_amount" => time_amount_params},
      %{assigns: %{seconds: seconds, time_amount: time_amount}} = socket) do
    changeset =
      time_amount
      |> Timer.change_time_amount(time_amount_params)

    if changeset.valid? do
      if seconds == 0, do: Process.send_after(self(), :tick, 1000)
      {:noreply, socket 
        |> assign(:seconds, seconds + changeset.changes.amount)}
    else
      {:noreply, socket
        |> put_flash(:error, "Invalid time amount")}
    end
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
