# Sistemas Inoperativos
 
[![Build Status](https://travis-ci.org/wollok/EjercicioIntegradorSistemasInoperativos.svg?branch=master)](https://travis-ci.org/wollok/EjercicioIntegradorSistemasInoperativos)


**Nos encontramos ante la necesidad de modelar diferentes sistemas operativos para poder probar su instalación y comportamiento.**

![](https://despaciocerebrito.files.wordpress.com/2012/07/bill_gates_simpsons.png)
*“No me hice rico firmando cheques”*

En primer lugar tenemos a GüinDOS, un sistema que tuvo sus primeros orígenes en QDOS. Viene con muchas aplicaciones por defecto y soporta una cantidad total de aplicaciones activas que se calcula como el doble de la versión. (por ejemplo, la versión 3.11 soporta 6 aplicaciones ejecutando simultáneamente). 

Luego tenemos algunos sistemas de la familia Unix:

* PinguinOS: Son sistemas muy customizables, usados generalmente por nerds y militantes del software libre. La cantidad de aplicaciones que puede ejecutar en simultáneo depende de qué distribución utilicemos. Todas las distribuciones se diferencian también en las aplicaciones que ya traen.
Por ejemplo la distribución Mate puede ejecutar 80 (tantas aplicaciones como la temperatura normal en grados Celsius de un mate), mientras que la distribución Ubuntu puede ejecutar 128 y puede haber otras con otra cantidad.
* iPear: Posee atractivo visual al igual que una consola potente. Puede tener una aplicación levantada por cada 1000 dólares invertidos en el proyecto que lo desarrolla, hasta el momento. (El proyecto recibe donaciones permanentemente, sin preguntar el origen de los fondos). La única aplicación que viene por defecto es una que permite hacer donaciones. 

Estos sistemas corren sobre diferentes equipos, de los cuales se conoce su memoria RAM y su espacio en disco, que utilizarán para guardar aplicaciones instaladas, las cuales ocasionalmente podrán estar corriendo y por lo tanto utilizando RAM. En cada equipo se puede instalar un solo sistema operativo y muchas aplicaciones. (Para simplificar, obviamos el consumo de CPU y otros recursos o variantes) Por ejemplo, un equipo podría tener 2048 MB de RAM y un disco de 1.000.000 MB.

De todo sistema operativo conocemos cuánto espacio de disco ocupa y la memoria RAM que utiliza para su funcionamiento básico, sin contar las aplicaciones por defecto.

En cuanto a las aplicaciones, tanto de las que pueden venir con el sistema operativo como otras que se puedan instalar posteriormente, se conoce sus consumos de memoria y espacio en disco, valores que representamos utilizando números enteros.


### Primera parte: Instalación
Instalar un sistema inoperativo en un equipo. Si el equipo no tiene el espacio en disco se debe advertir e interrumpir la acción. Si ya tuviera otro sistema operativo instalado previamente, sustituirlo por el actual. Al instalar el sistema, se instalan también las aplicaciones por defecto que trae; si alcanzara el espacio en el disco para el sistema pero no para las aplicaciones, no se instala nada. No importa si no le alcanza la memoria para luego ejecutar, instalarse se instala!
Validar si se puede instalar una aplicación en un equipo. Se debe verificar que tenga algún sistema inoperativo instalado, que los recursos de disco sean suficientes y que la aplicación no esté ya instalada en ese equipo.

**Implementar el código y hacer al menos un test de cada ítem.**

### Segunda parte: Ejecución
1. Encender el equipo. Al hacerlo, se ejecuta el sistema inoperativo. En caso de no poder ejecutarse por falta de memoria, interrumpir inmediatamente el programa.
2. Ejecutar una aplicación. En cualquier momento se puede ejecutar una aplicación que esté instalada (y no esté ya ejecutándose). Tampoco debe permitir ejecutar una tarea que sobrepase el límite físico de memoria RAM disponible del equipo. Considerar que el límite de aplicaciones que un sistema puede tener activas puede ser alcanzado pero nunca superado! Cuando esto se da, la solicitud de ejecución de la aplicación debe ser ignorada sin que eso comprometa el funcionamiento del sistema. En el caso de güinDOS, se acepta la nueva aplicación que sobrepasa los límites establecidos, pero se detienen todas las que estaban en ejecución al momento. 
3. Detener una aplicación. En cualquier momento, una aplicación que se esté ejecutando puede ser detenida.
4. Obtener estadísticas de rendimiento:
   * Saber si un equipo está explotado: esto sucede cuando tiene más del 90% de su memoria utilizada por el sistema inoperativo y las aplicaciones que tiene actualmente corriendo.
   * Saber si un equipo es capaz de ejecutar todas las aplicaciones que tiene instaladas simultáneamente.
   * Determinar si la aplicación instalada más exigente (la que más memoria RAM ocupa) está ejecutándose actualmente en el equipo.

**Implementar el código correspondiente.**

### Tercera Parte: Para pensar
Se quiere agregar un nuevo sistema operativo llamado BeSeDe. 
Se trata de un sistema seguro desarrollado por la universidad de Berkeley. 
No podrá tener más de 1234 aplicaciones instaladas y soportará hasta 200 corriendo simultáneamente. 
Rara vez se lo utiliza en equipos de oficina, aunque tiene presencia en servidores. 
Explicar el impacto que podría tener la implementación de este sistema en la solución desarrollada. 
Relacionar con los conceptos de “polimorfismo” y  “declaratividad” 


### Cuarta parte: Para el 10
Además de las aplicaciones propiamente dichas, el sistema inoperativo ejecuta otras tareas sin que el usuario las haga ejecutar y sin que estén instaladas en el equipo, pero que también consumen RAM. Las tareas existentes son:
* “Think differently” que ocupa toda la memoria RAM libre que tenga el equipo al momento de ejecutarse. Si luego otra tarea finaliza, “Think differently” deberá usar lo que dicha tarea libere del procesador. En consecuencia, a menos que se la detenga y libere memoria, no se podrá ejecutar otra aplicación simultáneamente.
* “Pantalla verde de la muerte”, al ejecutarse, debe eliminar todas las tareas que el sistema esté corriendo al momento, y quedar sólo ella ejecutando. Si es la única tarea activa y se solicita ejecutar una nueva tarea o aplicación, se detiene la presente tarea y luego se ejecuta la nueva. 
* "Virus". Al ejecutarse, hace que una aplicación o tarea en ejecución aleatoriamente se detenga y se reemplace por dicho virus, que no hace nada, pero consume el doble de recursos. Cada vez que se ejecuta una nueva aplicación, el virus duplica su consumo de recursos, así hasta hacer colapsar el sistema.

**Elegir sólo una de las tareas e implementarla**

