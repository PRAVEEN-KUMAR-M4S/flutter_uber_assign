import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_places_flutter/model/prediction.dart';
import 'package:uber_clone/core/common/widgets/search_box_place.dart';
import 'package:uber_clone/core/utils/snack_bar.dart';
import 'package:uber_clone/faetures/home/bloc/fetch_data_bloc.dart';
import 'package:uber_clone/faetures/home/view/widgets/slider.dart';
import 'package:uber_clone/faetures/models/driver_model.dart';
import 'package:uber_clone/faetures/models/user_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<DriverModel> drivers = [];
  UserModel? userModel;
  final List<Marker> _markers = <Marker>[];
  int markerCounte = 0;
  final Completer<GoogleMapController> _controller = Completer();
  bool searchToggle = false;

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.7749, -122.4157),
    zoom: 12,
  );

  @override
  void initState() {
    context.read<FetchDataBloc>().add(FetchUserData());
    context.read<FetchDataBloc>().add(FetchDriverData());
    super.initState();
  }

  Future<void> gotoSearchPlace(double lat, double long) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: LatLng(lat, long), zoom: 15)));
  }

  _setNearMarker(LatLng point) async {
    var counter = markerCounte++;

    final Uint8List markerIcon =
        await getByteFromeAssets('assets/icon1.png', 80);

    final Marker marker = Marker(
        markerId: MarkerId('marker_$counter'),
        position: point,
        onTap: () {},
        icon: BitmapDescriptor.fromBytes(markerIcon));
    setState(() {
      _markers.add(marker);
    });
  }

  refreash() {
    context.read<FetchDataBloc>().add(FetchUserData());
  }

  Future<Uint8List> getByteFromeAssets(String path, int width) async {
    ByteData data = await rootBundle.load(path);

    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenwidth = MediaQuery.of(context).size.width;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            searchToggle = !searchToggle;
          });
        },
        child: Icon(!searchToggle ? Icons.search : Icons.menu),
      ),
      body: BlocConsumer<FetchDataBloc, FetchDataState>(
        listener: (context, state) {
          if (state is FetchDataFailure) {
            showSnackBar(context, state.error);
          } else if (state is BookRideSuccess) {
            return showSnackBar(context, "Booking for the Cab successful");
          }
        },
        builder: (context, state) {
          if (state is FetchDataLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is FetchDriverDataSuccess) {
            drivers = state.drivers;

            for (var element in drivers) {
              _setNearMarker(LatLng(element.lat, element.long));
            }
          } else if (state is FetchUserDataSuccess) {
            userModel = state.userModel;
            gotoSearchPlace(state.userModel.lat, state.userModel.long);
          }

          return Stack(
            children: [
              SizedBox(
                height: screenHeight,
                width: screenwidth,
                child: GoogleMap(
                    markers: Set<Marker>.of(_markers),
                    mapType: MapType.normal,
                    mapToolbarEnabled: false,
                    onMapCreated: (GoogleMapController controller) {
                      _controller.complete(controller);
                    },
                    initialCameraPosition: _kGooglePlex),
              ),
              searchToggle == true
                  ? Positioned(
                      top: 30,
                      left: 5,
                      right: 5,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          SizedBox(
                              height: 60,
                              child: SearchBoxPlace(
                                prediction: (Prediction prediction) {
                                  gotoSearchPlace(double.parse(prediction.lat!),
                                      double.parse(prediction.lng!));
                                },
                              )),
                        ],
                      ))
                  : Container(),
              !searchToggle
                  ? Positioned(
                      bottom: 1,
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        alignment: Alignment.bottomCenter,
                        height: screenHeight * 0.4,
                        width: screenwidth,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(16),
                              topRight: Radius.circular(16)),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color:
                                  Colors.black.withOpacity(0.2), // shadow color
                              spreadRadius: 1, // spread radius
                              blurRadius: 5, // blur radius
                              offset: const Offset(0,
                                  3), // changes position of shadow to the bottom
                            ),
                          ],
                        ),
                        child: userModel != null
                            ? Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      const Icon(Icons.person),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Text(userModel!.name)
                                    ],
                                  ),
                                  const Divider(),
                                  SliderWidget(
                                    height: 200,
                                    drivers: drivers,
                                    userModel: userModel!,
                                  )
                                ],
                              )
                            : Align(
                                alignment: Alignment.topRight,
                                child: IconButton(
                                    onPressed: refreash,
                                    icon: const Icon(Icons.refresh))),
                      ),
                    )
                  : Container()
            ],
          );
        },
      ),
    );
  }
}
