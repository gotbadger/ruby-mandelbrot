require "oily_png"
require_relative "lib/rainbow"
require_relative "lib/image"

WIDTH = 20
MAX_Y = 20


class Pallet
  def initialize(colors)
    @pallet = Rainbow.new(colors)
  end

  def draw_chunk(index, png, shade)
    x0 = (WIDTH*index)+1
    x1 = x0+WIDTH
    # puts "#{x0}->#{x1} (#{shade})"
    colour = ChunkyPNG::Color.from_hex(shade)
    png.rect(x0, 1, x1, MAX_Y-1, colour, colour)
  end

  def draw
    png = Image.new(MAX_Y, (@pallet.colors.count*WIDTH))
    @pallet.colors.each_with_index do |shade, index|
      draw_chunk(index, png, shade)
    end
    png.write_to_iterm
  end

end



Pallet.new(50).draw
