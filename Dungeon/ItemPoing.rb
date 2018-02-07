# Dépendances Gems
require 'gosu'  # Librairie graphique Gosu
require_relative 'Item.rb'

class ItemPoing < Item
      attr_accessor :vitesse, :isAttaque
  def initialize(app,map,modele,itbox,x,y,z)
      super map , modele, itbox , x,y,z
      @vitesse = 0
      @app = app
  end

  def attaque
    if @vitesse <= 0
      @vitesse = 140

        @app.ennemis.each do |ennemie|
          x = Math.sin(@app.player.angle) * 8 + @app.player.x
          z = Math.cos(@app.player.angle) * 8 + @app.player.z
          if Math.sqrt((ennemie.x - x)**2 + (ennemie.z - z)**2) < (@app.player.arme.itBox + ennemie.itBox)
            ennemie.detruire
          end
        end

      end
  end

  def update
    @vitesse -= 1
  end
end
