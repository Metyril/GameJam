require 'gosu'

require_relative './Element.rb'



class Ennemi < Element
    def initialize(room, modele, itbox=3,x=0,y=0,z=0)
        super
    end


    #def draw
    #    Gosu.draw_rect(@x, @y, @cell_size, @cell_size, Gosu::Color.argb(0xff_0000ff), 1)
  #  end # Fin draw
end # Fin Ennemi
