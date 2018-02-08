# Dépendances Gems
require 'gosu'  # Librairie graphique Gosu

require_relative 'Bouton.rb'
# require_relative '../main.rb'
# require_relative 'MenuPrincipal.rb'

class MenuGameOver < Gosu::Window

    def initialize(width=1280, height=720, options={:fullscreen => false})     # options facultatif / update_interval est en ms
      super
      @cursor = Gosu::Image.new('../media/mouse.png')
      @titre = Gosu::Image.new('../media/Omotecy - Titre Final.png')
      @rejouer = Bouton.new(500,350,270,80,Gosu::Color::CYAN,"Rejouer",3)
      @exit = Bouton.new(500,450,270,80,Gosu::Color::CYAN,"Quitter",2.8)
    end

    def draw
      @rejouer.draw
      @exit.draw
      @titre.draw 50, 100, 2
      @cursor.draw self.mouse_x, self.mouse_y, 4
    end

    def update
      @mouse_x = mouse_x.to_i+30
      @mouse_y = mouse_y.to_i+10
      if @rejouer.isHover(@mouse_x,@mouse_y)
        @rejouer.color(Gosu::Color::YELLOW)
      elsif @rejouer.getColor == Gosu::Color::YELLOW
        @rejouer.color(Gosu::Color::CYAN)
      end
      if @exit.isHover(@mouse_x,@mouse_y)
        @exit.color(Gosu::Color::YELLOW)
      elsif @exit.getColor == Gosu::Color::YELLOW
        @exit.color(Gosu::Color::CYAN)
      end
    end

    def button_down(id)
      @mouse_x = mouse_x.to_i+30
      @mouse_y = mouse_y.to_i+10
      case id
      when Gosu::MsLeft
        if @rejouer.isHover(@mouse_x,@mouse_y)
          self.close!
          Fenetre.new.show
        end
        if @exit.isHover(@mouse_x,@mouse_y)
          self.close!
          MenuPrincipal.new.show
        end
      end
    end
end