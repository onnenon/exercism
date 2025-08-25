defmodule PaintByNumber do
  def palette_bit_size_(color_count, prev_iteration) do
    current_iteration = prev_iteration + 1

    case 2 ** current_iteration do
      x when x >= color_count -> current_iteration
      x when x < color_count -> palette_bit_size_(color_count, current_iteration)
    end
  end

  def palette_bit_size(color_count) do
    palette_bit_size_(color_count, 0)
  end

  def empty_picture() do
    <<>>
  end

  def test_picture() do
    <<0::2, 1::2, 2::2, 3::2>>
  end

  def prepend_pixel(picture, color_count, pixel_color_index) do
    bit_size = palette_bit_size(color_count)
    <<pixel_color_index::size(bit_size), picture::bitstring>>
  end

  def get_first_pixel(picture, color_count) do
    bit_size = palette_bit_size(color_count)

    case picture do
      <<>> -> nil
      <<value::size(bit_size), _::bitstring>> -> value
    end
  end

  def drop_first_pixel(picture, color_count) do
    bit_size = palette_bit_size(color_count)

    case picture do
      <<>> -> <<>>
      <<_::size(bit_size), rest::bitstring>> -> rest
    end
  end

  def concat_pictures(<<>>, <<>>), do: <<>>
  def concat_pictures(a, <<>>), do: a
  def concat_pictures(<<>>, b), do: b

  def concat_pictures(picture1, picture2) do
    <<picture1::bitstring, picture2::bitstring>>
    # Please implement the concat_pictures/2 function
  end
end
