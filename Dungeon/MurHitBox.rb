class MurHitBox
  attr_accessor :x, :z
  def initialize o
    @x = 0
    @z = 0

    @o = o
  end

  def setPos x, z
    @x = x
    @z = z
  end

  def collision cible
    puts "cible.x: #{cible.x} cible.z: #{cible.z}, @x: #{@x} @z: #{@z}"

    if @o == "S"
      if (cible.z + cible.itBox + 2) > @z
        cible.z = @z - cible.itBox - 2
      end
    end

    if @o == "N"
      if (cible.z - cible.itBox - 2) < @z
        cible.z = @z + cible.itBox + 2
      end
    end
  end
end
