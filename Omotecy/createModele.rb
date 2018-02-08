class CreateModele
  def self.sim theme = 0

    couleur1 = 0
    couleur2 = 0

    if theme == 1
      couleur1 = 0xff218c74
      couleur2 = 0xff33d9b2
    else if == theme 2
      couleur1 = 0xFF696969
      couleur2 = 0xFF595959
    end

    s1 = Point.new(-1, 0, -1)
    s2 = Point.new(-1, 0, 1)
    s3 = Point.new(0, -2, 0)
    s4 = Point.new(1, 0, 1)
    s5 = Point.new(1, 0, -1)
    s6 = Point.new(0, 2, 0)

    pointsSim = [s1, s2, s3, s4, s5, s6]

    trianglesSim = [
      ### pyramide bas
      Triangle.new(s1, s2, s3, couleur1 == 0 ? 0xff2ecc71 : couleur1),
      Triangle.new(s2, s4, s3, couleur2 == 0 ? 0xfff39c12 : couleur2),
      Triangle.new(s4, s5, s3, couleur1 == 0 ? 0xff2980b9 : couleur1),
      Triangle.new(s5, s1, s3, couleur2 == 0 ? 0xffe74c3c : couleur2),

      ### pyramide haut
      Triangle.new(s2, s1, s6, couleur2 == 0 ? 0xff8e44ad : couleur2),
      Triangle.new(s4, s2, s6, couleur1 == 0 ? 0xffecf0f1 : couleur1),
      Triangle.new(s5, s4, s6, couleur2 == 0 ? 0xffF03434 : couleur2),
      Triangle.new(s1, s5, s6, couleur1 == 0 ? 0xff95A5A6 : couleur1)
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
    s2 = Point.new(0, 0, 2)
    s3 = Point.new(2, 0, 0)
    s4 = Point.new(2, 0, 2)

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

  def self.cellule m = "0000", theme = 0
    couleurSol = 0xff808e9b
    couleur1 = 0xff7158e2
    couleur2 = 0xffff9f1a

    if theme == 1
      couleur1 = 0xff34ace0
      couleur2 = 0xffe55039
    elsif theme == 2
      couleur1 = 0xff009432
      couleur2 = 0xffffb142
    elsif theme == 3
      couleur1 = 0xff474787
      couleur2 = 0xffcd6133
    end

    size = 10

    c1 = Point.new(-size, 0, size)
    c2 = Point.new(size, 0, size)
    c3 = Point.new(size, 0, -size)
    c4 = Point.new(-size, 0, -size)

    pointsCellule = [c1, c2, c3, c4]

    trianglesCellule = [
      TriangleSpe.new(c1, c2, c3, couleurSol),
      TriangleSpe.new(c1, c3, c4, couleurSol)
    ]

    #NORD
    if m[3] == "0"
      cm1 = Point.new(size, -size, -size)
      cm2 = Point.new(-size, -size, -size)

      pointsCellule.push(cm1)
      pointsCellule.push(cm2)

      trianglesCellule.push(Triangle.new(cm1, c4, c3, couleur1))
      trianglesCellule.push(Triangle.new(cm2, c4, cm1, couleur1))
    end

    #SUD
    if m[2] == "0"
      cm1 = Point.new(-size, -size, size)
      cm2 = Point.new(size, -size, size)

      pointsCellule.push(cm1)
      pointsCellule.push(cm2)

      trianglesCellule.push(Triangle.new(cm1, c2, c1, couleur1))
      trianglesCellule.push(Triangle.new(cm2, c2, cm1, couleur1))
    end

    #EST
    if m[1] == "0"
      cm1 = Point.new(size, -size, size)
      cm2 = Point.new(size, -size, -size)

      pointsCellule.push(cm1)
      pointsCellule.push(cm2)

      trianglesCellule.push(Triangle.new(cm1, c3, c2, couleur2))
      trianglesCellule.push(Triangle.new(cm2, c3, cm1, couleur2))
    end

    #OUEST
    if m[0] == "0"
      cm1 = Point.new(-size, -size, -size)
      cm2 = Point.new(-size, -size, size)

      pointsCellule.push(cm1)
      pointsCellule.push(cm2)

      trianglesCellule.push(Triangle.new(cm1, c1, c4, couleur2))
      trianglesCellule.push(Triangle.new(cm2, c1, cm1, couleur2))
    end

    return Modele.new(pointsCellule, trianglesCellule)
  end

  def self.batte
    size = 2

    b1 = Point.new(-0.2 * size, -3 * size, -0.2 * size)
    b2 = Point.new(-0.2 * size, -3 * size, 0.2 * size)
    b3 = Point.new(0, -3.2 * size, 0)
    b4 = Point.new(0.2 * size, -3 * size, 0.2 * size)
    b5 = Point.new(0.2 * size, -3 * size, -0.2 * size)
    b6 = Point.new(0, 0, 0)

    pointBatte = [b1, b2, b3, b4, b5, b6]

    triangleBatte = [
      Triangle.new(b1, b2, b3, 0xffcc8e35),
      Triangle.new(b2, b4, b3, 0xffffb142),
      Triangle.new(b4, b5, b3, 0xffd35400),
      Triangle.new(b5, b1, b3, 0xffe67e22),

      ### pyramide haut
      Triangle.new(b2, b1, b6, 0xffcc8e35),
      Triangle.new(b4, b2, b6, 0xffffb142),
      Triangle.new(b5, b4, b6, 0xffd35400),
      Triangle.new(b1, b5, b6, 0xffe67e22)
    ]

    return Modele.new(pointBatte, triangleBatte)
  end

  def self.player(ennemi=false)
    if ennemi
      body_color = 0xffccae62
      head_color = 0xffbadc58
      head_color2 = 0xffA0BC4B
    else
      body_color = 0xff2ecc71
      head_color = 0xffffeaa7
      head_color2 = 0xffe0c47d
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
      Triangle.new(p11, p20, p14, head_color2),
      Triangle.new(p20, p11, p17, head_color2),
      #--

      # face 2 tete
      Triangle.new(p14, p20, p19, head_color2),
      Triangle.new(p14, p19, p13, head_color2),
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
      Triangle.new(p16, p17, p10, head_color2),
      Triangle.new(p10, p17, p11, head_color2),
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

  def self.batte
    size = 2

    b1 = Point.new(-0.2 * size, -3 * size, -0.2 * size)
    b2 = Point.new(-0.2 * size, -3 * size, 0.2 * size)
    b3 = Point.new(0, -3.2 * size, 0)
    b4 = Point.new(0.2 * size, -3 * size, 0.2 * size)
    b5 = Point.new(0.2 * size, -3 * size, -0.2 * size)
    b6 = Point.new(0, 0, 0)

    pointBatte = [b1, b2, b3, b4, b5, b6]

    triangleBatte = [
      Triangle.new(b1, b2, b3, 0xffcc8e35),
      Triangle.new(b2, b4, b3, 0xffffb142),
      Triangle.new(b4, b5, b3, 0xffd35400),
      Triangle.new(b5, b1, b3, 0xffe67e22),

      ### pyramide haut
      Triangle.new(b2, b1, b6, 0xffcc8e35),
      Triangle.new(b4, b2, b6, 0xffffb142),
      Triangle.new(b5, b4, b6, 0xffd35400),
      Triangle.new(b1, b5, b6, 0xffe67e22)
    ]

    return Modele.new(pointBatte, triangleBatte)
  end

  def self.pistolet
    size = 3

    p1 = Point.new(-0.1 * size, 0, 0)
    p2 = Point.new(-0.1 * size, 0, 1 * size)
    p3 = Point.new(-0.1 * size, -0.2 * size, 1 * size)
    p4 = Point.new(-0.1 * size, -0.2 * size, -0.1 * size)
    p5 = Point.new(-0.1 * size, 0.3 * size, -0.35 * size)
    p6 = Point.new(-0.1 * size, 0.4 * size, -0.3 * size)

    p7 = Point.new(0.1 * size, 0, 0)
    p8 = Point.new(0.1 * size, 0, 1 * size)
    p9 = Point.new(0.1 * size, -0.2 * size, 1 * size)
    p10 = Point.new(0.1 * size, -0.2 * size, -0.1 * size)
    p11 = Point.new(0.1 * size, 0.3 * size, -0.35 * size)
    p12 = Point.new(0.1 * size, 0.4 * size, -0.3 * size)

    pointsPistolet = [p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, p12]

    trianglesPistolet = [
      Triangle.new(p7, p9, p8, 0xffdcdde1),
      Triangle.new(p9, p7, p10, 0xffdcdde1),
      Triangle.new(p10, p7, p11, 0xffdcdde1),
      Triangle.new(p11, p7, p12, 0xffdcdde1),

      Triangle.new(p1, p2, p3, 0xffdcdde1),
      Triangle.new(p3, p4, p1, 0xffdcdde1),
      Triangle.new(p4, p5, p1, 0xffdcdde1),
      Triangle.new(p5, p6, p1, 0xffdcdde1),


      Triangle.new(p1, p8, p2, 0xff808e9b),
      Triangle.new(p1, p7, p8, 0xff808e9b),

      Triangle.new(p2, p8, p3, 0xff2f3640),
      Triangle.new(p3, p8, p9, 0xff2f3640),

      Triangle.new(p3, p9, p4, 0xffd2dae2),
      Triangle.new(p4, p9, p10, 0xffd2dae2),

      Triangle.new(p4, p10, p5, 0xffd2dae2),
      Triangle.new(p10, p11, p5, 0xffd2dae2),

      Triangle.new(p5, p11, p6, 0xff808e9b),
      Triangle.new(p11, p12, p6, 0xff808e9b),

      Triangle.new(p6, p7, p1, 0xff808e9b),
      Triangle.new(p6, p12, p7, 0xff808e9b)
    ]

    return Modele.new(pointsPistolet, trianglesPistolet)
  end

  def self.ruby
    r1 = Point.new(0.5, -3, 1.5)
    r2 = Point.new(1.5, -3, 0.5)
    r3 = Point.new(1.5, -3, -0.5)
    r4 = Point.new(0.5, -3, -1.5)
    r5 = Point.new(-0.5, -3, -1.5)
    r6 = Point.new(-1.5, -3, -0.5)
    r7 = Point.new(-1.5, -3, 0.5)
    r8 = Point.new(-0.5, -3, 1.5)

    r9 = Point.new(0, 0, 0)
    r10 = Point.new(0, -4, 0)

    pointsRuby = [r1, r2, r3, r4, r5, r6, r7, r8, r9, r10]

    trianglesRuby = [
      Triangle.new(r2, r1, r9, 0xffe74c3c),
      Triangle.new(r3, r2, r9, 0xffc0392b),
      Triangle.new(r4, r3, r9, 0xffe74c3c),
      Triangle.new(r5, r4, r9, 0xffc0392b),
      Triangle.new(r6, r5, r9, 0xffe74c3c),
      Triangle.new(r7, r6, r9, 0xffc0392b),
      Triangle.new(r8, r7, r9, 0xffe74c3c),
      Triangle.new(r1, r8, r9, 0xffc0392b),


      Triangle.new(r1, r2, r10, 0xffc0392b),
      Triangle.new(r2, r3, r10, 0xffe74c3c),
      Triangle.new(r3, r4, r10, 0xffc0392b),
      Triangle.new(r4, r5, r10, 0xffe74c3c),
      Triangle.new(r5, r6, r10, 0xffc0392b),
      Triangle.new(r6, r7, r10, 0xffe74c3c),
      Triangle.new(r7, r8, r10, 0xffc0392b),
      Triangle.new(r8, r1, r10, 0xffe74c3c)
    ]

    return Modele.new(pointsRuby, trianglesRuby)
  end

  def self.pilule

  #Hauteur et Taille
  hauteur = -4.5
  size = 0.75

  #Couleurs
  rougeClair = 0xFFEA2027
  rougeFonce = 0xFFCE1A21
  cyanClair = 0xFF12CBC4
  cyanFonce = 0xFF11AAA5


  #Points Gros Octogone Rouge
  p1r = Point.new(-1*size,(0+hauteur)*size,-4*size)
  p2r = Point.new(-2*size,(1+hauteur)*size,-4*size)
  p3r = Point.new(-2*size,(3+hauteur)*size,-4*size)
  p4r = Point.new(-1*size,(4+hauteur)*size,-4*size)
  p5r = Point.new(1*size,(4+hauteur)*size,-4*size)
  p6r = Point.new(2*size,(3+hauteur)*size,-4*size)
  p7r = Point.new(2*size,(1+hauteur)*size,-4*size)
  p8r = Point.new(1*size,(0+hauteur)*size,-4*size)
  pmilieur = Point.new(0*size,(2+hauteur)*size,-4.75*size)

  #Points Gros Octogone Milieu
  p1m = Point.new(-1*size,(0+hauteur)*size,0*size)
  p2m = Point.new(-2*size,(1+hauteur)*size,0*size)
  p3m = Point.new(-2*size,(3+hauteur)*size,0*size)
  p4m = Point.new(-1*size,(4+hauteur)*size,0*size)
  p5m = Point.new(1*size,(4+hauteur)*size,0*size)
  p6m = Point.new(2*size,(3+hauteur)*size,0*size)
  p7m = Point.new(2*size,(1+hauteur)*size,0*size)
  p8m = Point.new(1*size,(0+hauteur)*size,0*size)
  pmilieum = Point.new(0*size,(2+hauteur)*size,0*size)

  #Points Gros Octogone Cyan
  p1c = Point.new(-1*size,(0+hauteur)*size,4*size)
  p2c = Point.new(-2*size,(1+hauteur)*size,4*size)
  p3c = Point.new(-2*size,(3+hauteur)*size,4*size)
  p4c = Point.new(-1*size,(4+hauteur)*size,4*size)
  p5c = Point.new(1*size,(4+hauteur)*size,4*size)
  p6c = Point.new(2*size,(3+hauteur)*size,4*size)
  p7c = Point.new(2*size,(1+hauteur)*size,4*size)
  p8c = Point.new(1*size,(0+hauteur)*size,4*size)
  pmilieuc = Point.new(0*size,(2+hauteur)*size,4.75*size)

  pointsPilule = [p1r, p2r, p3r, p4r, p5r, p6r, p7r, p8r, pmilieur,
                  p1m, p2m, p3m, p4m, p5m, p6m, p7m, p8m, pmilieum,
                  p1c, p2c, p3c, p4c, p5c, p6c, p7c, p8c, pmilieuc]

  trianglesPilule = [

  #Triangles Gros Octogone Rouge
  Triangle.new(pmilieur,p2r,p1r,rougeClair),
  Triangle.new(pmilieur,p3r,p2r,rougeFonce),
  Triangle.new(pmilieur,p4r,p3r,rougeClair),
  Triangle.new(pmilieur,p5r,p4r,rougeFonce),
  Triangle.new(pmilieur,p6r,p5r,rougeClair),
  Triangle.new(pmilieur,p7r,p6r,rougeFonce),
  Triangle.new(pmilieur,p8r,p7r,rougeClair),
  Triangle.new(pmilieur,p1r,p8r,rougeFonce),

  #Triangles Gros Octogone Cyan
  Triangle.new(pmilieuc,p1c,p2c,cyanFonce),
  Triangle.new(pmilieuc,p2c,p3c,cyanClair),
  Triangle.new(pmilieuc,p3c,p4c,cyanFonce),
  Triangle.new(pmilieuc,p4c,p5c,cyanClair),
  Triangle.new(pmilieuc,p5c,p6c,cyanFonce),
  Triangle.new(pmilieuc,p6c,p7c,cyanClair),
  Triangle.new(pmilieuc,p7c,p8c,cyanFonce),
  Triangle.new(pmilieuc,p8c,p1c,cyanClair),

  #Triangles reliant Gros Octogone Rouge et Milieu
  #Face 1
  Triangle.new(p1r,p2m,p1m,rougeFonce),
  Triangle.new(p1r,p2r,p2m,rougeFonce),
  #Face 2
  Triangle.new(p2r,p3m,p2m,rougeClair),
  Triangle.new(p2r,p3r,p3m,rougeClair),
  #Face 3
  Triangle.new(p3r,p4m,p3m,rougeFonce),
  Triangle.new(p3r,p4r,p4m,rougeFonce),
  #Face 4
  Triangle.new(p4r,p5m,p4m,rougeClair),
  Triangle.new(p4r,p5r,p5m,rougeClair),
  #Face 5
  Triangle.new(p5r,p6m,p5m,rougeFonce),
  Triangle.new(p5r,p6r,p6m,rougeFonce),
  #Face 6
  Triangle.new(p6r,p7m,p6m,rougeClair),
  Triangle.new(p6r,p7r,p7m,rougeClair),
  #Face 7
  Triangle.new(p7r,p8m,p7m,rougeFonce),
  Triangle.new(p7r,p8r,p8m,rougeFonce),
  #Face 8
  Triangle.new(p8r,p1m,p8m,rougeClair),
  Triangle.new(p8r,p1r,p1m,rougeClair),

  #Triangles reliant Gros Octogone Cyan et Milieu
  #Face 1
  Triangle.new(p1c,p1m,p2m,cyanClair),
  Triangle.new(p1c,p2m,p2c,cyanClair),
  #Face 2
  Triangle.new(p2c,p2m,p3m,cyanFonce),
  Triangle.new(p2c,p3m,p3c,cyanFonce),
  #Face 3
  Triangle.new(p3c,p3m,p4m,cyanClair),
  Triangle.new(p3c,p4m,p4c,cyanClair),
  #Face 4
  Triangle.new(p4c,p4m,p5m,cyanFonce),
  Triangle.new(p4c,p5m,p5c,cyanFonce),
  #Face 5
  Triangle.new(p5c,p5m,p6m,cyanClair),
  Triangle.new(p5c,p6m,p6c,cyanClair),
  #Face 6
  Triangle.new(p6c,p6m,p7m,cyanFonce),
  Triangle.new(p6c,p7m,p7c,cyanFonce),
  #Face 7
  Triangle.new(p7c,p7m,p8m,cyanClair),
  Triangle.new(p7c,p8m,p8c,cyanClair),
  #Face 8
  Triangle.new(p8c,p8m,p1m,cyanFonce),
  Triangle.new(p8c,p1m,p1c,cyanFonce)
  ]

  return Modele.new(pointsPilule, trianglesPilule)
end

def self.croix

  #Hauteur et Taille
  #hauteur = 2
  hauteur = -7
  size = 1

  #Couleurs
  vertClair = 0xFF00AD3A
  vertFonce = 0xFF01842D
  vertFonce2 = 0xFF009432

  #Points Croix Avant
  p1a = Point.new(0*size,(0+hauteur)*size,0*size)
  p2a = Point.new(0*size,(2+hauteur)*size,0*size)
  p3a = Point.new(-2*size,(2+hauteur)*size,0*size)
  p4a = Point.new(-2*size,(3+hauteur)*size,0*size)
  p5a = Point.new(0*size,(3+hauteur)*size,0*size)
  p6a = Point.new(0*size,(5+hauteur)*size,0*size)
  p7a = Point.new(1*size,(5+hauteur)*size,0*size)
  p8a = Point.new(1*size,(3+hauteur)*size,0*size)
  p9a = Point.new(3*size,(3+hauteur)*size,0*size)
  p10a = Point.new(3*size,(2+hauteur)*size,0*size)
  p11a = Point.new(1*size,(2+hauteur)*size,0*size)
  p12a = Point.new(1*size,(0+hauteur)*size,0*size)

  #Points Croix Arrière
  p1r = Point.new(0*size,(0+hauteur)*size,1*size)
  p2r = Point.new(0*size,(2+hauteur)*size,1*size)
  p3r = Point.new(-2*size,(2+hauteur)*size,1*size)
  p4r = Point.new(-2*size,(3+hauteur)*size,1*size)
  p5r = Point.new(0*size,(3+hauteur)*size,1*size)
  p6r = Point.new(0*size,(5+hauteur)*size,1*size)
  p7r = Point.new(1*size,(5+hauteur)*size,1*size)
  p8r = Point.new(1*size,(3+hauteur)*size,1*size)
  p9r = Point.new(3*size,(3+hauteur)*size,1*size)
  p10r = Point.new(3*size,(2+hauteur)*size,1*size)
  p11r = Point.new(1*size,(2+hauteur)*size,1*size)
  p12r = Point.new(1*size,(0+hauteur)*size,1*size)

  pointsCroix = [p1a, p2a, p3a, p4a, p5a, p6a, p7a, p8a, p9a, p10a, p11a, p12a,
                 p1r, p2r, p3r, p4r, p5r, p6r, p7r, p8r, p9r, p10r, p11r, p12r]

  trianglesCroix = [

    #Triangles Cotés Croix Avant
    Triangle.new(p1a,p11a,p2a,vertClair),
    Triangle.new(p1a,p12a,p11a,vertClair),

    Triangle.new(p3a,p5a,p4a,vertClair),
    Triangle.new(p3a,p2a,p5a,vertClair),

    Triangle.new(p5a,p7a,p6a,vertClair),
    Triangle.new(p5a,p8a,p7a,vertClair),

    Triangle.new(p11a,p9a,p8a,vertClair),
    Triangle.new(p11a,p10a,p9a,vertClair),

    #Triangles Milieu Croix Avant
    Triangle.new(p2a,p8a,p5a,vertClair),
    Triangle.new(p2a,p11a,p8a,vertClair),

    #Triangles Cotés Croix Arrière
    Triangle.new(p1r,p2r,p11r,vertClair),
    Triangle.new(p1r,p11r,p12r,vertClair),

    Triangle.new(p3r,p4r,p5r,vertClair),
    Triangle.new(p3r,p5r,p2r,vertClair),

    Triangle.new(p5r,p6r,p7r,vertClair),
    Triangle.new(p5r,p7r,p8r,vertClair),

    Triangle.new(p11r,p8r,p9r,vertClair),
    Triangle.new(p11r,p9r,p10r,vertClair),

    #Triangles Milieu Croix Arrière
    Triangle.new(p2r,p5r,p8r,vertClair),
    Triangle.new(p2r,p8r,p11r,vertClair),

    #Triangles reliant les Deux Croix
    #Face 1
    Triangle.new(p1a,p2r,p1r,vertFonce),
    Triangle.new(p1a,p2a,p2r,vertFonce),
    #Face 2
    Triangle.new(p2a,p3r,p2r,vertFonce2),
    Triangle.new(p2a,p3a,p3r,vertFonce2),
    #Face 3
    Triangle.new(p3a,p4r,p3r,vertFonce),
    Triangle.new(p3a,p4a,p4r,vertFonce),
    #Face 4
    Triangle.new(p4a,p5r,p4r,vertFonce2),
    Triangle.new(p4a,p5a,p5r,vertFonce2),
    #Face 5
    Triangle.new(p5a,p6r,p5r,vertFonce),
    Triangle.new(p5a,p6a,p6r,vertFonce),
    #Face 6
    Triangle.new(p6a,p7r,p6r,vertFonce2),
    Triangle.new(p6a,p7a,p7r,vertFonce2),
    #Face 7
    Triangle.new(p7a,p8r,p7r,vertFonce),
    Triangle.new(p7a,p8a,p8r,vertFonce),
    #Face 8
    Triangle.new(p8a,p9r,p8r,vertFonce2),
    Triangle.new(p8a,p9a,p9r,vertFonce2),
    #Face 9
    Triangle.new(p9a,p10r,p9r,vertFonce),
    Triangle.new(p9a,p10a,p10r,vertFonce),
    #Face 10
    Triangle.new(p10a,p11r,p10r,vertFonce2),
    Triangle.new(p10a,p11a,p11r,vertFonce2),
    #Face 11
    Triangle.new(p11a,p12r,p11r,vertFonce),
    Triangle.new(p11a,p12a,p12r,vertFonce),
    #Face 12
    Triangle.new(p12a,p1r,p12r,vertFonce2),
    Triangle.new(p12a,p1a,p1r,vertFonce2),

    ]

  return Modele.new(pointsCroix, trianglesCroix)
end

def self.projectile size = 0.3, colorClair = 0xFFEE5A24, colorFonce = 0xFFCE4D1E

  #Hauteur et Taille
  hauteur = 2
  #size = 0.3

  #Couleurs
  orangeClair = colorClair
  orangeFonce = colorFonce

  #Pointe Projectile
  ppointe = Point.new(0*size,(0+hauteur)*size,7*size)

  #Points Octogone Avant
  p1a = Point.new(-1*size,(-2+hauteur)*size,3*size)
  p2a = Point.new(-2*size,(-1+hauteur)*size,3*size)
  p3a = Point.new(-2*size,(1+hauteur)*size,3*size)
  p4a = Point.new(-1*size,(2+hauteur)*size,3*size)
  p5a = Point.new(1*size,(2+hauteur)*size,3*size)
  p6a = Point.new(2*size,(1+hauteur)*size,3*size)
  p7a = Point.new(2*size,(-1+hauteur)*size,3*size)
  p8a = Point.new(1*size,(-2+hauteur)*size,3*size)
  pmilieua = Point.new(0*size,(0+hauteur)*size,3*size)

  #Points Octogone Arrière
  p1r = Point.new(-1*size,(-2+hauteur)*size,-2*size)
  p2r = Point.new(-2*size,(-1+hauteur)*size,-2*size)
  p3r = Point.new(-2*size,(1+hauteur)*size,-2*size)
  p4r = Point.new(-1*size,(2+hauteur)*size,-2*size)
  p5r = Point.new(1*size,(2+hauteur)*size,-2*size)
  p6r = Point.new(2*size,(1+hauteur)*size,-2*size)
  p7r = Point.new(2*size,(-1+hauteur)*size,-2*size)
  p8r = Point.new(1*size,(-2+hauteur)*size,-2*size)
  pmilieur = Point.new(0*size,(0+hauteur)*size,-2*size)


  pointsProj = [p1r, p2r, p3r, p4r, p5r, p6r, p7r, p8r, pmilieur,
                p1a, p2a, p3a, p4a, p5a, p6a, p7a, p8a, pmilieua, ppointe]

  trianglesProj = [

  #Triangles Octogone Arrière
  Triangle.new(pmilieur,p2r,p1r,orangeClair),
  Triangle.new(pmilieur,p3r,p2r,orangeFonce),
  Triangle.new(pmilieur,p4r,p3r,orangeClair),
  Triangle.new(pmilieur,p5r,p4r,orangeFonce),
  Triangle.new(pmilieur,p6r,p5r,orangeClair),
  Triangle.new(pmilieur,p7r,p6r,orangeFonce),
  Triangle.new(pmilieur,p8r,p7r,orangeClair),
  Triangle.new(pmilieur,p1r,p8r,orangeFonce),

  #Triangles Octogone Avant
  Triangle.new(pmilieua,p1a,p2a,orangeFonce),
  Triangle.new(pmilieua,p2a,p3a,orangeClair),
  Triangle.new(pmilieua,p3a,p4a,orangeFonce),
  Triangle.new(pmilieua,p4a,p5a,orangeClair),
  Triangle.new(pmilieua,p5a,p6a,orangeFonce),
  Triangle.new(pmilieua,p6a,p7a,orangeClair),
  Triangle.new(pmilieua,p7a,p8a,orangeFonce),
  Triangle.new(pmilieua,p8a,p1a,orangeClair),

  #Triangles reliant Octogone Avant et Pointe
  Triangle.new(ppointe,p1a,p2a,orangeClair),
  Triangle.new(ppointe,p2a,p3a,orangeFonce),
  Triangle.new(ppointe,p3a,p4a,orangeClair),
  Triangle.new(ppointe,p4a,p5a,orangeFonce),
  Triangle.new(ppointe,p5a,p6a,orangeClair),
  Triangle.new(ppointe,p6a,p7a,orangeFonce),
  Triangle.new(ppointe,p7a,p8a,orangeClair),
  Triangle.new(ppointe,p8a,p1a,orangeFonce),

  #Triangles reliant Octogones Avant et Arrière
  #Face 1
  Triangle.new(p1r,p2a,p1a,orangeFonce),
  Triangle.new(p1r,p2r,p2a,orangeFonce),
  #Face 2
  Triangle.new(p2r,p3a,p2a,orangeClair),
  Triangle.new(p2r,p3r,p3a,orangeClair),
  #Face 3
  Triangle.new(p3r,p4a,p3a,orangeFonce),
  Triangle.new(p3r,p4r,p4a,orangeFonce),
  #Face 4
  Triangle.new(p4r,p5a,p4a,orangeClair),
  Triangle.new(p4r,p5r,p5a,orangeClair),
  #Face 5
  Triangle.new(p5r,p6a,p5a,orangeFonce),
  Triangle.new(p5r,p6r,p6a,orangeFonce),
  #Face 6
  Triangle.new(p6r,p7a,p6a,orangeClair),
  Triangle.new(p6r,p7r,p7a,orangeClair),
  #Face 7
  Triangle.new(p7r,p8a,p7a,orangeFonce),
  Triangle.new(p7r,p8r,p8a,orangeFonce),
  #Face 8
  Triangle.new(p8r,p1a,p8a,orangeClair),
  Triangle.new(p8r,p1r,p1a,orangeClair),

  ]

  return Modele.new(pointsProj, trianglesProj)
end

def self.hache

#Taille
size = 0.25
sizeMancheBois = 25
sizeMancheAcier = 2
sizeMancheBout = 1

#Couleurs
colorBoisFonce = 0xFF955628
colorBoisClair = 0xFFCD853F
colorAcier = 0xFFAFAFAF

#Points Manche Hache
#Octogones classés de Bas en Haut avec Lettres

#Points Octogone A
octa1 = Point.new(0*size,0*size,0*size)
octa2 = Point.new(-1*size,0*size,1*size)
octa3 = Point.new(-1*size,0*size,3*size)
octa4 = Point.new(0*size,0*size,4*size)
octa5 = Point.new(2*size,0*size,4*size)
octa6 = Point.new(3*size,0*size,3*size)
octa7 = Point.new(3*size,0*size,1*size)
octa8 = Point.new(2*size,0*size,0*size)
octam = Point.new(1*size,0*size,2*size)

#Points Octogone B
octb1 = Point.new(0*size,-sizeMancheBois*size,0*size)
octb2 = Point.new(-1*size,-sizeMancheBois*size,1*size)
octb3 = Point.new(-1*size,-sizeMancheBois*size,3*size)
octb4 = Point.new(0*size,-sizeMancheBois*size,4*size)
octb5 = Point.new(2*size,-sizeMancheBois*size,4*size)
octb6 = Point.new(3*size,-sizeMancheBois*size,3*size)
octb7 = Point.new(3*size,-sizeMancheBois*size,1*size)
octb8 = Point.new(2*size,-sizeMancheBois*size,0*size)
octbm = Point.new(1*size,-sizeMancheBois*size,2*size)

#Points Octogone C
octc1 = Point.new(0*size,(-sizeMancheBois-sizeMancheAcier)*size,0*size)
octc2 = Point.new(-1*size,(-sizeMancheBois-sizeMancheAcier)*size,1*size)
octc3 = Point.new(-1*size,(-sizeMancheBois-sizeMancheAcier)*size,3*size)
octc4 = Point.new(0*size,(-sizeMancheBois-sizeMancheAcier)*size,4*size)
octc5 = Point.new(2*size,(-sizeMancheBois-sizeMancheAcier)*size,4*size)
octc6 = Point.new(3*size,(-sizeMancheBois-sizeMancheAcier)*size,3*size)
octc7 = Point.new(3*size,(-sizeMancheBois-sizeMancheAcier)*size,1*size)
octc8 = Point.new(2*size,(-sizeMancheBois-sizeMancheAcier)*size,0*size)
octcm = Point.new(1*size,(-sizeMancheBois-sizeMancheAcier)*size,2*size)

#Points Octogone D
octd1 = Point.new(0*size,(-sizeMancheBois-sizeMancheAcier-sizeMancheBout)*size,0*size)
octd2 = Point.new(-1*size,(-sizeMancheBois-sizeMancheAcier-sizeMancheBout)*size,1*size)
octd3 = Point.new(-1*size,(-sizeMancheBois-sizeMancheAcier-sizeMancheBout)*size,3*size)
octd4 = Point.new(0*size,(-sizeMancheBois-sizeMancheAcier-sizeMancheBout)*size,4*size)
octd5 = Point.new(2*size,(-sizeMancheBois-sizeMancheAcier-sizeMancheBout)*size,4*size)
octd6 = Point.new(3*size,(-sizeMancheBois-sizeMancheAcier-sizeMancheBout)*size,3*size)
octd7 = Point.new(3*size,(-sizeMancheBois-sizeMancheAcier-sizeMancheBout)*size,1*size)
octd8 = Point.new(2*size,(-sizeMancheBois-sizeMancheAcier-sizeMancheBout)*size,0*size)
octdm = Point.new(1*size,(-sizeMancheBois-sizeMancheAcier-sizeMancheBout)*size,2*size)

#Points Lame Hache
#Points Lame Bas - Niveau Octogone B
plamebas1 = Point.new(0*size,(-sizeMancheBois/2)*size,10*size)
plamebas2 = Point.new(2*size,(-sizeMancheBois/2)*size,10*size)

#Points Lame Haut - Niveau Octogone C
plamehaut1 = Point.new(0*size,(-sizeMancheBois-sizeMancheAcier)*size,12*size)
plamehaut2 = Point.new(2*size,(-sizeMancheBois-sizeMancheAcier)*size,12*size)

pointsHache = [octa1,octa2,octa3,octa4,octa5,octa6,octa7,octa8,octam,
               octb1,octb2,octb3,octb4,octb5,octb6,octb7,octb8,octbm,
               octc1,octc2,octc3,octc4,octc5,octc6,octc7,octc8,octcm,
               octd1,octd2,octd3,octd4,octd5,octd6,octd7,octd8,octdm,
               plamebas1,plamebas2,plamehaut1,plamehaut2]


trianglesHache = [

  #Manche
  #Triangles reliant Octogone A
  Triangle.new(octam,octa2,octa1,colorBoisClair),
  Triangle.new(octam,octa3,octa2,colorBoisClair),
  Triangle.new(octam,octa4,octa3,colorBoisClair),
  Triangle.new(octam,octa5,octa4,colorBoisClair),
  Triangle.new(octam,octa6,octa5,colorBoisClair),
  Triangle.new(octam,octa7,octa6,colorBoisClair),
  Triangle.new(octam,octa8,octa7,colorBoisClair),
  Triangle.new(octam,octa1,octa8,colorBoisClair),

  #Triangles reliant Octogone A et B
  Triangle.new(octa1,octb2,octb1,colorBoisFonce),
  Triangle.new(octa1,octa2,octb2,colorBoisFonce),

  Triangle.new(octa2,octb3,octb2,colorBoisFonce),
  Triangle.new(octa2,octa3,octb3,colorBoisFonce),

  Triangle.new(octa3,octb4,octb3,colorBoisFonce),
  Triangle.new(octa3,octa4,octb4,colorBoisFonce),

  Triangle.new(octa4,octb5,octb4,colorBoisFonce),
  Triangle.new(octa4,octa5,octb5,colorBoisFonce),

  Triangle.new(octa5,octb6,octb5,colorBoisFonce),
  Triangle.new(octa5,octa6,octb6,colorBoisFonce),

  Triangle.new(octa6,octb7,octb6,colorBoisFonce),
  Triangle.new(octa6,octa7,octb7,colorBoisFonce),

  Triangle.new(octa7,octb8,octb7,colorBoisFonce),
  Triangle.new(octa7,octa8,octb8,colorBoisFonce),

  Triangle.new(octa8,octb1,octb8,colorBoisFonce),
  Triangle.new(octa8,octa1,octb1,colorBoisFonce),

  #Triangles reliant Octogone B et C
  Triangle.new(octb1,octc2,octc1,colorAcier),
  Triangle.new(octb1,octb2,octc2,colorAcier),

  Triangle.new(octb2,octc3,octc2,colorAcier),
  Triangle.new(octb2,octb3,octc3,colorAcier),

  Triangle.new(octb3,octc4,octc3,colorAcier),
  Triangle.new(octb3,octb4,octc4,colorAcier),

  Triangle.new(octb4,octc5,octc4,colorAcier),
  Triangle.new(octb4,octb5,octc5,colorAcier),

  Triangle.new(octb5,octc6,octc5,colorAcier),
  Triangle.new(octb5,octb6,octc6,colorAcier),

  Triangle.new(octb6,octc7,octc6,colorAcier),
  Triangle.new(octb6,octb7,octc7,colorAcier),

  Triangle.new(octb7,octc8,octc7,colorAcier),
  Triangle.new(octb7,octb8,octc8,colorAcier),

  Triangle.new(octb8,octc1,octc8,colorAcier),
  Triangle.new(octb8,octb1,octc1,colorAcier),

  #Triangles reliant Octogone C et D
  Triangle.new(octc1,octd2,octd1,colorBoisFonce),
  Triangle.new(octc1,octc2,octd2,colorBoisFonce),

  Triangle.new(octc2,octd3,octd2,colorBoisFonce),
  Triangle.new(octc2,octc3,octd3,colorBoisFonce),

  Triangle.new(octc3,octd4,octd3,colorBoisFonce),
  Triangle.new(octc3,octc4,octd4,colorBoisFonce),

  Triangle.new(octc4,octd5,octd4,colorBoisFonce),
  Triangle.new(octc4,octc5,octd5,colorBoisFonce),

  Triangle.new(octc5,octd6,octd5,colorBoisFonce),
  Triangle.new(octc5,octc6,octd6,colorBoisFonce),

  Triangle.new(octc6,octd7,octd6,colorBoisFonce),
  Triangle.new(octc6,octa7,octd7,colorBoisFonce),

  Triangle.new(octc7,octd8,octd7,colorBoisFonce),
  Triangle.new(octc7,octc8,octd8,colorBoisFonce),

  Triangle.new(octc8,octd1,octd8,colorBoisFonce),
  Triangle.new(octc8,octc1,octd1,colorBoisFonce),

  #Triangles reliant Octogone D
  Triangle.new(octdm,octd1,octd2,colorBoisClair),
  Triangle.new(octdm,octd2,octd3,colorBoisClair),
  Triangle.new(octdm,octd3,octd4,colorBoisClair),
  Triangle.new(octdm,octd4,octd5,colorBoisClair),
  Triangle.new(octdm,octd5,octd6,colorBoisClair),
  Triangle.new(octdm,octd6,octd7,colorBoisClair),
  Triangle.new(octdm,octd7,octd8,colorBoisClair),
  Triangle.new(octdm,octd8,octd1,colorBoisClair),


  #Lame Hache
  #Points Carrés Attache Lame Manche
  #Carré Bas - Niveau Octogone B
  Triangle.new(plamebas2,plamebas1,octb5,colorAcier),
  Triangle.new(plamebas1,octb4,octb5,colorAcier),


  #Carré Haut - Niveau Octogone C
  Triangle.new(plamehaut2,octc5,plamehaut1,colorAcier),
  Triangle.new(plamehaut1,octc5,octc4,colorAcier),

  #Bout Lame -pas bon pd
  Triangle.new(plamebas2,plamehaut2,plamehaut1,colorAcier),
  Triangle.new(plamehaut1,plamebas1,plamebas2,colorAcier),

  #Coté Lame 1- pas bon pd
  Triangle.new(plamehaut1,octc4,plamebas1,colorAcier),
  Triangle.new(octc4,octb4,plamebas1,colorAcier),

  #Coté Lame 2
  Triangle.new(octc5,plamebas2,octb5,colorAcier),
  Triangle.new(plamehaut2,plamebas2,octc5,colorAcier)
  ]

return Modele.new(pointsHache, trianglesHache)
end

def self.pointInterrogation
  c1 = Point.new(-1, 0, -1)
  c2 = Point.new(-1, -2, -1)
  c3 = Point.new(1, 0, -1)
  c4 = Point.new(1, -2, -1)
  c5 = Point.new(-1, -2, 1)
  c6 = Point.new(-1, 0, 1)
  c7 = Point.new(1, 0, 1)
  c8 = Point.new(1, -2, 1)

  c9 = Point.new(-1, -3, -1)
  c10 = Point.new(-1, -7, -1)
  c11 = Point.new(1, -3, -1)
  c12 = Point.new(1, -7, -1)
  c13 = Point.new(-1, -7, 1)
  c14 = Point.new(-1, -3, 1)
  c15 = Point.new(1, -3, 1)
  c16 = Point.new(1, -7, 1)

  pointsCube = [c1, c2, c3, c4, c5, c6, c7, c8, c9, c10, c11, c12, c13, c14, c15, c16]

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
    Triangle.new(c2, c1, c6, 0xffecf0f1),
    #---

#################################""

    # devant
    Triangle.new(c9, c10, c11, 0xff2ecc71),
    Triangle.new(c11, c10, c12, 0xff2ecc71),
    #---

    # deriere
    Triangle.new(c13, c14, c15, 0xfff39c12),
    Triangle.new(c16, c13, c15, 0xfff39c12),
    #---

    # haut
    Triangle.new(c14, c9, c15, 0xff2980b9),
    Triangle.new(c9, c11, c15, 0xff2980b9),
    #---

    # bas
    Triangle.new(c10, c13, c16, 0xffe74c3c),
    Triangle.new(c12, c10, c16, 0xffe74c3c),
    #---

    # droite
    Triangle.new(c12, c16, c15, 0xff8e44ad),
    Triangle.new(c11, c12, c15, 0xff8e44ad),
    #---

    # gauche
    Triangle.new(c13, c10, c14, 0xffecf0f1),
    Triangle.new(c10, c9, c14, 0xffecf0f1)
    #---
  ]

  return Modele.new(pointsCube, trianglesCube)
end

def self.bazooka size = 0.7

  #Hauteur et Longueur
  hauteur = 2
  longueur = 13
  tailleEmbout = 0.33
  longueurEmbout = 2

  #Couleurs
  noirClair = 0xFF253542
  noirFonce = 0xFF1E272E
  noirInt = 0xFF000000

  #Points Embout
  p1e = Point.new(-1*size-tailleEmbout,(-2-hauteur)*size-tailleEmbout,longueur/2*size+longueurEmbout)
  p2e = Point.new(-2*size-tailleEmbout,(-1-hauteur)*size-tailleEmbout,longueur/2*size+longueurEmbout)
  p3e = Point.new(-2*size-tailleEmbout,(1-hauteur)*size+tailleEmbout,longueur/2*size+longueurEmbout)
  p4e = Point.new(-1*size-tailleEmbout,(2-hauteur)*size+tailleEmbout,longueur/2*size+longueurEmbout)
  p5e = Point.new(1*size+tailleEmbout,(2-hauteur)*size+tailleEmbout,longueur/2*size+longueurEmbout)
  p6e = Point.new(2*size+tailleEmbout,(1-hauteur)*size+tailleEmbout,longueur/2*size+longueurEmbout)
  p7e = Point.new(2*size+tailleEmbout,(-1-hauteur)*size-tailleEmbout,longueur/2*size+longueurEmbout)
  p8e = Point.new(1*size+tailleEmbout,(-2-hauteur)*size-tailleEmbout,longueur/2*size+longueurEmbout)
  pmilieue = Point.new(0*size+tailleEmbout,(0-hauteur)*size-tailleEmbout,longueur/2*size+longueurEmbout)

  #Points Octogone Avant
  p1a = Point.new(-1*size,(-2-hauteur)*size,longueur/2*size)
  p2a = Point.new(-2*size,(-1-hauteur)*size,longueur/2*size)
  p3a = Point.new(-2*size,(1-hauteur)*size,longueur/2*size)
  p4a = Point.new(-1*size,(2-hauteur)*size,longueur/2*size)
  p5a = Point.new(1*size,(2-hauteur)*size,longueur/2*size)
  p6a = Point.new(2*size,(1-hauteur)*size,longueur/2*size)
  p7a = Point.new(2*size,(-1-hauteur)*size,longueur/2*size)
  p8a = Point.new(1*size,(-2-hauteur)*size,longueur/2*size)

  #Points Octogone Arrière
  p1r = Point.new(-1*size,(-2-hauteur)*size,-longueur/2*size)
  p2r = Point.new(-2*size,(-1-hauteur)*size,-longueur/2*size)
  p3r = Point.new(-2*size,(1-hauteur)*size,-longueur/2*size)
  p4r = Point.new(-1*size,(2-hauteur)*size,-longueur/2*size)
  p5r = Point.new(1*size,(2-hauteur)*size,-longueur/2*size)
  p6r = Point.new(2*size,(1-hauteur)*size,-longueur/2*size)
  p7r = Point.new(2*size,(-1-hauteur)*size,-longueur/2*size)
  p8r = Point.new(1*size,(-2-hauteur)*size,-longueur/2*size)
  pmilieur = Point.new(0*size,(0-hauteur)*size,-longueur/2*size)


  pointsBazooka = [p1r, p2r, p3r, p4r, p5r, p6r, p7r, p8r, pmilieur,
                   p1a, p2a, p3a, p4a, p5a, p6a, p7a, p8a,
                   p1e, p2e, p3e, p4e, p5e, p6e, p7e, p8e, pmilieue,]

  trianglesBazooka = [

  #Triangles Octogone Arrière
  Triangle.new(pmilieur,p2r,p1r,noirClair),
  Triangle.new(pmilieur,p3r,p2r,noirFonce),
  Triangle.new(pmilieur,p4r,p3r,noirClair),
  Triangle.new(pmilieur,p5r,p4r,noirFonce),
  Triangle.new(pmilieur,p6r,p5r,noirClair),
  Triangle.new(pmilieur,p7r,p6r,noirFonce),
  Triangle.new(pmilieur,p8r,p7r,noirClair),
  Triangle.new(pmilieur,p1r,p8r,noirFonce),

  #Triangles Embout
  Triangle.new(pmilieue,p1e,p2e,noirInt),
  Triangle.new(pmilieue,p2e,p3e,noirInt),
  Triangle.new(pmilieue,p3e,p4e,noirInt),
  Triangle.new(pmilieue,p4e,p5e,noirInt),
  Triangle.new(pmilieue,p5e,p6e,noirInt),
  Triangle.new(pmilieue,p6e,p7e,noirInt),
  Triangle.new(pmilieue,p7e,p8e,noirInt),
  Triangle.new(pmilieue,p8e,p1e,noirInt),

  #Triangles reliant Octogones Avant et Arrière
  #Face 1
  Triangle.new(p1r,p2a,p1a,noirFonce),
  Triangle.new(p1r,p2r,p2a,noirFonce),
  #Face 2
  Triangle.new(p2r,p3a,p2a,noirClair),
  Triangle.new(p2r,p3r,p3a,noirClair),
  #Face 3
  Triangle.new(p3r,p4a,p3a,noirFonce),
  Triangle.new(p3r,p4r,p4a,noirFonce),
  #Face 4
  Triangle.new(p4r,p5a,p4a,noirClair),
  Triangle.new(p4r,p5r,p5a,noirClair),
  #Face 5
  Triangle.new(p5r,p6a,p5a,noirFonce),
  Triangle.new(p5r,p6r,p6a,noirFonce),
  #Face 6
  Triangle.new(p6r,p7a,p6a,noirClair),
  Triangle.new(p6r,p7r,p7a,noirClair),
  #Face 7
  Triangle.new(p7r,p8a,p7a,noirFonce),
  Triangle.new(p7r,p8r,p8a,noirFonce),
  #Face 8
  Triangle.new(p8r,p1a,p8a,noirClair),
  Triangle.new(p8r,p1r,p1a,noirClair),

  #Triangles reliant Octogones Avant et Embout
  #Face 1
  Triangle.new(p1a,p2e,p1e,noirClair),
  Triangle.new(p1a,p2a,p2e,noirClair),
  #Face 2
  Triangle.new(p2a,p3e,p2e,noirFonce),
  Triangle.new(p2a,p3a,p3e,noirFonce),
  #Face 3
  Triangle.new(p3a,p4e,p3e,noirClair),
  Triangle.new(p3a,p4a,p4e,noirClair),
  #Face 4
  Triangle.new(p4a,p5e,p4e,noirFonce),
  Triangle.new(p4a,p5a,p5e,noirFonce),
  #Face 5
  Triangle.new(p5a,p6e,p5e,noirClair),
  Triangle.new(p5a,p6a,p6e,noirClair),
  #Face 6
  Triangle.new(p6a,p7e,p6e,noirFonce),
  Triangle.new(p6a,p7a,p7e,noirFonce),
  #Face 7
  Triangle.new(p7a,p8e,p7e,noirClair),
  Triangle.new(p7a,p8a,p8e,noirClair),
  #Face 8
  Triangle.new(p8a,p1e,p8e,noirFonce),
  Triangle.new(p8a,p1a,p1e,noirFonce)

  ]

  return Modele.new(pointsBazooka, trianglesBazooka)
end

def self.teleporteur
  c1 = Point.new(-6, 0, -1)
  c2 = Point.new(-6, -8, -1)
  c3 = Point.new(-4, 0, -1)
  c4 = Point.new(-4, -8, -1)
  c5 = Point.new(-6, -8, 1)
  c6 = Point.new(-6, 0, 1)
  c7 = Point.new(-4, 0, 1)
  c8 = Point.new(-4, -8, 1)

  c9 = Point.new(4, 0, -1)
  c10 = Point.new(4, -8, -1)
  c11 = Point.new(6, 0, -1)
  c12 = Point.new(6, -8, -1)
  c13 = Point.new(4, -8, 1)
  c14 = Point.new(4, 0, 1)
  c15 = Point.new(6, 0, 1)
  c16 = Point.new(6, -8, 1)
  ######################################

  c17 = Point.new(-3, -6, 0)
  c18 = Point.new(-3, -8, 0)
  c19 = Point.new(-1, -6, 0)
  c20 = Point.new(-1, -8, 0)

  c21 = Point.new(-3, 0, 0)
  c22 = Point.new(-3, -2, 0)
  c23 = Point.new(-1, 0, 0)
  c24 = Point.new(-1, -2, 0)

  c25 = Point.new(3, -6, 0)
  c26 = Point.new(3, -8, 0)
  c27 = Point.new(1, -6, 0)
  c28 = Point.new(1, -8, 0)

  c29 = Point.new(3, 0, 0)
  c30 = Point.new(3, -2, 0)
  c31 = Point.new(1, 0, 0)
  c32 = Point.new(1, -2, 0)
###########################################

  c33 = Point.new(-3, -4, 0)
  c34 = Point.new(0, -6, 0)
  c35 = Point.new(0, -2, 0)
  c36 = Point.new(3, -4, 0)


  pointsCube = [c1, c2, c3, c4, c5, c6, c7, c8, c9, c10, c11, c12, c13 , c14, c15, c16, c17, c18, c19, c20, c21, c22, c23, c24, c25, c26, c27, c28, c29, c30, c31, c32, c33, c34, c35, c36]

  trianglesCube = [
    # devant
    Triangle.new(c1, c2, c3, 0xff18dcff),
    Triangle.new(c3, c2, c4, 0xff18dcff),
    #---

    # deriere tp gauche
    Triangle.new(c5, c6, c7, 0xffff0101),
    Triangle.new(c8, c5, c7, 0xffff0101),
    #---

    # haut tp gauche
    Triangle.new(c6, c1, c7, 0xff2d3436),
    Triangle.new(c1, c3, c7, 0xff2d3436),
    #---

    # bas tp gauche
    Triangle.new(c2, c5, c8, 0xff2d3436),
    Triangle.new(c4, c2, c8, 0xff2d3436),
    #---

    # droite tp gauche
    Triangle.new(c4, c8, c7, 0xff2d3436),
    Triangle.new(c3, c4, c7, 0xff2d3436),
    #---

    # gauche tp gauche
    Triangle.new(c5, c2, c6, 0xff2d3436),
    Triangle.new(c2, c1, c6, 0xff2d3436),
    #---

    # devant tp droit
    Triangle.new(c9, c10, c11, 0xffff0101),
    Triangle.new(c11, c10, c12, 0xffff0101),
    #---

    # deriere tp droit
    Triangle.new(c13, c14, c15, 0xff18dcff),
    Triangle.new(c16, c13, c15, 0xff18dcff),
    #---

    # haut tp droit
    Triangle.new(c14, c9, c15, 0xff2d3436),
    Triangle.new(c9, c11, c15, 0xff2d3436),
    #---

    # bas tp droit
    Triangle.new(c10, c13, c16, 0xff2d3436),
    Triangle.new(c12, c10, c16, 0xff2d3436),
    #---

    # droite tp droit
    Triangle.new(c12, c16, c15, 0xff2d3436),
    Triangle.new(c11, c12, c15, 0xff2d3436),
    #---

    # gauche tp droit
    Triangle.new(c13, c10, c14, 0xff2d3436),
    Triangle.new(c10, c9, c14, 0xff2d3436),
    #---

    # particules 1
    Triangle.new(c17, c18, c20, 0xff2d3436),
    Triangle.new(c17, c19, c20, 0xff2d3436),

    Triangle.new(c21, c22, c23, 0xff2d3436),
    Triangle.new(c22, c23, c24, 0xff2d3436),

    Triangle.new(c25, c28, c26, 0xff2d3436),
    Triangle.new(c25, c28, c27, 0xff2d3436),

    Triangle.new(c29, c31, c30, 0xff2d3436),
    Triangle.new(c30, c32, c31, 0xff2d3436),

    Triangle.new(c33, c34, c36, 0xff2d3436),
    Triangle.new(c33, c36, c35, 0xff2d3436),

    Triangle.new(c34, c36, c25, 0xff2d3436),
    Triangle.new(c33, c34, c17, 0xff2d3436),
    Triangle.new(c33, c22, c35, 0xff2d3436),
    Triangle.new(c36, c35, c30, 0xff2d3436)
    #---
  ]

  return Modele.new(pointsCube, trianglesCube)
end
def self.mitraillette

    #Tailles
    size = 3
    tailleBout = 0.8

    #Couleurs
    colorBois1 = 0xFF88421D
    colorBois2 = 0xFF8E4918
    colorChargeur1 = 0xFF808080
    colorChargeur2 = 0xFF8F8F8F
    colorChargeur3 = 0xFF8C8989
    colorCanon1 = 0xFF696969
    colorCanon2 = 0xFF595959
    colorCanon3 = 0xFF515151
    colorEmbout = 0xff2F3640


    #Points Canon Coté Gauche (Vue Personnage)
    p1 = Point.new(-0.1 * size, 0, 0)
    p2 = Point.new(-0.1 * size, 0, 1 * size)
    p3 = Point.new(-0.1 * size, -0.2 * size, 1 * size)
    p4 = Point.new(-0.1 * size, -0.2 * size, -0.1 * size)

    #Points Manche Coté Gauche
    p5 = Point.new(-0.2 * size, 0.3 * size, -0.45 * size)
    p6 = Point.new(-0.1 * size, 0.4 * size, -0.4 * size)

    #Points Canon Coté Droit (Vue Personnage)
    p7 = Point.new(0.1 * size, 0, 0)
    p8 = Point.new(0.1 * size, 0, 1 * size)
    p9 = Point.new(0.1 * size, -0.2 * size, 1 * size)
    p10 = Point.new(0.1 * size, -0.2 * size, -0.1 * size)

    #Points Manche Coté Droit
    p11 = Point.new(0.1 * size, 0.3 * size, -0.45 * size)
    p12 = Point.new(0.1 * size, 0.4 * size, -0.4 * size)

    #Points Bout
    p13 = Point.new(0.1 * size, 0, (1+tailleBout) * size) #p8 allongé
    p14 = Point.new(0.1 * size, -0.2 * size, (1+tailleBout) * size) #p9 allongé
    p15 = Point.new(-0.1 * size, -0.2 * size, (1+tailleBout) * size) #p3 allongé
    p16 = Point.new(-0.1 * size, 0, (1+tailleBout) * size) #p2 allongé

    #Points Sur Canon Pour Attache Chargeur
    p17 = Point.new(0.1 * size, 0, (1+(tailleBout/4)) * size)
    p18 = Point.new(0.1 * size, -0.2 * size, (1+(tailleBout/4)) * size)

    #Points Chargeur
    p19 = Point.new(0.6 * size, 0, 1 * size) #p8 allongé à droite
    p20 = Point.new(0.6 * size, -0.2 * size, 1 * size) #p9 allongé à droite
    p21 = Point.new(0.6 * size, 0, (1+(tailleBout/4)) * size) #p17 allongé à droite
    p22 = Point.new(0.6 * size, -0.2 * size, (1+(tailleBout/4)) * size) #p18 allongé à droite

    pointsMitraillette = [p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, p12, p13, p14, p15, p16, p17, p18, p19, p20, p21, p22]

    trianglesMitraillette = [
      Triangle.new(p7, p9, p8, colorBois2),
      Triangle.new(p9, p7, p10, colorBois2),

      Triangle.new(p10, p7, p11, colorBois2),
      Triangle.new(p11, p7, p12, colorBois2),

      Triangle.new(p1, p2, p3, colorBois2),
      Triangle.new(p3, p4, p1, colorBois2),

      Triangle.new(p4, p5, p1, colorBois2),
      Triangle.new(p5, p6, p1, colorBois2),


      Triangle.new(p1, p8, p2, colorBois1),
      Triangle.new(p1, p7, p8, colorBois1),

      Triangle.new(p3, p9, p4, colorCanon3),
      Triangle.new(p4, p9, p10, colorCanon3),

      Triangle.new(p4, p10, p5, colorBois1),
      Triangle.new(p10, p11, p5, colorBois1),

      Triangle.new(p5, p11, p6, colorBois1),
      Triangle.new(p11, p12, p6, colorBois1),

      Triangle.new(p6, p7, p1, colorBois1),
      Triangle.new(p6, p12, p7, colorBois1),

      #Triangles Bout
      #Coté Droit
      Triangle.new(p8, p14, p13, colorCanon2),
      Triangle.new(p14, p8, p9, colorCanon2),
      #Coté Gauche
      Triangle.new(p2, p16, p15, colorCanon2),
      Triangle.new(p15, p3, p2, colorCanon2),
      #Dessus
      Triangle.new(p15, p14, p3, colorCanon1),
      Triangle.new(p3, p14, p9, colorCanon1),
      #Dessous
      Triangle.new(p2, p13, p16, colorCanon1),
      Triangle.new(p2, p8, p13, colorCanon1),
      #Bout Canon
      Triangle.new(p16, p13, p15, colorEmbout),
      Triangle.new(p15, p13, p14, colorEmbout),

      #Triangles Chargeur
      #Coté Droit
      Triangle.new(p19, p22, p21, colorChargeur3),
      Triangle.new(p22, p19, p20, colorChargeur3),
      #Dessus
      Triangle.new(p18, p22, p9, colorChargeur2),
      Triangle.new(p9, p22, p20, colorChargeur2),
      #Dessous
      Triangle.new(p8, p21, p17, colorChargeur2),
      Triangle.new(p8, p19, p21, colorChargeur2),
      #Devant
      Triangle.new(p17, p21, p18, colorChargeur1),
      Triangle.new(p18, p21, p22, colorChargeur1),
      #Derrière
      Triangle.new(p9, p20, p8, colorChargeur1),
      Triangle.new(p20, p19, p8, colorChargeur1),

    ]

    return Modele.new(pointsMitraillette, trianglesMitraillette)
  end

end
