# Dépendances Gems
require 'gosu'  # Librairie graphique Gosu

require_relative './Bouton.rb'


class MenuPrincipal < Gosu::Window

    def initialize(width=1500, height=1500, options={:fullscreen => false, :update_interval => 75})     # options facultatif / update_interval est en ms
      super
      @cursor = Gosu::Image.new(self,'../../media/mouse.png')
      @bouton = Bouton.new(500,550,500,100,Gosu::Color.argb(0xff_ffff00),"Jouer");
    end

    def draw
      @bouton.draw
      @cursor.draw self.mouse_x, self.mouse_y, 4
    end

    def click_button
      if Gosu::MsLeft && this.mouse_x>@bouton.x && this.mouse_x<@bouton.x+@bouton.width && this.mouse_y>@bouton.y && this.mouse_y<@bouton.y+@bouton.height
        this.close!
      end
    end
end

#TEST
# Création d'une fenêtre
window = MenuPrincipal.new

# Affichage
window.show
