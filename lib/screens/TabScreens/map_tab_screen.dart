import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mca_project/service/location_services.dart';
import 'package:mca_project/service/maps_service.dart';
import 'package:provider/provider.dart';

class MapTabScreen extends StatefulWidget {
  const MapTabScreen({Key? key}) : super(key: key);

  @override
  State<MapTabScreen> createState() => _MapTabScreenState();
}

class _MapTabScreenState extends State<MapTabScreen> {
  static const _initialCameraPosition = CameraPosition(
      target: LatLng(26.173887784420405, 91.7765664980727), zoom: 11.5);

  //Text Controllers

  TextEditingController _originController = TextEditingController();
  TextEditingController _destinationController = TextEditingController();

  late GoogleMapController _googleMapController;
  Completer<GoogleMapController> _controller = Completer();

  Set<Marker> _markers = Set<Marker>();
  Set<Polygon> _polygons = Set<Polygon>();
  Set<Polyline> _polyline = Set<Polyline>();
  List<LatLng> polygonLatLngs = <LatLng>[];

  int _polygonIdCounter = 1;
  int _polylineIdCounter = 1;

  @override
  void initState() {
    super.initState();
    setMarkerToPosition();
  }

  void _setMarker(LatLng point) {
    setState(() {
      _markers.add(
        Marker(markerId: MarkerId('marker'), position: point),
      );
    });
  }

  void setMarkerToPosition() async{
    var value = await Provider.of<GenerateMaps>(context, listen: false).getCurrentLocation();
    setState(() {
          _markers.add(
            Marker(markerId: MarkerId('User Location'), position: LatLng(value.latitude, value.longitude)),

      );
          animateCameraToCurrentLocation();
    });
  }

  void _setPolygon() {
    final String polygonIdVal = 'polygon_$_polygonIdCounter';
    _polygonIdCounter++;

    _polygons.add(
      Polygon(
        polygonId: PolygonId(polygonIdVal),
        points: polygonLatLngs,
        strokeWidth: 2,
        fillColor: Colors.transparent,
      ),
    );
  }

  void _setPolyline(List<PointLatLng> points){
    final String polylineIdVal = 'polyline_$_polylineIdCounter';
    _polylineIdCounter++;

    _polyline.add(
      Polyline(
          polylineId: PolylineId(polylineIdVal),
          width: 2,
        color: Colors.blue,
        points: points.map(
                (point) => LatLng(point.latitude, point.longitude)
        ).toList(),
      )
    );

  }

  @override
  void dispose() {
    _googleMapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text(finalAddress),
          // Row(
          //   children: [
          //     Expanded(
          //       child: Column(
          //         children: [
          //           TextFormField(
          //             controller: _originController,
          //             textCapitalization: TextCapitalization.words,
          //             decoration: InputDecoration(hintText: 'Origin'),
          //             onChanged: (value) {
          //               print(value);
          //             },
          //           ),
          //           TextFormField(
          //             controller: _destinationController,
          //             textCapitalization: TextCapitalization.words,
          //             decoration: InputDecoration(hintText: 'Destination'),
          //             onChanged: (value) {
          //               print(value);
          //             },
          //           ),
          //         ],
          //       ),
          //     ),
          //     IconButton(
          //         onPressed: () async {
          //           print("object");
          //           var directions = await LocationServices().getDirections(
          //               _originController.text,
          //               _destinationController.text
          //           );
          //           _goToPlace(
          //               directions['start_location']['lat'],
          //               directions['start_location']['lng'],
          //               directions['bounds_ne'],
          //               directions['bounds_sw'],
          //           );
          //
          //           _setPolyline(directions['polyline_decoded']);
          //
          //           // var place = await LocationServices()
          //           //     .getPlace(_originController.text);
          //           // print(place);
          //           // _goToPlace(place);
          //         },
          //         icon: Icon(Icons.search)),
          //   ],
          // ),

          Expanded(
            child: GoogleMap(
              initialCameraPosition: _initialCameraPosition,
              zoomControlsEnabled: false,
              myLocationButtonEnabled: false,
              onMapCreated: (controller) => _googleMapController = controller,
              markers: _markers,
              polygons: _polygons,
              polylines: _polyline,
              onTap: (point){
                setState(() {
                  polygonLatLngs.add(point);
                  _setPolygon();
                });
              },
              // onLongPress: _addMarker,
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        onPressed: setMarkerToPosition,
        child: const Icon(Icons.center_focus_strong),
      ),
    );
  }

  Future<void> _goToPlace(
      double lat,
      double lng,
      Map<String, dynamic> boundsNe,
      Map<String, dynamic> boundsSw,
      ) async {
    // final double lat = place['geometry']['location']['lat'];
    // final double lng = place['geometry']['location']['lng'];
    _googleMapController.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(lat, lng),
          zoom: 12,
        ),
      ),
    );

    _googleMapController.animateCamera(
      CameraUpdate.newLatLngBounds(
        LatLngBounds(
            southwest: LatLng(boundsSw['lat'], boundsSw['lng']),
            northeast: LatLng(boundsNe['lat'], boundsNe['lng']),
        ),
        25,
      )
    );

    _setMarker(LatLng(lat, lng));
  }

  // void _addMarker(LatLng pos) {
  //   if (_origin == null || (_origin != null && _destination != null)) {
  //     setState(() {
  //       _origin = Marker(
  //         markerId: const MarkerId('origin'),
  //         infoWindow: const InfoWindow(title: 'Origin'),
  //         icon: BitmapDescriptor.defaultMarkerWithHue(
  //             BitmapDescriptor.hueGreen),
  //         position: pos,
  //       );
  //       _destination = null!;
  //     });
  //   }
  //   else {
  //     setState(() {
  //       _destination = Marker(
  //         markerId: const MarkerId('destination'),
  //         infoWindow: const InfoWindow(title: 'Destination'),
  //         icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
  //         position: pos,
  //       );
  //     });
  //   }
  // }

  void animateCameraToCurrentLocation() async{
    Provider.of<GenerateMaps>(context, listen: false).getCurrentLocation().then((value) =>
        _googleMapController.animateCamera(
          CameraUpdate.newCameraPosition(
              CameraPosition(
                  target: LatLng(value.latitude, value.longitude), zoom: 15),

          ),
        )
    );
  }


}
