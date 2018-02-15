# Dépendances Gems
require 'gosu'  # Librairie graphique Gosu

class Piege < Item
    attr_accessor :app

    def initialize(app,room,x=0,y=0,z=0,itbox=2)
      super room,CreateModele::sol,itbox,x,y,z
      if rand < 0.5
        @nom = "Zombie"
      else
        @nom = "Projectile"
      end
      @app = app
    end # Fin initialize

    def activeEffet
      case @nom
      when "Zombie"
        for i in 1..rand(2..5)
          @app.ennemis << Ennemi.new(@room, @app.ennemisModele,@app)
        end
      when "Projectile"
        minX = @room.x_pos*@room.cell_size
        minZ = @room.y_pos*@room.cell_size
        maxX = (@room.x_pos+@room.width-1)*@room.cell_size
        maxZ = (@room.y_pos+@room.height-1)*@room.cell_size

        @app.projectiles << Projectile.new(@app,Math::PI/2,minX,@app.player.y,@app.player.z,3,1,@app.modeleProjectileVert,@room,1,true,150)
        @app.projectiles << Projectile.new(@app,3*Math::PI/2,maxX,@app.player.y,@app.player.z,3,1,@app.modeleProjectileVert,@room,1,true,150)
        @app.projectiles << Projectile.new(@app,0,@app.player.x,@app.player.y,minZ,3,1,@app.modeleProjectileVert,@room,1,true,150)
        @app.projectiles << Projectile.new(@app,Math::PI,@app.player.x,@app.player.y,maxZ,3,1,@app.modeleProjectileVert,@room,1,true,150)
      end
    end
end
