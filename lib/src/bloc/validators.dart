import 'dart:async';

import 'package:qrreaderapp/src/models/scan_model.dart';

class Validators{
  final validarGeo = StreamTransformer<List<ScanModel>,List<ScanModel>>.fromHandlers(
    handleData: (scan, sink){
      final geoScans = scan.where((element) => element.tipo == 'geo').toList();
      sink.add(geoScans);
    }
  );
  final validarHttp = StreamTransformer<List<ScanModel>,List<ScanModel>>.fromHandlers(
    handleData: (scan, sink){
      final geoScans = scan.where((element) => element.tipo == 'http').toList();
      sink.add(geoScans);
    }
  );
}