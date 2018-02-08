require 'gosu'

require_relative './Element.rb'



class MegaZombie < Ennemi
    def initialize(room, modele, itbox=5,x=0,y=0,z=0,cracheur = true ,app = 0)
        super room, modele , itbox, x,y,z,cracheur,app
        @vie = 90
    end

    def attaque
      if @cracheur
        if @vitesseAt <= 0
          @vitesseAt = 140
          @app.projectiles << Projectile.new(@app,@angle,@x,@y,@z,3,1,@app.modeleProjectileVert,@room,1,true,50)
          @app.projectiles << Projectile.new(@app,@angle-Math::PI/4,@x,@y,@z,3,1,@app.modeleProjectileVert,@room,1,true,100)
          @app.projectiles << Projectile.new(@app,@angle+Math::PI/4,@x,@y,@z,3,1,@app.modeleProjectileVert,@room,1,true,100)
          @app.projectiles << Projectile.new(@app,@angle-Math::PI/6,@x,@y,@z,3,1,@app.modeleProjectileVert,@room,1,true,100)
          @app.projectiles << Projectile.new(@app,@angle+Math::PI/6,@x,@y,@z,3,1,@app.modeleProjectileVert,@room,1,true,100)
        end
        @vitesseAt -= 1
      end
    end
end # Fin Ennemi
