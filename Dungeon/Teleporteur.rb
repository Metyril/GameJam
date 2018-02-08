require_relative './Ennemi.rb'
require_relative './ItemTire.rb'

class Teleporteur < Element
    attr_accessor :allSet
    def initialize fenetre, map_width, map_height, cell_size, wall_size, nb_room, type_gen, playerInitPos, batte, modeleRuby, ennemisModele, modeleTP, modPilule,itbox=2,x=0,y=0,z=0
        @allSet = self.setAll(fenetre, map_width, map_height, cell_size, wall_size, nb_room, type_gen, playerInitPos, batte, modeleRuby, ennemisModele, modeleTP, modPilule)
        room = @allSet[:map].rooms[rand(0..nb_room-1)]
        super room, modeleTP, itbox, x, y, z
        @sonTeleporteur = Gosu::Sample.new('../media/divers/teleporteur.wav')
        @sonTeleporteur.play(1)
    end

    def setAll fenetre, map_width, map_height, cell_size, wall_size, nb_room, type_gen, playerInitPos, batte, modeleRuby, ennemisModele, modeleTP, modPilule
        map = Map.new(map_width, map_height, cell_size, wall_size, nb_room, type_gen)   # Map à générer

        # playerInitPos = rand(0..nb_room-1)
        @projectiles = Array.new
        @ramassablesArme = Array.new
        @ennemis = Array.new
        @ramassables = Array.new
        @pilules = Array.new
        @drones = Array.new
        @particules = Array.new
        @vies =  Array.new
        @pieges = Array.new

        map.rooms.each_with_index do |room, r|
          if r != playerInitPos
            if fenetre.etage == 0
              self.spone(fenetre,room,"Zombie",0.5,15)
              self.spone(fenetre,room,"Ruby",0.5,15)
              self.spone(fenetre,room,"Pilule",0.5,3)
              self.spone(fenetre,room,"MegaPilule",0.5,1)
              self.spone(fenetre,room,"Drone",0.2,1)
              self.spone(fenetre,room,"ItemPoing",0.5,1)
              self.spone(fenetre,room,"Vie",0.1,1)
              self.spone(fenetre,room,"Piege",0.5,2)
            elsif fenetre.etage == 1
              self.spone(fenetre,room,"Zombie",0.5,20)
              self.spone(fenetre,room,"ZombieCracheur",0.5,4)
              self.spone(fenetre,room,"Ruby",0.5,15)
              self.spone(fenetre,room,"Pilule",0.5,3)
              self.spone(fenetre,room,"MegaPilule",0.5,1)
              self.spone(fenetre,room,"Drone",0.2,1)
              self.spone(fenetre,room,"ItemPoing",0.5,1)
              self.spone(fenetre,room,"ItemTire",0.5,1)
              self.spone(fenetre,room,"Vie",0.1,1)
              self.spone(fenetre,room,"Piege",0.5,2)
            elsif fenetre.etage == 2
              self.spone(fenetre,room,"Zombie",0.5,25)
              self.spone(fenetre,room,"ZombieCracheur",0.5,10)
              self.spone(fenetre,room,"Ruby",0.5,15)
              self.spone(fenetre,room,"Pilule",0.5,3)
              self.spone(fenetre,room,"MegaPilule",0.5,2)
              self.spone(fenetre,room,"Drone",0.2,1)
              self.spone(fenetre,room,"ItemPoing",0.5,1)
              self.spone(fenetre,room,"ItemTire",0.5,1)
              self.spone(fenetre,room,"Vie",0.1,1)
              self.spone(fenetre,room,"Piege",0.5,2)
            elsif fenetre.etage == 3
              self.spone(fenetre,room,"Zombie",0.5,30)
              self.spone(fenetre,room,"ZombieCracheur",0.5,13)
              self.spone(fenetre,room,"Ruby",0.5,15)
              self.spone(fenetre,room,"Pilule",0.5,3)
              self.spone(fenetre,room,"MegaPilule",0.5,2)
              self.spone(fenetre,room,"Drone",0.2,3)
              self.spone(fenetre,room,"ItemPoing",0.5,2)
              self.spone(fenetre,room,"ItemTire",0.5,2)
              self.spone(fenetre,room,"Vie",0.1,3)
              self.spone(fenetre,room,"Piege",0.5,2)
            end
          end
        end

        return {:map => map, :projectiles => @projectiles, :ramassablesArme => @ramassablesArme, :ennemis => @ennemis, :ramassables => @ramassables, :pilules => @pilules, :drones => @drones, :particules => @particules, :vies => @vies,:pieges => @pieges}
    end

    def spone(fenetre,room,type,proba,nbTour)
      for i in 1 .. nbTour
        if rand < proba
          case type
          when "Zombie"
            @ennemis << Ennemi.new(room, fenetre.ennemisModele)
          when "ZombieCracheur"
            @ennemis << Ennemi.new(room, fenetre.ennemisModele,3,0,0,0,true,fenetre)
          when "Ruby"
            @ramassables << ObjetRamassable.new(room, fenetre.modeleRuby)
          when "Pilule"
            @pilules << Pilule.new(fenetre,room)
          when "MegaPilule"
            @pilules << MegaPilule.new(fenetre,room)
          when "Drone"
            @drones << DroneAt.new(fenetre,room)
          when "ItemPoing"
            @ramassablesArme << ItemPoing.new(fenetre,room)
          when "ItemTire"
            @ramassablesArme << ItemTire.new(fenetre,room)
          when "Vie"
            @vies << Vie.new(room)
          when "Piege"
            @pieges << Piege.new(fenetre,room)
          end

        end
      end
    end

end
