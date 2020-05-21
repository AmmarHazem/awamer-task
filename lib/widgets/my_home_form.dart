import 'package:awamer_task/screens/pick_location_map.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cupertino_date_picker/flutter_cupertino_date_picker.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../helpers.dart';
import 'inputField.dart';

const xPadding = const EdgeInsets.symmetric(horizontal: 30);

class MyHomeForm extends StatefulWidget {
  final void Function(LatLng) onLocationSelected;
  final void Function(DateTime) onDateSelected;
  final void Function(TimeOfDay) onTimeSelected;

  const MyHomeForm({
    Key key,
    @required this.onLocationSelected,
    @required this.onDateSelected,
    @required this.onTimeSelected,
  }) : super(key: key);

  @override
  _MyHomeFormState createState() => _MyHomeFormState();
}

class _MyHomeFormState extends State<MyHomeForm> {
  DateTime _selectedDate;
  TimeOfDay _selectedTime;
  LatLng _pickedLocation;

  void _pickDate() async {
    _selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365)),
    );
    if (_selectedDate == null) return;
    setState(() {});
    widget.onDateSelected(_selectedDate);
  }

  void _selectTime() {
    showDialog(
      context: context,
      builder: (cxt) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        titlePadding: const EdgeInsets.only(top: 10),
        title: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Row(
                children: <Widget>[
                  Icon(
                    Icons.access_time,
                    color: Theme.of(context).accentColor,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    'تحديد الوقت',
                    style: TextStyle(
                      color: Theme.of(context).accentColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Spacer(),
                  SizedBox(
                    width: 35,
                    child: IconButton(
                      padding: const EdgeInsets.all(0),
                      color: Theme.of(context).accentColor,
                      icon: Icon(Icons.close),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                ],
              ),
            ),
            Divider(color: Colors.grey),
          ],
        ),
        content: SingleChildScrollView(
          child: TimePickerWidget(
            locale: DateTimePickerLocale.ar_eg,
            onConfirm: (time, list) {
              setState(() {
                _selectedTime = TimeOfDay.fromDateTime(time);
              });
              widget.onTimeSelected(_selectedTime);
            },
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // final inputBorder = OutlineInputBorder(
    //   borderRadius: BorderRadius.circular(30),
    //   borderSide: BorderSide(color: Theme.of(context).accentColor),
    // );
    final formattedDate = _selectedDate == null
        ? ''
        : '${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}';
    return Column(
      children: <Widget>[
        Padding(
          padding: xPadding,
          child: Row(
            children: <Widget>[
              Text(
                'تحديد عنوانك',
                style: TextStyle(
                  color: Theme.of(context).accentColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 15),
        Padding(
          padding: xPadding,
          child: InputField(
            validator: validateLocation,
            onTap: () async {
              _pickedLocation = await Navigator.push(
                context,
                CupertinoPageRoute(builder: (cxt) => PickLocationMap()),
              );
              widget.onLocationSelected(_pickedLocation);
              setState(() {});
            },
            text: _pickedLocation == null
                ? ''
                : '${_pickedLocation.latitude} - ${_pickedLocation.longitude}',
            trailingIcon: Icon(
              Icons.location_on,
              color: Colors.grey[600],
            ),
          ),
        ),
        // const SizedBox(height: 5),
        // Padding(
        //   padding: xPadding,
        //   child: Row(
        //     children: <Widget>[
        //       Text(
        //         '* لابد من تحديد موقعك',
        //         style: TextStyle(
        //           color: Colors.red,
        //           fontWeight: FontWeight.bold,
        //         ),
        //       ),
        //     ],
        //   ),
        // ),
        Divider(
          color: Colors.grey,
          height: 20,
        ),
        Padding(
          padding: xPadding,
          child: Row(
            children: <Widget>[
              Text(
                'تحديد التاريخ',
                style: TextStyle(
                  color: Theme.of(context).accentColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 15),
        Padding(
          padding: xPadding,
          child: InputField(
            validator: validateDate,
            onTap: _pickDate,
            text: formattedDate,
            trailingIcon: Icon(
              Icons.calendar_today,
              color: Colors.grey[600],
            ),
          ),
        ),
        Divider(
          color: Colors.grey,
          height: 40,
        ),
        Padding(
          padding: xPadding,
          child: Row(
            children: <Widget>[
              Text(
                'تحديد الوقت',
                style: TextStyle(
                  color: Theme.of(context).accentColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 15),
        Padding(
          padding: xPadding,
          child: InputField(
            validator: validateTime,
            onTap: _selectTime,
            text: _selectedTime == null
                ? ''
                : '${_selectedTime.hourOfPeriod}:${_selectedTime.minute} ${_selectedTime.period == DayPeriod.am ? 'AM' : 'PM'}',
            trailingIcon: Icon(
              Icons.access_time,
              color: Colors.grey[600],
            ),
          ),
        ),
        Divider(
          color: Colors.grey,
          height: 40,
        ),
        Padding(
          padding: xPadding,
          child: Row(
            children: <Widget>[
              Text(
                'إدخال كوبون الخصم',
                style: TextStyle(
                  color: Theme.of(context).accentColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 15),
        Padding(
          padding: xPadding,
          child: Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Theme.of(context).accentColor),
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color: Theme.of(context).accentColor.withOpacity(0.5),
                        blurRadius: 3,
                      )
                    ],
                  ),
                  child: TextField(
                    expands: false,
                    cursorColor: Theme.of(context).accentColor,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 15,
                      ),
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                    ),
                  ),
                ),
              ),
              Spacer(),
            ],
          ),
        ),
      ],
    );
  }
}
