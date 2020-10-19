import 'package:flutter/material.dart';
import 'package:qrreaderapp/src/bloc/scans_bloc.dart';
import 'package:qrreaderapp/src/models/scan_model.dart';
import 'package:qrreaderapp/src/pages/direcciones_page.dart';
import 'package:qrreaderapp/src/pages/mapa_page.dart';

import 'package:protobuf/protobuf.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:qrreaderapp/src/utils/utils.dart' as utils;

class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final scanBloc = ScansBloc();

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Qr Scanner'),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.delete_forever), onPressed: scanBloc.borrarTodos)
        ],
      ),
      body: _loadPage(currentIndex),
      bottomNavigationBar: _bottomNavigation(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () => _scanQR(context),
        child: Icon(Icons.filter_center_focus),
        backgroundColor: Theme.of(context).primaryColor,
        ),
    );
  }

 _scanQR( BuildContext context ) async {

   //geo:-0.28779051308985115,-78.56930151423343
   //https://www.google.com


    dynamic futureString ='https://www.google.com';
    // try {
    //   futureString = await BarcodeScanner.scan();
    // }catch(e){
    //   futureString=e.toString();
    // }
    if ( futureString != null ){
      final scan = ScanModel(valor: futureString);
      scanBloc.agregaScan(scan);

      final scan2 = ScanModel(valor: 'geo:-0.28779051308985115,-78.56930151423343');
      scanBloc.agregaScan(scan2);
      utils.abrirScan(context, scan2);
    }
 }

  Widget _loadPage( int index ){
    switch( index ){
      case 0: return MapaPage();
      case 1: return DireccionesPage();
      default:
      return MapaPage();
    }
  }

  Widget _bottomNavigation(){
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: (index){
        setState(() {
          currentIndex = index;
        });
      },
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.map),label: 'Mapa'),
        BottomNavigationBarItem(icon: Icon(Icons.directions),label: 'Direcciones'),
      ]
      );
  }
}