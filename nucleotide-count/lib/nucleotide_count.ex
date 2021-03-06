defmodule NucleotideCount do
  @nucleotides [?A, ?C, ?G, ?T]

  @initial Enum.reduce(@nucleotides, %{}, &(Map.put(&2, &1, 0)))

  @doc """
  Counts individual nucleotides in a DNA strand.

  ## Examples

  iex> NucleotideCount.count('AATAA', ?A)
  4

  iex> NucleotideCount.count('AATAA', ?T)
  1
  """
  @spec count(charlist(), char()) :: non_neg_integer()
  def count(strand, nucleotide) do
    histogram(strand)[nucleotide]
  end

  @doc """
  Returns a summary of counts by nucleotide.

  ## Examples

  iex> NucleotideCount.histogram('AATAA')
  %{?A => 4, ?T => 1, ?C => 0, ?G => 0}
  """
  @spec histogram(charlist()) :: map()
  def histogram(strand) do
    Enum.reduce(
      strand,
      @initial,
      fn char, acc ->
        Map.update(acc, char, 0, &(&1 + 1))
      end
    )
  end
end
