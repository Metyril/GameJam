# Dépendances Gems
require 'gosu'  # Librairie graphique Gosu
require_relative 'Item.rb'

class DroneAt < Item
    attr_accessor :app,:nom,:room,:attaqueVit,:vitesse
    def initialize(app,room,x=0,y=0,z=0,itbox=1)
      @app = app
      @nom = nom
      @room = room
      @vitesse = 0
      @vitesseP = 2
      @degats = 1
      @attaqueVit = 1
      modele = @app.modeleDrone
      super room, modele,itbox,x,y,z
    end

    def tirer
      if @vitesse <= 0
        @vitesse = 140
        @app.projectiles << Projectile.new(@app,@app.player.angle,@app.player.x+rand(2..4),@app.player.y,@app.player.z+rand(2..4),@itBox,@degats,@app.modeleProjectile,@room,@vitesseP)
      end
    end
    def update
      @vitesse -= @attaqueVit + @app.player.vitesseAt
    end
end
