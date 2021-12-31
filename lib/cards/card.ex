defmodule Cards.Card do
  @moduledoc """
  Defines the Card structure
  """

  @enforce_keys [:value, :suit]

  defstruct [:value, :suit]
end
