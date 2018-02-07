class Particule < Element
  def initialize room, modele, x, y, z
    super room, modele, 0, x, y, z, false

    @temps = 15 + rand(0..10)
    @angle = rand(-Math::PI..Math::PI)
    @vitesse = rand(1..1.5)

    @angleAnime = rand(-3..3)
  end

  def update
    @temps -= 1
    @x += Math.sin(@angle) * @vitesse
    @z += Math.cos(@angle) * @vitesse
    @vitesse *= 0.95
    self.detruire if @temps <= 0
  end

  def draw camera
    #Gosu.draw_rect(@x, @z, @cell_size, @cell_size, Gosu::Color.argb(0xff_00ff00), 1)
    @angleAnime += 0.4
    @modele.draw(camera, @x, @y, @z, @angleAnime*0.3, @angleAnime, @angleAnime*1.2)
  end # Fin draw
end
