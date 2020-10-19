import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:qrreaderapp/src/models/scan_model.dart';

class MapasPage extends StatelessWidget {

  final map = MapController();

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
              map.move(scan.getLatLng(),23.0);
            }
          )
        ],
      ),
      body: _mapa( scan )
    );
  }

  Widget _mapa( ScanModel scan ){
    return FlutterMap(
      mapController: map,
      options: MapOptions(
        center: scan.getLatLng(),
        zoom: 23.0
      ),
      layers: [
        _map()
      ],
    );
  }

  _map(){
    return TileLayerOptions(
      urlTemplate: 'https://api.mapbox.com/styles/v1/'
      '{id}/tiles/{z}/{x}/{y}?access_token={accessToken}',
      additionalOptions: {
        'accessToken' : 'pk.eyJ1IjoidG9ueWtiZXphcyIsImEiOiJja2dkNXRoNGEwMTg2MnBtaWltdTBzMDE0In0.-SsyDZhhs9mpqRkKKbVsNA',
        'id' : 'mapbox/streets-v11'
      }
    );
  }

}