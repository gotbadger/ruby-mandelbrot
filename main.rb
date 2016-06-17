require "colorize"
require_relative "lib/mandelbrot"

MAX_ITERATIONS = String.colors.count

def colour(str, itr)
  decode = String.colors[itr]
  str.colorize(decode)
end

def grid
  mandelbrot = Mandelbrot.new(MAX_ITERATIONS)
  (1.0).step(-1,-0.02) do |y|
    (-2.0).step(0.5,0.015) do |x|
      _, itr = mandelbrot.calculate(x,y)
      print itr < MAX_ITERATIONS ? "#{colour("@",itr)}" : ' '
    end
    puts
  end
end

grid
