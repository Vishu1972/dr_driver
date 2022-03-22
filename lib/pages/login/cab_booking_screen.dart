//import 'dart:async';
//import 'dart:developer';
//import 'package:flutter/cupertino.dart';
//import 'package:flutter/material.dart';
//import 'package:flutter_polyline_points/flutter_polyline_points.dart';
//import 'package:geolocator/geolocator.dart';
//import 'package:google_maps_flutter/google_maps_flutter.dart';
//import 'package:intl/intl.dart';
//
//import '../../SlideRightRoute.dart';
//import '../../address/address_search.dart';
//import '../../address/place_service.dart';
//import '../../res/color.dart';
//import '../../res/styles.dart';
//import '../../res/text_size.dart';
//import '../../widget/empty_app_bar.dart';
//
//class DriverDashboard extends StatefulWidget {
//  const DriverDashboard({Key? key}) : super(key: key);
//
//  @override
//  _DriverDashboardState createState() => _DriverDashboardState();
//}
//
//class _DriverDashboardState extends State<DriverDashboard> {
//  final _fromLocationController = TextEditingController();
//  final _toLocationController = TextEditingController();
//  final _dateController = TextEditingController();
//  String currentDate = "";
//  String currentTime = "";
//
//  Completer<GoogleMapController> _controller = Completer();
//
//  static LatLng _center = const LatLng(28.591150, 77.318970);
//
//  final Set<Marker> _markers = {};
//
//  LatLng _lastMapPosition = _center;
//
//  MapType _currentMapType = MapType.normal;
//
//  LatLng _originLocation = LatLng(0.0, 0.0);
//  LatLng _destinationLocation = LatLng(0.0, 0.0);
//
//  Map<PolylineId, Polyline> polylines = {};
//  List<LatLng> polylineCoordinates = [];
//  PolylinePoints polylinePoints = PolylinePoints();
//
//  void _onMapTypeButtonPressed() {
//    setState(() {
//      _currentMapType = _currentMapType == MapType.normal
//          ? MapType.satellite
//          : MapType.normal;
//    });
//  }
//
//  void _onAddMarkerButtonPressed(latLng) {
//
//    setState(() {
//      _markers.add(
//          Marker(
//        // This marker id can be anything that uniquely identifies each marker.
//        markerId: MarkerId((latLng).toString()),
//        position: latLng,
//        infoWindow: InfoWindow(
//          title: 'From Location',
//        ),
//        icon: BitmapDescriptor.defaultMarker,
//      ));
//    });
//  }
//
//  void _getCurrentLocation(){
//    CameraPosition(
//      target: _center,
//      zoom: 15.0,
//    );
//  }
//
//  void _onCameraMove(CameraPosition position) {
//    _lastMapPosition = position.target;
//  }
//
//  void _onMapCreated(GoogleMapController controller) {
//    _controller.complete(controller);
//  }
//
//  // get current location
//  void getCurrentLocation() async{
//    await Geolocator.getCurrentPosition().then((currLocation) {
//      setState(() {
//        _center = LatLng(currLocation.latitude, currLocation.longitude);
//      });
//    });
//  }
//
//  //call this onPress floating action button
//  void _addMarker(latLng) async {
//    final GoogleMapController controller = await _controller.future;
//    getCurrentLocation();
//    controller.animateCamera(CameraUpdate.newCameraPosition(
//      CameraPosition(
//        target: latLng,
//        zoom: 10.0,
//      ),
//    ));
//    _onAddMarkerButtonPressed(latLng);
//
//  }
//
//  void drawRoute(sourceLat, sourceLng, desLat, desLng) async {
//    PolylinePoints polylinePoints = PolylinePoints();
//    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
//        "AIzaSyDugVy4cXmw7FkTqSIRFDpGHkFK0bneWeg",
//        PointLatLng(sourceLat, sourceLng),
//        PointLatLng(desLat, desLng),
//      travelMode: TravelMode.driving
//    );
//    if (result.points.isNotEmpty) {
//      result.points.forEach((PointLatLng point) {
//        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
//      });
//    }
//    _addPolyLine();
//  }
//
//  _addPolyLine() {
//    PolylineId id = PolylineId("poly");
//    Polyline polyline = Polyline(
//        polylineId: id, color: Colors.red, points: polylineCoordinates);
//    polylines[id] = polyline;
//    setState(() {});
//  }
//
//  @override
//  void initState() {
//    // TODO: implement initState
//    super.initState();
//
//    TimeOfDay selectedTime = TimeOfDay.now();
//    DateTime now = DateTime.now();
//    final dt = DateTime(now.year, now.month, now.day, selectedTime.hour, selectedTime.minute);
//    currentDate = getDateFormat(DateTime.now());
//    currentTime = getTimeFormat(dt);
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      backgroundColor: AppColor.WHITE_COLOR,
//      appBar: EmptyAppBar(),
//      body: Stack(
//        fit: StackFit.loose,
//        children: [
//          GoogleMap(
//            onMapCreated: _onMapCreated,
//            initialCameraPosition: CameraPosition(
//              target: _center,
//              zoom: 15.0,
//            ),
//            mapType: _currentMapType,
//            markers: _markers,
//            onCameraMove: _onCameraMove,
//            myLocationEnabled: truea,
//            compassEnabled: true,
//            myLocationButtonEnabled: true,
//
//          ),
//
////          Image.asset(
////            'assets/images/map.JPG',
////            width: double.infinity,
////            height: double.infinity,
////            fit: BoxFit.fill,
////          ),
//
//          Container(
//            child: Column(
//              crossAxisAlignment: CrossAxisAlignment.start,
//              mainAxisAlignment: MainAxisAlignment.start,
//              children: [
//                Container(
//                  margin: const EdgeInsets.only(top: 24, left: 16, right: 16),
//                  child: TextField(
//                    controller: _fromLocationController,
//                    onTap: () async {
//                      final Suggestion? result = await showSearch(
//                        context: context,
//                        delegate: AddressSearch(),
//                      );
//                      // This will change the text displayed in the TextField
//                      if (result != null) {
//                        final place = await PlaceApiProvider().getPlaceLatLng(result.description);
//                        log("Place==$place");
//                        var lat = place['lat'];
//                        var lng = place['lng'];
//                        log("Latitude==$lat");
//                        setState(() {
//                          _originLocation = LatLng(lat, lng);
//                          _addMarker(_originLocation);
//                          if(_toLocationController.text != "") {
//                            drawRoute(
//                                _originLocation.latitude,
//                                _originLocation.longitude,
//                                _destinationLocation.longitude,
//                                _destinationLocation.longitude,
//                            );
//                          }
//                          _fromLocationController.text = result.description;
//                        });
//                      }
//                    },
//                    decoration: InputDecoration(
//                        border: OutlineInputBorder(
//                          borderRadius: BorderRadius.circular(16),
//                        ),
//                        fillColor: Colors.white,
//                        filled: true,
//                        prefixIcon: Icon(Icons.my_location),
//                        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
//                        labelText:"Enter pickup location",
//                        hintStyle: const TextStyle(
//                            fontSize: TextSize.headerText,
//                            fontWeight: FontWeight.w600,
//                            color: Colors.black38
//                        ),
//
//                    ),
//                    style: const TextStyle(
//                        color: Colors.black,
//                        fontWeight: FontWeight.w600,
//                        fontSize: TextSize.subjectText
//                    ),
//                  ),
//                ),
//
//                Container(
//                  margin: const EdgeInsets.only(top: 8, left: 16, right: 16),
//                  child: TextField(
//                    controller: _toLocationController,
//                    onTap: () async {
//                      final Suggestion? result = await showSearch(
//                        context: context,
//                        delegate: AddressSearch(),
//                      );
//                      // This will change the text displayed in the TextField
//                      if (result != null) {
//                        final place = await PlaceApiProvider().getPlaceLatLng(result.description);
//                        log("Place==$place");
//                        var lat = place['lat'];
//                        var lng = place['lng'];
//                        log("Latitude==$lat");
//                        setState(() {
//                          _originLocation = LatLng(lat, lng);
//                          _addMarker(_originLocation);
//                          if(_fromLocationController.text != "") {
//                            drawRoute(
//                              _originLocation.latitude,
//                              _originLocation.longitude,
//                              _destinationLocation.longitude,
//                              _destinationLocation.longitude,
//                            );
//                          }
//                          _toLocationController.text = result.description;
//                        });
//                      }
//                    },
//                    decoration: InputDecoration(
//                        border: OutlineInputBorder(
//                          borderRadius: BorderRadius.circular(16),
//                        ),
//                        fillColor: Colors.white,
//                        filled: true,
//                        prefixIcon: Icon(Icons.near_me),
//                        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
//                        labelText:"Enter dropoff location",
//                        hintStyle: const TextStyle(
//                            fontSize: TextSize.headerText,
//                            fontWeight: FontWeight.w600,
//                            color: Colors.black38
//                        ),
//
//                    ),
//                    style: const TextStyle(
//                        color: Colors.black,
//                        fontWeight: FontWeight.w600,
//                        fontSize: TextSize.subjectText
//                    ),
//                  ),
//                ),
//
////                    InkWell(
////                      onTap: (){
////                        _selectDate(context);
////                      },
////                      child: Container(
////                        margin: const EdgeInsets.only(top: 24, left: 16, right: 16),
////                        padding: EdgeInsets.symmetric(horizontal: 16,vertical: 8),
////                        decoration: BoxDecoration(
////                          color: Colors.white,
////                          borderRadius: BorderRadius.circular(16),
////                          border: Border.all(
////                            color: Colors.blue,
////                            width: 2
////                          )
////                        ),
////                        child: Row(
////                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
////                          crossAxisAlignment: CrossAxisAlignment.center,
////                          children: [
////                            Text(
////                              '$currentDate',
////                              style: const TextStyle(
////                                  color: Colors.black,
////                                  fontWeight: FontWeight.w600,
////                                  fontSize: TextSize.subjectText
////                              ),
////                            ),
////                            const Icon(Icons.date_range)
////                          ],
////                        ),
////                      ),
////                    ),
////                    InkWell(
////                      onTap: (){
////                        _selectTime(context);
////                      },
////                      child: Container(
////                        margin: const EdgeInsets.only(top: 24, left: 16, right: 16),
////                        padding: EdgeInsets.symmetric(horizontal: 16,vertical: 8),
////                        decoration: BoxDecoration(
////                          color: Colors.white,
////                          borderRadius: BorderRadius.circular(16),
////                          border: Border.all(
////                            color: Colors.blue,
////                            width: 2
////                          )
////                        ),
////                        child: Row(
////                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
////                          crossAxisAlignment: CrossAxisAlignment.center,
////                          children: [
////                            Text(
////                              '$currentTime',
////                              style: const TextStyle(
////                                  color: Colors.black,
////                                  fontWeight: FontWeight.w600,
////                                  fontSize: TextSize.subjectText
////                              ),
////                            ),
////                            const Icon(Icons.timer)
////                          ],
////                        ),
////                      ),
////                    ),
//
////                    Container(
////                      margin: const EdgeInsets.only(top: 24, left: 16, right: 16),
////                      child: TextField(
////                        keyboardType: TextInputType.number,
////                        decoration: InputDecoration(
////                            border: OutlineInputBorder(
////                              borderRadius: BorderRadius.circular(16),
////                            ),
////                            fillColor: Colors.white,
////                            filled: true,
////
////                            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
////                            labelText:"No. of Passengers",
////                            hintStyle: const TextStyle(
////                                fontSize: TextSize.headerText,
////                                fontWeight: FontWeight.w600,
////                                color: Colors.black38
////                            ),
////                            suffixIcon: const Icon(Icons.people)
////                        ),
////                        style: const TextStyle(
////                            color: Colors.black,
////                            fontWeight: FontWeight.w600,
////                            fontSize: TextSize.subjectText
////                        ),
////                      ),
////                    ),
//
////                    Container(
////                      margin: const EdgeInsets.only(top: 24, left: 16, right: 16),
////                      child: TextField(
////                        keyboardType: TextInputType.number,
////                        decoration: InputDecoration(
////                          border: OutlineInputBorder(
////                              borderRadius: BorderRadius.circular(16),
////                          ),
////                          fillColor: Colors.white,
////                          filled: true,
////
////                          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
////                          labelText:"No. of Baggage",
////                          hintStyle: const TextStyle(
////                              fontSize: TextSize.headerText,
////                              fontWeight: FontWeight.w600,
////                              color: Colors.black38
////                          ),
////                          suffixIcon: const Icon(Icons.shopping_bag)
////                        ),
////                        style: const TextStyle(
////                            color: Colors.black,
////                            fontWeight: FontWeight.w600,
////                            fontSize: TextSize.subjectText
////                        ),
////                      ),
////                    ),
//
////                      Container(
////                        alignment: Alignment.center,
////                        child: Container(
////                          width: 120,
////                          decoration: BoxDecoration(
////                              color: Colors.orange,
////                              borderRadius: BorderRadius.circular(16)
////                          ),
////                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
////                          margin: const EdgeInsets.only(top:36,left: 0),
////                          alignment: Alignment.topCenter,
////                          child: const Text(
////                            "Book Now",
////                            style: TextStyle(
////                                color: Colors.white,
////                                fontSize: 18
////                            ),
////                          ),
////                        ),
////                      ),
//                const SizedBox(height: 120,)
//              ],
//            ),
//          ),
//
////          Positioned(
////            bottom: 0,
////            left: 0,
////            right: 0,
////            top: MediaQuery.of(context).size.height - 200,
////            child: ConstrainedBox(
////              constraints: BoxConstraints(
////                maxHeight: 180,
////              ),
////              child: Container(
////                decoration: BoxDecoration(
////                  color: AppColor.WHITE_COLOR
////                ),
////                child: ListView.builder(
////                    itemCount: 4,
////                    shrinkWrap: true,
//////                    physics: NeverScrollableScrollPhysics(),
////                    scrollDirection: Axis.horizontal,
////                    itemBuilder: (context, index){
////                      return  InkWell(
////                        onTap: () {
////                          _showDialog(context);
////                        },
////                        child: Container(
////                          margin: const EdgeInsets.only(left: 16, right: 8),
////                          child: Column(
////                            crossAxisAlignment: CrossAxisAlignment.center,
////                            mainAxisAlignment: MainAxisAlignment.center,
////                            children: [
////                              Image.asset(
////                                index == 0
////                                    ? "assets/car/ic_car1.JPG"
////                                    : index==1
////                                    ? "assets/car/ic_car2.JPG"
////                                    : index==2
////                                    ? "assets/car/ic_car3.JPG"
////                                    :"assets/car/ic_car4.JPG",
////                                height: 100,
////                                width: 150,
////                                fit: BoxFit.contain,
////                              ),
////                              Text(
////                                index == 0
////                                    ? "Swift"
////                                    : index==1
////                                    ? "Sydan"
////                                    : index==2
////                                    ? "Car"
////                                    :"Innova",
////                                style: TextStyle(
////                                  fontSize: 18,
////                                  fontWeight: FontWeight.w700
////                                ),
////                              ),
////                              Text(
////                                index == 0
////                                    ? "250 Rs"
////                                    : index==1
////                                    ? "340 Rs"
////                                    : index==2
////                                    ? "120 Rs"
////                                    : "350 Rs",
////                                style: TextStyle(
////                                    fontSize: 18,
////                                    fontWeight: FontWeight.w700
////                                ),
////                              )
////                            ],
////                          ),
////                        ),
////                      );
////                    }
////
////
////                ),
////              ),
////            ),
////          ),
//        ],
//      ),
//    );
//  }
//
//  Future<void> _selectDate(BuildContext context) async {
//    DateTime today = DateTime.now();
//    final DateTime? pickedDate = await showDatePicker(
//        context: context,
//        initialDate: today,
//        firstDate: today,
//        lastDate: DateTime(2050));
//    if (pickedDate != null)
//      setState(() {
//        currentDate = getDateFormat(pickedDate);
//      });
//  }
//
//  _selectTime(BuildContext context) async {
//    TimeOfDay selectedTime = TimeOfDay.now();
//    final TimeOfDay? timeOfDay = await showTimePicker(
//      context: context,
//      initialTime: selectedTime,
//      initialEntryMode: TimePickerEntryMode.dial,
//    );
//    if(timeOfDay != null) {
//      setState(() {
//        currentTime = getTimeFormat(timeOfDay);
////        currentTime = timeOfDay.toString().substring(10);
//      });
//    }
//  }
//
//  String getDateFormat(currentDate) {
//    var formatter = DateFormat('dd-MM-yyyy');
//    String formatted = formatter.format((currentDate));
//    return formatted;
//  }
//
//  String getTimeFormat(currentTime) {
//    final now = new DateTime.now();
//    final dt = DateTime(now.year, now.month, now.day, currentTime.hour, currentTime.minute);
//    var formatter = DateFormat('hh:mm a');
//    String formatted = formatter.format(dt);
//    return formatted;
//  }
////  Future _showDialog(context) {
////    bool _value = false;
////    int? selected = -1;
////    return showDialog<void>(
////      context: context,
////      barrierDismissible: true, // user must tap button!
////      builder: (BuildContext context) {
////        return AlertDialog(
////          shape: RoundedRectangleBorder(
////              borderRadius: BorderRadius.all(Radius.circular(32.0))),
////          content: StatefulBuilder(
////            builder: (context, myState) {
////              return  SingleChildScrollView(
////                  child: Container(
//////                    padding: const EdgeInsets.all(16),
////                    child: Column(
////                      crossAxisAlignment: CrossAxisAlignment.start,
////                      mainAxisAlignment: MainAxisAlignment.start,
////                      children: [
////                        Row(
////                          crossAxisAlignment: CrossAxisAlignment.center,
////                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
////                          children: [
////                            Expanded(child: Container()),
////                            Expanded(
////                              flex: 2,
////                              child: const Text(
////                                'Please Select',
////                                style: TextStyle(
////                                    fontSize: TextSize.headerText,
////                                    fontWeight: FontWeight.w900,
////                                    color: AppColor.BLACK_COLOR
////                                ),
////                              ),
////                            ),
////                            Expanded(
////                              child: InkWell(
////                                onTap: () => {Navigator.of(context).pop()},
////                                child: Container(
////                                  alignment: Alignment.centerRight,
////                                  child: Padding(
////                                    padding: const EdgeInsets.only(right: 0,left: 16),
////                                    child: Icon(Icons.close),
////
////                                  ),
////                                ),
////                              ),
////                            )
////                          ],
////                        ),
////                        SizedBox(height: 16,),
//////                        GestureDetector(
//////                          onTap: (){
//////                            Navigator.push(
//////                                context,
//////                                SlideRightRoute(
//////                                    page: singleTrip()
//////                                )
//////                            );
//////                          },
//////                          child: Container(
//////                            alignment: Alignment.center,
//////                            child: Container(
//////                              decoration: BoxDecoration(
//////                                  color:
//////                                  AppColor.BUTTON_COLOR,
//////                                  borderRadius: BorderRadius.circular(16)
//////                              ),
//////                              padding: const EdgeInsets.symmetric(horizontal: 00, vertical: 12),
//////                              margin: const EdgeInsets.only(top:10, left: 0),
//////                              alignment: Alignment.topCenter,
//////                              child: const Text(
//////                                "Single Trip",
//////                                style: TextStyle(
//////                                    color: Colors.white,
//////                                    fontWeight: FontWeight.w700,
//////                                    fontSize: TextSize.headerText
//////                                ),
//////                              ),
//////                            ),
//////                          ),
//////                        ),
//////                        SizedBox(height: 16,),
//////                        GestureDetector(
//////                          onTap: (){
//////                            Navigator.push(
//////                                context,
//////                                SlideRightRoute(
//////                                    page: RoundTrip()
//////                                )
//////                            );
//////                          },
//////                          child: Container(
//////                            alignment: Alignment.center,
//////                            child: Container(
//////                              decoration: BoxDecoration(
//////                                  color:
//////                                  AppColor.BUTTON_COLOR,
//////                                  borderRadius: BorderRadius.circular(16)
//////                              ),
//////                              padding: const EdgeInsets.symmetric(horizontal: 00, vertical: 12),
//////                              alignment: Alignment.topCenter,
//////                              child: const Text(
//////                                "Round Trip",
//////                                style: TextStyle(
//////                                    color: Colors.white,
//////                                    fontWeight: FontWeight.w700,
//////                                    fontSize: TextSize.headerText
//////                                ),
//////                              ),
//////                            ),
//////
//////                          ),
//////                        ),
////                      ],
////                    ),
////                  )
////              );
////            },
////          ),
////
////        );
////      },
////    );
////  }
//}
