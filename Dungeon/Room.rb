######################################################################################################################
#       Principe de la classe :
# Une Room est une pièce composée de plusieurs cellules
# Elle est de taille aléatoire et est placée à un endroit aléatoire de la Map
# Une Room peut vérifier si elle est placée sur une autre Room à sa création
# Le but étant d'espacer (ou regrouper) les Rooms dans la Map
#
#       Evaluation des cellules :
# On évalue les cellules de chaque Room pour ne pas qu'elles soient traitées par le Maze généré par la Map
# On choisit aussi pour valeur 16 afin de ne pas être évalué par certaines conditions du draw de Map
# Plus de détails sur la valuation des cellules dans le fichier de la classe Map
#######################################################################################################################



class Room

    # Getters
    attr_accessor :width, :height, :x_pos, :y_pos, :room

    def initialize(map_width, map_height, cell_size)
        @width = rand(3..10)     # Largeur de la Room
        @height = rand(3..10)    # Hauteur de la Room
        @x_pos = rand(1..map_width-@width-1)    # Position X de la Room dans la Map, aléatoire
        @y_pos = rand(1..map_height-@height-1)  # Position Y de la Room dans la Map, aléatoire

        @cell_size = cell_size  # Taille d'une cellule / Pour gérer les collisions

        @room = Array.new(@height) { Array.new(@width, 15)}     # Initialisation de la Room à 16 / Permet une évaluation différente des cellules du Maze
        self.createRoom
    end


    def createRoom
        @room.each do |row|
            row[0] = 7
            row[@width-1] = 11
        end

        @room[0][0] = 6
        @room[0].fill(14, 1, @width-2)
        @room[0][@width-1] = 10

        @room[@height-1][0] = 5
        @room[@height-1].fill(13, 1, @width-2)
        @room[@height-1][@width-1] = 9
    end


    def isCollide(room)     # Détecte la collision entre 2 instances de Room
        # Coordonnées de cette instance de Room
        x1 = @x_pos * @cell_size
        y1 = @y_pos * @cell_size
        width1 = @width * @cell_size
        height1 = @height * @cell_size

        # Coordonnées de l'instance de Room passée en paramètre
        x2 = room.x_pos * @cell_size
        y2 = room.y_pos * @cell_size
        width2 = room.width * @cell_size
        height2 = room.height * @cell_size

        # Valeur retour : Vrai si collision, Faux sinon
        # Source : https://developer.mozilla.org/fr/docs/Games/Techniques/2D_collision_detection
        return x1 < x2 + width2 + @cell_size &&
               x1 + width1 + @cell_size > x2 &&
               y1 < y2 + height2 + @cell_size &&
               y1 + height1 + @cell_size > y2
    end

end # Fin Room
