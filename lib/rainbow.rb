class Rainbow

  attr_accessor :size
  attr_accessor :colors

  def initialize(size)
    @size = size
    @colors = rainbow
  end

  def at(index)
    @colors[index]
  end

  private

  def rainbow
    Array.new(size).each_with_index.map do |_,i|
      red =   sin_to_hex(i, 0 * Math::PI * 2/3); # 0 deg
      blue =  sin_to_hex(i, 1 * Math::PI * 2/3); # 120 deg
      green = sin_to_hex(i, 2 * Math::PI * 2/3); # 240 deg
      "##{red}#{green}#{blue}"
    end
  end

  # port of http://nikolay.rocks/2015-10-29-rainbows-generator-in-javascript
  def sin_to_hex(i, phase)
    sin = Math.sin(Math::PI / size * 2 * i + phase)
    int = (sin * 127).floor + 128;
    hex = int.to_s(16);
    hex.length == 1 ? "0"+hex : hex
  end
end
