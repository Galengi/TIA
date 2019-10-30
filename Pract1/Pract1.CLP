
 (deffunction fuzzify (?fztemplate ?value ?delta)

        (bind ?low (get-u-from ?fztemplate))
        (bind ?hi  (get-u-to   ?fztemplate))

        (if (<= ?value ?low)
          then
            (assert-string
              (format nil "(%s (%g 1.0) (%g 0.0))" ?fztemplate ?low ?delta))
          else
            (if (>= ?value ?hi)
              then
                (assert-string
                   (format nil "(%s (%g 0.0) (%g 1.0))"
                               ?fztemplate (- ?hi ?delta) ?hi))
              else
                (assert-string
                   (format nil "(%s (%g 0.0) (%g 1.0) (%g 0.0))"
                               ?fztemplate (max ?low (- ?value ?delta))
                               ?value (min ?hi (+ ?value ?delta)) ))
            )
        )
  )





;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(deftemplate agrietamiento 0 100 porcentaje
  (
  (ligero  (10 1) (20 0))
  (medio    (5 0) (25 1) (45 1) (55 0))
  (fuerte   (50 0) (60 1))
  )
)

(deftemplate temperatura -10 90 grados
  (
  (fria  (5 1) (10 0))
   (moderada    (-5 0) (15 1) (40 1) (50 0))
   (calida  (35 0) (45 1))
   )
)

(deftemplate necesidad-reasfaltado 0 100 prioridad
  (
  (baja  (z 10 25))
   (media  (pi 15 60))
   (urgente  (s 55 90))
   )
)

(deftemplate densidad-trafico 0 300 vehporhora
  (
  (baja  (z 20 80))
   (alta  (s 120 250))
   )
) 

(deftemplate modeloCarretera
   (slot id_car (type SYMBOL))
   (slot niv_agri (type INTEGER))
   (slot max_tempe (type INTEGER))
   (slot min_tempe (type INTEGER))
   (slot den_carro (type INTEGER))
   (slot prioridadRes (type FLOAT))
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(defrule fria_ligero
   (agrietamiento ligero)
   (temperatura fria)
  =>
   (assert (necesidad-reasfaltado media))
)

(defrule fria_medio
   (agrietamiento medio)
   (temperatura fria)
  =>
   (assert (necesidad-reasfaltado urgente))
)

(defrule fria_fuerte
   (agrietamiento fuerte)
   (temperatura fria)
  =>
   (assert (necesidad-reasfaltado extremely urgente))
)



;;;;;;;;;;;;;;;;;;;;;



(defrule moderada_ligero
   (agrietamiento ligero)
   (temperatura moderada)
  =>
   (assert (necesidad-reasfaltado very baja))
)

(defrule moderada_medio
   (agrietamiento medio)
   (temperatura moderada)
  =>
   (assert (necesidad-reasfaltado baja))
)

(defrule moderada_fuerte
   (agrietamiento fuerte)
   (temperatura moderada)
  =>
   (assert (necesidad-reasfaltado somewhat media))
)

;;;;;;;;;;;;;;;;;;;;;



(defrule calida_ligero
   (agrietamiento ligero)
   (temperatura calida)
  =>
   (assert (necesidad-reasfaltado media))
)

(defrule calida_medio
   (agrietamiento medio)
   (temperatura calida)
  =>
   (assert (necesidad-reasfaltado very urgente))
)


(defrule calida_fuerte
   (agrietamiento fuerte)
   (temperatura calida)
  =>
   (assert (necesidad-reasfaltado extremely urgente))
)


;;;;;;;;;;;;;;;;;;;;;


(defrule densidad_baja
   (densidad-trafico baja)
  =>
   (assert (necesidad-reasfaltado more-or-less baja))
)


(defrule densidad_alta
   (densidad-trafico alta)
  =>
   (assert (necesidad-reasfaltado very urgente))
)



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defrule leerconsola ;lee de consola un valor difuso y lo aserta
   (initial-fact)
   =>
   (printout t "Introduzca el identificador de la carretera" crlf)
   (bind ?id_carretera (read))
   (assert-string (format nil "(Identificador %s)" ?id_carretera))
 
   (printout t "Introduzca el nivel de agrietamiento" crlf)
   (bind ?niv_agr (read))
 
   (printout t "Introduzca la maxima temperatura de la carretera" crlf)
   (bind ?max_temp (read))
 
   (printout t "Introduzca la minima temperatura de la carretera" crlf)
   (bind ?min_temp (read))
 
   (printout t "Introduzca la densidad de la carretera" crlf)
   (bind ?den_car (read))

   (assert (modeloCarretera (id_car ?id_carretera) (niv_agri ?niv_agr) (max_tempe ?max_temp) (min_tempe ?min_temp) (den_carro ?den_car)))
 
   (fuzzify agrietamiento ?niv_agr 0) 
   (fuzzify temperatura ?max_temp 0) 
   (fuzzify temperatura ?min_temp 0)
   (fuzzify densidad-trafico ?den_car 0) 
 
 ) 
 
 
 
 
 (defrule resultado
   (declare (salience -1))
      (necesidad-reasfaltado ?x)
      (modeloCarretera (id_car ?id_carretera) (niv_agri ?niv_agr) (max_tempe ?max_temp) (min_tempe ?min_temp) (den_carro ?den_car) (prioridadRes ?prio))
      =>
      (bind ?mom_def (moment-defuzzify ?x))
      (bind ?max_def (maximum-defuzzify ?x))

      (printout t "moment-defuzzify " ?mom_def crlf)
      (printout t "maximum-defuzzify " ?max_def crlf)
)