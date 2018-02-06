require 'gosu'  # Librairie graphique Gosu


class Bouton

  attr_accessor :x, :y, :width, :height, :color, :text, :font_length


  def initialize(x,y,width,height,color,text,font_length)
      @x = x
      @y = y
      @width = width
      @height = height
      @color = color
      @text = text
      @font = Gosu::Font.new(20)
      @font_length = font_length
  end

  def draw
      @font.draw(@text,@x+@x/5+10,@y+10,3,@font_length,@font_length,Gosu::Color::BLACK)
      Gosu.draw_rect(@x, @y, @width, @height, @color, 2)
  end # Fin draw

end
