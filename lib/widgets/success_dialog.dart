import 'package:awamer_task/screens/request_service.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../models.dart';

class SuccessDialog extends StatelessWidget {
  const SuccessDialog({
    Key key,
    @required this.selecedMethod,
    @required this.selectedLocation,
    @required this.selectedDate,
    @required this.selectedTime,
    @required this.options,
    @required this.totalPrice,
  }) : super(key: key);

  final int selecedMethod;
  final double totalPrice;
  final LatLng selectedLocation;
  final DateTime selectedDate;
  final TimeOfDay selectedTime;
  final List<ServiceOption> options;

  @override
  Widget build(BuildContext context) {
    print('');
    return AlertDialog(
      title: Text('تم تسجيل الحجز'),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Text(
                  'طريقة تلقى الخدمة:',
                  style: TextStyle(
                    color: Theme.of(context).accentColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 15),
                Text(selecedMethod == 0 ? 'منزلى' : 'منزل مقدم الخدمة'),
              ],
            ),
            if (selectedLocation != null)
              Row(
                children: <Widget>[
                  Text(
                    'العنوان',
                    style: TextStyle(
                      color: Theme.of(context).accentColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: Text(
                      '${selectedLocation.latitude} - ${selectedLocation.longitude}',
                    ),
                  ),
                ],
              ),
            Row(
              children: <Widget>[
                Text(
                  'التاريخ',
                  style: TextStyle(
                    color: Theme.of(context).accentColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: Text(
                    '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}',
                  ),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Text(
                  'الوقت',
                  style: TextStyle(
                    color: Theme.of(context).accentColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: Text(
                    '${selectedTime.hourOfPeriod}:${selectedTime.minute} ${selectedTime.period == DayPeriod.am ? 'AM' : 'PM'}',
                  ),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Text(
                  'الخدمات',
                  style: TextStyle(
                    color: Theme.of(context).accentColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            ...options.map<Widget>((option) {
              return ServiceOptionRow(
                option: option,
                showDetails: false,
              );
            }).toList(),
            Row(
              children: <Widget>[
                Text(
                  'إجمالى التكلفة',
                  style: TextStyle(
                    color: Theme.of(context).accentColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 15),
                Text(
                  '${totalPrice.toStringAsFixed(2)} رس',
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
