class Particule < Element
  attr_accessor :aoe
  def initialize (room, modele, x, y, z, aoe = false)
    super room, modele, 1, x, y, z, false

    @temps = 15 + rand(0..10)
    @angle = rand(-Math::PI..Math::PI)
    @vitesse = rand(1..1.5)
    @angleAnime = rand(-3..3)
    @aoe = aoe
    @ennemis = Array.new
  end

  def update
    @temps -= 1
    @x += Math.sin(@angle) * @vitesse
    @z += Math.cos(@angle) * @vitesse
    @vitesse *= 0.95
    self.detruire if @temps <= 0
  end

  def mettreDegat(ennemi)
    if !@ennemis.include?(ennemi)
      ennemi.vie -= 1
    end
  end

  def draw camera
    @angleAnime += 0.4
    @modele.draw(camera, @x, @y, @z, @angleAnime*0.3, @angleAnime, @angleAnime*1.2)
  end # Fin draw
end
