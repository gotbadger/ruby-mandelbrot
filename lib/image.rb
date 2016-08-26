require "oily_png"

class Image < ChunkyPNG::Image
  def initialize(height, width)
    super(width, height, ChunkyPNG::Color::BLACK)
  end

  def write_to_iterm
    data = ["",to_blob].pack('A*m').gsub(/\n/, '')
    puts("\x1b]1337;File=name=fractal;inline=1:#{data}\a\n")
  end
end
