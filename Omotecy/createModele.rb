class CreateModele
  def self.sim
    s1 = Point.new(-1, 0, -1)
    s2 = Point.new(-1, 0, 1)
    s3 = Point.new(0, -2, 0)
    s4 = Point.new(1, 0, 1)
    s5 = Point.new(1, 0, -1)
    s6 = Point.new(0, 2, 0)

    pointsSim = [s1, s2, s3, s4, s5, s6]

    trianglesSim = [
      ### pyramide bas
      Triangle.new(s1, s2, s3, 0xff2ecc71),
      Triangle.new(s2, s4, s3, 0xfff39c12),
      Triangle.new(s4, s5, s3, 0xff2980b9),
      Triangle.new(s5, s1, s3, 0xffe74c3c),

      ### pyramide haut
      Triangle.new(s2, s1, s6, 0xff8e44ad),
      Triangle.new(s4, s2, s6, 0xffecf0f1),
      Triangle.new(s5, s4, s6, 0xffF03434),
      Triangle.new(s1, s5, s6, 0xff95A5A6)
    ]

    return Modele.new(pointsSim, trianglesSim)
  end

  def self.cube
    c1 = Point.new(-1, 1, -1)
    c2 = Point.new(-1, -1, -1)
    c3 = Point.new(1, 1, -1)
    c4 = Point.new(1, -1, -1)
    c5 = Point.new(-1, -1, 1)
    c6 = Point.new(-1, 1, 1)
    c7 = Point.new(1, 1, 1)
    c8 = Point.new(1, -1, 1)

    pointsCube = [c1, c2, c3, c4, c5, c6, c7, c8]

    trianglesCube = [
      # devant
      Triangle.new(c1, c2, c3, 0xff2ecc71),
      Triangle.new(c3, c2, c4, 0xff2ecc71),
      #---

      # deriere
      Triangle.new(c5, c6, c7, 0xfff39c12),
      Triangle.new(c8, c5, c7, 0xfff39c12),
      #---

      # haut
      Triangle.new(c6, c1, c7, 0xff2980b9),
      Triangle.new(c1, c3, c7, 0xff2980b9),
      #---

      # bas
      Triangle.new(c2, c5, c8, 0xffe74c3c),
      Triangle.new(c4, c2, c8, 0xffe74c3c),
      #---

      # droite
      Triangle.new(c4, c8, c7, 0xff8e44ad),
      Triangle.new(c3, c4, c7, 0xff8e44ad),
      #---

      # gauche
      Triangle.new(c5, c2, c6, 0xffecf0f1),
      Triangle.new(c2, c1, c6, 0xffecf0f1)
      #---
    ]

    return Modele.new(pointsCube, trianglesCube)
  end

  def self.tonneau b = 1.2
    t1 = Point.new(0, -2, 2)
    t2 = Point.new(2, -2, 0.4)
    t3 = Point.new(1.2, -2, -2)
    t4 = Point.new(-1.2, -2, -2)
    t5 = Point.new(-2, -2, 0.4)

    t6 = Point.new(0, 2, 2)
    t7 = Point.new(2, 2, 0.4)
    t8 = Point.new(1.2, 2, -2)
    t9 = Point.new(-1.2, 2, -2)
    t10 = Point.new(-2, 2, 0.4)

    t11 = Point.new(0 * b, 0, 2 * b)
    t12 = Point.new(2 * b, 0, 0.4 * b)
    t13 = Point.new(1.2 * b, 0, -2 * b)
    t14 = Point.new(-1.2 * b, 0, -2 * b)
    t15 = Point.new(-2 * b, 0, 0.4 * b)

    pointsTonneau = [t1, t2, t3, t4, t5, t6, t7, t8, t9, t10, t11, t12, t13, t14, t15];

    trianglesTonneau = [
      #bas
      Triangle.new(t1, t2, t3, 0xffd35400),
      Triangle.new(t1, t3, t4, 0xffd35400),
      Triangle.new(t1, t4, t5, 0xffd35400),

      #haut
      Triangle.new(t6, t8, t7, 0xffd35400),
      Triangle.new(t6, t9, t8, 0xffd35400),
      Triangle.new(t6, t10, t9, 0xffd35400),

      #cotes bas
      Triangle.new(t1, t11, t2, 0xfff1c40f),
      Triangle.new(t2, t11, t12, 0xfff1c40f),
      Triangle.new(t2, t12, t3, 0xfff1c40f),
      Triangle.new(t3, t12, t13, 0xfff1c40f),
      Triangle.new(t4, t3, t13, 0xffFFC312),
      Triangle.new(t4, t13, t14, 0xffFFC312),
      Triangle.new(t5, t14, t15, 0xffFFC312),
      Triangle.new(t5, t4, t14, 0xffFFC312),
      Triangle.new(t5, t15, t1, 0xffe67e22),
      Triangle.new(t1, t15, t11, 0xffe67e22),



      Triangle.new(t6, t7, t11, 0xffe67e22),
      Triangle.new(t7, t12, t11, 0xffe67e22),
      Triangle.new(t7, t8, t12, 0xfff39c12),
      Triangle.new(t8, t13, t12, 0xfff39c12),
      Triangle.new(t9, t13, t8, 0xfff39c12),
      Triangle.new(t9, t14, t13, 0xfff39c12),
      Triangle.new(t10, t15, t14, 0xfffbc531),
      Triangle.new(t10, t14, t9, 0xfffbc531),

      Triangle.new(t10, t6, t15, 0xfffbc531),
      Triangle.new(t6, t11, t15, 0xfffbc531)
    ]

    return Modele.new(pointsTonneau, trianglesTonneau)
  end

  def self.pyramide
    p1 = Point.new(0, 0, 1.3)
    p2 = Point.new(-1.2, 0, -0.7)
    p3 = Point.new(1.2, 0, -0.7)
    p4 = Point.new(0, -2, 0)

    pointsPyramide = [p1, p2, p3, p4]

    trianglesPyramide = [
      #base
      Triangle.new(p1, p2, p3, 0xff6c5ce7),

      #cotes
      Triangle.new(p1, p4, p2, 0xff0984e3),
      Triangle.new(p3, p4, p1, 0xffd63031),
      Triangle.new(p2, p4, p3, 0xff00b894)
    ]

    return Modele.new(pointsPyramide, trianglesPyramide)
  end

  def self.sol
    s1 = Point.new(0, 0, 0)
    s2 = Point.new(0, 0, 10)
    s3 = Point.new(10, 0, 0)
    s4 = Point.new(10, 0, 10)

    pointsSol = [s1, s2, s3, s4]

    trianglesSol = [
      Triangle.new(s1, s2, s3, 0xffb2bec3),
      Triangle.new(s4, s3, s2, 0xffb2bec3)
    ]

    return Modele.new(pointsSol, trianglesSol)
  end

  def self.mur
    m1 = Point.new(-4, 0, 0)
    m2 = Point.new(4, 0, 0)
    m3 = Point.new(-4, -4, 0)
    m4 = Point.new(4, -4, 0)

    pointsMur = [m1, m2, m3, m4]

    trianglesMur = [
      Triangle.new(m1, m2, m3),
      Triangle.new(m2, m4, m3)
    ]

    return Modele.new(pointsMur, trianglesMur)
  end

  def self.cellule m = "0000"
    size = 10

    c1 = Point.new(-size, 0, size)
    c2 = Point.new(size, 0, size)
    c3 = Point.new(size, 0, -size)
    c4 = Point.new(-size, 0, -size)

    pointsCellule = [c1, c2, c3, c4]

    trianglesCellule = [
      TriangleSpe.new(c1, c2, c3, 0xff808e9b),
      TriangleSpe.new(c1, c3, c4, 0xff808e9b)
    ]

    #NORD
    if m[3] == "0"
      cm1 = Point.new(-size, -size, size)
      cm2 = Point.new(size, -size, size)

      pointsCellule.push(cm1)
      pointsCellule.push(cm2)

      trianglesCellule.push(Triangle.new(cm1, c2, c1, 0xff7158e2))
      trianglesCellule.push(Triangle.new(cm2, c2, cm1, 0xff7158e2))
    end

    #EST
    if m[1] == "0"
      cm1 = Point.new(size, -size, size)
      cm2 = Point.new(size, -size, -size)

      pointsCellule.push(cm1)
      pointsCellule.push(cm2)

      trianglesCellule.push(Triangle.new(cm1, c3, c2, 0xffff9f1a))
      trianglesCellule.push(Triangle.new(cm2, c3, cm1, 0xffff9f1a))
    end

    #SUD
    if m[2] == "0"
      cm1 = Point.new(size, -size, -size)
      cm2 = Point.new(-size, -size, -size)

      pointsCellule.push(cm1)
      pointsCellule.push(cm2)

      trianglesCellule.push(Triangle.new(cm1, c4, c3, 0xff7158e2))
      trianglesCellule.push(Triangle.new(cm2, c4, cm1, 0xff7158e2))
    end

    #OUEST
    if m[0] == "0"
      cm1 = Point.new(-size, -size, -size)
      cm2 = Point.new(-size, -size, size)

      pointsCellule.push(cm1)
      pointsCellule.push(cm2)

      trianglesCellule.push(Triangle.new(cm1, c1, c4, 0xffff9f1a))
      trianglesCellule.push(Triangle.new(cm2, c1, cm1, 0xffff9f1a))
    end

    return Modele.new(pointsCellule, trianglesCellule)
  end



  def self.player(ennemi=false)
    if ennemi
      body_color = 0xffccae62
      head_color = 0xffbadc58
    else
      body_color = 0xff2ecc71
      head_color = 0xffffeaa7
    end

    p1 = Point.new(-1, 0, -1)
    p2 = Point.new(-1, -4, -1)
    p3 = Point.new(1, 0, -1)
    p4 = Point.new(1, -4, -1)
    p5 = Point.new(-1, -4, 1)
    p6 = Point.new(-1, 0, 1)
    p7 = Point.new(1, 0, 1)
    p8 = Point.new(1, -4, 1)

    p9 = Point.new(-2, -5, -1)
    p10 = Point.new(-2, -6, -1)
    p11 = Point.new(-1, -7, -1)
    p12 = Point.new(2, -5, -1)
    p13 = Point.new(2, -6, -1)
    p14 = Point.new(1, -7, -1)

    p15 = Point.new(-2, -5, 1)
    p16 = Point.new(-2, -6, 1)
    p17 = Point.new(-1, -7, 1)
    p18 = Point.new(2, -5, 1)
    p19 = Point.new(2, -6, 1)
    p20 = Point.new(1, -7, 1)

    pointsPlayer = [p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, p12, p13, p14, p15, p16, p17, p18, p19, p20]

    trianglesPlayer = [
      # devant corps
      Triangle.new(p1, p2, p3, body_color),
      Triangle.new(p3, p2, p4, body_color),
      #---

      # deriere corps
      Triangle.new(p5, p6, p7, body_color),
      Triangle.new(p8, p5, p7, body_color),
      #---

      # haut corps
      Triangle.new(p6, p1, p7, body_color),
      Triangle.new(p1, p3, p7, body_color),
      #---

      # droite corps
      Triangle.new(p4, p8, p7, body_color),
      Triangle.new(p3, p4, p7, body_color),
      #---

      # gauche corps
      Triangle.new(p5, p2, p6, body_color),
      Triangle.new(p2, p1, p6, body_color),
      #---

      # arrière tete
      Triangle.new(p8, p18, p19, head_color),
      Triangle.new(p8, p19, p20, head_color),
      Triangle.new(p8, p20, p17, head_color),
      Triangle.new(p8, p17, p16, head_color),
      Triangle.new(p8, p16, p15, head_color),
      Triangle.new(p8, p15, p5, head_color),
      #---

      # avant tete
      Triangle.new(p4, p13, p12, head_color),
      Triangle.new(p4, p14, p13, head_color),
      Triangle.new(p4, p11, p14, head_color),
      Triangle.new(p4, p10, p11, head_color),
      Triangle.new(p4, p9, p10, head_color),
      Triangle.new(p4, p2, p9, head_color),
      #---

      # face 1 tete
      Triangle.new(p11, p20, p14, head_color),
      Triangle.new(p20, p11, p17, head_color),
      #--

      # face 2 tete
      Triangle.new(p14, p20, p19, head_color),
      Triangle.new(p14, p19, p13, head_color),
      #--

      # face 3 tete
      Triangle.new(p13, p19, p12, head_color),
      Triangle.new(p19, p18, p12, head_color),
      #--

      # face 4 tete
      Triangle.new(p18, p8, p12, head_color),
      Triangle.new(p12, p8, p4, head_color),
      #--

      # face 5 tete
      Triangle.new(p16, p17, p10, head_color),
      Triangle.new(p10, p17, p11, head_color),
      #--

      # face 6 tete
      Triangle.new(p16, p9, p15, head_color),
      Triangle.new(p9, p16, p10, head_color),
      #--

      # face 7 tete
      Triangle.new(p15, p2, p5, head_color),
      Triangle.new(p2, p15, p9, head_color)
      #--
    ]

    return Modele.new(pointsPlayer, trianglesPlayer)
  end
end
