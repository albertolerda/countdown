defmodule Countdown.Timer do
  alias Countdown.Timer.TimeAmount

  def change_time_amount(%TimeAmount{} = time_amount, attrs \\ %{}) do
    TimeAmount.changeset(time_amount, attrs)
  end
end
