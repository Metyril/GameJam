require 'gosu'

require_relative './Element.rb'



class Ennemi < Element
  attr_accessor :vie
    def initialize(room, modele, itbox=3,x=0,y=0,z=0)
        super
        @vie = 3
    end


    def deplacements(xP, zP)
        if xP >= @x - 2*20 && zP >= @z - 2*20
            if @x > xP
                @x -= 0.4
            else
                @x += 0.4
            end
            if @z > zP
                @z -= 0.4
            else
                @z += 0.4
            end
        end
    end


    #def draw
    #    Gosu.draw_rect(@x, @y, @cell_size, @cell_size, Gosu::Color.argb(0xff_0000ff), 1)
  #  end # Fin draw
end # Fin Ennemi
