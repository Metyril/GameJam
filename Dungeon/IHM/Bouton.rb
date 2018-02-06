require 'gosu'  # Librairie graphique Gosu


class Bouton

  attr_accessor :x, :y, :width, :height, :color, :text


  def initialize(x,y,width,height,color,text)
      @x = x
      @y = y
      @width = width
      @height = height
      @color = color
      @text = text
      @font = Gosu::Font.new(20)
  end

  def draw
      @font.draw(@text,@x+@x/4+10,@y,3,5,5,Gosu::Color::BLACK)
      Gosu.draw_rect(@x, @y, @width, @height, @color, 2)
  end # Fin draw

end
