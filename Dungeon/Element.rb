# Dépendances Gems
require 'gosu'  # Librairie graphique Gosu

class Element
    attr_accessor :x, :y, :z, :itBox

    def initialize(map,itbox,x,y,z)
        @map = map
        @cell_size = @map.cell_size
        @x = x
        @y = y
        @z = z
        @itBox = itbox
        self.createElement
    end # Fin initialize


    def createElement
        @x, @z = rand(@map.width), rand(@map.height)
        while @map.map[@z][@x] < 15
            @x, @z = rand(@map.width), rand(@map.height)
        end
        @x *= @cell_size
        @z *= @cell_size
        @z = ((@map.width-1) * @cell_size) - @z
    end # Fin createElement


    def draw
        Gosu.draw_rect(@x, @z, @cell_size, @cell_size, Gosu::Color.argb(0xff_00ff00), 1)
    end # Fin draw
end # Fin Element
