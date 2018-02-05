# Dépendances Gems
require 'gosu'  # Librairie graphique Gosu

class ArmeTire < Arme
    def initialize(map, cell_size,itbox,x,y,nom)
        super
    end
    
    def tirer(x,y,angle)
      case @nom
      when "Pistolet"
        return Projectile.new(@map,@cell_size,3,x,y,3,angle)
      when "Bazooka"
        return Projectile.new(@map,@cell_size,10,x,y,10,angle)
      end
    end
  end
