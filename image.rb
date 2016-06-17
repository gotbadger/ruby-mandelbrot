require_relative "lib/rainbow"
require_relative "lib/mandelbrot"
require_relative "lib/image"

MAX_ITERATIONS = 20

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

def grid
  png =   Image.new(grid_x.count, grid_y.count)
  mandelbrot = Mandelbrot.new(MAX_ITERATIONS)
  rainbow = Rainbow.new(MAX_ITERATIONS)

  grid_y.each_with_index do |y, yn|
    grid_x.each_with_index do |x, xn|
      _, itr = mandelbrot.calculate(x, y)
      if itr < MAX_ITERATIONS && itr > 1
        png[yn, xn] = ChunkyPNG::Color.from_hex(rainbow.at(itr))
      end
    end
  end
  png.write_to_iterm
end

grid
