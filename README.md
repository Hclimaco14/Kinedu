# Kinedu #
Prueba de Kinedu

## Requerimientos
- Xcode 11+
- Swift 5+
- iOS 12+
- Una conexión activa a internet
- Conocimiento y configuración de Cocoapods (cocoapopds.org)

### KineduNPS:

Contiene un proyecto  con la prueba de seleccion de Kinedu, se crea aplicacion con el patron de diseño MVVM y Separacion de consumo de datos,  crea prueba unitaria para el consumo de servicio, este puede ser mediante la url proporcionado en la documentacion y se anexa archivo .json para pruebas ya que el servicio no estaba activo este se puede swichear mediante la bandera "loadFromFile"  Ubicacada en KinediNPS -> ViewModels -> NPS -> NPSHomeViewModel.swift  linea: 50 


cd .../Kinedu

pod repo update
pod install


### Release Notes:

Version: 1.0 

* Se crea consumo de servio mediante Alamofire y se mapea objeto con ObjectMapper
* Se crea pruebas unitarias para el consumo de los datos
* Se crean vista media .xib y se ocupa el patron coordinator para la navegacion de la applicacion
* Se separa el consumo de datos de la vista mediate el patron de diseño MVVM
* Se crea componete visual para la visulalizacion de score en pantalla princial 
* Se crea pantalla para la visualizacion de detalles por version 
* Se crea MVVM para el manejo de reglas de negocio de Detalles
