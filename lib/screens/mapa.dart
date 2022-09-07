import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class mapa extends StatefulWidget {
  double latitud;
  double longitud;
  String nombre;

  mapa(
      {Key? key,
      required this.latitud,
      required this.longitud,
      required this.nombre})
      : super(key: key);

  @override
  State<mapa> createState() => _mapaState();
}

class _mapaState extends State<mapa> {
  @override
  Widget build(BuildContext context) {
    final Completer<GoogleMapController> _controller = Completer();
    final Marker _marcador = Marker(
        markerId: MarkerId(widget.nombre),
        infoWindow: InfoWindow(title: widget.nombre),
        icon: BitmapDescriptor.defaultMarker,
        position: LatLng(widget.latitud, widget.longitud));

    CameraPosition initialPosition = CameraPosition(
        target: LatLng(widget.latitud, widget.longitud), zoom: 16.0);

    return Container(
      decoration: BoxDecoration(border: Border.all(width: .5)),
      height: 250,
      child: GoogleMap(
        initialCameraPosition: initialPosition,
        mapType: MapType.hybrid,
        markers: {_marcador},
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
    );
  }
}
