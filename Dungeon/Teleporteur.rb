require_relative './Player.rb'
require_relative './ItemTire.rb'

class Teleporteur < Element
    attr_accessor :allSet
    def initialize fenetre, map_width, map_height, cell_size, wall_size, nb_room, type_gen, batte, modeleRuby, ennemisModele, modeleTP,itbox=2,x=0,y=0,z=0
        @allSet = self.setAll(fenetre, map_width, map_height, cell_size, wall_size, nb_room, type_gen, batte, modeleRuby, ennemisModele, modeleTP)
        room = @allSet[:map].rooms[rand(0..nb_room-1)]
        super room, modeleTP, itbox, x, y, z
    end

    def setAll fenetre, map_width, map_height, cell_size, wall_size, nb_room, type_gen, batte, modeleRuby, ennemisModele, modeleTP
        map = Map.new(map_width, map_height, cell_size, wall_size, nb_room, type_gen)   # Map à générer
    
        playerInitPos = rand(0..nb_room-1)
        # player = Player.new(map.rooms[playerInitPos], playerModele, ItemTire.new(fenetre, map.rooms[playerInitPos],0,0,0,"Pistolet"))
    
        projectiles = Array.new
        ramassablesArme = Array.new
        ennemis = Array.new
        ramassables = Array.new

        map.rooms.each_with_index do |room, r|
          if r != playerInitPos
            j = rand(2..10)
            for i in 1..j
              ennemis << Ennemi.new(room, ennemisModele)
            end
          end
          j = rand(2..10)
          for i in 1..j
            ramassables << ObjetRamassable.new(room, modeleRuby)
          end
        end
        ramassablesArme << ItemPoing.new(fenetre,map.rooms[rand(0..nb_room-1)],0,0,0,"Tronconeuse")

        return {:map => map, :projectiles => projectiles, :ramassablesArme => ramassablesArme, :ennemis => ennemis, :ramassables => ramassables}
    end
end