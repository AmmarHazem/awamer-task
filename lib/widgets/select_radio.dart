import 'package:flutter/material.dart';

class SelectRadio extends StatelessWidget {
  final bool selected;
  final String text;
  final Function onTap;

  const SelectRadio({
    Key key,
    @required this.selected,
    @required this.text,
    @required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: <Widget>[
          AnimatedContainer(
            duration: Duration(milliseconds: 150),
            width: 15,
            height: 15,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey[600]),
              shape: BoxShape.circle,
              color: selected ? Colors.grey[600] : Colors.transparent,
            ),
          ),
          const SizedBox(width: 10),
          Text(
            text,
            // style: TextStyle(color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }
}
