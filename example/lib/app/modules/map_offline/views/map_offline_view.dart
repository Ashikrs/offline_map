import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';

import '../controllers/map_offline_controller.dart';

class MapOfflineView extends GetView<MapOfflineController> {
  const MapOfflineView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    controller;

    return Scaffold(
      appBar: AppBar(title: const Text('Offline Map')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
              child: Text(
                'This is an offline map that is showing Anholt Island, Denmark.',
              ),
            ),
            Flexible(
              child: FlutterMap(
                options: MapOptions(
                  center: LatLng(8.548824070866914, 76.91735867846106),
                  minZoom: 13,
                  maxZoom: 15,
                  zoom: 15,
                  maxBounds: LatLngBounds(
                    LatLng(8.580067766470968, 76.83071427867765),
                    LatLng(8.371760037875509, 77.05713896668198),
                  ),
                  bounds: LatLngBounds(
                    LatLng(8.580067766470968, 76.83071427867765),
                    LatLng(8.371760037875509, 77.05713896668198),
                  ),
                  // swPanBoundary: LatLng(8.580067766470968, 76.83071427867765),
                  // nePanBoundary: LatLng(8.371760037875509, 77.05713896668198),
                ),
                children: [
                  TileLayer(
                    tileProvider: AssetTileProvider(),
                    maxZoom: 15,
                    urlTemplate: 'assets/map/tvm/{z}/{x}/{y}.png',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
