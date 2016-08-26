class Rainbow

  attr_accessor :size
  attr_accessor :colors

  def initialize(size, base_colours = [])
    @size = size
    @colors = rainbow
  end

  def at(index)
    @colors[index]
  end

  private

  def colours_between(first, last, count)
    # http://stackoverflow.com/questions/14482226/how-can-i-get-the-color-halfway-between-two-colors
  end

  def string_to_hex(value)
    value = value[1..-1] if value.length > 6
    [
      extract_from(value, 0, 1),
      extract_from(value, 2, 3),
      extract_from(value, 4, 5)
    ]
  end

  def extract_from(str, at_1, at_2)
    "#{str[0]}#{str[1]}".to_i(16)
  end

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
