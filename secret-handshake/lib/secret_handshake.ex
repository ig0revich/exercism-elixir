defmodule SecretHandshake do
  use Bitwise, only_operators: true

  @special_code 16

  @actions %{
    1 => "wink",
    2 => "double blink",
    4 => "close your eyes",
    8 => "jump",
    @special_code => None
  }

  @doc """
  Determine the actions of a secret handshake based on the binary
  representation of the given `code`.

  If the following bits are set, include the corresponding action in your list
  of commands, in order from lowest to highest.

  1 = wink
  10 = double blink
  100 = close your eyes
  1000 = jump

  10000 = Reverse the order of the operations in the secret handshake
  """
  @spec commands(code :: integer) :: list(String.t())
  def commands(code) do
    Enum.reduce(
      @actions,
      [],
      fn item, acc ->
        known_code = elem(item, 0)
        needs_action = (code &&& known_code) == known_code

        cond do
          needs_action && known_code != @special_code -> acc ++ [elem(item, 1)]
          needs_action && known_code == @special_code -> Enum.reverse(acc)
          true -> acc
        end
      end
    )
  end
end
