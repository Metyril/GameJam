require 'gosu'

require_relative './Element.rb'



class MegaZombie < Ennemi
    def initialize(room, modele, itbox=5,x=0,y=0,z=0,cracheur = true ,app = 0)
        super room, modele , itbox, x,y,z,cracheur,app
        @vie = 250
        @vitesseSpone = 750
    end

    def attaque
      if @cracheur
        if @vitesseAt <= 0
          @vitesseAt = 140
          @app.projectiles << Projectile.new(@app,@angle,@x,@y,@z,3,1,@app.modeleProjectileVert,@room,1,true)
          @app.projectiles << Projectile.new(@app,@angle-Math::PI/4,@x,@y,@z,3,1,@app.modeleProjectileVert,@room,1,true)
          @app.projectiles << Projectile.new(@app,@angle+Math::PI/4,@x,@y,@z,3,1,@app.modeleProjectileVert,@room,1,true)
          @app.projectiles << Projectile.new(@app,@angle-Math::PI/6,@x,@y,@z,3,1,@app.modeleProjectileVert,@room,1,true)
          @app.projectiles << Projectile.new(@app,@angle+Math::PI/6,@x,@y,@z,3,1,@app.modeleProjectileVert,@room,1,true)
        end
        @vitesseAt -= 1
      end
      self.sponeZombie
    end

    def sponeZombie
      if @vitesseSpone <= 0
        @vitesseSpone = 1500
        for i in 1..4
          @app.ennemis << Ennemi.new(@room, @app.ennemisModele)
        end
      end
      @vitesseSpone -= 1
    end

end # Fin Ennemi
