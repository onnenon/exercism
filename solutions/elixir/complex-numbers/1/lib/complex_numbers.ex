defmodule ComplexNumbers do
  @typedoc """
  In this module, complex numbers are represented as a tuple-pair containing the real and
  imaginary parts.
  For example, the real number `1` is `{1, 0}`, the imaginary number `i` is `{0, 1}` and
  the complex number `4+3i` is `{4, 3}'.
  """
  @type complex :: {number, number}

  @doc """
  Return the real part of a complex number
  """
  @spec real(a :: complex) :: number
  def real({a, _}), do: a

  @doc """
  Return the imaginary part of a complex number
  """
  @spec imaginary(a :: complex) :: number
  def imaginary({_, i}), do: i

  @doc """
  Multiply two complex numbers, or a real and a complex number
  """
  @spec mul(a :: complex | number, b :: complex | number) :: complex
  def mul(a, b) when is_number(a) and is_number(b), do: {a * b, 0}
  def mul({a, b}, r) when is_number(r), do: {a * r, b * r}
  def mul(r, {c, d}) when is_number(r), do: {r * c, r * d}
  def mul({a, b}, {c, d}), do: {a * c - b * d, a * d + b * c}

  @doc """
  Add two complex numbers, or a real and a complex number
  """
  @spec add(a :: complex | number, b :: complex | number) :: complex
  def add(a, b) when is_number(a) and is_number(b), do: {a + b, 0}
  def add({a, b}, r) when is_number(r), do: {a + r, b}
  def add(r, {c, d}) when is_number(r), do: {r + c, d}
  def add({a, b}, {c, d}), do: {a + c, b + d}

  @doc """
  Subtract two complex numbers, or a real and a complex number
  """
  @spec sub(a :: complex | number, b :: complex | number) :: complex
  def sub(a, b) when is_number(a) and is_number(b), do: {a - b, 0}
  def sub({a, b}, r) when is_number(r), do: {a - r, b}
  def sub(r, {c, d}) when is_number(r), do: {r - c, -d}
  def sub({a, b}, {c, d}), do: {a - c, b - d}

  @doc """
  Divide two complex numbers, or a real and a complex number
  """
  @spec div(a :: complex | number, b :: complex | number) :: complex
  def div(a, b) when is_number(a) and is_number(b), do: {a / b, 0}
  def div({a, b}, r) when is_number(r), do: {a / r, b / r}

  def div(r, {c, d}) when is_number(r) do
    denom = c * c + d * d
    {r * c / denom, -r * d / denom}
  end

  def div({a, b}, {c, d}) do
    denom = c * c + d * d
    real = (a * c + b * d) / denom
    imag = (b * c - a * d) / denom
    {real, imag}
  end

  @doc """
  Absolute value of a complex number
  """
  @spec abs(a :: complex) :: number
  def abs({a, b}), do: :math.sqrt(a * a + b * b)

  @doc """
  Conjugate of a complex number
  """
  @spec conjugate(a :: complex) :: complex
  def conjugate({a, b}), do: {a, -b}

  @doc """
  Exponential of a complex number
  """
  @spec exp(a :: complex) :: complex
  def exp({a, b}) do
    ea = :math.exp(a)
    {ea * :math.cos(b), ea * :math.sin(b)}
  end
end
