defmodule Cards.Card do
  @enforce_keys [:value, :suit]

  defstruct [:value, :suit]
end
