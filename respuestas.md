# Sector A

## A1

**¿Qué columnas no se pueden repetir nunca?**
`id`, `dni` y `email`. Las tres tienen restricciones que impiden valores duplicados (`id` es PRIMARY KEY; `dni` y `email` son UNIQUE)

**¿Cuál es la clave primaria? ¿Cuáles son claves alternativas?**
- Clave primaria: `id`.
- Claves alternativas: `dni` y `email`

**¿Qué columna apunta a otra tabla? ¿A cuál?**
`plan_id` es una clave ajena (FK) que apunta a la tabla `planes`, exactamente a la columna `planes(id)`

**El DNI ya identifica a cada socio. ¿Por qué crees que usamos un id numérico como clave primaria en vez del DNI? Da al menos una razón.**

El `id` numérico autogenerado es más eficiente: menos espacio en disco, las comparaciones numéricas son más rápidas y los índices y JOINs rinden mejor.

## A2

| Pareja | Un A, ¿cuántos B? | Un B, ¿cuántos A? | Relación |
|:---|:---|:---|:---|
| planes – socios | muchos | uno | 1:N |
| socios – tarjetas | uno | uno | 1:1 |
| monitores – clases | muchos | uno | 1:N |
| socios – clases | muchos | muchos | N:M |
| monitores – especialidades | muchos | muchos | N:M |

## A3

**Las dos preguntas:**
- Un monitor, ¿cuántos socios? → **muchos**
- Una clase, ¿cuántos monitores? → **uno**
- 1:N. Lado muchos: clases. La clave ajena va en `clases`.

**¿En qué tabla va la clave ajena? ¿Cómo la llamarías?**
En la tabla `clases`, con el nombre `monitor_id`.

**Dibuja (en una tabla Markdown) cómo quedaría si la pusieras en el lado equivocado y explica en una frase por qué falla.**

| id | dni | nombre | clase_id |
|:---|:----|:-------|:---------|
| 1 | 90000001J | Carla Navarro | 1, 2, 4, 6|
| 2 | 90000002K | Javier Ortega | 3, 5|

**¿Debe ser NOT NULL? ¿Por qué?**
Sí, porque no tiene sentido programar una clase sin un monitor responsable de impartirla.

**¿Qué tabla hay que crear primero?**
`monitores`, porque `clases` tiene una FK que apunta a `monitores(id)` y la tabla referenciada debe existir primero.

## A4

**¿Qué pasaría si quitásemos UNIQUE de socio_id? Ejemplo de datos:**

Un mismo socio tendría dos tarjetas en la tabla `tarjetas`, dejaria de ser 1:1 

**Hay dos columnas UNIQUE en tarjetas. ¿Qué evita cada una?**
- `codigo` UNIQUE: evita que existan dos tarjetas con el mismo código
- `socio_id` UNIQUE: evita que un socio tenga asignadas múltiples tarjetas

**Inventa otra relación 1:1 de la vida real e indica en qué tabla pondrías la FK:**
Relación: Persona 1----1 Pasaporte.
Una persona tiene un solo pasaporte, y un pasaporte pertenece a una sola persona.
FK: en la tabla `pasaportes`, apuntando a `personas(id)` con UNIQUE.

## A5

**Las dos preguntas y tipo de relación:**
- Un monitor, ¿cuántas especialidades? → muchos
- Una especialidad, ¿cuántos monitores? → muchos
- Relación: N:M

**¿Qué tablas necesitas? Ponles nombre:**
1. `especialidades`
2. `monitor_especialidades` (tabla intermedia)

**Escribe las columnas de cada tabla y marca cuál es PK, cuál UNIQUE y cuál FK.**

*Tabla `especialidades`:*
- `id` (PK)
- `nombre` (UNIQUE, NOT NULL)
- `descripcion` (TEXT)

*Tabla `monitor_especialidades`:*
- `id` (PK)
- `monitor_id` (FK → monitores(id))
- `especialidad_id` (FK → especialidades(id))
- UNIQUE(`monitor_id`, `especialidad_id`)

**¿Qué evita el UNIQUE de la tabla intermedia?**
Evita que un mismo monitor tenga asignada la misma especialidad dos veces.

**¿Qué tienen en común `reservas` y `monitor_especialidades`? ¿En qué se diferencian?**

*En común:* Ambas son tablas intermedias que resuelven relaciones N:M con dos claves ajenas.

*Diferencian:* `monitor_especialidades` solo vincula (es puramente relacional). `reservas` además almacena datos propios como `fecha_reserva`.

## A6

**País – ciudad:**
- Un país, ¿cuántas ciudades? → muchas
- Una ciudad, ¿cuántos países? → uno
- Relación: 1:N. FK `pais_id` en `ciudades`.

**Persona – pasaporte:**
- Una persona, ¿cuántos pasaportes? → uno
- Un pasaporte, ¿cuántas personas? → uno
- Relación: 1:1. FK `persona_id` en `pasaportes` + UNIQUE.

**Alumno – asignatura:**
- Un alumno, ¿cuántas asignaturas? → muchas
- Una asignatura, ¿cuántos alumnos? → muchos
- Relación: N:M. Tabla intermedia `alumno_asignatura`.

**Cliente – pedido:**
- Un cliente, ¿cuántos pedidos? → muchos
- Un pedido, ¿cuántos clientes? → uno
- Relación: 1:N. FK `cliente_id` en `pedidos`.

**Película – actor:**
- Una película, ¿cuántos actores? → muchos
- Un actor, ¿cuántas películas? → muchas
- Relación: N:M. Tabla intermedia `película_actor` con `nombre_personaje`.

**Autor – libro:**
- Un autor, ¿cuántos libros? → muchos (o uno)
- Un libro, ¿cuántos autores? → uno (o muchos)
- Relación: Depende del dato que falta: ¿Un libro puede tener varios autores o solo uno? Si es uno: 1:N FK en `libros`. Si es varios: N:M tabla intermedia.

**Furniro: usuario – pedido:**
- Un usuario, ¿cuántos pedidos? → muchos
- Un pedido, ¿cuántos usuarios? → uno
- Relación: 1:N. FK `usuario_id` en `pedidos`.

**Furniro: pedido – producto:**
- Un pedido, ¿cuántos productos? → muchos
- Un producto, ¿cuántos pedidos? → muchos
- Relación: N:M. Tabla intermedia `pedido_producto` con datos propios: `cantidad`, `precio_unitario`, `subtotal`.

# Sector B

## B3

**B3.1: Un socio con un plan que no existe**

Antes: Fallará

Línea del error (traducida): "Violación de restricción de clave foránea". La clave foránea `plan_id REFERENCES planes(id)` lo ha impedido

**B3.2: Un socio con el email de Ana**

Antes: Fallará

Línea del error (traducida): "Violación de restricción UNIQUE en la columna email". La restricción UNIQUE en `email` lo ha impedido

**B3.3: Una segunda tarjeta para Ana**

Antes: Fallará

Línea del error (traducida): "Violación de restricción UNIQUE en la columna socio_id". La restricción UNIQUE en `socio_id` lo ha impedido

**B3.4: Ana reserva otra vez el Spinning del lunes**

Antes: Fallará

Línea del error (traducida): "Violación de restricción UNIQUE en las columnas socio_id, clase_id". La restricción UNIQUE lo ha impedido

**B3.5: Una reserva para una clase que no existe**

Antes: Fallará 

Línea del error (traducida): "Violación de restricción de clave foránea". La clave foránea `clase_id REFERENCES clases(id)` lo ha impedido

**B3.6: Borrar el plan Básico**

Antes: Fallará

Línea del error (traducida): "Violación de restricción de clave foránea". Los socios con `plan_id = 1` lo han impedido

**B3.7: Borrar el plan Mañanas**

Antes: Funcionará. El plan Mañanas (id=4) está en la tabla `planes` pero ningún socio lo usa (Rubén es el único que lo tiene y probablemente fue un error o está vacío en los datos). Al no haber referencias, el DELETE se ejecuta sin problemas.

**B3.8: B3.6 falla y B3.7 funciona. Los dos son planes. ¿Por qué?**

Porque B3.6 intenta borrar un plan que sí tiene socios asociados. B3.7 borra un plan que no tiene ningún socio, por lo que no hay referencias que lo protejan. Solo se impide el DELETE si hay filas dependientes en otras tablas

#B4

**B4.11**

No es un error. La consulta une `reservas` con socios y clases; Ana aparece una vez por cada reserva que tiene, así que sale tres veces porque tiene tres reservas

## B6

**B6.1 ¿Qué diferencia hay entre una clave primaria y una clave UNIQUE?**
La clave primaria identifica cada fila, no admite NULL y solo puede haber una por tabla. UNIQUE impide duplicados y puede haber varias restricciones de este tipo por tabla.

**B6.2 ¿Por qué una clave ajena sí puede repetirse?**
Porque varias filas del lado muchos pueden apuntar a la misma fila referenciada.

**B6.3 En una relación 1:N, ¿en qué lado va la clave ajena? ¿Por qué no en el otro?**
Va en el lado N. En el lado 1 habría que guardar varios valores en una celda o repetir filas.

**B6.4 ¿Qué convierte una relación 1:N en una 1:1?**
Añadir UNIQUE a la clave ajena para impedir que se repita.

**B6.5 ¿Por qué una relación N:M necesita una tabla intermedia?**
Porque cada registro de ambos lados puede relacionarse con muchos del otro; la tabla intermedia guarda cada pareja mediante dos claves ajenas.

**B6.6 ¿Por qué `fecha_reserva` está en `reservas` y no en `socios` ni en `clases`?**
Porque corresponde a cada reserva concreta entre un socio y una clase, no al socio ni a la clase por separado.