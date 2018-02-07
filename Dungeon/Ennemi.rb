require 'gosu'

require_relative './Element.rb'



class Ennemi < Element
  attr_accessor :vie
    def initialize(room, modele, itbox=3,x=0,y=0,z=0)
        super
        @vie = 3
        @angle = 0
        @dirAngle = 0
        @vitesse = rand(0.5..1.2)
        @velRecul = 1
    end


    def deplacements(xP, zP)
        # if (@x <= xP + 20 || @x >= xP - 20) && (@z <= zP + 20 || @z >= zP - 20)
        if Math.sqrt((@x-xP)**2 + (@z-zP)**2) < 40
            # if @x > xP
            #     @x -= 0.4
            # else
            #     @x += 0.4
            # end
            # if @z > zP
            #     @z -= 0.4
            # else
            #     @z += 0.4
            # end

            @angle = Math.atan2((xP - @x), (zP - @z))


        else

            @angle += @dirAngle

            @dirAngle = rand(-0.4..0.4) if rand(5) > 3
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

    def draw camera
        #Gosu.draw_rect(@x, @z, @cell_size, @cell_size, Gosu::Color.argb(0xff_00ff00), 1)
        @modele.draw(camera, @x, @y, @z, 0, -@angle, 0)
      end # Fin draw
    #def draw
    #    Gosu.draw_rect(@x, @y, @cell_size, @cell_size, Gosu::Color.argb(0xff_0000ff), 1)
  #  end # Fin draw
end # Fin Ennemi
