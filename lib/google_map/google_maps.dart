import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapScreen extends StatefulWidget {
  final dynamic user;
  const GoogleMapScreen({super.key, required this.user});

  @override
  State<GoogleMapScreen> createState() => _GoogleMapScreenState();
}

class _GoogleMapScreenState extends State<GoogleMapScreen> {
  Completer<GoogleMapController> _controller = Completer();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Location'),
        centerTitle: true,
      ),
      body: SafeArea(
          child: GoogleMap(
        initialCameraPosition: CameraPosition(
            target: LatLng(widget.user['latitude'], widget.user['longitude']),
            zoom: 14),
        mapType: MapType.normal,
        onMapCreated: ((controller) {
          _controller.complete(controller);
        }),
      )),
    );
  }
}
