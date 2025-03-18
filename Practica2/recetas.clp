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


;;; Crear un fichero de texto recetas.txt en el mismo directorio de recetas.clp y compiar el contenido del archivo compartido

(defrule carga_recetas
(declare (salience 1000))
=>
(load-facts "recetas.txt")
)


(defrule guarda_recetas
(declare (salience -1000))
=>
(save-facts "recetas_saved.txt")
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


(defrule determinar_ingredientes_relevantes
    (receta (nombre ?r) (ingredientes $? ?ingrediente $?))
    (test (member$ ?ingrediente (create$ "pollo" "carne" "pescado" "huevo" "leche" "queso" "soja" "azucar" "mantequilla" "picante" "gluten")))
=>
    (assert (propiedad_receta ingrediente_relevante ?r ?ingrediente)))

(defrule asignar_tipo_plato
    (receta (nombre ?r) (tipo_plato $?tp) (ingredientes $?ing))
    (test (eq (length$ ?tp) 0))  ;; Si la lista de tipo_plato está vacía
=>
    (bind ?tipo (if (member$ "azucar" ?ing) then "postre" else "plato_principal"))
    (assert (propiedad_receta tipo_plato ?r ?tipo)))


(defrule es_vegetariana_receta
    (receta (nombre ?r) (ingredientes $?ing))
    (not (test (or (member$ "pollo" ?ing) (member$ "carne" ?ing) (member$ "pescado" ?ing))))
=>
    (assert (propiedad_receta es_vegetariana ?r)))


(defrule es_vegana_receta
    (receta (nombre ?r) (ingredientes $?ing))
    (not (test (or (member$ "pollo" ?ing) (member$ "carne" ?ing) (member$ "pescado" ?ing) 
                   (member$ "huevo" ?ing) (member$ "leche" ?ing) (member$ "queso" ?ing) 
                   (member$ "mantequilla" ?ing))))
=>
    (assert (propiedad_receta es_vegana ?r)))


(defrule es_sin_gluten_receta
    (receta (nombre ?r) (ingredientes $?ing))
    (not (test (member$ "gluten" ?ing)))
=>
    (assert (propiedad_receta es_sin_gluten ?r)))


(defrule es_sin_lactosa_receta
    (receta (nombre ?r) (ingredientes $?ing))
    (not (test (or (member$ "leche" ?ing) (member$ "queso" ?ing) (member$ "mantequilla" ?ing))))
=>
    (assert (propiedad_receta es_sin_lactosa ?r)))

(defrule es_picante_receta
    (receta (nombre ?r) (ingredientes $?ing))
    (test (member$ "picante" ?ing))
=>
    (assert (propiedad_receta es_picante ?r)))

(defrule es_de_dieta_receta
    (receta (nombre ?r) (Grasa ?g) (Carbohidratos ?c))
    (test (and (< ?g 10) (< ?c 20)))  
=>
    (assert (propiedad_receta es_de_dieta ?r)))

 (defrule listar_alimentos_receta
     (receta (nombre ?n) (ingredientes $?ig))
     =>
     (printout t crlf "Receta: "?n)
     (bind ?i 1)
     (bind ?num-ingredientes (length$ ?ig))   
   
    (while (<= ?i ?num-ingredientes) do
       (bind ?ingrediente (nth$ ?i ?ig))
       (printout t crlf ?ingrediente)
       (bind ?i (+ ?i 1)) 
    )  
 )



 

 
