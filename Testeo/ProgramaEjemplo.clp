; Definir un hecho inicial con un template
(deftemplate persona
  (slot nombre)
  (slot edad))

; Regla que detecta personas mayores de edad
(defrule mayor-de-edad
  (persona (nombre ?n) (edad ?e&:(>= ?e 18)))
  =>
  (printout t ?n " es mayor de edad." crlf))
