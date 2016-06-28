require_relative "lib/rainbow"
require_relative "lib/mandelbrot"
require_relative "lib/image"
require "byebug"

DEFAULT_MAX_ITERATIONS = 20
class MandelbrotImage

  def initialize(x, y, resolution, max_iterations=DEFAULT_MAX_ITERATIONS)
    @x0, @x1 = x
    @y0, @y1 = y
    @resolution = resolution
    @max_iterations = max_iterations
    @pallet = Rainbow.new(max_iterations)
  end

  def grid_x
    (@x0).step(@x1, @resolution)
  end

  def grid_y
    (@y0).step(@y1, @resolution)
  end

  def draw
    png =   Image.new(grid_x.count, grid_y.count)
    mandelbrot = Mandelbrot.new(@max_iterations)

    grid_y.each_with_index do |y, yn|
      grid_x.each_with_index do |x, xn|
        _, itr = mandelbrot.calculate(x, y)
        if itr < @max_iterations && itr > 1
          png[yn, xn] = get_colour_for(itr)
        end
      end
    end
    png.write_to_iterm
    # png.save("mandlebrot.png")
  end

  private

  def get_colour_for(itr)
    ChunkyPNG::Color.from_hex(@pallet.at(itr))
  end
end

MandelbrotImage.new([-2.0,1.0], [-1.5, 1.5], 0.003, 20).draw
# MandelbrotImage.new([-1.08, -1.0], [0.3, 0.40],  0.0001, 30).draw
