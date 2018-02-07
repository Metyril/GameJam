class Particule < Element
  def initialize room, modele, x, y, z
    super room, modele, 0, x, y, z, false

    @temps = 100
    @angle = rand(-Math::PI..Math::PI)
    @vitesse = rand(2..5)
  end

  def update
    @temps -= 1
    @x += Math.sin(@angle) * @vitesse
    @z += Math.cos(@angle) * @vitesse

    self.detruire if @temps == 0
  end
end
