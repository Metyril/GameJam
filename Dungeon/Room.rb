class Room

    # Getters
    attr_accessor :width, :height, :x_pos, :y_pos, :cell_size, :room

    def initialize(map_width, map_height, cell_size, lastRoom = false)
        if lastRoom
          @width = 8     # Largeur de la Room
          @height = 10    # Hauteur de la Room
        else
          @width = rand(3..10)     # Largeur de la Room
          @height = rand(3..10)    # Hauteur de la Room
        end

        @x_pos = rand(1..map_width-@width-1)    # Position X de la Room dans la Map, aléatoire
        @y_pos = rand(1..map_height-@height-1)  # Position Y de la Room dans la Map, aléatoire

        @cell_size = cell_size

        @room = Array.new(@height) { Array.new(@width, 15)}
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

        return x1 < x2 + width2 + @cell_size && x1 + width1 + @cell_size > x2 && y1 < y2 + height2 + @cell_size && y1 + height1 + @cell_size > y2
    end

end # Fin Room
