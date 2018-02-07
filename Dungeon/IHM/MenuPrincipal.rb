# Dépendances Gems
require 'gosu'  # Librairie graphique Gosu

require_relative './Bouton.rb'
#require_relative '../../main.rb'

class MenuPrincipal < Gosu::Window

    def initialize(width=1280, height=720, options={:fullscreen => true})     # options facultatif / update_interval est en ms
      super
      @cursor = Gosu::Image.new('../../media/mouse.png')
      @titre = Gosu::Image.new('../../media/Omotecy - Titre Final.png')
      @bouton = Bouton.new(500,350,270,80,Gosu::Color::CYAN,"Jouer",3)
      @exit = Bouton.new(500,450,270,80,Gosu::Color::CYAN,"Quitter",2.8)
      @music = Gosu::Song.new('../../media/little_apocalypse.ogg')
    end

    def draw
      @bouton.draw
      @exit.draw
      @titre.draw 50, 100, 2
      @cursor.draw self.mouse_x, self.mouse_y, 4
      @music.play(true)
    end

    def update
      @mouse_x = mouse_x.to_i+30
      @mouse_y = mouse_y.to_i+10
      if @bouton.isHover(@mouse_x,@mouse_y)
        @bouton.color(Gosu::Color::YELLOW)
      elsif @bouton.getColor == Gosu::Color::YELLOW
        @bouton.color(Gosu::Color::CYAN)
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
        if @bouton.isHover(@mouse_x,@mouse_y)
          self.close!
          #Fenetre.new.show
        end
        if @exit.isHover(@mouse_x,@mouse_y)
          self.close!
        end
      end
    end
end

#TEST
# Création d'une fenêtre
window = MenuPrincipal.new

# Affichage
window.show
