import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Service extends StatelessWidget {
  final String name;
  final bool selected;
  final double price;
  final Duration duration;
  final Function onTap;

  const Service({
    Key key,
    @required this.name,
    @required this.selected,
    @required this.price,
    @required this.duration,
    @required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            border: Border(
          top: BorderSide(color: Colors.grey, width: 0.5),
          // bottom: BorderSide(color: Colors.grey, width: 0.5),
        )),
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 5,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              flex: 2,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.only(top: 5),
                    width: 15,
                    height: 15,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.grey[600],
                        width: 2,
                      ),
                    ),
                    padding: const EdgeInsets.all(2),
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 150),
                      decoration: BoxDecoration(
                        color: selected ? Colors.grey[600] : Colors.white,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              flex: 5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    name,
                    // style: TextStyle(color: Colors.grey[600]),
                  ),
                  Row(
                    children: <Widget>[
                      Icon(
                        FontAwesomeIcons.moneyBill,
                        color: Colors.grey[600],
                        size: 15,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        '${price.toStringAsFixed(0)} رس',
                        // style: TextStyle(color: Colors.grey[600]),
                      ),
                      const SizedBox(width: 20),
                      Icon(
                        Icons.access_time,
                        color: Colors.grey[600],
                        size: 15,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        '${duration.inMinutes} د',
                        // style: TextStyle(color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
