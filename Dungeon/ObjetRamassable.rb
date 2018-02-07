class ObjetRamassable < Element
  def initialize room,modele,itbox=2,x=0,y=0,z=0
    super

    @angle = rand 1
  end

  def update
    @angle += 0.025
  end

  def draw camera
      #Gosu.draw_rect(@x, @z, @cell_size, @cell_size, Gosu::Color.argb(0xff_00ff00), 1)
      @modele.draw(camera, @x, @y, @z, 0, @angle, 0)
  end # Fin draw
end
