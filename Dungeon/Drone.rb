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

      #@xOffset = rand(-10..10)
      #@zOffset = rand(-10..10)
      @dist = rand(2..6)
      @y = -rand(2..4)
    end

    def tirer
      if @vitesse <= 0
        @vitesse = 140
        #@app.projectiles << Projectile.new(@app,@app.player.angle,@app.player.x+rand(2..4),@app.player.y,@app.player.z+rand(2..4),@itBox,@degats,@app.modeleProjectile,@room,@vitesseP)
        @app.projectiles << Projectile.new(@app,@app.player.angle,@x,@y,@z,@itBox,@degats,@app.modeleProjectile,@room,@vitesseP)
      end
    end
    def updateActif
      @vitesse -= @attaqueVit + @app.player.vitesseAt

      player = @app.player
      angle = Math.atan2((player.x - @x), (player.z - @z))
      dist = @app.dist(self, player)

      v = ((dist-@dist)/10)
      @x += Math.sin(angle) * v
      @z += Math.cos(angle) * v
    end

    #def draw camera
    #    @modele.draw(camera, @x, @y - 2, @z, 0, 0, 0)
    #end
end
