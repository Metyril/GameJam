# Dépendances Gems
require 'gosu'  # Librairie graphique Gosu

class ArmePoint < Arme
    def initialize(map, cell_size,itbox,x,y,nom)
        super
    end
    
    def frapper(x,y,angle)
      liste = Array.new()
      case @nom
      when "Batte"
        for i in 1..20
          liste << Point.new(x + i*Math.sin(angle),y + i*Math.cos(angle))
        end
      when "Tronceneuse"
        for i in 1..40
          liste << Point.new(x + i*Math.sin(angle),y + i*Math.cos(angle))
        end
      end
      return liste
    end
end
