# Dépendances Gems
require 'gosu'  # Librairie graphique Gosu

class Element
    attr_accessor :x, :y, :itBox

    def initialize(map, cell_size,itbox,x,y)
        @map = map
        @cell_size = cell_size
        @x = x
        @y = y
        @itBox = itbox
        self.createElement
    end # Fin initialize


    def createElement
        @x, @y = rand(@map.width), rand(@map.height)
        while @map.map[@y][@x] < 15
            @x, @y = rand(@map.width), rand(@map.height)
        end
        @x *= @cell_size
        @y *= @cell_size
    end # Fin createElement


    def draw
        Gosu.draw_rect(@x, @y, @cell_size, @cell_size, Gosu::Color.argb(0xff_00ff00), 1)
    end # Fin draw
end # Fin Element
