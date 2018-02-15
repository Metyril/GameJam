require 'gosu'  # Librairie graphique Gosu

# Dépendances Fichiers
require_relative './Room.rb' # Génération de Room


# Déclarations de constantes
N, S, E, W = 1, 2, 4, 8
DX         = { E => 1, W => -1, N =>  0, S => 0 }
DY         = { E => 0, W =>  0, N => -1, S => 1 }
OPPOSITE   = { E => W, W =>  E, N =>  S, S => N }



class Map

    # Getters
    attr_accessor :map, :width, :height, :rooms, :cell_size

    def initialize(width, height, cell_size, wall_size, nb_room, type_gen, lastRoom = false)
        @width = width              # Largeur de la Map
        @height = height            # Hauteur de la Map
        @cell_size = cell_size      # Taille d'une cellule
        @wall_size = wall_size      # Largeur d'un mur
        @nb_room = nb_room          # Nombre de salles
        @type_gen = type_gen        # Type de génération du Maze

        @lastRoom = lastRoom

        @map = Array.new(@height) { Array.new(@width, 0) }  # Initialisation de la Map à 0 / Nécessaire pour la méthode createMaze

        # Création des salles / Min : 1, Max : Selon Map et Gosu
        @rooms = [Room.new(@width, @height, @cell_size)]
        for i in 1..@nb_room-1
            @rooms << self.addRoom
        end

        # Création de la Map à partir de @map et de @rooms
        self.createMap

        # Création du Maze à partire de @map
        self.createMaze

        # Ouverture des Rooms au Maze
        self.openRoom

        # Fermeture du Maze
        self.closeMaze
    end # Fin initialize


    def addRoom   # Crée une instance de Room, si elle n'est pas créée sur une autre Room on l'ajoute à @rooms
        tmp_room = Room.new(@width, @height, @cell_size, @lastRoom)
        collision = false
        @rooms.each do |room|
            if room.isCollide(tmp_room)
                collision = true
                break;
            end
        end
        if !collision
            return tmp_room
        else
            return addRoom
        end
    end # Fin addRoom


    def createMap   # Récupère @rooms et ajoute chaque Room dans la Map
        @rooms.each do |r|
            x = r.x_pos
            y = r.y_pos
            i = 0
            j = 0
            r.room.each do |row|
                row.each do |cell|
                    @map[y+i][x+j] = cell
                    j += 1
                end
                i += 1
                j = 0
            end
        end
    end # Fin createMap


    def createMaze  # Méthode pour générer le Maze contenu dans la Map
        # Début du Maze
        x, y = rand(@width), rand(@height)
        while @map[y][x] != 0
            x, y = rand(@width), rand(@height)
        end

        # cells est une liste de cellule à faire traiter par l'algorithme
        cells = []
        cells << [x, y]

        until cells.empty?
            case @type_gen
                when 'random'
                    index = rand(cells.length)
                when 'newest'
                    index = cells.length - 1
                when 'middle'
                    index = cells.length / 2
                when 'oldest'
                    index = 0
            end
            x, y = cells[index]

            # Mélange des directions et choix de l'une d'entre elles / Si impossible, prendre la suivante
            [N, S, E, W].shuffle.each do |dir|
                nx, ny = x + DX[dir], y + DY[dir]

                # Cellule choisie dans la Map et pas encore traitée? Sinon on en choisit une autre
                if nx >= 0 && ny >= 0 && nx < @width && ny < @height && @map[ny][nx] == 0

                    # Valuation de la cellule et de celle choisie
                    @map[y][x] |= dir
                    @map[ny][nx] |= OPPOSITE[dir]

                    # Ajout de la cellule choisie dans cells
                    cells << [nx, ny]
                    index = nil
                    break
                end
            end

            # On enlève une cellule de cells lorsqu'aucune direction n'est traitable
            cells.delete_at(index) if index
        end
    end # Fin createMaze


    def openRoom
        @rooms.each do |room|
            x = rand(0..room.width-1)
            y = rand(0..room.height-1)

            while room.room[y][x] == 15 || room.room[y][x] == 6 || room.room[y][x] == 5 || room.room[y][x] == 10 || room.room[y][x] == 9
                x = rand(0..room.width-1)
                y = rand(0..room.height-1)
            end

            x += room.x_pos
            y += room.y_pos

            if @map[y][x] == 7
                @map[y][x] |= W
                @map[y][x-1] |= E
            elsif @map[y][x] == 11
                @map[y][x] |= E
                @map[y][x+1] |= W
            elsif @map[y][x] == 14
                @map[y][x] |= N
                @map[y-1][x] |= S
            elsif @map[y][x] == 13
                @map[y][x] |= S
                @map[y+1][x] |= N
            end
        end
    end # Fin openRoom


    def closeMaze
        continue = true
        while(continue)
            continue = false
            x = 0
            y = 0
            @map.each do |row|
                row.each do |cell|
                    if cell == N
                        @map[y][x] = 0
                        @map[y-1][x] -= S
                        continue = true
                    elsif cell == S
                        @map[y][x] = 0
                        @map[y+1][x] -= N
                        continue = true
                    elsif cell == E
                        @map[y][x] = 0
                        @map[y][x+1] -= W
                        continue = true
                    elsif cell == W
                        @map[y][x] = 0
                        @map[y][x-1] -= E
                        continue = true
                    end
                    x += 1
                end
                y += 1
                x = 0
            end
        end
    end # Fin closeMaze


    def draw    # Opérations à réaliser et qui peuvent être affichées dans la fenêtre
        x = 0
        y = 0
        @map.each do |row|
            row.each do |cell|

                # Cellule de Room? Sinon c'est une cellule de Maze
                if cell == 0
                    Gosu.draw_rect(x, y, @cell_size, @cell_size, Gosu::Color.argb(0xff_000000), 1)
                else
                    Gosu.draw_rect(x, y, @cell_size, @cell_size, Gosu::Color.argb(0xff_ffffff), 1)

                    # Affichage du mur selon les directions valuées dans la cellule
                    if cell & N == 0
                        Gosu.draw_rect(x, y, @cell_size, @wall_size, Gosu::Color.argb(0xff_000000), 3)
                    end
                    if cell & S == 0
                        Gosu.draw_rect(x, y + @cell_size - @wall_size, @cell_size, @wall_size, Gosu::Color.argb(0xff_000000), 3)
                    end
                    if cell & E == 0
                        Gosu.draw_rect(x + @cell_size - @wall_size, y, @wall_size, @cell_size, Gosu::Color.argb(0xff_000000), 3)
                    end
                    if cell & W == 0
                        Gosu.draw_rect(x, y, @wall_size, @cell_size, Gosu::Color.argb(0xff_000000), 3)
                    end
                end
                x += @cell_size
            end
            y += @cell_size
            x = 0
        end
    end # Fin draw

end # Fin Map
