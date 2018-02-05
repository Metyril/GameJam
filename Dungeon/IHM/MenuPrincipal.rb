# Dépendances Gems
require 'gosu'  # Librairie graphique Gosu

require_relative './Bouton.rb'


class MenuPrincipal < Gosu::Window

    def initialize(width=1500, height=1500, options={:fullscreen => false, :update_interval => 75})     # options facultatif / update_interval est en ms
      super
      @bouton = Bouton.new(500,550,500,100,Gosu::Color.argb(0xff_ffff00),"Jouer");
    end

    def draw
      @bouton.draw
    end
end

#TEST
# Création d'une fenêtre
window = MenuPrincipal.new

# Affichage
window.show
