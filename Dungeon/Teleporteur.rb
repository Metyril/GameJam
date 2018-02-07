require_relative './Player.rb'
require_relative './ItemTire.rb'

class Teleporteur < Element
    attr_accessor :allSet
    def initialize fenetre, map_width, map_height, cell_size, wall_size, nb_room, type_gen, playerInitPos, batte, modeleRuby, ennemisModele, modeleTP, modPilule,itbox=2,x=0,y=0,z=0
        @allSet = self.setAll(fenetre, map_width, map_height, cell_size, wall_size, nb_room, type_gen, playerInitPos, batte, modeleRuby, ennemisModele, modeleTP, modPilule)
        room = @allSet[:map].rooms[rand(0..nb_room-1)]
        super room, modeleTP, itbox, x, y, z
    end

    def setAll fenetre, map_width, map_height, cell_size, wall_size, nb_room, type_gen, playerInitPos, batte, modeleRuby, ennemisModele, modeleTP, modPilule
        map = Map.new(map_width, map_height, cell_size, wall_size, nb_room, type_gen)   # Map à générer

        # playerInitPos = rand(0..nb_room-1)

        projectiles = Array.new
        ramassablesArme = Array.new
        ennemis = Array.new
        ramassables = Array.new
        pilules = Array.new
        drones = Array.new
        particules = Array.new
        vies =  Array.new

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
          j = rand(2..4)
          for i in 1..j
            if rand < 0.2
              pilules << Pilule.new(fenetre,room,modPilule)
            end
          end
          j = rand(2..4)
          for i in 1..j
            if rand < 0.1
              drones << DroneAt.new(fenetre,room)
            end
          end
          j = rand(2..4)
          for i in 1..j
            if rand < 0.5
              ramassablesArme << ItemPoing.new(fenetre,map.rooms[rand(0..nb_room-1)])
            else rand> 0.5
              ramassablesArme << ItemTire.new(fenetre,map.rooms[rand(0..nb_room-1)])
            end
          end
          j = rand(2..4)
          for i in 1..j
            if rand < 0.1
              vies << Vie.new(map.rooms[rand(0..nb_room-1)])
            end
          end
        end

        return {:map => map, :projectiles => projectiles, :ramassablesArme => ramassablesArme, :ennemis => ennemis, :ramassables => ramassables, :pilules => pilules, :drones => drones, :particules => particules, :vies => vies}
    end
end
