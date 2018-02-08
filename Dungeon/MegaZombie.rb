require 'gosu'

require_relative './Element.rb'



class MegaZombie < Ennemi
    def initialize(room, modele,app = 0, itbox=5,x=0,y=0,z=0,cracheur = true)
        super room, modele,app , itbox, x,y,z,cracheur
        @vie = 90
    end

    def deplacements(xP, zP)
      if Math.sqrt((@x-xP)**2 + (@z-zP)**2) < 70

          @angle = Math.atan2((xP - @x), (zP - @z))

          if !@a_crie
            @son.play(0.5)
            @a_crie = true
          end

          @tire = true
      else

        @tire = false

          @angle += @dirAngle

          @dirAngle = rand(-0.4..0.4) if rand(5) > 3

          if @a_crie
            @a_crie = false
          end
      end

      @x += Math.sin(@angle) * (0.3 * @vitesse) * @velRecul
      @z += Math.cos(@angle) * (0.3 * @vitesse) * @velRecul
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
