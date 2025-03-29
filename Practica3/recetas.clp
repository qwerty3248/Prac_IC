;;;; AÑADIR LA INFORMACION DE AL MENOS 2 RECETAS NUEVAS al archivo compartido recetas.txt (https://docs.google.com/document/d/15zLHIeCEUplwsxUxQU66LsyKPY9n9p5v1bmi8M85YlU/edit?usp=sharing)
;;;;;recoger los datos de https://www.recetasgratis.net  en el siguiente formato
(deftemplate receta
(slot nombre)   ; necesario
(slot introducido_por) ; necesario
(slot numero_personas)  ; necesario
(multislot ingredientes)   ; necesario
(slot dificultad (allowed-symbols alta media baja muy_baja))  ; necesario
(slot duracion)  ; necesario
(slot enlace)  ; necesario
(multislot tipo_plato (allowed-symbols entrante primer_plato plato_principal postre desayuno_merienda acompanamiento)) ; necesario, introducido o deducido en este ejercicio
(slot coste)  ; opcional relevante
(slot tipo_copcion (allowed-symbols crudo cocido a_la_plancha frito al_horno al_vapor))   ; opcional
(multislot tipo_cocina)   ;opcional
(slot temporada)  ; opcional
;;;; Estos slot se calculan, se haria mediante un algoritmo que no vamos a implementar para este prototipo, lo usamos con la herramienta indicada y lo introducimos
(slot Calorias) ; calculado necesario
(slot Proteinas) ; calculado necesario
(slot Grasa) ; calculado necesario
(slot Carbohidratos) ; calculado necesario
(slot Fibra) ; calculado necesario
(slot Colesterol) ; calculado necesario
)
;;;; Para los datos calculados se puede utilizar: https://www.labdeiters.com/nutricalculadora/ o https://fitia.app/buscar/alimentos-y-recetas/


;(deffunction new-str-replace (?str ?rpl ?fnd)
;   (if (eq ?fnd "") then (return ?str))
;   (bind ?rv "")
;   (bind ?i (str-index ?fnd ?str))
;   (while ?i
;      (bind ?rv (str-cat ?rv (sub-string 1 (- ?i 1) ?str) ?rpl))
;      (bind ?str (sub-string (+ ?i (str-length ?fnd)) (str-length ?str) ?str))
;      (bind ?i (str-index ?fnd ?str)))
;   (bind ?rv (str-cat ?rv ?str))
;   (return ?rv)
;)

(deffunction str-replace (?str ?rpl ?fnd)
   (if (eq ?fnd "") then (return ?str))
   (bind ?rv "")
   (bind ?i (str-index ?fnd ?str))
   (while ?i
      (bind ?rv (str-cat ?rv (sub-string 1 (- ?i 1) ?str) ?rpl))
      (bind ?str (sub-string (+ ?i (str-length ?fnd)) (str-length ?str) ?str))
      (bind ?i (str-index ?fnd ?str)))
   (bind ?rv (str-cat ?rv ?str)))

(deffunction   pregunta  (?pregunta  $?valores-permitidos)
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

;;;; Concocimiento general

(deffacts piramide_alimentaria
(nivel_piramide_alimentaria verdura 1)
(nivel_piramide_alimentaria hortalizas 1)
(nivel_piramide_alimentaria fruta 2)
(nivel_piramide_alimentaria cereales_integrales 3)
(nivel_piramide_alimentaria lacteos 4)
(nivel_piramide_alimentaria aceite_de_oliva 5)
(nivel_piramide_alimentaria frutos 5)
(nivel_piramide_alimentaria frutos_secos 6)
(nivel_piramide_alimentaria especies 6)
(nivel_piramide_alimentaria hierbas_aromaticas 6)
(nivel_piramide_alimentaria legumbres 7)
(nivel_piramide_alimentaria carne_blanca 8)
(nivel_piramide_alimentaria pescado 8)
(nivel_piramide_alimentaria huevos 8)
(nivel_piramide_alimentaria carne_roja 9)
(nivel_piramide_alimentaria embutidos 9)
(nivel_piramide_alimentaria fiambres 9)
(nivel_piramide_alimentaria dulces 9)
)   

(deffacts es_un_tipo_de_alimentos
(es_un_tipo_de carne_roja carne)
(es_un_tipo_de lomo carne_roja)
(es_un_tipo_de ternera carne_roja)
(es_un_tipo_de cerdo carne_roja)
(es_un_tipo_de cordero carne_roja)
(es_un_tipo_de carne_blanca carne)
(es_un_tipo_de pollo carne_blanca)
(es_un_tipo_de conejo carne_blanca)
(es_un_tipo_de leche lacteos)
(es_un_tipo_de helado lacteos)
(es_un_tipo_de queso lacteos)
(es_un_tipo_de yogur lacteos)
(es_un_tipo_de atun pescado) 
(es_un_tipo_de salmon pescado)
(es_un_tipo_de salmon_ahumado pescado)
(es_un_tipo_de surimi pescado)     
(es_un_tipo_de boquerones pescado)
(es_un_tipo_de sardinas pescado)
(es_un_tipo_de salchichon embutidos)
(es_un_tipo_de chorizo embutidos)
(es_un_tipo_de judias_blancas legumbres)
(es_un_tipo_de garbanzos legumbres)
(es_un_tipo_de guisantes legumbres)
(es_un_tipo_de nueces frutos_secos)
(es_un_tipo_de almendra frutos_secos)
(es_un_tipo_de perejil hierbas_aromaticas)
(es_un_tipo_de pimienta especies)
(es_un_tipo_de pimenton especies)
(es_un_tipo_de cereales_integrales cereales)
(es_un_tipo_de trigo cereales)
(es_un_tipo_de harina cereales)
(es_un_tipo_de maiz cereales)
(es_un_tipo_de sandia fruta)
(es_un_tipo_de pinia fruta)
(es_un_tipo_de platano fruta)
(es_un_tipo_de pera fruta)
(es_un_tipo_de manzana fruta)
(es_un_tipo_de naranja fruta)
(es_un_tipo_de lechuga verdura)
(es_un_tipo_de coliflor verdura)
(es_un_tipo_de brocoli verdura)
(es_un_tipo_de ajo verdura)
(es_un_tipo_de pimiento verdura)
(es_un_tipo_de zanahoria verdura)
(es_un_tipo_de patata verdura)
(es_un_tipo_de verduras_para_ensaladilla verdura)
(es_un_tipo_de cebolla verdura)
(es_un_tipo_de tomate verdura)
(es_un_tipo_de pimiento_rojo pimiento)
(es_un_tipo_de pimiento_verde pimiento)
(es_un_tipo_de pastel dulces)
(es_un_tipo_de caramelos dulces)
(es_un_tipo_de azucar dulces)
(es_un_tipo_de aceite_de_oliva aceite)
(es_un_tipo_de mortadela fiambres)
(es_un_tipo_de jamon_de_york fiambres)
(es_un_tipo_de aceitunas_verdes frutos)
(es_un_tipo_de aceitunas_rellenas frutos)
(es_un_tipo_de aceitunas_rojas frutos)
)

(deffacts es_un_tipo_de_condimento
(es_un_tipo_de especies condimento)
(es_un_tipo_de caldo condimento)
(es_un_tipo_de vino condimento)
(es_un_tipo_de aceite condimento)
(es_un_tipo_de mahonesa condimento)
(es_un_tipo_de ajo condimento)
(es_un_tipo_de salsa condimento)
(es_un_tipo_de bebida condimento)
(es_un_tipo_de esencia_vainilla condimento)
)

(deffacts bebidas
(es_un_tipo_de cognac bebida)
(es_un_tipo_de vino bebida)
(es_un_tipo_de cerveza bebida)
(es_un_tipo_de agua bebida)
(es_un_tipo_de cerveza bebida)
(es_un_tipo_de colacao bebida)
(es_un_tipo_de cafe bebida)
)

(deffacts especias
(es_un_tipo_de sal especies)
(es_un_tipo_de cebolleta especies)
(es_un_tipo_de azafran especies)
(es_un_tipo_de laurel especies)
(es_un_tipo_de curry especies)
(es_un_tipo_de curcuma especies)
)


(deffacts hecho_de 
(compuesto_fundamentalmente_por pan harina)
(compuesto_fundamentalmente_por pasta harina)
(compuesto_fundamentalmente_por pizza harina)
(compuesto_fundamentalmente_por caldo_de_pollo pollo)
)


(defrule componiendo_es_un_tipo_de
(declare (salience 10))
(es_un_tipo_de ?x ?y)
(es_un_tipo_de ?y ?z)
=>
(assert (es_un_tipo_de ?x ?z))
)

(defrule compuesto_fundamentalmente_por_entonces_tipo_de 
(declare (salience 10))
(compuesto_fundamentalmente_por ?x ?y)
(es_un_tipo_de ?y ?z)
=>
(assert (es_un_tipo_de ?x ?z))
)

(defrule deducir_grupo_por_piramide
(declare (salience 10))
(nivel_piramide_alimentaria ?g ?)
=>
(assert (es_grupo_alimentos ?g))
)

(defrule superclase_grupos_son_grupos
(declare (salience 10))
(es_grupo_alimentos ?g)
(es_un_tipo_de ?g ?x)
(test (neq ?x condimento))
=>
(assert (es_grupo_alimentos ?x))
)

(defrule es_alimento
(declare (salience 10))
(es_un_tipo_de ?a ?g)
(es_grupo_alimentos ?g)
=>
(assert (es_alimento ?a))
)

(defrule deducir_es_un_tipo_de
    (declare (salience 10))
    (es_grupo_alimentos ?g)
    (or  (alimento ?a)
        (es_grupo_alimentos ?a))
    (test (neq ?a ?g))
    =>
    (bind ?espacio_a (str-index "_" ?a))
    (if ?espacio_a
        then
        (bind ?primera_palabra_a (sub-string 1 (- ?espacio_a 1) ?a))
        (if (eq ?primera_palabra_a ?g)
            then
            (assert (es_un_tipo_de ?a ?g))))
)

;(defrule es_un_tipo_de_grupo
;    (es_grupo_alimentos ?g)
;    (or (es_alimento ?a) (es_grupo_alimentos ?a))
;    (not (es_un_tipo_de ?a ?))
;    (test (neq ?a ?g))
;    =>
;    (bind ?cadeneta (str-cat "" ?a))
;    (while (neq (str-index "_" ?cadeneta) FALSE) do
;        (bind ?espacio_a (str-index "_" ?cadeneta))
;        (bind ?primera_palabra_a (sub-string 1 (- ?espacio_a 1) ?cadeneta))
;        (if (and (neq ?primera_palabra_a "de") (neq ?primera_palabra_a "con") (neq (str-index ?primera_palabra_a ?g) FALSE)) then
;            (assert (es_un_tipo_de ?a ?g)))
;        (bind ?borra (str-cat primera_palabra_a "_"))
;        (bind ?cadeneta (str-replace ?cadeneta "" ?borra )))
;    (if (and (neq (str-index ?cadeneta ?g) FALSE) (neq ?cadeneta "de") (neq ?cadeneta "con")) then
;        (assert (es_un_tipo_de ?a ?g)))
;)

;(defrule es_un_tipo_de_por_alimento
;(declare (salience 1))
;(es_alimento ?a)
;(es_alimento ?b)
;(test (neq ?a ?b))
;(not (es_un_tipo_de ?a ?))
;(es_un_tipo_de ?b ?g)
;=>
;(bind ?cadeneta (str-cat "" ?a))
;(while (neq (str-index "_" ?cadeneta) FALSE) do
;    (bind ?espacio_a (str-index "_" ?cadeneta))
;    (bind ?primera_palabra_a (sub-string 1 (- ?espacio_a 1) ?cadeneta))
;    (if (and (neq ?primera_palabra_a "de") (neq ?primera_palabra_a "con") (neq (str-index ?primera_palabra_a ?b)FALSE)) then
;        (assert (es_un_tipo_de ?a ?g))
;    )
;    (bind ?borra (str-cat primera_palabra_a "_"))
;    (bind ?cadeneta (str-replace ?cadeneta "" ?borra ))
;)
;(if (and (neq(str-index ?cadeneta ?b)FALSE) (neq ?cadeneta "de") (neq ?cadeneta "con")) then
;    (assert(es_un_tipo_de ?a ?g))
;)    
;)


(defrule de_alimento_a_grupo
(declare (salience 10))
?f <- (es_alimento ?a)
(es_un_tipo_de ?x ?a)
=>
(assert (es_grupo_alimentos ?a))
(retract ?f)
)

(defrule retractar_grupo_como_alimento
(declare (salience 8))
?f <- (es_alimento ?g)
(es_grupo_alimentos ?g)
=>
(retract ?f)
)

(defrule retractar_grupos_sin_subgrupos
(declare (salience 9))
?f <- (es_grupo_alimentos ?g)
(not (es_un_tipo_de ? ?g))
=>
(retract ?f)
)

(defrule agrupando_por_nombre
(declare (salience 10))
(es_un_tipo_de ?a1 ?g)
(es_un_tipo_de ?a2 ?g)
(test (neq ?a1 ?a2))
(not (es_un_tipo_de ?a1 ?a2))
(not (es_un_tipo_de ?a2 ?a1))
=>
(bind ?espacio_a1 (str-index "_" ?a1))
(if ?espacio_a1 then 
   (bind ?primera_palabra_a1 (sym-cat (sub-string 1 (- ?espacio_a1 1) ?a1))) 
   (bind ?espacio_a2 (str-index "_" ?a2))
   (if ?espacio_a2 then 
      (bind ?primera_palabra_a2 (sym-cat (sub-string 1 (- ?espacio_a2 1) ?a2)))
	  ;(printout t "Intentando agrupar " ?a1 " " ?a2 crlf)
      ;(printout t "Primeras palabras respectivas " ?primera_palabra_a1 " " ?primera_palabra_a2 crlf)
      (if (eq (upcase ?primera_palabra_a1) (upcase ?primera_palabra_a2)) then 
         ;(printout t "Creando grupo " ?primera_palabra_a1 " con " ?a1 " y " ?a2 crlf) 
         (if (neq ?a1 ?primera_palabra_a1) then (assert (es_un_tipo_de ?a1 ?primera_palabra_a1)) (assert (es_un_tipo_de ?primera_palabra_a1 ?g))) 
         (if (neq ?a2 ?primera_palabra_a1) then (assert (es_un_tipo_de ?a2 ?primera_palabra_a1)) (assert (es_un_tipo_de ?primera_palabra_a1 ?g))) 
       )
	)   
)
)


(deffacts rico_en_proteinas
(propiedad rico_en_proteinas carne si)
(propiedad rico_en_proteinas pescado si)
(propiedad rico_en_proteinas huevos si)
(propiedad rico_en_proteinas embutidos si)
(propiedad rico_en_proteinas fiambres si)
(propiedad rico_en_proteinas lacteos si)
)

(deffacts rico_en_hidratos_carbono
(propiedad rico_en_hidratos_carbono cereales si)
(propiedad rico_en_hidratos_carbono frutos_secos si)
(propiedad rico_en_hidratos_carbono legumbres si)
(propiedad rico_en_hidratos_carbono cereales_integrales si)
)


(deffacts rico_fibras
(propiedad rico_fibras fruta si)
(propiedad rico_fibras verduras si)
(propiedad rico_fibras hortalizas si)
)

(deffacts rico_grasas
(propiedad rico_grasas carne_roja si)
(propiedad rico_grasas embutidos si)
(propiedad rico_grasas aceite_de_oliva si)
(propiedad rico_grasas queso si)
)

(deffacts rico_azucares
(propiedad rico_azucares dulces si)
(propiedad rico_azucares fruta si)
)




;;; Crear un fichero de texto recetas.txt en el mismo directorio de recetas.clp y compiar el contenido del archivo compartido

(defrule carga_recetas
(declare (salience 1000))
=>
(load-facts "/home/jesus/Segundo_cuatri/IC/Practica/Practica2/recetas.txt")
)


(defrule guarda_recetas
(declare (salience -1000))
=>
(save-facts "/home/jesus/Segundo_cuatri/IC/Practica/Practica2/recetas_saved.txt")
)

;;;EJERCICIO: Añadir reglas para  deducir tal y como tu lo harias (usando razonamiento basado en conocimiento):
;;;  1) cual o cuales son los ingredientes relevantes de una receta
;;;  2) modificar las recetas completando cual seria el/los tipo_plato asociados a una receta, 
;;;;;;;; especialmente para el caso de que no incluya ninguno
;;;  3) si una receta es: vegana, vegetariana, de dieta, picante, sin gluten o sin lactosa

;;;FORMATO DE LOS HECHOS: 
;  
;       (propiedad_receta ingrediente_relevante ?r ?a)
;       (propiedad_receta es_vegetariana ?r) 
;       (propiedad_receta es_vegana ?r)
;       (propiedad_receta es_sin_gluten ?r)
;       (propiedad_receta es_picante ?r)
;       (propiedad_receta es_sin_lactosa ?r)
;       (propiedad_receta es_de_dieta ?r)


;;;;;; EJERCICIO 1 ;;;;;;;;;;;;;;;;
;; Aqui extraemos los ingredientes de la receta 

(defrule extraer_ingredientes_receta
    ?receta <- (receta (nombre ?n) (ingredientes $?ig))
    =>
    (loop-for-count (?i 1 (length$ ?ig)) do
        (bind ?ingrediente (nth$ ?i ?ig))
        (assert (es_un_ingredinente_de ?ingrediente ?receta))
    )
)

(defrule incluir_ingredientes
(es_un_ingredinente_de ?i ?r)

=>
(assert (es_alimento ?i))
)



(defrule extraer_alimento_importante_en_el_nombre
    ?receta <- (receta (nombre ?n))
    (es_un_ingredinente_de ?i ?receta)
    (not (propiedad_receta ingrediente_relevante ?receta ?i))
    (test (neq (str-index ?i (str-cat (lowcase ?n)))FALSE))
    =>
    (assert (propiedad_receta ingrediente_relevante ?receta ?i))
)


(defrule extraer_nutriente_principal_de_mi_receta
?receta <- (receta (nombre ?n) (Proteinas ?p) (Grasa ?g) (Carbohidratos ?c) (Fibra ?f))
(not(propiedad_receta ? ?receta))
=>
(bind ?mayor (max ?p ?g ?c ?f))
(if(eq ?mayor ?p) then
    (assert (propiedad_receta rico_en_proteinas ?receta))
)
(if (eq ?mayor ?g) then
    (assert (propiedad_receta rico_grasas ?receta))
)
(if (eq ?mayor ?c) then
    (assert (propiedad_receta rico_en_hidratos_carbono ?receta))
)
(if (eq ?mayor ?f) then
    (assert (propiedad_receta rico_fibras ?receta))
)
)

(defrule alimento_importante_por_nutriente
(es_un_ingredinente_de ?i ?r)
(not (propiedad_receta ingrediente_relevante ?r ?i))
(propiedad_receta ?propiedad ?r)
(propiedad ?propiedad ?i si)
=>
    (assert (propiedad_receta ingrediente_relevante ?r ?i))
)

(defrule deducir_alimento_importante_por_mismo_tipo
(es_un_ingredinente_de ?i ?r)
(propiedad_receta ingrediente_relevante ?r ?ingrediente_importante)
(test (neq ?i ?ingrediente_importante))
(not(propiedad_receta ingrediente_relevante ?r ?i))
(es_un_tipo_de ?ingrediente_importante ?t)
(es_un_tipo_de ?i ?t)
=>
    (assert (propiedad_receta ingrediente_relevante ?r ?i))
)

;;;;;;;;; EJERCICIO 2 ;;;;;;;;;;;;;;;;

(defrule deducir_postre
?receta <- (receta (nombre ?nombre) (tipo_plato $?tipos))
(test (not (member$ postre $?tipos)))
(test (not (member$ plato_principal $?tipos)))
(test (not (member$ entrante $?tipos)))
(test (not (member$ primer_plato $?tipos)))
(propiedad_receta ingrediente_relevante ?receta ?ingrediente)
(or 
    (es_un_tipo_de ?ingrediente fruta)
    (es_un_tipo_de ?ingrediente dulces)
    (es_un_tipo_de ?ingrediente cereales)
    (test (neq(str-index "ostada" ?nombre)FALSE))
    (and (es_un_tipo_de ?ingrediente lacteos)(test(neq ?ingrediente queso)) (not (es_un_tipo_de ?ingrediente queso)))
    (test(eq ?ingrediente cafe))
    (test(eq ?ingrediente colacao))
    (test(eq ?ingrediente helado))

)
=> 
(modify ?receta (tipo_plato $?tipos postre))
)

(defrule deducir_desayuno_merienda
?receta <- (receta (nombre ?nombre) (tipo_plato $?tipos))
(test (not (member$ desayuno_merienda $?tipos)))
(test (not (member$ plato_principal $?tipos)))
(test (not (member$ entrante $?tipos)))
(test (not (member$ primer_plato $?tipos)))
(propiedad_receta ingrediente_relevante ?receta ?ingrediente)
(or
    (es_un_tipo_de ?ingrediente fruta)
    (es_un_tipo_de ?ingrediente dulces)
    (es_un_tipo_de ?ingrediente cereales)
    (test (neq(str-index "ostada" ?nombre)FALSE))
    (and (es_un_tipo_de ?ingrediente lacteos)(test(neq ?ingrediente queso)) (not (es_un_tipo_de ?ingrediente queso)))
    (test(eq ?ingrediente cafe))
    (test(eq ?ingrediente colacao))
)    
=> 
(modify ?receta (tipo_plato $?tipos desayuno_merienda))
)


(defrule deducir_acompanamiento
    ?receta <- (receta (nombre ?nombre) (tipo_plato $?tipos))
    (test (not (member$ acompanamiento $?tipos)))
    (propiedad_receta ingrediente_relevante ?receta ?ingrediente)
    (or 
        (test (neq (str-index "pan" ?nombre)FALSE))
        (test (neq (str-index "Pan" ?nombre)FALSE))
        (test (neq (str-index "nsalada" ?nombre)FALSE))
        (test (eq ?nombre "atatas fritas"))
        (test (eq ?ingrediente lechuga))
        (and (es_un_tipo_de ?ingrediente bebida)(test(neq ?ingrediente colacao)) (test (neq ?ingrediente cafe)))
        (es_un_tipo_de ?ingrediente frutos)
        (es_un_tipo_de ?ingrediente frutos_secos)
    )
    => 
    (modify ?receta (tipo_plato $?tipos acompanamiento))
)


(defrule deducir_entrante 
    ?receta <- (receta (nombre ?nombre) (tipo_plato $?tipos))
    (test (not (member$ entrante $?tipos)))
    (propiedad_receta ingrediente_relevante ?receta ?ingrediente)
    (or 
        (test (neq(str-index "sopa" ?nombre) FALSE))
        (test (neq(str-index "Sopa" ?nombre) FALSE))
        (es_un_tipo_de ?ingrediente fiambres)
        (es_un_tipo_de ?ingrediente caldo)
        (test(eq ?ingrediente queso))
    
    )
    => 
    (modify ?receta (tipo_plato $?tipos entrante))

)

(defrule deducir_primero
    ?receta <- (receta(nombre ?nombre)(tipo_plato $?tipos))
    (test (not (member$ primer_plato $?tipos)))
    (propiedad_receta ingrediente_relevante ?receta ?ingrediente)
    (or 
        (test (neq (str-index "Sopa" ?nombre)FALSE))
        (test (neq (str-index "sopa" ?nombre)FALSE))
        (test (neq (str-index "nsalada" ?nombre)FALSE))
        (es_un_tipo_de ?ingrediente verdura)
        (es_un_tipo_de ?ingrediente hortalizas)
        (es_un_tipo_de ?ingrediente legumbres)
        (es_un_tipo_de ?ingrediente pasta)
        (test (eq ?ingrediente pasta))
    )
    => 
    (modify ?receta (tipo_plato $?tipos primer_plato))
)

(defrule deducir_plato_principal
    ?receta <- (receta(nombre ?nombre)(tipo_plato $?tipos))
    (test (not (member$ plato_principal $?tipos)))
    (propiedad_receta ingrediente_relevante ?receta ?ingrediente)
    (or
        (es_un_tipo_de ?ingrediente legumbres)
        (es_un_tipo_de ?ingrediente pasta)
        (propiedad_receta rico_grasas ?receta)
    )
    => 
    (modify ?receta (tipo_plato $?tipos plato_principal))
)


;;;;;;;;;;;; EJERCICIO 3 ;;;;;;;;;;;;;;;;

;;Lo uso en vegetariano y vegana
(defrule tiene_carne_o_pescado
(declare (salience -1))
(es_un_ingredinente_de ?i ?r)
(not(propiedad_receta lleva_carne_o_pescado ?r))
(or (es_un_tipo_de ?i carne)(es_un_tipo_de ?i pescado)(es_un_tipo_de ?i embutidos) (es_un_tipo_de ?i fiambres) (es_un_tipo_de ?i carne_blanca) (es_un_tipo_de ?i carne_roja)) 
=>
(assert(propiedad_receta lleva_carne_o_pescado ?r))
)



;;Lo uso en vegano
(defrule producto_origen_animal
(declare(salience -1))
(es_un_ingredinente_de ?i ?r)
(not(propiedad_receta lleva_producto_animal ?r))
(or 
    (es_un_tipo_de ?i lacteos)
    (test(eq ?i huevos))
    (test(eq ?i huevo))
) 
=>
(assert(propiedad_receta lleva_producto_animal ?r))
)

;;Lo uso en sin gluten
(defrule receta_tiene_gluten
(declare(salience -1))
(es_un_ingredinente_de ?i ?r)
(not(propiedad_receta con_gluten ?r))
(es_un_tipo_de ?i cereales)
=>
(assert(propiedad_receta con_gluten ?r))
)


;;Lo uso en sin lactosa
(defrule receta_tiene_lactosa
(declare(salience -1))
(es_un_ingredinente_de ?i ?r)
(not(propiedad_receta con_lactosa ?r))
(or 
    (es_un_tipo_de ?i lacteos) 
    (test(eq ?i leche)) 
    (test(eq ?i queso)) 
    (test(eq ?i yogur)) 
    (test(eq ?i helado))
)
=>
(assert(propiedad_receta con_lactosa ?r))
)

;; Recetas sin gluten
(defrule receta_sin_gluten
(declare(salience -50))
?receta <- (receta(nombre ?n))
(not(propiedad_receta con_gluten ?receta))
=>
(assert(propiedad_receta es_sin_gluten ?receta))
)



;; Receta es vegana
(defrule receta_es_vegana
(declare (salience -50))
?receta <- (receta(nombre ?n))
(not(propiedad_receta lleva_producto_animal ?receta))
(not(propiedad_receta lleva_carne_o_pescado ?receta))
=> 
(assert (propiedad_receta es_vegana ?receta))
)

;; Receta es picante
(defrule receta_es_picante
(declare(salience -50))
(es_un_ingredinente_de ?i ?r)
(not(propiedad_receta es_picante ?r))
(es_un_tipo_de ?i picante)
=>
(assert(propiedad_receta es_picante ?r))
)

;; Receta es vegetariana
(defrule receta_es_vegetariana
(declare (salience -50))
?receta <- (receta(nombre ?n))
(not(propiedad_receta lleva_carne_o_pescado ?receta))
=>
(assert(propiedad_receta es_vegetariana ?receta))
)

;; Recetas sin lactosa 
(defrule receta_sin_lactosa
(declare(salience -50))
?receta <- (receta(nombre ?n))
(not(propiedad_receta con_lactosa ?receta))
=>
(assert(propiedad_receta es_sin_lactosa ?receta))
)

;; Receta es de dieta 
(defrule receta_es_de_dieta
(declare(salience -50))
?receta <-(receta (nombre ?n)(Grasa ?g)(Carbohidratos ?c)(numero_personas ?p)(Colesterol ?col))
(or 
    (propiedad_receta rico_fibras ?receta);;Si tiene mucha fibra es de dieta 
    (and ;;Dividimos haber si para una persona tiene poca grasa y colesterol y carbo
        (test (<(/ ?g ?p)10))
        (test (<(/ ?c ?p)15))
        (test (<(/ ?col ?p)40))
    )
)
=>
(assert(propiedad_receta es_de_dieta ?receta))
) 


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;Aqui empieza el programa principal de mi sistema experto simple (Practica 3);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defrule receta_tiene_frutos_secos
(declare(salience -1))
(es_un_ingredinente_de ?i ?r)
(not(propiedad_receta tiene_frutos_secos ?r))
(es_un_tipo_de ?i frutos_secos)
=>
(assert(propiedad_receta tiene_frutos_secos ?r))
)

(defrule receta_es_sin_frutos_secos
(declare(salience -50))
?receta <- (receta(nombre ?n))
(not(propiedad_receta tiene_frutos_secos ?receta))
=>
(assert(propiedad_receta es_sin_frutos_secos ?receta))
)
 
;;Mis razones para elegir esta receta

(deftemplate justificacion
(slot razon)
)

;Empieza en el -100 para que salga lo ultimo 

(defrule titulo
(declare (salience -100))
=>
(printout t crlf "Bienvenido a mi sistema experto simple" crlf)
(assert(modulo extraer_recetas_candidatas))
)

;Extramemos cnaditas
(defrule extraer_alimentos_candidatos
(declare (salience -100))
(modulo extraer_recetas_candidatas)
?receta <- (receta(nombre ?n))
=>
(assert(propiedad_receta es_candidata ?receta))
)

(defrule fin_alimentos_candidatos
(declare (salience -101))
(modulo extraer_recetas_candidatas)
?modulo <- (modulo extraer_recetas_candidatas)
=>
(retract ?modulo)
(assert(modulo preguntar_alergias))
)

(defrule extraer_alergias
(modulo preguntar_alergias)
?modulo <- (modulo preguntar_alergias)
=>
(bind ?respuesta(pregunta "Tiene alguna alergia" gluten lacteos frutos_secos no))
(if (eq ?respuesta no)
    then 
        (assert (modulo preguntar_vegetariano))
)
(if (eq ?respuesta lacteos)
    then 
        (assert (modulo alergia_lacteos))
)
(if (eq ?respuesta gluten)
    then 
        (assert (modulo alergia_gluten))
)
(if (eq ?respuesta frutos_secos)
    then 
        (assert (modulo alergia_frutos_secos))
)

(while (not (eq ?respuesta no)) do
    (bind  ?respuesta (pregunta "Alguna otra alergia" gluten lacteos frutos_secos no))
    (if (eq ?respuesta lacteos)
        then
            (assert (modulo alergia_lacteos))
    
    )
    (if (eq ?respuesta gluten)
        then
            (assert (modulo alergia_gluten))
    
    )
    (if (eq ?respuesta frutos_secos)
        then
            (assert (modulo alergia_frutos_secos))
    
    )

)

(retract ?modulo)
)

(defrule eliminar_alimentos_con_gluten
(declare (salience -100))
(modulo alergia_gluten)
?receta <- (receta(nombre ?n))
(propiedad_receta con_gluten ?receta)
(propiedad_receta es_candidata ?receta)
?borra <- (propiedad_receta es_candidata ?receta)
=>
(retract ?borra)
)

(defrule fin_alimentos_candidatos_alergia_al_gluten
(declare (salience -101))
(modulo alergia_gluten)
?modulo <- (modulo alergia_gluten)
=>
(assert(justificacion (razon "No tiene gluten")))
(retract ?modulo)
(assert(modulo preguntar_vegetariano))
)


(defrule eliminar_alimentos_con_lactosa
(declare (salience -100))
(modulo alergia_lacteos)
?receta <- (receta(nombre ?n))
(propiedad_receta con_lactosa ?receta)
(propiedad_receta es_candidata ?receta)
?borra <- (propiedad_receta es_candidata ?receta)
=>
(retract ?borra)
)

(defrule fin_alimentos_candidatos_alergia_a_la_lactosa
(declare (salience -101))
(modulo alergia_lacteos)
?modulo <- (modulo alergia_lacteos)
=>
(assert(justificacion (razon "No tiene lactosa")))
(retract ?modulo)
(assert(modulo preguntar_vegetariano))

)

(defrule eliminar_alimentos_con_frutos_secos
(declare (salience -100))
(modulo alergia_frutos_secos)
?receta <- (receta(nombre ?n))
(propiedad_receta tiene_frutos_secos ?receta)
(propiedad_receta es_candidata ?receta)
?borra <- (propiedad_receta es_candidata ?receta)
=>
(retract ?borra)
)

(defrule fin_alimentos_candidatos_alergia_a_los_frutos_secos
(declare (salience -101))
(modulo alergia_frutos_secos)
?modulo <- (modulo alergia_frutos_secos)
=>
(assert(justificacion (razon "No tiene frutos secos")))
(retract ?modulo)
(assert(modulo preguntar_vegetariano))

)

;Ahora aqui preguntamos si es vegetariano o vegano
(defrule pregunta_si_es_vegetariano_o_vegano
(declare (salience -102))
(modulo preguntar_vegetariano)
?modulo <- (modulo preguntar_vegetariano)
=>
(bind ?respuesta (pregunta "Eres vegetariano o vegano" vegetariano vegano no))
(if (eq ?respuesta no)
    then
        (assert (modulo quiere_dieta))

)
(if (eq ?respuesta vegano)
    then
        (assert (modulo es_vegano))

)
(if (eq ?respuesta vegetariano)
    then
        (assert (modulo es_vegetariano))

)
(retract ?modulo)

)

(defrule eliminar_alimentos_no_vegetarianos
(declare (salience -100))
?receta <- (receta(nombre ?n))
(modulo es_vegetariano)
(propiedad_receta lleva_carne_o_pescado ?receta)
(propiedad_receta es_candidata ?receta)
?borra <- (propiedad_receta es_candidata ?receta)
=>
(retract ?borra)
)

(defrule fin_alimentos_no_vegetarianos
(declare (salience -101))
(modulo es_vegetariano)
?modulo <- (modulo es_vegetariano)
=>
(assert(justificacion (razon "Es vegetariano")))
(retract ?modulo)
(assert(modulo quiere_dieta))
)

(defrule eliminar_alimentos_no_veganos
(declare (salience -100))
?receta <- (receta(nombre ?n))
(modulo es_vegano)
(not (propiedad_receta lleva_carne_o_pescado ?receta))
(not (propiedad_receta lleva_producto_animal ?receta))
(propiedad_receta es_candidata ?receta)
?borra <- (propiedad_receta es_candidata ?receta)
=>
(retract ?borra)
)

(defrule fin_alimentos_no_veganos
(declare (salience -101))
(modulo es_vegano)
?modulo <- (modulo es_vegano)
=>
(assert(justificacion (razon "Es vegana")))
(retract ?modulo)
(assert(modulo quiere_dieta))
)

(defrule ver_si_hay_de_dieta
(declare (salience -102))
(modulo quiere_dieta)
?modulo <- (modulo quiere_dieta)
?receta <- (receta(nombre ?n))
(propiedad_receta es_candidata ?receta)
(propiedad_receta es_candidata ?receta2);Para ver si hay dos o mas recetas de dieta
(test (neq ?receta ?receta2))
=>
(retract ?modulo)
(assert(modulo hay_de_dieta))
)

(defrule no_hay_dieta
(declare (salience -103))
(modulo quiere_dieta)
?modulo <- (modulo quiere_dieta)
=>
(retract ?modulo)
(assert(modulo mirar_dificultad))
)

;Preguntar si quiere que sea de dieta o no
(defrule pregunta_si_quiere_de_dieta
(modulo hay_de_dieta)
?modulo <- (modulo hay_de_dieta)
=>
(bind ?respuesta (pregunta "Quieres que sea de dieta" si no))
(if (eq ?respuesta si)
    then
        (assert (modulo eliminar_los_no_dieteticos))

)
(if (eq ?respuesta no)
    then
        (assert (modulo mirar_dificultad))
)
(retract ?modulo)
)


;Eliminar los recetas que no sean de dieta
(defrule eliminamos_los_no_dieteticos
(declare (salience -100))
?receta <- (receta(nombre ?n))
(modulo eliminar_los_no_dieteticos)
(propiedad_receta es_candidata ?receta)
(not(propiedad_receta es_de_dieta ?receta))
?borra <- (propiedad_receta es_candidata ?receta)
=>
(retract ?borra)
)

(defrule fin_alimentos_no_dieteticos
(declare(salience -101))
(modulo eliminar_los_no_dieteticos)
?modulo <- (modulo eliminar_los_no_dieteticos)
=>
(assert(justificacion (razon "Es de dieta")))
(retract ?modulo)
(assert(modulo mirar_dificultad))
)

(defrule mirar_dificultad
(modulo mirar_dificultad)
?modulo <- (modulo mirar_dificultad)
=>
(retract ?modulo)
(assert(modulo muy_baja))
(assert(modulo baja))
(assert(modulo media))
(assert(modulo alta))
)

(defrule ver_si_hay_muy_baja
(declare (salience -100))
(modulo muy_baja)
?modulo <- (modulo muy_baja)
?receta <- (receta(nombre ?n)(dificultad ?d))
(test (eq ?d muy_baja))
(propiedad_receta es_candidata ?receta)
=>
(retract ?modulo)
(assert(modulo hay_muy_baja))
)

(defrule ver_si_hay_baja
(declare (salience -100))
(modulo baja)
?modulo <- (modulo baja)
?receta <- (receta(nombre ?n)(dificultad ?d))
(test (eq ?d baja))
(propiedad_receta es_candidata ?receta)
=>
(retract ?modulo)
(assert(modulo hay_baja))
)

(defrule ver_si_hay_media
(declare (salience -100))
(modulo media)  
?modulo <- (modulo media)
?receta <- (receta(nombre ?n)(dificultad ?d))
(test (eq ?d media))
(propiedad_receta es_candidata ?receta)
=>
(retract ?modulo)
(assert(modulo hay_media))
)

(defrule ver_si_hay_alta
(declare (salience -100))
(modulo alta)
?modulo <- (modulo alta)
?receta <- (receta(nombre ?n)(dificultad ?d))
(test (eq ?d alta))
(propiedad_receta es_candidata ?receta)
=>
(retract ?modulo)
(assert(modulo hay_alta))
)

;Preguntar solamente si hay de todas las dificultades
(defrule no_hay_de_todas
(declare (salience -101))
(or(modulo muy_baja)(modulo baja)(modulo media)(modulo alta))
=>
(assert(modulo borramos_modulos_dificultades))
)

(defrule borrar_muy_facil
(declare (salience -102))
(modulo muy_baja)
?modulo <- (modulo muy_baja)
(modulo borramos_modulos_dificultades)
=>
(retract ?modulo)
)

(defrule borrar_facil
(declare (salience -102))
(modulo baja)
?modulo <- (modulo baja)
(modulo borramos_modulos_dificultades)
=>
(retract ?modulo)
)

(defrule borrar_media
(declare (salience -102))
(modulo media)
?modulo <- (modulo media)
(modulo borramos_modulos_dificultades)
=>
(retract ?modulo)
)

(defrule borrar_dificil
(declare (salience -102))
(modulo alta)
?modulo <- (modulo alta)
(modulo borramos_modulos_dificultades)
=>
(retract ?modulo)
)

(defrule fin_borrar_dificultades
(declare (salience -104))
(modulo borramos_modulos_dificultades)
?modulo <- (modulo borramos_modulos_dificultades)
=>
(retract ?modulo)
(assert(modulo mas_de_1_candidato))
)

(defrule preguntar_dificultad
(modulo hay_muy_baja)
(modulo hay_baja)
(modulo hay_media)
(modulo hay_alta)
?modulo1 <- (modulo hay_muy_baja)
?modulo2 <- (modulo hay_baja)
?modulo3 <- (modulo hay_media)
?modulo4 <- (modulo hay_alta)
=>
(bind ?respuesta (pregunta "¿Quiere una dificultad en específico?" muy_baja baja media alta no))
(if (eq ?respuesta no)
    then
        (assert (modulo mas_de_1_candidato))
)
(if (eq ?respuesta muy_baja)
    then
        (assert (modulo quedarse_con_las_muy_bajas))
)
(if(eq ?respuesta baja)
    then
        (assert (modulo quedarse_con_las_bajas))
)
(if(eq ?respuesta media)
    then
        (assert (modulo quedarse_con_las_medias))
)
(if(eq ?respuesta alta)
    then
        (assert (modulo quedarse_con_las_altas))
)

(retract ?modulo1)
(retract ?modulo2)
(retract ?modulo3)
(retract ?modulo4)
)
 
(defrule eliminamos_los_no_muy_faciles
(declare (salience -100))
(modulo quedarse_con_las_muy_bajas)
?receta <- (receta(nombre ?n)(dificultad ?d))
(test (neq ?d muy_baja))
(propiedad_receta es_candidata ?receta)
?borra <- (propiedad_receta es_candidata ?receta)
=>
(retract ?borra)
)

(defrule fin_alimentos_muy_faciles
(declare (salience -101))
(modulo quedarse_con_las_muy_bajas)
?modulo <- (modulo quedarse_con_las_muy_bajas)
=>
(assert(justificacion (razon "Es muy baja de dificultad")))
(retract ?modulo)
(assert(modulo mas_de_1_candidato))
)

(defrule eliminamos_los_no_faciles
(declare (salience -100))
(modulo quedarse_con_las_bajas)
?receta <- (receta(nombre ?n)(dificultad ?d))
(test (neq ?d baja))
(propiedad_receta es_candidata ?receta)
?borra <- (propiedad_receta es_candidata ?receta)
=>
(retract ?borra)
)

(defrule fin_alimentos_faciles
(declare (salience -101))
(modulo quedarse_con_las_bajas)
?modulo <- (modulo quedarse_con_las_bajas)
=>
(assert(justificacion (razon "Es baja de dificultad")))
(retract ?modulo)
(assert(modulo mas_de_1_candidato))
)

(defrule eliminamos_los_no_medias
(declare (salience -100))
(modulo quedarse_con_las_medias)
?receta <- (receta(nombre ?n)(dificultad ?d))
(test (neq ?d media))
(propiedad_receta es_candidata ?receta)
?borra <- (propiedad_receta es_candidata ?receta)
=>
(retract ?borra)
)

(defrule fin_alimentos_medios
(declare (salience -101))
(modulo quedarse_con_las_medias)
?modulo <- (modulo quedarse_con_las_medias)
=>
(assert(justificacion (razon "Es media de dificultad")))
(retract ?modulo)
(assert(modulo mas_de_1_candidato))
)

(defrule eliminamos_los_no_altas
(declare(salience -100))
(modulo quedarse_con_las_altas)
?receta <- (receta(nombre ?n)(dificultad ?d))
(test (neq ?d alta))
(propiedad_receta es_candidata ?receta)
?borra <- (propiedad_receta es_candidata ?receta)
=>
(retract ?borra)
)

(defrule fin_alimentos_muy_altos
(declare (salience -101))
(modulo quedarse_con_las_altas)
?modulo <- (modulo quedarse_con_las_altas)
=>
(assert(justificacion (razon "Es alta de dificultad")))
(retract ?modulo)
(assert(modulo mas_de_1_candidato))
)

;Comprobar más de 1 candidato nuevamente

(defrule ver_si_hay_mas_de_1_candidato
(declare (salience -100))
(modulo mas_de_1_candidato)
?modulo <- (modulo mas_de_1_candidato)
(propiedad_receta es_candidata ?receta1)
(propiedad_receta es_candidata ?receta2)
(test (neq ?receta1 ?receta2))
=>
(retract ?modulo)
(assert(modulo preguntar_alimentos))
)

(defrule no_hay_mas_de_1_candidato
(declare (salience -101))
(modulo mas_de_1_candidato)
?modulo <- (modulo mas_de_1_candidato)
=>
(retract ?modulo)
(assert(modulo establecer_ese_candidato))
)

(defrule elegir_candidato_unico
(modulo establecer_ese_candidato)
?modulo <- (modulo establecer_ese_candidato)
(propiedad_receta es_candidata ?receta)
?borra <- (propiedad_receta es_candidata ?receta)
=>
(retract ?modulo)
(assert(propiedad_receta es_elegida ?receta))
(retract ?borra)
(assert(modulo anunciar_elegido))
)

;preguntar alimentos que tiene disponibles para seguir quitando candidatos

(defrule preguntarle_alimentos
(modulo preguntar_alimentos)
?modulo <- (modulo preguntar_alimentos)
=>
(printout t "¿Que ingredientes tienes disponible, SI QUIRE FINALIZAR PONGA - ya -? ")
(bind ?respuesta (read))
(if(eq ?respuesta ya)
    then
        (assert (modulo elegir_por_calorias))
)
(if(neq ?respuesta ya)
    then
        (assert (es_alimento_del_usuario ?respuesta))
        (while (neq ?respuesta ya) do
            (printout t "¿Alguno más?" crlf)
            (bind ?respuesta (read))
            (if(neq ?respuesta ya)
                then
                    (assert (es_alimento_del_usuario ?respuesta))
            )
        )
        (assert(modulo calcular_valor_alimentos_proporcionados))    
)
)

(defrule elegimos_por_calorias
(modulo elegir_por_calorias)
?modulo <- (modulo elegir_por_calorias)
(propiedad_receta es_candidata ?receta)
?borra <- (propiedad_receta es_candidata ?receta)
=>
(assert(propiedad_receta es_elegida ?receta))
(retract ?borra)
(retract ?modulo)
(assert(modulo buscar_la_menos_calorica))
)

(defrule buscamos_la_menos_calorica
(declare (salience -100))
(modulo buscar_la_menos_calorica)
?r1 <- (receta(nombre ?n1)(numero_personas ?p1)(Calorias ?c1))
?r2 <- (receta(nombre ?n2)(numero_personas ?p2)(Calorias ?c2))
(propiedad_receta es_elegida ?r1)
(propiedad_receta es_candidata ?r2)
?borra1 <- (propiedad_receta es_elegida ?r1)
?borra2 <- (propiedad_receta es_candidata ?r2)
(test (neq ?r1 ?r2))
=>
(if(> (/ ?c1 ?p1) (/ ?c2 ?p2))
    then
        (retract ?borra1)
        (assert(propiedad_receta es_elegida ?r2))
        (retract ?borra2)
        (assert(propiedad_receta es_candidata ?r1))

)
)

(defrule fin_menos_calorica
(declare (salience -101))
(modulo buscar_la_menos_calorica)
?borra <- (modulo buscar_la_menos_calorica)
=>
(retract ?borra)
(assert(modulo anunciar_elegido))
(assert(modulo preguntar_anunciar_alternativas))
(assert(justificacion (razon "La receta elegida es la menos calorica")))
)

(defrule calcular_valor_alimentos
(declare (salience -100))
(modulo calcular_valor_alimentos_proporcionados)
?receta <- (receta(nombre ?n)(ingredientes $?ig))
(propiedad_receta es_candidata ?receta)
(not(propiedad_receta valor_ingredientes ?receta))
=>
(bind ?valor(* (length$ ?ig)-1))
(assert(propiedad_receta valor_ingredientes ?receta ?valor))
)

(defrule fin_calcular_valor_alimentos
(declare (salience -101))
(modulo calcular_valor_alimentos_proporcionados)
?modulo <- (modulo calcular_valor_alimentos_proporcionados)
=>
(retract ?modulo)
(assert(modulo recalcular_valor_ingredientes))
)

(defrule recalcular_valor_ingredientes
(declare (salience -100))
(modulo recalcular_valor_ingredientes)
?receta <- (receta(nombre ?n))
(propiedad_receta es_candidata ?receta)
(es_un_ingredinente_de ?i ?receta)
(not(propiedad_receta ingrediente_relevante ?receta ?i))
(es_alimento_del_usuario ?i)
(propiedad_receta valor_ingredientes ?receta ?v)
?h <- (propiedad_receta valor_ingredientes ?receta ?v)
(not(ingrediente_tratado ?r ?i))
=>
(bind ?nv (+ ?v 1))
(retract ?h)
(assert(propiedad_receta valor_ingredientes ?receta ?nv))
(assert(ingrediente_tratado ?receta ?i))
)

(defrule recalcular_valor_alimentos_importantes
(declare (salience -100))
(modulo recalcular_valor_ingredientes)
?receta <- (receta(nombre ?n))
(propiedad_receta es_candidata ?receta)
(es_un_ingredinente_de ?i ?receta)
(propiedad_receta ingrediente_relevante ?receta ?i)
(es_alimento_del_usuario ?i)
(propiedad_receta valor_ingredientes ?receta ?v)
?h <- (propiedad_receta valor_ingredientes ?receta ?v)
(not(ingrediente_tratado ?receta ?i))
=>
(bind ?nv (+ ?v 2))
(retract ?h)
(assert(propiedad_receta valor_ingredientes ?receta ?nv))
(assert(ingrediente_tratado ?receta ?i))
)

(defrule fin_recalcular_valor_alimentos
(declare (salience -101))
(modulo recalcular_valor_ingredientes)
?modulo <- (modulo recalcular_valor_ingredientes)
?receta <- (receta(nombre ?n))
(propiedad_receta es_candidata ?receta)
?c <- (propiedad_receta es_candidata ?receta)
(propiedad_receta valor_ingredientes ?receta ?)
=>
(retract ?modulo)
(retract ?c)
(assert(propiedad_receta es_elegida ?receta))
(assert(modulo calcular_mejor_por_ingredientes))
)

(defrule buscamos_la_mejor_por_ingredientes
(declare (salience -100))
(modulo calcular_mejor_por_ingredientes)
(propiedad_receta es_candidata ?receta2)
(propiedad_receta es_elegida ?receta1)
(propiedad_receta valor_ingredientes ?receta1 ?v1)
(propiedad_receta valor_ingredientes ?receta2 ?v2)
?borra1 <- (propiedad_receta es_elegida ?receta1)
?borra2 <- (propiedad_receta es_candidata ?receta2)
(test (neq ?receta1 ?receta2))
=>
(if(< ?v1 ?v2)
    then
        (retract ?borra1)
        (retract ?borra2)
        (assert(propiedad_receta es_elegida ?receta2))
        (assert(propiedad_receta es_candidata ?receta1))

)
)

(defrule fin_mejor_por_ingredientes
(declare (salience -101))
(modulo calcular_mejor_por_ingredientes)
?borra <- (modulo calcular_mejor_por_ingredientes)
=>
(retract ?borra)
(assert(modulo anunciar_elegido))
(assert(modulo anunciar_alternativas))
(assert(justificacion (razon " La receta que menos ingredientes necesitas comprar")))
)

(defrule imprimir_alternativas
(declare(salience -150))
(modulo anunciar_alternativas)
?receta <- (receta(nombre ?n))
(propiedad_receta es_candidata ?receta)
=>
(printout t " La receta " ?n " es una alternativa" crlf)
)

(defrule imprimir_elegido
(declare(salience -149))
(modulo anunciar_elegido)
?receta <- (receta(nombre ?n))
(propiedad_receta es_elegida ?receta)
=>
(printout t " La receta " ?n " es la elegida" crlf)
(bind ?justificaciones (find-all-facts ((?j justificacion))TRUE))
(printout t "Justificaciones:" crlf)
(do-for-all-facts ((?j justificacion))TRUE
(printout t "    " ?j:razon crlf)

)
)

