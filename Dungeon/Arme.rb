# Dépendances Gems
require 'gosu'  # Librairie graphique Gosu

class Arme < Item
  attr_accessor :nom
    def initialize(map, cell_size,itbox,x,y,nom)
        super
        @nom = nom
    end
  end
