import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_maps/maps.dart';

class InteractiveMarker extends StatefulWidget {
  @override
  _InteractiveMarkerState createState() => _InteractiveMarkerState();
}

class _InteractiveMarkerState extends State<InteractiveMarker> {
  late AnimationController _controller;
  late MapTileLayerController _tileLayerController;
  late Map<String, MapLatLng> _markers;

  int _selectedMarkerIndex = -1;
  int _prevSelectedMarkerIndex = -1;

  @override
  void initState() {
    _tileLayerController = MapTileLayerController();
    _markers = <String, MapLatLng>{
      'Vietnam': MapLatLng(10.7754461, 106.7038779),
      'USA': MapLatLng(39.191097, -106.817535),
      'USA': MapLatLng(26.153539 , -80.317386),
      'Spain': MapLatLng(41.403077, 2.156232),
      'United Kingdom': MapLatLng(51.514031, -0.152578),
      'Paris': MapLatLng(48.8666632 , 2.303665452),
      'Korea': MapLatLng(37.525768, 127.024875),
      'Japan': MapLatLng(35.652832, 	139.839478),
      'Kazakhstan': MapLatLng(43.17612, 76.8715),
      'Russia': MapLatLng(55.75222 , 37.61556),
      'United Arab Emirates': MapLatLng(25.199514, 55.277397),
      'Germany': MapLatLng(52.5000936, 13.3122435),
      'Sweden': MapLatLng(59.339335 , 18.067435),
    };
    super.initState();
  }

  @override
  void dispose() {
    _controller.stop();
    _controller.dispose();
    _markers.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: MapTileLayer(
        urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
        initialZoomLevel: 3,
        initialFocalLatLng: MapLatLng(2.3104, 16.5581),
        controller: _tileLayerController,
        initialMarkersCount: _markers.length,
        markerBuilder: (BuildContext context, int index) =>
            _buildMarker(context, index),
      ),
    );
  }

  MapMarker _buildMarker(BuildContext context, int index) {
    final double size = _selectedMarkerIndex == index ? 40 : 25;
    final MapLatLng markerLatLng = _markers.values.elementAt(index);
    final Icon current = Icon(Icons.store);
    return MapMarker(
      latitude: markerLatLng.latitude,
      longitude: markerLatLng.longitude,
      child: GestureDetector(
        onTap: () {
          _prevSelectedMarkerIndex = _selectedMarkerIndex;
          _selectedMarkerIndex = index;
          _tileLayerController.updateMarkers([
            if (_prevSelectedMarkerIndex != -1) _prevSelectedMarkerIndex,
            _selectedMarkerIndex
          ]);
        },
        child: AnimatedContainer(
          transform: Matrix4.identity()..translate(0.0, -size / 2),
          duration: const Duration(milliseconds: 250),
          height: size,
          width: size,
          child: FittedBox(child: current),
        ),
      ),
    );
  }
}