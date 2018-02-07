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
    hit = false
    if @o == "S"
      if (cible.z + cible.itBox + 2) > @z
        cible.z = @z - cible.itBox - 2
        hit = true
      end
    end

    if @o == "N"
      if (cible.z - cible.itBox - 2) < @z
        cible.z = @z + cible.itBox + 2
        hit = true
      end
    end

    if @o == "E"
      if (cible.x + cible.itBox + 2) > @x
        cible.x = @x - cible.itBox - 2
        hit = true
      end
    end

    if @o == "W"
      if (cible.x - cible.itBox - 2) < @x
        cible.x = @x + cible.itBox + 2
        hit = true
      end
    end

    return hit
  end
end
