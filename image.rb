# require "base64"
require 'oily_png'
require "complex"
require "colorize"

MAX_ITERATIONS = 20

# port of http://nikolay.rocks/2015-10-29-rainbows-generator-in-javascript
def sin_to_hex(i, phase, size)
  sin = Math.sin(Math::PI / size * 2 * i + phase)
  int = (sin * 127).floor + 128;
  hex = int.to_s(16);
  hex.length == 1 ? "0"+hex : hex
end

def rainbow(size)
  Array.new(size).each_with_index.map do |_,i|
    red   = sin_to_hex(i, 0 * Math::PI * 2/3, size); # 0   deg
    blue  = sin_to_hex(i, 1 * Math::PI * 2/3, size); # 120 deg
    green = sin_to_hex(i, 2 * Math::PI * 2/3, size); # 240 deg
    "#"+ red + green + blue
  end
end

RAINBOW = rainbow(MAX_ITERATIONS)

def mandelbrot(a)
  base_case = [a, 0]
  Array.new(MAX_ITERATIONS, base_case).inject(base_case) do |prev ,base|
    z, itr = prev
    c, _ = base
    val = z*z + c
    itr += 1 unless val.abs < 2
    [val, itr]
  end
end

def colour(str, itr)
  decode = String.colors[itr]
  str.colorize(decode)
end

def grid_x
  # (-2.0).step(0.5,0.001)
  (-2.0).step(0.5,0.003)
  # (-2.0).step(0.5,0.015)
end

def grid_y
  # (1.0).step(-1,-0.001)
  (1.0).step(-1,-0.003)
  # (1.0).step(-1,-0.02)
end

def display(png)
  data = ["",png.to_blob].pack('A*m').gsub(/\n/, '')
  puts("\x1b]1337;File=name=fractal;inline=1:#{data}\a\n")
end

def generate_image
  height = grid_x.count
  width = grid_y.count
  ChunkyPNG::Image.new(width, height, ChunkyPNG::Color::TRANSPARENT)
end

def grid
  png = generate_image()
  grid_y.each_with_index do |y, yn|
    grid_x.each_with_index do |x, xn|
      _, itr = mandelbrot(Complex(x,y))
      if itr < MAX_ITERATIONS && itr > 1
        # png[yn, xn] =  ChunkyPNG::Color('red')
        png[yn, xn] = ChunkyPNG::Color.from_hex(RAINBOW[itr])
      end
    end
  end
  display(png)
end

# test

grid
