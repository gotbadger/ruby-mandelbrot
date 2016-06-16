require "complex"
require "colorize"

MAX_ITERATIONS = String.colors.count

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

def grid
  (1.0).step(-1,-0.02) do |y|
    (-2.0).step(0.5,0.015) do |x|
      _, itr = mandelbrot(Complex(x,y))
      print itr < MAX_ITERATIONS ? "#{colour("@",itr)}" : ' '
    end
    puts
  end
end

grid
