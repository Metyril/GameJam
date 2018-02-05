require 'gosu'

require_relative './Element.rb'



class Player < Element
    def initialize(map, cell_size)
        super
    end

    def draw
        Gosu.draw_rect(@x, @y, @cell_size, @cell_size, Gosu::Color.argb(0xff_ff0000), 2)
    end # Fin draw
end # Fin Player