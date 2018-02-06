# Dépendances Gems
require 'gosu'  # Librairie graphique Gosu

require_relative './Bouton.rb'
require_relative '../../main.rb'

class MenuPrincipal < Gosu::Window

    def initialize(width=1000, height=600, options={:fullscreen => false, :update_interval => 75})     # options facultatif / update_interval est en ms
      super
      @cursor = Gosu::Image.new('../../media/mouse.png')
      @titre = Gosu::Image.new('../../media/titre.png')
      @bouton = Bouton.new(350,250,310,80,Gosu::Color::BLUE,"Jouer",3)
      @music = Gosu::Song.new('../../media/little_apocalypse.ogg')
    end

    def draw
      @bouton.draw
      @titre.draw 200, 100, 2
      @cursor.draw self.mouse_x, self.mouse_y, 4
      @music.play(true)
    end

    def button_down(id)
      @mouse_x = mouse_x.to_i+30
      @mouse_y = mouse_y.to_i+10
      case id
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
