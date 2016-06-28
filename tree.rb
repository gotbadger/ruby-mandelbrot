require "oily_png"
require_relative "lib/image"

MAX_ITERATIONS = 2
WIDTH = 200
HEIGHT = 200

def basic_draw
  red = ChunkyPNG::Color.from_hex("#ff0000")
  green = ChunkyPNG::Color.from_hex("#00ff00")
  blue = ChunkyPNG::Color.from_hex("#0000ff")
  white = ChunkyPNG::Color.from_hex("#ffffff")
  transparent = ChunkyPNG::Color::TRANSPARENT
  png = Image.new(HEIGHT, WIDTH)
  png.rect(HEIGHT/2, WIDTH/2, HEIGHT-1, WIDTH-1, red, transparent)
  png.line(1, 1, WIDTH, HEIGHT, green)
  png.line(1, HEIGHT, WIDTH, 1, blue)
  # puts png.inspect
  png.write_to_iterm
  # png.save("out.png")
end


basic_draw
