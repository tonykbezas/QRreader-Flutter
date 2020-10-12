import 'package:flutter/material.dart';
import 'package:qrreaderapp/src/pages/direcciones_page.dart';
import 'package:qrreaderapp/src/pages/mapa_page.dart';

import 'package:protobuf/protobuf.dart';
import 'package:barcode_scan/barcode_scan.dart';

class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Qr Scanner'),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.delete_forever), onPressed: (){})
        ],
      ),
      body: _loadPage(currentIndex),
      bottomNavigationBar: _bottomNavigation(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: _scanQR,
        child: Icon(Icons.filter_center_focus),
        backgroundColor: Theme.of(context).primaryColor,
        ),
    );
  }

 _scanQR() async {

   //geo:-0.28779051308985115,-78.56930151423343
   //https://www.google.com


     dynamic futureString ='';
     try {
      futureString = await BarcodeScanner.scan();
    }catch(e){
      futureString=e.toString();
    }
 
print('Future String: ${futureString.rawContent}');
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
        BottomNavigationBarItem(icon: Icon(Icons.map),title: Text('Mapa')),
        BottomNavigationBarItem(icon: Icon(Icons.directions),title: Text('Direcciones')),
      ]
      );
  }
}