;;funciones
(deffunction combinacion (?fc1 ?fc2)
(if (and (> ?fc1 0) (> ?fc2 0) )
then
(bind ?rv (- (+ ?fc1 ?fc2) (* ?fc1 ?fc2) ) )
else
(if (and (< ?fc1 0) (< ?fc2 0) )
then
(bind ?rv (+ (+ ?fc1 ?fc2) (* ?fc1 ?fc2) ) )
else
(bind ?rv (/ (+ ?fc1 ?fc2) (- 1 (min (abs ?fc1) (abs ?fc2))) ))
)
)
?rv)
(deffunction encadenado (?fc_antecedente ?fc_regla)
(if (> ?fc_antecedente 0)
then
(bind ?rv (* ?fc_antecedente ?fc_regla))
else
(bind ?rv 0) )
?rv)
(deffunction pregunta (?pregunta $?valores-permitidos)
(progn$
(?var ?valores-permitidos)
(lowcase ?var))
(format t "¿%s? (%s) " ?pregunta (implode$ ?valores-permitidos)) (bind ?respuesta (read))
(while (not (member$ (lowcase ?respuesta) ?valores-permitidos)) do
(format t "¿%s? (%s) " ?pregunta (implode$ ?valores-permitidos))
(bind ?respuesta (read))
)
?respuesta
)
;;; convertimos cada evidencia en una afirmación sobre su factor de certeza
(defrule certeza_evidencias
(Evidencia ?e ?r)
=>
(assert (FactorCerteza ?e ?r 1)) )
;;;;;; Combinar misma deduccion por distintos caminos
(defrule combinar
(declare (salience 1))
?f <- (FactorCerteza ?h ?r ?fc1)
?g <- (FactorCerteza ?h ?r ?fc2)
(test (neq ?fc1 ?fc2))
=>
(retract ?f ?g)
(assert (FactorCerteza ?h ?r (combinacion ?fc1 ?fc2)))
)
(defrule combinar_signo
(declare (salience 2))
(FactorCerteza ?h si ?fc1)
(FactorCerteza ?h no ?fc2)
=>
(assert (Certeza ?h (- ?fc1 ?fc2))) 
)
;Aqui iremos guardando la razones por la que deducimos certezas
(deftemplate justificacion
(slot problema)
(slot contenido))
;R1: SI el motor obtiene gasolina Y el motor gira ENTONCES problemas con las bujías con
;certeza 0,7
(defrule R1
(FactorCerteza motor_llega_gasolina si ?f1)
(FactorCerteza gira_motor si ?f2)
(test (and (> ?f1 0) (> ?f2 0)))
=>
(assert (FactorCerteza problema_bujias si (encadenado (* ?f1 ?f2) 0.7)))
(assert (justificacion (problema problema_bujias) (contenido "El motor gira y problamente le
llegue gasolina.")))
)
;;añadimos el resto de reglas
;R2: SI NO gira el motor ENTONCES problema con el starter con certeza 0,8
(defrule R2
(FactorCerteza gira_motor no ?f1)
(test (> ?f1 0))
=>
(assert (FactorCerteza problema_starter si (encadenado ?f1 0.8)))
(assert (justificacion (problema problema_starter) (contenido "El motor no gira.")))
)
;R3: SI NO encienden las luces ENTONCES problemas con la batería con certeza 0,9
(defrule R3
(FactorCerteza encienden_las_luces no ?f1)
(test (> ?f1 0))
=>
(assert (FactorCerteza problema_bateria si (encadenado ?f1 0.9)))
(assert (justificacion (problema problema_bateria) (contenido "Las luces no encienden.")))
)
;R4: SI hay gasolina en el deposito ENTONCES el motor obtiene gasolina con certeza 0,9
(defrule R4
(FactorCerteza hay_gasolina_en_deposito si ?f1)
(test (> ?f1 0))
=>
(assert (FactorCerteza motor_llega_gasolina si (encadenado ?f1 0.9)))
)
;R5: SI hace intentos de arrancar ENTONCES problema con el starter con certeza -0,6
(defrule R5
(FactorCerteza hace_intentos_arrancar si ?f1)
(test (> ?f1 0))
=>
(assert (FactorCerteza problema_starter si (encadenado ?f1 -0.6)))
(assert (justificacion (problema problema_starter) (contenido "El que intente arrancar lo
hace menos probable.")))
)
;R6: SI hace intentos de arrancar ENTONCES problema con la batería 0,5
(defrule R6
(FactorCerteza hace_intentos_arrancar si ?f1)
(test (> ?f1 0))
=>
(assert (FactorCerteza problema_bateria si (encadenado ?f1 0.5)))
(assert (justificacion (problema problema_bateria) (contenido "Hace intentos de arrancar.")))
)
;Preguntamos las evidencias
(defrule preguntar_si_hace_intentos_de_arrancar
(declare (salience -33))
=>
(bind ?respuesta (pregunta "¿El coche hace intentos de arrancar?" si no))
(assert(Evidencia hace_intentos_arrancar ?respuesta))
)
(defrule preguntar_si_hay_gasolina_en_deposito
(declare (salience -33))
=>
(bind ?respuesta (pregunta "¿El coche tiene gasolina en el deposito?" si no))
(assert(Evidencia hay_gasolina_en_deposito ?respuesta))
)
(defrule preguntar_si_encienden_las_luces
(declare (salience -33))
=>
(bind ?respuesta (pregunta "¿El coche enciende las luces?" si no))
(assert(Evidencia encienden_las_luces ?respuesta))
)
(defrule preguntar_si_gira_motor
(declare (salience -33))
=>
(bind ?respuesta (pregunta "¿El motor gira?" si no))
(assert(Evidencia gira_motor ?respuesta))
)
;Para extraer el más probable primero inicializamos otro problema con certeza 0
(defrule inicializar_problema_mas_probable
(declare (salience -34))
=>
(assert (problema_mas_probable desconocido 0))
(assert (justificacion (problema desconocido) (contenido "No hay certeza de lo que pasa.")))
)
;extraemos el más probable entre los problemas
(defrule extraer_problema_mas_probable
(declare (salience -35))
?mas_probable <- (problema_mas_probable ?problema_mas_probable ?certeza)
(FactorCerteza ?problema si ?f1)
(test (or (eq ?problema problema_starter) (or (eq ?problema problema_bujias) (eq
?problema problema_bateria))))
(test (> ?f1 ?certeza))
=>
(retract ?mas_probable)
(assert (problema_mas_probable ?problema ?f1))
)
;Imprimimos el problema y su justificación
(defrule imrpimir_problema_mas_probable
(declare (salience -36))
(problema_mas_probable ?problema ?probabilidad)
=>
(printout t crlf "El problema más probable es " ?problema " con una certeza de " (*
?probabilidad 100) crlf)
)
(defrule imprimir_justificacion
(declare (salience -37))
(problema_mas_probable ?problema ?probabilidad)
=>
(printout t "Los motivos son: " crlf)
(do-for-all-facts ((?j justificacion)) (eq ?j:problema ?problema)
(printout t " - " ?j:contenido crlf))
)