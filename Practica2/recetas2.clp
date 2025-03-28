;Ejercicio 2
;plantilla de la receta
(deftemplate receta
   (slot nombre) ; necesario
   (slot introducido_por) ; necesario
   (slot numero_personas) ; necesario
   (multislot ingredientes) ; necesario
   (slot dificultad (allowed-symbols alta media baja muy_baja)) ; necesario, y con errata :(
   (slot duracion) ; necesario
   (slot enlace) ; necesario
   (multislot tipo_plato (allowed-symbols entrante primer_plato plato_principal postre desayuno_merienda acompanamiento)) ; necesario, introducido o deducido en este ejercicio
   (slot coste) ; opcional relevante
   (slot tipo_copcion (allowed-symbols crudo cocido a_la_plancha frito al_horno al_vapor)) ; opcional
   (multislot tipo_cocina) ;opcional
   (slot temporada) ; opcional
;;;; Estos slot se calculan, se haria mediante un algoritmo que no vamos a implementar para
este prototipo, lo usamos con la herramienta indicada y lo introducimos
   (slot Calorias) ; calculado necesario
   (slot Proteinas) ; calculado necesario
   (slot Grasa) ; calculado necesario
   (slot Carbohidratos) ; calculado necesario
   (slot Fibra) ; calculado necesario
   (slot Colesterol) ; calculado necesario
)

;;; Crear un fichero de texto recetas.txt en el mismo directorio de recetas.clp y compiar el
contenido del archivo compartido
(defrule carga_recetas
   (declare (salience 1000))
   =>
   (load-facts "recetas.txt")
)

;no le veo mucho sentido a esto ya que se borra las recetas originales,lo cambio
;aunque para usarlo en el ejercicio 3 haria el programa mas rapido ya que ya habria
deducido todo de las recetas
(defrule guarda_recetas
   (declare (salience -1000))
   =>
   (save-facts "hechos.txt")
)

;;; FUNCIONES "UTILES"
;pongo new porque pone que ya existe una str-replace
(deffunction new-str-replace(?str ?rpl ?fnd)
   (if (eq ?fnd "") then (return ?str))
   (bind ?rv "")
   (bind ?i (str-index ?fnd ?str))
   (while ?i
      (bind ?rv (str-cat ?rv (sub-string 1 (- ?i 1) ?str) ?rpl))
      (bind ?str (sub-string (+ ?i (str-length ?fnd)) (str-length ?str) ?str))
      (bind ?i (str-index ?fnd ?str)))
   (bind ?rv (str-cat ?rv ?str)))
   (return ?rv)
)

(deffunction pregunta (?pregunta $?valores-permitidos)
   (progn$
      (?var ?valores-permitidos)
      (lowcase ?var))
   (format t "¿%s? (%s) " ?pregunta (implode$ ?valores-permitidos)) 
   (bind ?respuesta (read))
   (while (not (member$ (lowcase ?respuesta) ?valores-permitidos)) do
      (format t "¿%s? (%s) " ?pregunta (implode$ ?valores-permitidos))
      (bind ?respuesta (read))
   )
   ?respuesta
)

;;;; Concocimiento general, tanto de las plantillas y algo nuevo
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
   (es_un_tipo_de ternera carne_roja)
   (es_un_tipo_de cerdo carne_roja)
   (es_un_tipo_de cordero carne_roja)
   (es_un_tipo_de carne_blanca carne)
   (es_un_tipo_de pollo carne_blanca)
   (es_un_tipo_de conejo carne_blanca)
   (es_un_tipo_de leche lacteos)
   (es_un_tipo_de queso lacteos)
   (es_un_tipo_de yogur lacteos)
   (es_un_tipo_de atun pescado)
   (es_un_tipo_de salmon pescado)
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
   (es_un_tipo_de aceitunas_rojas frutos)
   (es_un_tipo_de macarrones pasta)
   (es_un_tipo_de espaguetis pasta)
   (es_un_tipo_de pimienta picante)
   (es_un_tipo_de pimenton picante)
   (es_un_tipo_de salsa_picante picante)
   (es_un_tipo_de guindillas picante)
   (es_un_tipo_de bistec carne)
   (es_un_tipo_de solomillo carne)
   (es_un_tipo_de lomo carne)
   (es_un_tipo_de pechuga carne)
   (es_un_tipo_de pato carne)
   (es_un_tipo_de pavo carne)
   (es_un_tipo_de camarones pescado)
   (es_un_tipo_de langostino pescado)
   (es_un_tipo_de bacalao pescado)
   (es_un_tipo_de chocolate lacteo)
   (es_un_tipo_de arroz cereales)
   (es_un_tipo_de fruta coco)
)

(deffacts es_un_tipo_de_condimento
   (es_un_tipo_de especies condimento)
   (es_un_tipo_de caldo condimento)
   (es_un_tipo_de vino condimento)
   (es_un_tipo_de aceite condimento)
   (es_un_tipo_de ajo condimento)
   (es_un_tipo_de salsa condimento)
   (es_un_tipo_de bebida condimento)
   (es_un_tipo_de salsa_picante condimento)
   (es_un_tipo_de guindillas condimento)
)

(deffacts bebidas
   (es_un_tipo_de cognac bebida)
   (es_un_tipo_de vino bebida)
   (es_un_tipo_de cerveza bebida)
   (es_un_tipo_de agua bebida)
   (es_un_tipo_de cafe bebida)
   (es_un_tipo_de colacao bebida)
)

(deffacts especias
   (es_un_tipo_de sal especies)
   (es_un_tipo_de azafran especies)
   (es_un_tipo_de laurel especies)
   (es_un_tipo_de curry especies)
   (es_un_tipo_de curcuma especies)
)

;ponemos mas prioridad a las deducciones por defecto ya que son la mas correctas y se
pueden pisar con las nuevas
(defrule componiendo_es_un_tipo_de
   (declare (salience 10))
   (es_un_tipo_de ?x ?y)
   (es_un_tipo_de ?y ?z)
   =>
   (assert (es_un_tipo_de ?x ?z))
)

(deffacts hecho_de
   (compuesto_fundamentalmente_por pan harina)
   (compuesto_fundamentalmente_por pasta harina)
   (compuesto_fundamentalmente_por pizza harina)
)

(defrule compuesto_fundamentalmente_por_entonces_es_un_tipo_de
   (declare (salience 10))
   (compuesto_fundamentalmente_por ?x ?y)
   =>
   (assert (es_un_tipo_de ?x ?y))
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

;funciones parecida a deducir_es_un_tipo_de, pero esta si funciona y es mas completa
;puede llegar a cometer errores puntuales, como por ejemplo solomillo_de_pollo puede
llegar a ponerlo como caldo por el
;caldo_de_pollo
;lo mejor seria ir mirando palabra por palabra del alimento y ver si pertenece a un tipo
mirando todos los tipos posibles,
;pero clips es tan broza y tiene tan poca documentacion que tardaria varios en hacerla, ya
solo estas me llevaron mucho tiempoS
;esta trata de encontrar un tipo a un alimento que no tiene buscando en los tipos, por
ejemplo si tenemos carne_de_cerdo y el
;tipo carne deducira que es un tipo de carne
(defrule deducir_es_un_tipo_de_por_grupo
   (es_grupo_alimentos ?g)
   (or (es_alimento ?a) (es_grupo_alimentos ?a))
   (not (es_un_tipo_de ?a ?))
   (test (neq ?a ?g))
   =>
   (bind ?cadena (str-cat "" ?a))
   (while (neq (str-index "_" ?cadena) FALSE) do
      (bind ?espacio_a (str-index "_" ?cadena))
      (bind ?primera_palabra_a (sub-string 1 (- ?espacio_a 1) ?cadena))
      (if (and (neq ?primera_palabra_a "de") (neq ?primera_palabra_a "con")
         (neq (str-index ?primera_palabra_a ?g) FALSE))
         then
         (assert (es_un_tipo_de ?a ?g))
      )
      (bind ?borra (str-cat ?primera_palabra_a "_"))
      (bind ?cadena (new-str-replace ?cadena "" ?borra))
   )
   (if (and (neq ?cadena "de") (neq ?cadena "con")
      (neq (str-index ?cadena ?g) FALSE))
      then
      (assert (es_un_tipo_de ?a ?g))
   )
)

;funcion como la anterior, pero en este caso mira los alimentos. Por ejemplo si está salmon_ahumado, que no
;está en la base de conocimento, deduce que es un pescado
;tiene mas prioridad ya que los alimentos se van a parecer más a otro alimento que a un grupo
(defrule deducir_es_un_tipo_de_por_alimento
   (declare (salience 1))
   (es_alimento ?a)
   (es_alimento ?b)
   (test (neq ?a ?b))
   (not (es_un_tipo_de ?a ?))
   (es_un_tipo_de ?b ?g)
   =>
   (bind ?cadena (str-cat "" ?a))
   (while (neq (str-index "_" ?cadena) FALSE) do
      (bind ?espacio_a (str-index "_" ?cadena))
      (bind ?primera_palabra_a (sub-string 1 (- ?espacio_a 1) ?cadena))
      (if (and (neq ?primera_palabra_a "de") (neq ?primera_palabra_a "con")
         (neq (str-index ?primera_palabra_a ?b) FALSE))
         then
         (assert (es_un_tipo_de ?a ?g))
      )
      (bind ?borra (str-cat ?primera_palabra_a "_"))
      (bind ?cadena (new-str-replace ?cadena "" ?borra))
   )
   (if (and (neq ?cadena "de") (neq ?cadena "con")
      (neq (str-index ?cadena ?b) FALSE))
      then
      (assert (es_un_tipo_de ?a ?g))
   )
)

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
         (if (eq (upcase ?primera_palabra_a1) (upcase ?primera_palabra_a2)) then
            (if (neq ?a1 ?primera_palabra_a1) then
               (assert (es_un_tipo_de ?a1 ?primera_palabra_a1))
               (assert (es_un_tipo_de ?primera_palabra_a1 ?g))
            )
            (if (neq ?a2 ?primera_palabra_a1) then
               (assert (es_un_tipo_de ?a2 ?primera_palabra_a1))
               (assert (es_un_tipo_de ?primera_palabra_a1 ?g))
            )
         )
      )
   )
)

(deffacts rico_en_proteinas
   (propiedad rico_en_proteinas carne si)
   (propiedad rico_en_proteinas pescado si)
   (propiedad rico_en_proteinas huevos si)
   (propiedad rico_en_proteinas lacteos si)
)

(deffacts rico_en_hidratos_de_carbono
   (propiedad rico_en_hidratos cereales si)
   (propiedad rico_en_hidratos frutos_secos si)
   (propiedad rico_en_hidratos legumbres si)
)

(deffacts rico_en_fibras
   (propiedad rico_en_fibras fruta si)
   (propiedad rico_en_fibras verdura si)
   (propiedad rico_en_fibras hortalizas si)
   (propiedad rico_en_fibras hortalizas si)
)

(deffacts rico_en_grasas
   (propiedad rico_en_grasas carne_roja si)
   (propiedad rico_en_grasas embutidos si)
   (propiedad rico_en_grasas aceite_de_oliva si)
   (propiedad rico_en_grasas queso si)
)

(deffacts rico_en_azucares
   (propiedad rico_en_azucares dulces si)
   (propiedad rico_en_azucares fruta si)
)

(defrule herencia_propiedades
   (declare (salience 10))
   (propiedad ?p ?a ?v)
   (es_un_tipo_de ?x ?a)
   =>
   (assert (propiedad ?p ?x ?v))
)

;;;EJERCICIO: Añadir reglas para deducir tal y como tu lo harias (usando razonamiento
basado en conocimiento):
;;; 1) cual o cuales son los ingredientes relevantes de una receta
;extraemos todos los ingredientes de la receta y lo guardamos como hechos
(defrule extraer_ingredientes_receta
   ?receta <- (receta (nombre ?n) (ingredientes $?ingredientes))
   =>
   (loop-for-count (?i 1 (length$ ?ingredientes))
      (bind ?ingrediente (nth$ ?i ?ingredientes))
      (assert (es_un_ingrediente_de ?ingrediente ?receta))
   )
)

;guardamos los ingredientes como alimentos, para ver si es nuevo de que tipo es, por ejemplo carne_vacuno
;que no esta en la base de conocimiento, ver que es un tipo de carne gracias a las funciones que cree anteriormente
(defrule incluir_ingredientes
   (es_un_ingrediente_de ?ingrediente ?receta)
   =>
   (assert (es_alimento ?ingrediente))
)

;Si un ingrediente esta en el nombre de la receta este es importante
(defrule extraer_alimento_importante_del_nombre
   ?receta <- (receta (nombre ?nombre))
   (es_un_ingrediente_de ?ingrediente ?receta)
   (not (propiedad_receta ingrediente_relevante ?receta ?ingrediente))
   (test (neq (str-index ?ingrediente (str-cat (lowcase ?nombre))) FALSE))
   =>
   (assert (propiedad_receta ingrediente_relevante ?receta ?ingrediente))
)

;vemos que nutriente esta mas presenta en la receta y creamos una nueva propiedad
(defrule extraer_nutriente_principal_receta
   ?receta <- (receta (nombre ?nombre) (Proteinas ?proteinas) (Grasa ?grasa) (Carbohidratos ?carbohidratos) (Fibra ?fibra))
   (not (propiedad_receta ? ?receta))
   =>
   (bind ?mayor (max ?proteinas ?grasa ?carbohidratos ?fibra))
   (if (eq ?mayor ?proteinas)
      then
      (assert (propiedad_receta rico_en_proteinas ?receta))
   )
   (if (eq ?mayor ?grasa)
      then
      (assert (propiedad_receta rico_en_grasas ?receta))
   )
   (if (eq ?mayor ?carbohidratos)
      then
      (assert (propiedad_receta rico_en_hidratos_de_carbono ?receta))
      (assert (propiedad_receta rico_en_azucares ?receta))
   )
   (if (eq ?mayor ?fibra)
      then
      (assert (propiedad_receta rico_en_fibras ?receta))
   )
)

;si un alimento es rico en el nutriente en el que la receta es rico entonces es importante
(defrule deducir_alimento_importante_segun_nutrientes_receta
   (es_un_ingrediente_de ?ingrediente ?receta)
   (not (propiedad_receta ingrediente_relevante ?receta ?ingrediente))
   (propiedad_receta ?propiedad ?receta)
   (propiedad ?propiedad ?ingrediente si)
   =>
   (assert (propiedad_receta ingrediente_relevante ?receta ?ingrediente))
)

;si un alimento es del mismo tipo de uno importante lo anadimos
(defrule deducir_alimento_importante_por_mismo_tipo
   (es_un_ingrediente_de ?ingrediente ?receta)
   (propiedad_receta ingrediente_relevante ?receta ?ingrediente_importante)
   (test (neq ?ingrediente ?ingrediente_importante))
   (not (propiedad_receta ingrediente_relevante ?receta ?ingrediente))
   (es_un_tipo_de ?ingrediente_importante ?tipo)
   (es_un_tipo_de ?ingrediente ?tipo)
   =>
   (assert (propiedad_receta ingrediente_relevante ?receta ?ingrediente))
)

;;; 2) modificar las recetas completando cual seria el/los tipo_plato asociados a una receta,
;;;;;;;; especialmente para el caso de que no incluya ninguno
;siempre comprobamos que sea de ese tipo para no anadirlo 2 veces
;si los ingredientes son fruta, dulces, cereales... o es un colacao o mas cosas sirve para desayuno, postre y merienda
;y que no sea un plato principal, entrante o primer, ya que alguno de esto puede algo importante como naranja pero no
;ser algo de postre y tal

(defrule deducir_postres
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
      (test (neq (str-index "ostada" ?nombre) FALSE))
      (and (es_un_tipo_de ?ingrediente lacteos) (test (neq ?ingrediente queso)) (not (es_un_tipo_de ?ingrediente queso)))
      (test (eq ?ingrediente cafe))
      (test (eq ?ingrediente colacao))
   )
   =>
   (modify ?receta (tipo_plato $?tipos postre))
)

(defrule deducir_desayuno_o_merienda
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
      (test (neq (str-index "ostada" ?nombre) FALSE))
      (and (es_un_tipo_de ?ingrediente lacteos) (test (neq ?ingrediente queso)) (not (es_un_tipo_de ?ingrediente queso)))
      (test (eq ?ingrediente cafe))
      (test (eq ?ingrediente colacao))
   )
   =>
   (modify ?receta (tipo_plato $?tipos desayuno_merienda))
)

;Podemos poner como acompañamento bebidas, frutos secos, ensaladas(pongo nsalada
por si es Ensalada o ensalada acepta ambos)
(defrule deducir_acompanamiento
   ?receta <- (receta (nombre ?nombre) (tipo_plato $?tipos))
   (test (not (member$ acompanamiento $?tipos)))
   (propiedad_receta ingrediente_relevante ?receta ?ingrediente)
   (or
      (test (neq (str-index "pan" ?nombre) FALSE))
      (test (neq (str-index "Pan" ?nombre) FALSE))
      (test (neq (str-index "nsalada" ?nombre) FALSE))
      (test (eq ?nombre "atatas fritas"))
      (test (eq ?ingrediente lechuga))
      (and (es_un_tipo_de ?ingrediente bebida) (test (neq ?ingrediente colacao)) (test (neq ?ingrediente cafe)))
      (es_un_tipo_de ?ingrediente frutos)
      (es_un_tipo_de ?ingrediente frutos_secos)
   )
   =>
   (modify ?receta (tipo_plato $?tipos acompanamiento))
)

;Realmente para mi entrante, primer plato y principal es lo mismo menos que el entrante es mas pequeño
;Sin embargo vamos a inventarnos un par de cosas a ver que sale
;Para entrante he pensado poner sopas, embutidos...
(defrule deducir_entrante
   ?receta <- (receta (nombre ?nombre) (tipo_plato $?tipos))
   (test (not (member$ entrante $?tipos)))
   (propiedad_receta ingrediente_relevante ?receta ?ingrediente)
   (or
      (test (neq (str-index "sopa" ?nombre) FALSE))
      (test (neq (str-index "Sopa" ?nombre) FALSE))
      (es_un_tipo_de ?ingrediente embutidos)
      (es_un_tipo_de ?ingrediente fiambres)
      (es_un_tipo_de ?ingrediente caldo)
      (test (eq ?ingrediente queso))
   )
   =>
   (modify ?receta (tipo_plato $?tipos entrante))
)

;Para el primero pudemos poner legumbres, pasta, sopa también valdria
(defrule deducir_primer_plato
   ?receta <- (receta (nombre ?nombre) (tipo_plato $?tipos))
   (test (not (member$ primer_plato $?tipos)))
   (propiedad_receta ingrediente_relevante ?receta ?ingrediente)
   (or
      (test (neq (str-index "Sopa" ?nombre) FALSE))
      (test (neq (str-index "sopa" ?nombre) FALSE))
      (es_un_tipo_de ?ingrediente verdura)
      (es_un_tipo_de ?ingrediente hortalizas)
      (es_un_tipo_de ?ingrediente legumbres)
      (es_un_tipo_de ?ingrediente pasta)
      (test (eq ?ingrediente pasta))
   )
   =>
   (modify ?receta (tipo_plato $?tipos primer_plato))
)

;Podemos poner platos de carne o pescado, ricos en grasa...
(defrule deducir_plato_principal
   ?receta <- (receta (nombre ?nombre) (tipo_plato $?tipos))
   (test (not (member$ plato_principal $?tipos)))
   (propiedad_receta ingrediente_relevante ?receta ?ingrediente)
   (or
      (es_un_tipo_de ?ingrediente carne)
      (es_un_tipo_de ?ingrediente pescado)
      (propiedad_receta rico_en_grasas ?receta)
   )
   =>
   (modify ?receta (tipo_plato $?tipos plato_principal))
)

;;; 3) si una receta es: vegana, vegetariana, de dieta, picante, sin gluten o sin lactosa
;;vemos las que tiene carne o pescado primero
(defrule receta_tiene_carne_o_pescado
   (declare (salience -1))
   (es_un_ingrediente_de ?ingrediente ?receta)
   (not (propiedad_receta lleva_carne_o_pescado ?receta))
   (or (es_un_tipo_de ?ingrediente carne) (es_un_tipo_de ?ingrediente pescado)
      (es_un_tipo_de ?ingrediente embutidos) (es_un_tipo_de ?ingrediente fiambres))
   =>
   (assert (propiedad_receta lleva_carne_o_pescado ?receta))
)

;las vegetarianas seran las que no tienen la propiedad anterior, ponemos prioridades
;para asegurarnos que la anterior se calculo
(defrule receta_es_vegetariana
   (declare (salience -2))
   ?receta <- (receta (nombre ?n))
   (not (propiedad_receta lleva_carne_o_pescado ?receta))
   =>
   (assert (propiedad_receta es_vegetariana ?receta))
)

;igual que el caso anterior
(defrule receta_tiene_producto_animal
   (declare (salience -1))
   (es_un_ingrediente_de ?ingrediente ?receta)
   (not (propiedad_receta lleva_producto_animal ?receta))
   (or (es_un_tipo_de ?ingrediente lacteos) (test (eq ?ingrediente huevos)) (test (eq ?ingrediente huevo)))
   =>
   (assert (propiedad_receta lleva_producto_animal ?receta))
)
(defrule receta_es_vegana
   (declare (salience -2))
   ?receta <- (receta (nombre ?n))
   (not (propiedad_receta lleva_carne_o_pescado ?receta))
   (not (propiedad_receta lleva_producto_animal ?receta))
   =>
   (assert (propiedad_receta es_vegana ?receta))
)

;ahora miramos los alimentos que pican, normalmente depende de las cantidades, ya que si un alimento lleva pimienta
;pero poca no va a picar, pero no sabemos la cantidad, por eso puede salir recetas que a priori no suele ser picantes
(defrule receta_picante
   (declare (salience -1))
   (es_un_ingrediente_de ?ingrediente ?receta)
   (not (propiedad_receta es_picante ?receta))
   (es_un_tipo_de ?ingrediente picante)
   =>
   (assert (propiedad_receta es_picante ?receta))
)

;igual que vegetariano
(defrule receta_tiene_gluten
   (declare (salience -1))
   (es_un_ingrediente_de ?ingrediente ?receta)
   (not (propiedad_receta con_gluten ?receta))
   (es_un_tipo_de ?ingrediente cereales)
   =>
   (assert (propiedad_receta con_gluten ?receta))
)

(defrule receta_es_sin_gluten
   (declare (salience -2))
   ?receta <- (receta (nombre ?n))
   (not (propiedad_receta con_gluten ?receta))
   =>
   (assert (propiedad_receta es_sin_gluten ?receta))
)

;lo mismo que el anterior
(defrule receta_tiene_lactosa
   (declare (salience -1))
   (es_un_ingrediente_de ?ingrediente ?receta)
   (not (propiedad_receta con_lactosa ?receta))
   (es_un_tipo_de ?ingrediente lacteos)
   =>
   (assert (propiedad_receta con_lactosa ?receta))
)

(defrule receta_es_sin_lactosa
   (declare (salience -2))
   ?receta <- (receta (nombre ?n))
   (not (propiedad_receta con_lactosa ?receta))
   =>
   (assert (propiedad_receta es_sin_lactosa ?receta))
)

;es de dieta si tiene mucha fibra o tiene poco grasa,hidratos y colesterol
(defrule receta_es_de_dieta
   (declare (salience -1))
   ?receta <- (receta (nombre ?nombre) (Grasa ?grasa) (Carbohidratos ?carbohidratos)
   (numero_personas ?personas) (Colesterol ?colesterol))
   (or
      (propiedad_receta rico_en_fibras ?receta)
      (and
         (test (< (/ ?grasa ?personas) 10))
         (test (< (/ ?carbohidratos ?personas) 15))
         (test (< (/ ?colesterol ?personas) 50))
      )
   )
   =>
   (assert (propiedad_receta es_de_dieta ?receta))
)

;imprimimos lo obtenido para comprobar
(defrule imprimir_nombre_receta_ingrediente_relevante
   (declare (salience -10))
   ?receta <- (receta (nombre ?n))
   (propiedad_receta ingrediente_relevante ?receta ?ingrediente)
   =>
   (printout t "La receta " ?n " tiene el ingrediente importante: " ?ingrediente crlf)
)

(defrule imprimir-tipo-plato
   (declare (salience -11))
   ?receta <- (receta (nombre ?nombre) (tipo_plato $?tipos))
   =>
   (printout t "La receta " ?nombre " tiene los siguientes tipos de plato:" crlf)
   (foreach ?tipo ?tipos
      (printout t "- " ?tipo crlf)
   )
)

(defrule imprimir_vegetarianas
   (declare (salience -12))
   ?receta <- (receta (nombre ?n))
   (propiedad_receta es_vegetariana ?receta)
   =>
   (printout t "La receta " ?n " es vegetariana." crlf)
)

(defrule imprimir_veganas
   (declare (salience -13))
   ?receta <- (receta (nombre ?n))
   (propiedad_receta es_vegana ?receta)
   =>
   (printout t "La receta " ?n " es vegana." crlf)
)

(defrule imprimir_picantes
   (declare (salience -14))
   ?receta <- (receta (nombre ?n))
   (propiedad_receta es_picante ?receta)
   =>
   (printout t "La receta " ?n " es picante." crlf)
)

(defrule imprimir_sin_gluten
   (declare (salience -15))
   ?receta <- (receta (nombre ?n))
   (propiedad_receta es_sin_gluten ?receta)
   =>
   (printout t "La receta " ?n " no lleva gluten." crlf)
)

(defrule imprimir_sin_lactosa
   (declare (salience -16))
   ?receta <- (receta (nombre ?n))
   (propiedad_receta es_sin_lactosa ?receta)
   =>
   (printout t "La receta " ?n " no lleva lactosa." crlf)
)

(defrule imprimir_de_dieta
   (declare (salience -17))
   ?receta <- (receta (nombre ?n))
   (propiedad_receta es_de_dieta ?receta)
   =>
   (printout t "La receta " ?n " es de dieta." crlf)
)

;;;FORMATO DE LOS HECHOS:
;
; (propiedad_receta ingrediente_relevante ?r ?a)
; (propiedad_receta es_vegetariana ?r)
; (propiedad_receta es_vegana ?r)
; (propiedad_receta es_sin_gluten ?r)
; (propiedad_receta es_picante ?r)
; (propiedad_receta es_sin_lactosa ?r)
; (propiedad_receta es_de_dieta ?r)
;(defrule anunciar_listar_grupos_alimentos
;(declare (salience -997))
;=>
;(printout t crlf "Gurpos de alimentos de la base de conocimiento:" crlf)
;)
;(defrule listar_grupos_alimentos
;(declare (salience -998))
;(es_grupo_alimentos ?g)
;=>
;(printout t ?g crlf)
;)
;(defrule anunciar_listar_alimentos
;(declare (salience -999))
;=>
;(printout t crlf "Alimentos de la base de conocimiento:" crlf)
;)
;(defrule listar_alimentos
;(declare (salience -1000))
;(es_alimento ?a)
;=>
;(printout t ?a crlf)
;)
;(defrule anunciar_listar_condimentos
;(declare (salience -1001))
;=>
;(printout t crlf "Condimentos de la base de conocimiento:" crlf)
;)
;(defrule listar_condimentostos
;(declare (salience -1002))
;(es_un_tipo_de ?a condimento)
;=>
;(printout t ?a crlf)
;)