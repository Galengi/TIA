(define (domain dominioAsfalto)
    (:requirements
        :durative-actions
        :typing
        :fluents
    )
    (:types
        cuadrilla
        cisterna_asfalto
        pavimentadora
        compactadora
        tramo
        - object
    )
    (:predicates
        (at ?x - (either cuadrilla cisterna_asfalto pavimentadora compactadora ) ?t - tramo)
        (busy ?y - (either cuadrilla cisterna_asfalto pavimentadora compactadora tramo ) )
        (has-route ?t1 ?t2 - tramo)
        (estado-compactado ?t - tramo)
        (estado-pavimentado ?t - tramo)
        (estado-aplastado ?t - tramo)
        (estado-a-pintarMarcasViarias ?t - tramo)
        (estado-b-colocarVallasYQuitamiedos ?t - tramo)
        (estado-c-colocarSenalesYPanelesLuminosos ?t - tramo)
    )
    (:functions
        (distancia ?t1 ?t2 - tramo)
        (coste-pavimentadora)
        (coste-cisterna_asfalto)
        (coste-compactadora)
        (coste-total)
    )

    ;Actions
    (:durative-action compactarTerreno
        :parameters (?tramoActual - tramo)
        :duration (= ?duration 250)
        :condition (and
            (at start (not (busy ?tramoActual)))
            (at start (not (estado-compactado ?tramoActual)))
        )
        :effect (and
            (at start (busy ?tramoActual))
            (at end   (not (busy ?tramoActual)))
            (at end   (estado-compactado ?tramoActual))
        )
    )
    (:durative-action pavimentar
        :parameters (?tramoActual - tramo ?pavimentadoraActual - pavimentadora ?cisterna_asfaltoActual - cisterna_asfalto)
        :duration (= ?duration 190)
        :condition (and
            (at start (not (busy ?tramoActual)))
            (at start (not (busy ?pavimentadoraActual)))
            (at start (not (busy ?cisterna_asfaltoActual)))
            (at start (not (estado-pavimentado ?tramoActual)))
            (at start (estado-compactado ?tramoActual))
            (over all (at ?pavimentadoraActual ?tramoActual))
            (over all (at ?cisterna_asfaltoActual ?tramoActual))
        )
        :effect (and
            (at start (busy ?tramoActual))
            (at start (busy ?pavimentadoraActual))
            (at start (busy ?cisterna_asfaltoActual))
            (at end   (estado-pavimentado ?tramoActual))
            (at end   (not (busy ?tramoActual)))
            (at end   (not (busy ?pavimentadoraActual)))
            (at end   (not (busy ?cisterna_asfaltoActual)))
            (at end   (increase (coste-total) (coste-cisterna_asfalto)))
            (at end   (increase (coste-total) (coste-pavimentadora)))
        )
    )
    (:durative-action aplastar
        :parameters (?tramoActual - tramo ?compactadoraActual - compactadora)
        :duration (= ?duration 150)
        :condition (and
            (at start (not (busy ?tramoActual)))
            (at start (not (busy ?compactadoraActual)))
            (at start (not (estado-aplastado ?tramoActual)))
            (at start (estado-pavimentado ?tramoActual))
            (over all (at ?compactadoraActual ?tramoActual))
        )
        :effect (and
            (at start (busy ?tramoActual))
            (at start (busy ?compactadoraActual))
            (at end   (not (busy ?tramoActual)))
            (at end   (not (busy ?compactadoraActual)))
            (at end   (estado-aplastado ?tramoActual))
            (at end   (increase (coste-total) (coste-compactadora)))
        )
    )
    (:durative-action pintarMarcasViarias
        :parameters (?tramoActual - tramo ?cuadrillaActual - cuadrilla)
        :duration (= ?duration 30)
        :condition (and
            (at start (estado-aplastado ?tramoActual))
            (at start (not (busy ?cuadrillaActual)))
            (at start (not (estado-a-pintarMarcasViarias ?tramoActual)))
            (at start (estado-aplastado ?tramoActual))
            (over all (at ?cuadrillaActual ?tramoActual))
        )
        :effect (and
            (at start (busy ?tramoActual))
            (at start (busy ?cuadrillaActual))
            (at end   (not (busy ?tramoActual)))
            (at end   (estado-a-pintarMarcasViarias ?tramoActual))
            (at end   (not (busy ?cuadrillaActual)))
        )
    )
    (:durative-action colocarVallasYQuitamiedosstar
        :parameters (?tramoActual - tramo ?cuadrillaActual - cuadrilla)
        :duration (= ?duration 120)
        :condition (and
            (at start (estado-aplastado ?tramoActual))
            (at start (not (busy ?cuadrillaActual)))
            (at start (not (estado-b-colocarVallasYQuitamiedos ?tramoActual)))
            (at start (estado-aplastado ?tramoActual))
            (over all (at ?cuadrillaActual ?tramoActual))
        )
        :effect (and
            (at start (busy ?tramoActual))
            (at start (busy ?cuadrillaActual))
            (at end   (not (busy ?tramoActual)))
            (at end   (estado-b-colocarVallasYQuitamiedos ?tramoActual))
            (at end   (not (busy ?cuadrillaActual)))
        )
    )
    (:durative-action colocarSenalesYPanelesLuminosos
        :parameters (?tramoActual - tramo ?cuadrillaActual - cuadrilla)
        :duration (= ?duration 70)
        :condition (and
            (at start (estado-aplastado ?tramoActual))
            (at start (not (busy ?cuadrillaActual)))
            (at start (not (estado-c-colocarSenalesYPanelesLuminosos ?tramoActual)))
            (at start (estado-aplastado ?tramoActual))
            (over all (at ?cuadrillaActual ?tramoActual))
        )
        :effect (and
            (at start (busy ?tramoActual))
            (at start (busy ?cuadrillaActual))
            (at end   (not (busy ?tramoActual)))
            (at end   (estado-c-colocarSenalesYPanelesLuminosos ?tramoActual))
            (at end   (not (busy ?cuadrillaActual)))
        )
    )
    (:durative-action transportarCuadrilla
        :parameters (?tramoOrigen ?tramoDestino - tramo ?cuadrillaActual - cuadrilla)
        :duration (= ?duration (distancia ?tramoOrigen ?tramoDestino))
        :condition (and
            (at start (has-route ?tramoOrigen ?tramoDestino))
            (at start (not (busy ?tramoOrigen)))
            (at start (not (busy ?tramoDestino)))
            (at start (not (busy ?cuadrillaActual)))
            (at start (at ?cuadrillaActual ?tramoOrigen))
        )
        :effect (and
            (at start (busy ?tramoOrigen))
            (at start (busy ?tramoDestino))
            (at start (busy ?cuadrillaActual))
            (at start (not (at ?cuadrillaActual ?tramoOrigen)))
            (at end   (not (busy ?tramoOrigen)))
            (at end   (not (busy ?tramoDestino)))
            (at end   (not (busy ?cuadrillaActual)))
            (at end   (at ?cuadrillaActual ?tramoDestino))
        )
    )
    (:durative-action transportarMaquinaria
        :parameters (?tramoOrigen ?tramoDestino - tramo ?maquinaria - (either cisterna_asfalto pavimentadora compactadora ))
        :duration (= ?duration (* (distancia ?tramoOrigen ?tramoDestino) 2))
        :condition (and
            (at start (has-route ?tramoOrigen ?tramoDestino))
            (at start (not (busy ?tramoOrigen)))
            (at start (not (busy ?tramoDestino)))
            (at start (not (busy ?maquinaria)))
            (at start (at ?maquinaria ?tramoOrigen))
        )
        :effect (and
            (at start (busy ?tramoOrigen))
            (at start (busy ?tramoDestino))
            (at start (busy ?maquinaria))
            (at start (not (at ?maquinaria ?tramoOrigen)))
            (at end   (not (busy ?tramoOrigen)))
            (at end   (not (busy ?tramoDestino)))
            (at end   (not (busy ?maquinaria)))
            (at end   (at ?maquinaria ?tramoDestino))
        )
    )
)
