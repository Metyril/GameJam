# Dépendances Gems
require 'gosu'  # Librairie graphique Gosu

require_relative './Bouton.rb'
require_relative '../../main.rb'

class MenuPrincipal < Gosu::Window

    def initialize(width=1280, height=720, options={:fullscreen => true})     # options facultatif / update_interval est en ms
      super
      @cursor = Gosu::Image.new('../../media/mouse.png')
      @titre = Gosu::Image.new('../../media/Omotecy - Titre Final.png')
      @bouton = Bouton.new(500,350,250,80,Gosu::Color::CYAN,"Jouer",3)
      @music = Gosu::Song.new('../../media/little_apocalypse.ogg')
    end

    def draw
      @bouton.draw
      @titre.draw 50, 100, 2
      @cursor.draw self.mouse_x, self.mouse_y, 4
      @music.play(true)
    end

    def button_down(id)
      @mouse_x = mouse_x.to_i+30
      @mouse_y = mouse_y.to_i+10
      case id
      when Gosu::Window
        print("TEST")
        if @mouse_x>@bouton.x && @mouse_x<@bouton.x+@bouton.width && @mouse_y>@bouton.y && @mouse_y<@bouton.y+@bouton.height
          @bouton.color(Gosu::Color::YELLOW)
        end
      when Gosu::MsLeft
        if @mouse_x>@bouton.x && @mouse_x<@bouton.x+@bouton.width && @mouse_y>@bouton.y && @mouse_y<@bouton.y+@bouton.height
          self.close!
          Fenetre.new.show
        end
      end
    end
end

#TEST
# Création d'une fenêtre
window = MenuPrincipal.new

# Affichage
window.show
