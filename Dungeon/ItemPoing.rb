# Dépendances Gems
require 'gosu'  # Librairie graphique Gosu
require_relative 'Item.rb'

class ItemPoing < Item
      attr_accessor :vitesse,:range,:degats,:attaqueVit,:startAnime
  def initialize(app,room,modele,x,y,z,nom)
    case nom
    when "Batte"
      @range = 8
      @attaqueVit = 2
      @degats = 2
      itbox = 3
    when "Tronconeuse"
      @range = 10
      @attaqueVit = 1
      @degats = 4
      itbox = 5
    when "Main"
      @range = 3
      @attaqueVit = 4
      @degats = 1
      itbox = 3
    end
      @vitesse = 0
      @app = app
      @startAnime = false
      super room , modele, itbox , x,y,z
  end

  def attaque
    if @vitesse <= 0
      @vitesse = 140
      @startAnime = true

        @app.ennemis.each do |ennemie|
          x = Math.sin(@app.player.angle) * @range + @app.player.x
          z = Math.cos(@app.player.angle) * @range + @app.player.z
          if Math.sqrt((ennemie.x - x)**2 + (ennemie.z - z)**2) < (@itBox + ennemie.itBox)
            ennemie.vie -= @degats
          end
        end

      end
  end

  def update
    @vitesse -= @attaqueVit
  end
end
