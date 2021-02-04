import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:presto_mobile/constants/route_names.dart';
import 'package:presto_mobile/core/models/transaction_model.dart';
import 'package:presto_mobile/core/services/firestore_service.dart';
import 'package:presto_mobile/core/services/navigation_service.dart';
import 'package:presto_mobile/locator.dart';
import 'package:presto_mobile/ui/resources/Colors.dart' as color;

class BufferView extends StatefulWidget {
  final String transactionId;

  BufferView({this.transactionId});

  @override
  _BufferViewState createState() => _BufferViewState();
}

class _BufferViewState extends State<BufferView>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation animation;
  double animationValue;
  Completer<GoogleMapController> mapController = Completer();
  Position location;

  @override
  void initState() {
    super.initState();
    startTimer();
//    getLocation();
    controller =
        AnimationController(duration: const Duration(seconds: 30), vsync: this);
    animation = Tween(begin: 0, end: 1.0).animate(controller)
      ..addListener(() {
        setState(() async {
          animationValue = animation.value;
          location = await Geolocator.getCurrentPosition();
          // Change here any Animation object value.
        });
      });
  }

  @override
  void dispose() {
    controller.stop();
    super.dispose();
  }

  Timer _timer;
  int _start = 60;

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          timer.cancel();

          ///Move to Failure Screen
          _navigationService.navigateTo(FailureViewRoute, true);
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  FireStoreService _fireStoreService = FireStoreService();
  NavigationService _navigationService = locator<NavigationService>();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _fireStoreService.transaction(widget.transactionId),
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot is DocumentSnapshot) {
          TransactionModel transactionModel =
              TransactionModel.fromJson(snapshot.data());
          if (transactionModel.approvedStatus) {
            ///Go to Success Page
            _timer.cancel();
            _navigationService.navigateTo(
              SuccessViewRoute,
              true,
              arguments: transactionModel,
            );
          }
        }

        return SafeArea(
          child: Scaffold(
            body: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width / 1.5,
                    height: MediaQuery.of(context).size.height / 1.25,
                    child: GoogleMap(
                      onMapCreated: (mapController) {
                        this.mapController.complete(mapController);
                      },
                      scrollGesturesEnabled: false,
                      myLocationEnabled: true,
                      myLocationButtonEnabled: false,
                      initialCameraPosition: CameraPosition(
                        target: LatLng(location.latitude, location.longitude),
                        zoom: 15.0,
                      ),
                      markers: {
                        Marker(
                            markerId: MarkerId("You"),
                            icon: BitmapDescriptor.defaultMarkerWithHue(200),
                            position:
                                LatLng(location.latitude, location.longitude),
                            infoWindow:
                                InfoWindow(title: "You", snippet: 'Open Now')),
                      },
                    ),
                  ),
                ),
                LinearProgressIndicator(
                  value: animationValue,
                ),
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 10,
                    decoration:
                        BoxDecoration(border: Border.all(color: color.color1)),
                    child: Center(
                      child: Text(
                        'Money on the Way!',
                        style: TextStyle(color: color.color1, fontSize: 20.0),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
