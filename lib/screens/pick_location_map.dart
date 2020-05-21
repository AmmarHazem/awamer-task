import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PickLocationMap extends StatefulWidget {
  @override
  _PickLocationMapState createState() => _PickLocationMapState();
}

class _PickLocationMapState extends State<PickLocationMap> {
  LatLng _pickedLocation;

  @override
  Widget build(BuildContext context) {
    final initialLocation = LatLng(31.0346207726, 31.382392194);
    return Scaffold(
      body: WillPopScope(
        onWillPop: () async {
          Navigator.pop(context, _pickedLocation ?? initialLocation);
          return true;
        },
        child: SafeArea(
          child: Stack(
            children: <Widget>[
              GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: initialLocation,
                  zoom: 15,
                ),
                onTap: (location) {
                  setState(() {
                    _pickedLocation = location;
                  });
                },
                markers: _pickedLocation == null
                    ? null
                    : {
                        Marker(
                          markerId: MarkerId('picked-location'),
                          position: _pickedLocation,
                        ),
                      },
              ),
              Positioned(
                top: 10,
                right: 10,
                child: IconButton(
                  icon: Icon(Icons.menu),
                  onPressed: () {},
                  color: Theme.of(context).accentColor,
                ),
              ),
              Positioned(
                top: 15,
                left: 20,
                right: 60,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  width: 100,
                  height: 40,
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.location_on,
                        color: Colors.red,
                      ),
                      const SizedBox(width: 10),
                      Text('طريق السعودية حائل جدة')
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: 120,
                right: 10,
                child: SizedBox(
                  width: 35,
                  child: FlatButton(
                    shape: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide:
                          BorderSide(color: Theme.of(context).accentColor),
                    ),
                    padding: const EdgeInsets.all(0),
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    color: Theme.of(context).accentColor,
                    child: Icon(
                      Icons.my_location,
                      color: Colors.white,
                    ),
                    onPressed: () {},
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: SizedBox(
                  width: double.infinity,
                  child: FlatButton(
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(35),
                        topRight: Radius.circular(35),
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    child: Text('تحديد الأقرب'),
                    onPressed: () => Navigator.pop(
                      context,
                      _pickedLocation ?? initialLocation,
                    ),
                    color: Theme.of(context).accentColor,
                    textColor: Colors.white,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
