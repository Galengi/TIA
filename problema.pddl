(define (problem problema)
(:domain dominioAsfalto)
(:objects
    cuadrilla1 - cuadrilla
    cuadrilla2 - cuadrilla
    cuadrilla3 - cuadrilla
    cuadrilla4 - cuadrilla
    cisterna1 - cisterna_asfalto
    cisterna2 - cisterna_asfalto
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
    
    (estado-compactado tramo3)
    (estado-compactado tramo4)
    (estado-compactado tramo5)



    (= (coste-pavimentadora) 30)
    (= (coste-cisterna_asfalto) 25)
    (= (coste-compactadora) 35)

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
    
    (has-route tramo1 tramo2)
    (has-route tramo2 tramo1)
    
    (has-route tramo2 tramo3)
    (has-route tramo3 tramo2)
    
    (has-route tramo3 tramo5)
    (has-route tramo5 tramo3)
    
    (has-route tramo2 tramo4)
    (has-route tramo4 tramo2)
    
    (has-route tramo4 tramo5)
    (has-route tramo5 tramo4)

    (= (coste-total) 0)
)

(:goal (and

    (at cuadrilla1 tramo1)
    (at cuadrilla2 tramo5)
    (at cuadrilla4 tramo5)
    (at cisterna1 tramo1)
    (at cisterna2 tramo3)
    (at compactadora1 tramo5)

    (estado-aplastado tramo1)
    (estado-aplastado tramo2)
    (estado-aplastado tramo3)
    (estado-aplastado tramo4)
    (estado-aplastado tramo5)

    (estado-a-pintarMarcasViarias tramo1)
    (estado-a-pintarMarcasViarias tramo2)
    (estado-a-pintarMarcasViarias tramo3)
    (estado-a-pintarMarcasViarias tramo4)
    (estado-a-pintarMarcasViarias tramo5)

    (estado-b-colocarVallasYQuitamiedos tramo1)
    (estado-b-colocarVallasYQuitamiedos tramo2)
    (estado-b-colocarVallasYQuitamiedos tramo3)
    (estado-b-colocarVallasYQuitamiedos tramo4)
    (estado-b-colocarVallasYQuitamiedos tramo5)

    (estado-c-colocarSenalesYPanelesLuminosos tramo3)
    (estado-c-colocarSenalesYPanelesLuminosos tramo4)
    (estado-c-colocarSenalesYPanelesLuminosos tramo5)
))

    (:metric minimize (+ (* 0.2 (total-time)) (* 0.5 (coste-total))))
)
