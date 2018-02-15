class Point
  @@ZOOM = 1
  attr_accessor :x, :y, :z
  def initialize(x = 0, y = 0, z = 0)
    @x = x
    @y = y
    @z = z
  end

  def project(pp, cam, x = 0, y = 0, z = 0, aX = 0, aY = 0, aZ = 0)
    pp.x = @x
    pp.y = @y
    pp.z = @z

    #rotateX
    save = pp.y
    pp.y = Math.cos(aX) * pp.y + Math.sin(aX) * pp.z
    pp.z = -Math.sin(aX) * save + Math.cos(aX) * pp.z

    #rotateY
    save = pp.x
    pp.x = Math.cos(aY) * pp.x - Math.sin(aY) * pp.z
    pp.z = Math.sin(aY) * save + Math.cos(aY) * pp.z

    #rotateZ
    save = pp.x;
    pp.x = Math.cos(aZ) * pp.x - Math.sin(aZ) * pp.y
    pp.y = Math.sin(aZ) * save + Math.cos(aZ) * pp.y

    #translation de l'objet et de la camera
    pp.x += x - cam.position.x
    pp.y += y - cam.position.y
    pp.z += z - cam.position.z

    #rotateY de la camera
    save = pp.x
    pp.x = Math.cos(cam.rotation.y) * pp.x - Math.sin(cam.rotation.y) * pp.z
    pp.z = Math.sin(cam.rotation.y) * save + Math.cos(cam.rotation.y) * pp.z

    #rotateX  de la camera
    save = pp.y
    pp.y = Math.cos(cam.rotation.x) * pp.y + Math.sin(cam.rotation.x) * pp.z
    pp.z = -Math.sin(cam.rotation.x) * save + Math.cos(cam.rotation.x) * pp.z

    #Projection
    save = (pp.z * @@ZOOM) / 450
    pp.x = pp.x / save
    pp.y = pp.y / save
  end

  def self.setZoom (z)
    @@ZOOM = z
  end
end

class Triangle
  @@DWIDTH = 0
  @@DHEIGHT = 0

  def self.setRefSize (w, h)
    @@DWIDTH = w / 2
    @@DHEIGHT = h / 2
  end

  def initialize(a, b, c, couleur = 0xffffffff)
    @a = a
    @b = b
    @c = c
    @couleur = couleur
  end

  def draw()
     if ((@b.x - @a.x) * (@c.y - @a.y) - (@b.y - @a.y) * (@c.x - @a.x)) > 0 && @a.z > 0 && @b.z > 0 && @c.z > 0
      Gosu::draw_triangle(@a.x + @@DWIDTH, @a.y + @@DHEIGHT, @couleur, @b.x + @@DWIDTH, @b.y + @@DHEIGHT, @couleur, @c.x + @@DWIDTH, @c.y + @@DHEIGHT, @couleur, -(@a.z + @b.z + @c.z))
    end
  end
end

class Modele
  def initialize(points = Array.new, triangles = Array.new)
    projectPoints = points
    @tousLesPoints = Array.new

    points.each do |pt|
       @tousLesPoints.push([pt, pt.dup])
    end

    @triangles = triangles
  end

  def draw(cam, x = 0, y = 0, z = 0, aX = 0, aY = 0, aZ = 0)
    @tousLesPoints.each do |lesPoints|
      lesPoints.last.project(lesPoints.first, cam, x, y, z, aX, aY, aZ)
    end

    @triangles.each do |point|
      point.draw()
    end
  end
end

class TriangleSpe < Triangle
  def draw()
     if ((@b.x - @a.x) * (@c.y - @a.y) - (@b.y - @a.y) * (@c.x - @a.x)) > 0 && @a.z > 0 && @b.z > 0 && @c.z > 0
      Gosu::draw_triangle(@a.x + @@DWIDTH, @a.y + @@DHEIGHT, @couleur, @b.x + @@DWIDTH, @b.y + @@DHEIGHT, @couleur, @c.x + @@DWIDTH, @c.y + @@DHEIGHT, @couleur, -9999)
    end
  end
end

class Camera
  attr_accessor :position, :rotation
  def initialize(x,y,z)
    @position = Point.new(x, y, z)
    @rotation = Point.new(0, 0, 0)
  end
end
