import 'package:bakraw/model/useraddressmodel.dart';
import 'package:bakraw/utils/GroceryColors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../editadduseraddress.dart';

class GoogleMapActivity extends StatefulWidget {
  static const Tag = '/GoogleMap';

  @override
  _GoogleMapActivityState createState() => _GoogleMapActivityState();
}

class _GoogleMapActivityState extends State<GoogleMapActivity> {
  Data data;
  var latlong;
  GoogleMapController _mapController;
  static CameraPosition initialposition;
  bool isLoading = false;
  var check;

  Set<Marker> _marker = {};

  void getCurrentLocation() async {
    var target;
    await Geolocator.getLastKnownPosition().then((value) {
      setState(() {
        target = LatLng(value.latitude, value.longitude);
        initialposition = CameraPosition(target: target, zoom: 15);
        isLoading = true;
      });
    });

    if (_mapController != null) {
      setMarker(target);
      _mapController.animateCamera(CameraUpdate.newLatLng(target));
    }
  }

  void convertAddress(LatLng pos) async {
    setState(() {
      isLoading = false;
    });
    List<Placemark> _place =
        await placemarkFromCoordinates(pos.latitude, pos.longitude);
    Data useraddress = Data(
      id: data != null ? data.id : '',
      firstName: data != null ? data.firstName : '',
      lastName: data != null ? data.lastName : '',
      address1: '${_place[0].name} ${_place[0].street}',
      address2: '${_place[0].subLocality} ${_place[0].locality}',
      city: '${_place[0].subAdministrativeArea}',
      state: '${_place[0].administrativeArea}',
      country: '${_place[0].country}',
      zip: '${_place[0].postalCode}',
    );
    await Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => EditUserAddress(
                  model: useraddress,
                  isnav: check['isnav'],
                )));
  }

  void setMarker(LatLng pos) async {
    initialposition = CameraPosition(target: pos, zoom: 10);
    setState(() {
      _marker.add(Marker(
        markerId: MarkerId('mark-001'),
        position: initialposition.target,
        onDragEnd: (position) {
          initialposition = CameraPosition(target: position, zoom: 10);
        },
        draggable: true,
      ));
    });
    if (_mapController != null) {
      _mapController.animateCamera(CameraUpdate.newLatLng(pos));
    }
  }

  void setUserAddress() async {
    String address =
        '${data.address1} ${data.address2} ${data.city} ${data.state} ${data.country} - ${data.zip}';
    List<Location> mypos = await locationFromAddress(address);
    latlong = LatLng(mypos[0].latitude, mypos[0].longitude);
    initialposition = CameraPosition(target: latlong, zoom: 17);
    setMarker(latlong);
    setState(() {
      isLoading = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    check = ModalRoute.of(context).settings.arguments as Map;
    if (isLoading == false) {
      if (check['data'] != null) {
        data = check['data'];
        setUserAddress();
      } else {
        getCurrentLocation();
      }
    }
    return WillPopScope(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_rounded,
              color: Colors.white,
            ),
            onPressed: () async {
              await Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => EditUserAddress(
                            model: check['data'],
                            isnav: check['isnav'],
                          )));
            },
          ),
          title: Text('Select Delivery Location'),
        ),
        body: isLoading
            ? Stack(
                children: [
                  GoogleMap(
                    markers: _marker,
                    mapType: MapType.normal,
                    initialCameraPosition: initialposition,
                    onMapCreated: (controller) {
                      setState(() {
                        _mapController = controller;
                      });
                      setMarker(initialposition.target);
                    },
                    indoorViewEnabled: true,
                    compassEnabled: true,
                    mapToolbarEnabled: true,
                    zoomGesturesEnabled: true,
                    buildingsEnabled: true,
                    zoomControlsEnabled: true,
                    onTap: (cordinate) {
                      setMarker(cordinate);
                      _mapController
                          .animateCamera(CameraUpdate.newLatLng(cordinate));
                    },
                  ),
                  isLoading
                      ? Positioned(
                          top: 0,
                          right: 0,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Tooltip(
                              message: 'My currrent location',
                              waitDuration: Duration(milliseconds: 200),
                              child: Container(
                                height: 40,
                                width: 40,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      primary: grocery_colorPrimary,
                                      padding: EdgeInsets.only(
                                          right: 5,
                                          left: 5,
                                          top: 5,
                                          bottom: 5)),
                                  onPressed: () {
                                    setState(() {
                                      isLoading = false;
                                    });
                                    getCurrentLocation();
                                  },
                                  child: Center(
                                    child: Icon(
                                      Icons.my_location,
                                      color: CupertinoColors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                      : Container(),
                  isLoading
                      ? Positioned(
                          bottom: 0,
                          left: MediaQuery.of(context).size.width / 3.5,
                          right: MediaQuery.of(context).size.width / 3.5,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: grocery_colorPrimary,
                                  padding: EdgeInsets.only(
                                      right: 5, left: 5, top: 5, bottom: 5)),
                              onPressed: () {
                                convertAddress(initialposition.target);
                              },
                              child: Center(child: Text('Mark This Address')),
                            ),
                          ),
                        )
                      : Container()
                ],
              )
            : Container(
                color: Colors.green.shade50,
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
      ),
      onWillPop: () async {
        await Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => EditUserAddress(
                      model: check['data'],
                      isnav: check['isnav'],
                    )));
        return;
      },
    );
  }

  @override
  void initState() {}
}
