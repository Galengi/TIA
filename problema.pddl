(define (problem problema)
(:domain carreteras)
(:objects
    cuadrilla1 - cuadrilla
    cuadrilla2 - cuadrilla
    cuadrilla3 - cuadrilla
    cuadrilla4 - cuadrilla
    cisterna1 - cisterna
    cisterna2 - cisterna
    pavimentadora1 - pavimentadora
    pavimentadora2 - pavimentadora
    compactadora1 - compactadora
    tramo1 - tramo
    tramo2 - tramo
    tramo3 - tramo
    tramo4 - tramo
    tramo5 - tramo
    )

(:init
    (at cuadrilla1 tramo1)
    (at cuadrilla2 tramo1)
    (at cuadrilla3 tramo5)
    (at cuadrilla4 tramo5)
    (at cisterna1 tramo1)
    (at cisterna2 tramo1)
    (at pavimentadora1 tramo2)
    (at pavimentadora2 tramo2)
    (at compactadora1 tramo5)

    (agrietado tramo1)
    (agrietado tramo2)

    (compactado tramo3)
    (compactado tramo4)
    (compactado tramo5)

    (disponible cuadrilla1)
    (disponible cuadrilla2)
    (disponible cuadrilla3)
    (disponible cuadrilla4)
    (disponible tramo1)
    (disponible tramo2)
    (disponible tramo3)
    (disponible tramo4)
    (disponible tramo5)
    (disponible cisterna1)
    (disponible cisterna2)
    (disponible pavimentadora1)
    (disponible pavimentadora2)
    (disponible compactadora1)

    (= (lentitud cuadrilla1) 1)
    (= (lentitud cuadrilla2) 1)
    (= (lentitud cuadrilla3) 1)
    (= (lentitud cuadrilla4) 1)
    (= (lentitud cisterna1) 2)
    (= (lentitud cisterna2) 2)
    (= (lentitud pavimentadora1) 2)
    (= (lentitud pavimentadora2) 2)
    (= (lentitud compactadora1) 2)

    (= (distancia tramo1 tramo2) 5)
    (= (distancia tramo2 tramo1) 5)

    (= (distancia tramo2 tramo3) 6)
    (= (distancia tramo3 tramo2) 6)

    (= (distancia tramo2 tramo4) 4)
    (= (distancia tramo4 tramo2) 4)

    (= (distancia tramo3 tramo5) 7)
    (= (distancia tramo5 tramo3) 7)

    (= (distancia tramo4 tramo5) 6)
    (= (distancia tramo5 tramo4) 6)
    
    (conectado tramo1 tramo2)
    (conectado tramo2 tramo1)
    
    (conectado tramo2 tramo3)
    (conectado tramo3 tramo2)
    
    (conectado tramo3 tramo5)
    (conectado tramo5 tramo3)
    
    (conectado tramo2 tramo4)
    (conectado tramo4 tramo2)
    
    (conectado tramo4 tramo5)
    (conectado tramo5 tramo4)

    (= (coste-total) 0)
)

(:goal(and

    (at cuadrilla1 tramo1)
    (at cuadrilla2 tramo5)
    (at cuadrilla4 tramo5)
    (at cisterna1 tramo1)
    (at cisterna2 tramo3)
    (at compactadora1 tramo5)

    (aplastado tramo1)
    (aplastado tramo2)
    (aplastado tramo3)
    (aplastado tramo4)
    (aplastado tramo5)

    (pintado tramo1)
    (pintado tramo2)
    (pintado tramo3)
    (pintado tramo4)
    (pintado tramo5)

    (vallado tramo1)
    (vallado tramo2)
    (vallado tramo3)
    (vallado tramo4)
    (vallado tramo5)

    (senalizado tramo3)
    (senalizado tramo4)
    (senalizado tramo5)
))

(:metric minimize (+ (* 0.2 (total-time)) (* 0.5 (coste-total))))
)
