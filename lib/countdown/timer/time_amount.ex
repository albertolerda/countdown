defmodule Countdown.Timer.TimeAmount do
  defstruct [:amount]
  @types %{amount: :integer}

  import Ecto.Changeset
  def changeset(%__MODULE__{} = time_amount, attrs) do
    {time_amount, @types}
    |> cast(attrs, Map.keys(@types))
    |> validate_number(:amount, greater_than_or_equal_to: 0)
  end
end
