# Dépendances Gems
require 'gosu'  # Librairie graphique Gosu

class Element
    attr_accessor :x, :y, :z, :itBox, :isDetruit

    def initialize(map,modele,itbox=0,x=0,y=0,z=0)
      @modele = modele
        @map = map
        @cell_size = @map.cell_size
        @x = x
        @y = y
        @z = z
        @itBox = itbox

        @lastCel = 0
        @lastZCel = 0
        @lastXCel = 0
        @lastZ = 0
        @lastX = 0

        @isDetruit = false

        self.createElement
    end # Fin initialize

    def detruire
      @isDetruit = true
    end

    def getCelX
      return (@x / @map.cell_size).round
    end

    def getCelZ
      return (@z / @map.cell_size).round
    end

    def getCelVal
      return @map.map[self.getCelZ][self.getCelX]
    end

    def createElement
        @x, @z = rand(@map.width), rand(@map.height)
        while @map.map[@z][@x] < 15
            @x, @z = rand(@map.width), rand(@map.height)
        end
        @x *= @cell_size
        @z *= @cell_size
        #@z = ((@map.width-1) * @cell_size) - @z
    end # Fin createElement

    def collisions

        #if(this.cible.getX() < this.getX() - this.w/2){
        #  this.cible.x = this.getX() - this.w/2;
        #  this.cible.v[0] /= 2;
        #}
        #else if (this.cible.getX() >= this.getX() + this.w/2) {
        #  this.cible.x = this.getX() + this.w/2 - 1;
        #  this.cible.v[0] /= 2;
        #}
#
        #if (this.cible.getY() < this.getY() - this.h/2) {
      #    this.cible.y = this.getY() - this.h/2;
        #  this.cible.v[1] /= 2;
      #  }
      #  else if (this.cible.getY() >= this.getY() + this.h/2) {
      #    this.cible.y = this.getY() + this.h/2 - 1;
      #    this.cible.v[1] /= 2;
      #  }

      val = @lastCel
      col = false


      if (val & S) == 0 && @z > (@lastZCel*@map.cell_size) + ((@map.cell_size/2) - 4)
        #@z = @lastZ * @map.cell_size + (@map.cell_size/2)+10 if @z < @lastZ * @map.cell_size + (@map.cell_size/2)+10
        #@z = @lastZCel * (@map.cell_size-1)  if @lastZ < @lastZCel * (@map.cell_size-1)
        #puts "z: #{@z} lastz: #{@lastZ}"
        #if
          @z = (@lastZCel*@map.cell_size) + ((@map.cell_size/2) - 4)
          puts "S"
        #end
      elsif (val & N) == 0 && @z < (@lastZCel*@map.cell_size) - ((@map.cell_size/2) - 4)
        #@z = @lastZ * @map.cell_size - (@map.cell_size/2)-10 if @z > @lastZ * @map.cell_size - (@map.cell_size/2)-10
        #@z = @lastZCel * (@map.cell_size)  if @lastZ > @lastZCel * (@map.cell_size)
        #if
          @z = (@lastZCel*@map.cell_size) - ((@map.cell_size/2) - 4)
          puts "N"
        #end
      end

      #if !(W & val)
      #  if @x > (@lastXCel*@map.cell_size) - (@map.cell_size/2) + 2
      #    @x = (@lastXCel*@map.cell_size) - (@map.cell_size/2) + 2
      #  end
      #end

      #if !(E & val)
      #  if @x < (@lastXCel*@map.cell_size) + (@map.cell_size/2) - 2
      #    @x = (@lastXCel*@map.cell_size) + (@map.cell_size/2) - 2
      #  end
      #end

      return col
    end

    def update
    end

    def draw camera
        #Gosu.draw_rect(@x, @z, @cell_size, @cell_size, Gosu::Color.argb(0xff_00ff00), 1)
        @modele.draw(camera, @x, @y, @z, 0, 0, 0)
    end # Fin draw
end # Fin Element
