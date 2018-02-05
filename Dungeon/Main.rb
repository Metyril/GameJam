####################################################################################################################################################################################
#       Principe général :
# Le but de ce programme est de générer un donjon inspiré des jeux Rogue-like
# Pour se faire, un processus est utilisé pour permettre une génération optimale et aléatoire :
#   - On place plusieurs salles dans le donjon
#   - On crée un labyrinthe autour de ces salles
#   - On ouvre les salles au labyrinthe
#   - On retire un certain nombre de culs-de-sac
# Ce processus a été pensé par Bob Nystrom et est disponible au complet ici : http://journal.stuffwithstuff.com/2014/12/21/rooms-and-mazes/
# Il y développe son raisonnement clairement, avec des exemples des différentes étapes efficaces pour comprendre les différents mécanismes exploités
#
#       Principe de la classe :
# GameWindow est une classe héritée de la fenêtre de jeu de la librairie Gosu
# Elle permet donc de contrôler la globalité du jeu telles que les paramètres généraux, les IHM...
# La fenêtre de Gosu intègre une boucle de jeu, il suffit donc de donner les opérations à update et à draw pour faire fonctionner le jeu
####################################################################################################################################################################################



# Dépendances Gems
require 'gosu'  # Librairie graphique Gosu

# Dépendances Fichiers
require_relative './Map.rb' # Génération de Map
require_relative './Player.rb'
require_relative './Element.rb'
require_relative './Ennemi.rb'



class GameWindow < Gosu::Window     # Hérite de la fenêtre Gosu

    def initialize(width=1500, height=1500, options={:fullscreen => false, :update_interval => 75})     # options facultatif / update_interval est en ms
        super

        @width = width      # Largeur de la fenêtre
        @height = height    # Hauteur de la fenêtre
        self.caption = "Rogue-like Map Generator"   # Nom de la fenêtre

        @map_width = 50         # Largeur de la Map
        @map_height = 50        # Hauteur de la Map
        @cell_size = 30         # Taille d'une cellule
        @wall_size = 5          # Largeur d'un mur
        @nb_room = 30            # Nombre de salles
        @type_gen = 'random'    # Type de génération / 4 valeurs possibles : 'random', 'newest', 'middle', 'oldest'

        @map = Map.new(@map_width, @map_height, @cell_size, @wall_size, @nb_room, @type_gen)   # Map à générer

        @player = Player.new(@map, @cell_size)

        @elements = Array.new(10, 0)
        for i in 0..9
            @elements[i] = Element.new(@map, @cell_size)
        end

        @ennemis = Array.new(5, 0)
        for i in 0..4
            @ennemis[i] = Ennemi.new(@map, @cell_size)
        end

        @draws = 0          # Nombre de draw effectués / Sert pour l'affichage de la première frame
        @buttons_down = 0   # Nombre de boutons déclenchés
    end


    def update  # Opérations à faire toutes les update_interval ms
        if button_down?(Gosu::KbSpace)
            @map = Map.new(@map_width, @map_height, @cell_size, @wall_size, @nb_room, @type_gen)   # Map à générer
            @player = Player.new(@map, @cell_size)

            @elements = Array.new(10, 0)
            for i in 0..9
                @elements[i] = Element.new(@map, @cell_size)
            end

            @ennemis = Array.new(5, 0)
            for i in 0..4
                @ennemis[i] = Ennemi.new(@map, @cell_size)
            end
        end

        @player.x -= @cell_size if button_down?(Gosu::KbLeft) && (@map.map[@player.y / @cell_size][@player.x / @cell_size] & W != 0)
        @player.x += @cell_size if button_down?(Gosu::KbRight) && (@map.map[@player.y / @cell_size][@player.x / @cell_size] & E != 0)
        @player.y -= @cell_size if button_down?(Gosu::KbUp) && (@map.map[@player.y / @cell_size][@player.x / @cell_size] & N != 0)
        @player.y += @cell_size if button_down?(Gosu::KbDown) && (@map.map[@player.y / @cell_size][@player.x / @cell_size] & S != 0)

        @ennemis.each do |ennemi|
            if @player.x == ennemi.x && @player.y == ennemi.y
                @player = Player.new(@map, @cell_size)
            end

            dir = rand(1..4)
            case dir
                when 1
                    ennemi.x -= @cell_size if @map.map[ennemi.y / @cell_size][ennemi.x / @cell_size] & W != 0
                when 2
                    ennemi.x += @cell_size if @map.map[ennemi.y / @cell_size][ennemi.x / @cell_size] & E != 0
                when 3
                    ennemi.y -= @cell_size if @map.map[ennemi.y / @cell_size][ennemi.x / @cell_size] & N != 0
                when 4
                    ennemi.y += @cell_size if @map.map[ennemi.y / @cell_size][ennemi.x / @cell_size] & S != 0
            end
        end

        case button_down?
        when (Gosu::KB_Z)
          @player.deplacementX("Z")
        when (Gosu::KB_S)
          @player.deplacementX("S")
        when (Gosu::KB_D)
          @player.deplacementX("D")
        when (Gosu::KB_Q)
          @player.deplacementX("Q")
         when (Gosu::KB_Space)

           if @player.arme != 0
             if @player.arme.class == ArmeTire
               @player.tirer()
             else
             @player.frapper()
             end
           end
        end

    end


    def button_down(id)     # Opérations à faire lorsqu'on appuie sur une touche du clavier / de la souris
        close if id == Gosu::KbEscape
        @buttons_down += 1
    end


    def button_up(id)       # Opérations à faire lorsqu'on relâche une touche du clavier / de la souris
        @buttons_down -= 1
    end


    def needs_cursor?   # Affiche le curseur de la souris dans la fenêtre
        true
    end


    def needs_redraw?   # Conditions pour relancer la méthode draw de la fenêtre / Peut économiser de la mémoire
        @draws == 0 || @buttons_down > 0
    end


    def draw    # Opérations à réaliser et qui peuvent être affichées dans la fenêtre
        @draws += 1

        # Background
        Gosu.draw_rect(0, 0, @width, @height, Gosu::Color.argb(0xff_000000))

        # Map
        @map.draw
        @player.draw
        @elements.each do |element|
            element.draw
        end
        @ennemis.each do |ennemi|
            ennemi.draw
        end

    end

end # Fin GameWindow



# Création d'une fenêtre
window = GameWindow.new

# Affichage
window.show

# ap = Map.new(20,20,10,2,2,'random')
# map.showMap
# puts
# puts
# map.showRooms
