import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:qrreaderapp/src/models/scan_model.dart';

class MapasPage extends StatefulWidget{

  @override
  _MapasPageState createState() => _MapasPageState();
}

class _MapasPageState extends State<MapasPage> {
  final map = MapController();

  String tipoMapa = 'streets-v11';
  int i = 0;
  var vect = ['streets-v11','outdoors-v11','light-v10','dark-v10','satellite-v9','satellite-streets-v11'];

  @override
  Widget build(BuildContext context) {

    final ScanModel scan = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text('Coordenadas QR'),
        actions: [
          IconButton(
            icon: Icon(Icons.my_location), 
            onPressed: () {
              map.move(scan.getLatLng(), 15);
            }
          )
        ],
      ),
      body: _mapa( scan ),
      floatingActionButton: _botonflotante(context, scan),
    );
  }

  Widget _botonflotante(BuildContext context, ScanModel scan){
    return FloatingActionButton(  
      child: Icon(Icons.repeat),
      backgroundColor: Theme.of(context).primaryColor,
      onPressed: (){
        if ( i == vect.length-1 ){
          i = 0;
          tipoMapa = vect[i];
        }else{
          i++;
          tipoMapa = vect[i];
        }
        setState((){});
        map.move(scan.getLatLng(), 30);
 
        //Regreso al Zoom Deseado después de unos Milisegundos
        Future.delayed(Duration(milliseconds: 50),(){
          map.move(scan.getLatLng(), 15);
        });
          } 
        );
  }

  Widget _mapa( ScanModel scan ){
    return FlutterMap(
      mapController: map,
      options: MapOptions(
        center: scan.getLatLng(),
        zoom: 13.0
      ),
      layers: [
        _map(),
        _marcador( scan )
      ],
    );
  }

  _map(){
    return TileLayerOptions(
      urlTemplate: 'https://api.mapbox.com/styles/v1/'
      '{id}/tiles/{z}/{x}/{y}@2x?access_token={accessToken}',
      additionalOptions: {
        'accessToken' : 'pk.eyJ1IjoidG9ueWtiZXphcyIsImEiOiJja2dkNXRoNGEwMTg2MnBtaWltdTBzMDE0In0.-SsyDZhhs9mpqRkKKbVsNA',
        'id' : 'mapbox/$tipoMapa'
      }
    );
  }

  _marcador( ScanModel scan ){
    return MarkerLayerOptions(
      markers: <Marker>[
        Marker(
          width: 100.0,
          height: 100.0,
          point: scan.getLatLng(),
          builder: (context) => Icon(Icons.location_on,size: 45.0, color: Theme.of(context).primaryColor)
        )
      ]
    );
  }
}