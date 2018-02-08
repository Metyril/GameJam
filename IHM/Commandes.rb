require 'gosu'
require_relative 'Bouton.rb'


class Commandes < Gosu::Window
  def initialize(width=1280, height=720, options={:fullscreen => false})
    super
    self.caption = 'Omotecy - Commandes'
    @cursor = Gosu::Image.new('../media/mouse.png')
    @retour = Bouton.new(10,10,350,80,Gosu::Color::CYAN,"Retour",3)

    @commandes = Gosu::Image.from_text('Commandes', 50, {:font => "../media/Basica.ttf", :align => :center})
  end

  def draw
    @retour.draw
    @cursor.draw self.mouse_x, self.mouse_y, 4
    @commandes.draw(475, 50, 0)
  end

  def update
    @mouse_x = mouse_x.to_i+30
    @mouse_y = mouse_y.to_i+10
    if @retour.isHover(@mouse_x,@mouse_y)
        @retour.color(Gosu::Color::YELLOW)
    elsif @retour.getColor == Gosu::Color::YELLOW
        @retour.color(Gosu::Color::CYAN)
    end
end

  def button_down(id)
    @mouse_x = mouse_x.to_i+30
    @mouse_y = mouse_y.to_i+10
    case id
    when Gosu::MsLeft
      if @retour.isHover(@mouse_x,@mouse_y)
        self.close!
        MenuPrincipal.new.show
      end
    end
  end
end