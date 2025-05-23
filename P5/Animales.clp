;insertamos los hechos
(deffacts datos
(ave gorrion) (ave paloma) (ave aguila) (ave pinguino)
(mamifero vaca) (mamifero perro) (mamifero caballo)
(vuela pinguino no seguro) 
)
; Las aves son animales
(defrule aves_son_animales
(ave ?x)
=>
(assert (animal ?x))
(bind ?expl (str-cat "sabemos que un " ?x " es un animal porque las aves son
un tipo de animal"))
(assert (explicacion animal ?x ?expl)) 
)
; añadimos un hecho que contiene la explicación de la deducció
; Los mamiferos son animales
; añadimos un hecho que contiene la explicación de la deducción
(defrule mamiferos_son_animales
(mamifero ?x)
=>
(assert (animal ?x))
(bind ?expl (str-cat "sabemos que un " ?x " es un animal porque los
mamiferos son un tipo de animal"))
(assert (explicacion animal ?x ?expl)) )
;;; Casi todos las aves vuela --> puedo asumir por defecto que las aves vuelan
; Asumimos por defecto
(defrule ave_vuela_por_defecto
(declare (salience -1)) ; para disminuir probabilidad de añadir erróneamente
(ave ?x)
=>
(assert (vuela ?x si por_defecto))
(bind ?expl (str-cat "asumo que un " ?x " vuela, porque casi todas las aves
vuelan"))
(assert (explicacion vuela ?x ?expl))
)
; Retractamos cuando hay algo en contra
;;; COMETARIO: esta regla también elimina los por defecto cuando ya esta seguro
(defrule retracta_vuela_por_defecto
(declare (salience 1)) ; para retractar antes de inferir cosas erroneamente
?f<- (vuela ?x ?r por_defecto)
(vuela ?x ?s seguro)
=>
(retract ?f)
(bind ?expl (str-cat "retractamos que un " ?x ?r " vuela por defecto, porque
sabemos seguro que " ?x ?s " vuela"))
(assert (explicacion retracta_vuela ?x ?expl)) 
)
;;; La mayor parte de los animales no vuelan --> puede interesarme asumir por defecto que un animal no va a volar
(defrule mayor_parte_animales_no_vuelan
(declare (salience -2)) ;;;; es mas arriesgado, mejor después de otros razonamientos
(animal ?x)
(not (vuela ?x ? ?))
=>
(assert (vuela ?x no por_defecto))
(bind ?expl (str-cat "asumo que " ?x " no vuela, porque la mayor parte de los animales no
vuelan"))
(assert (explicacion vuela ?x ?expl)) 
)
;Implementamos lo pedido
;Primero preguntamos el nombre del animal
(defrule preguntar_nombre_animal
(declare (salience -3))
=>
(printout t crlf "Indica el animal del que desea saber si vuela: " )
(assert (animal_preguntado (read)))
)
;Vemos si esta en el sistema
(defrule ver_si_esta_incluido
(declare (salience -3))
(animal_preguntado ?x)
(animal ?x)
=>
(assert (imprime_informacion) )
)
;Vemos si no esta, entonces preguntamos si sabe si es mamifero o ave
(defrule ver_si_no_esta_incluido
(declare (salience -3))
(animal_preguntado ?x)
(not(animal ?x))
=>
(printout t crlf "Indica si es un mamifero o ave si lo conoce: " )
(assert (pregunta_tipo (read)))
)
;si responde mamifero lo metemos en el sistema
(defrule es_mamifero
(declare (salience -3))
(pregunta_tipo mamifero)
(animal_preguntado ?x)
=>
(assert (mamifero ?x))
)
;si responde ave lo metemos en el sistema
(defrule es_ave
(declare (salience -3))
(pregunta_tipo ave)
(animal_preguntado ?x)
=>
(assert (ave ?x))
)
;si no es ave o mamifero lo metemos como animal
(defrule ni_ave_ni_mamifero
(declare (salience -3))
(not(pregunta_tipo ave))
(not(pregunta_tipo mamifero))
(animal_preguntado ?x)
=>
(assert (animal ?x))
)
;Si vuela indicamos que si vuela y porque lo deducimos
(defrule imprimir_informacion_si_vuela
(declare (salience -3))
(imprime_informacion)
(animal_preguntado ?x)
(vuela ?x si ?)
(explicacion vuela ?x ?expl)
=>
(printout t ?x " si vuela porque " ?expl crlf)
)
;Si no vuela, y no se ha retractado que vuela decimos que no vuela y porque
(defrule imprimir_informacion_no_vuela_y_no_retractado
(declare (salience -3))
(imprime_informacion)
(animal_preguntado ?x)
(vuela ?x no ?)
(explicacion vuela ?x ?expl)
(not(explicacion retracta_vuela ?x ?))
=>
(printout t ?x " no vuela porque " ?expl crlf)
)
;Si no vuela, y se ha retractado que vuela decimos que no vuela y porque se retractó
(defrule imprimir_informacion_no_vuela_retractado
(declare (salience -3))
(imprime_informacion)
(animal_preguntado ?x)
(vuela ?x no ?)
(explicacion retracta_vuela ?x ?expl)
=>
(printout t ?x " no vuela porque " ?expl crlf)
)