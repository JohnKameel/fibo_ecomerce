import 'dart:async';

import 'package:fido_e/core/routing/router_app.dart';
import 'package:fido_e/core/style/app_colors.dart';
import 'package:fido_e/core/widgets/custom_primary_button.dart';
import 'package:fido_e/core/widgets/spacing_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../data/repo/location_repo.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  String cityName = 'Loading...';
  late BitmapDescriptor customMarkerIcon;
  Completer<GoogleMapController> _controller = Completer<GoogleMapController>();

  late LatLng currentLocation;
  CameraPosition initialCameraPosition = const CameraPosition(
    target: LatLng(30.033333, 31.233334),
    zoom: 16,
  );

  Set<Marker> Markers = {
    Marker(
      markerId: MarkerId('marker_1'),
      position: LatLng(30.033333, 31.233334),
      infoWindow: InfoWindow(title: 'Marker 1', snippet: 'This is marker 1'),
      icon: BitmapDescriptor.defaultMarker,
      // draggable: true,
      // onDragEnd: (e) {},
    ),
    Marker(
      markerId: MarkerId('marker_2'),
      position: LatLng(30.034000, 31.234000),
      infoWindow: InfoWindow(title: 'Marker 2', snippet: 'This is marker 2'),
    ),
  };

  getCurrentLocation() async {
    final getPosition = await LocationRepo().determinePosition();
    setState(() {
      currentLocation = LatLng(getPosition.latitude, getPosition.longitude);
      Markers = {
        Marker(
          markerId: MarkerId('1'),
          position: currentLocation,
          icon: customMarkerIcon,
          // draggable: true,
          // onDragEnd: (e) {},    to make marker move
          infoWindow: InfoWindow(
            title: 'Current Location',
            snippet: 'This is your current location',
          ),
        ),
      };
    });

    moveToPosition(currentLocation);

    try{
    List<Placemark> placemarks = await placemarkFromCoordinates(getPosition.latitude, getPosition.longitude);

    if (placemarks.isNotEmpty) {
      Placemark place = placemarks[0];
      String? city = place.locality ?? place.subAdministrativeArea ??
          place.administrativeArea;

      setState(() {
        cityName = city!;
      });
    } else {
      setState(() {
        cityName = 'Unknown City';
      });
    }
    } catch (e) {
      print('Error fetching placemark: $e');
      setState(() {
        cityName = 'Error fetching location';
      });
    }
  }

  Future<void> loadCustomMarkerIcon() async {
    customMarkerIcon = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration(size: Size(48.w, 48.h)),
      'assets/icons/homeicon2.png',
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadCustomMarkerIcon();
    getCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
            markers: Markers,
            mapType: MapType.normal,
            initialCameraPosition: initialCameraPosition,
          ),
          Positioned(
            bottom: 0,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 150,
              color: Colors.white,
              child: Center(
                child: Column(
                  children: [
                    HeightSpace(10.h),
                    Text(
                      'Current Location: $cityName',
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    HeightSpace(20.h),
                    CustomPrimaryButton(
                      onPress: () {
                        context.go(RouterApp.home);
                      },
                      buttonText: 'Save Location',
                      width: 325.w,
                      textColor: AppColors.primary,
                      buttonColor: AppColors.primaryColor,
                    ),
                  ],
                ),
              ),
            ),
          ),

        ],
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () async {
      //     moveToPosition(currentLocation);
      //   },
      //   child: const Icon(Icons.fmd_good_rounded),
      // ),
    );
  }

  Future<void> moveToPosition(LatLng location) async {
    GoogleMapController controller = await _controller.future;
    controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: location,
          zoom: 16,
        ),
      ),
    );
  }
}
