require 'gosu'  # Librairie graphique Gosu


class Bouton

  attr_accessor :x, :y, :width, :height


  def initialize(x,y,width,height)
      @x = x
      @y = y
      @width = width
      @height = height
  end

  def draw
      Gosu.draw_rect(@x, @y, @width, @height, Gosu::Color.argb(0xff_ff0000), 2)
  end # Fin draw

end
