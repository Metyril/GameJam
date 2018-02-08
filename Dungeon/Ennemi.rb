require 'gosu'

require_relative './Element.rb'



class Ennemi < Element
  attr_accessor :vie,:room,:son
    def initialize(room, modele,app = 0, itbox=3,x=0,y=0,z=0,cracheur = false)
        super room, modele , itbox, x,y,z
        @app = app
        @vie = rand(1..(3+@app.etage*4))
        @angle = 0
        @dirAngle = 0
        @vitesse = rand(0.5..1.2)
        @velRecul = 1
        @vitesseAt = 0
        @cracheur = cracheur

        @tire = false

        @rand = rand(2).to_i
        if @rand == 0
          @son = Gosu::Sample.new('./media/zombie/zombie01.ogg')
        elsif @rand == 1
          @son = Gosu::Sample.new('./media/zombie/zombie03.ogg')
        elsif @rand == 2
          @son = Gosu::Sample.new('./media/zombie/zombie04.ogg')
        end
        @a_crie = false
    end


    def deplacements(xP, zP)
        if Math.sqrt((@x-xP)**2 + (@z-zP)**2) < 50

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

    def recul
      @velRecul = -1
    end

    def update
      @velRecul += 0.04 if @velRecul < 1
    end

    def attaque
      if @cracheur && @tire
        if @vitesseAt <= 0
          @vitesseAt = 140
          @app.projectiles << Projectile.new(@app,@angle,@x,@y,@z,3,1,@app.modeleProjectileVert,@room,1,true)
        end
        @vitesseAt -= 1
      end
    end

    def draw camera
        @modele.draw(camera, @x, @y, @z, 0, -@angle, 0)
      end # Fin draw
end # Fin Ennemi
