import 'package:awamer_task/widgets/service.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../models.dart';

class ServicesGroup extends StatefulWidget {
  final bool expanded;
  final Function onTap;
  final ServiceModel service;
  final void Function(int, int) onOptionSelected;

  const ServicesGroup({
    Key key,
    @required this.service,
    @required this.onTap,
    @required this.onOptionSelected,
    this.expanded: false,
  }) : super(key: key);

  @override
  _ServicesGroupState createState() => _ServicesGroupState();
}

class _ServicesGroupState extends State<ServicesGroup> {
  var _selectedService = <int>[];

  void _selectService(int index) {
    if (_selectedService.contains(index)) return;
    setState(() {
      _selectedService.add(index);
    });
    widget.onOptionSelected(index, widget.service.id);
  }

  @override
  Widget build(BuildContext context) {
    final animationDuration = Duration(milliseconds: 250);
    final expandedHeight = widget.service.options.length * 71;
    return InkWell(
      onTap: widget.onTap,
      child: AnimatedContainer(
        height: widget.expanded ? expandedHeight.toDouble() : 60,
        curve: Curves.easeOutCubic,
        duration: animationDuration,
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 15,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    widget.service.name,
                    style: TextStyle(color: Theme.of(context).accentColor),
                  ),
                  Icon(
                    widget.expanded
                        ? FontAwesomeIcons.chevronUp
                        : FontAwesomeIcons.chevronDown,
                    color: Theme.of(context).accentColor,
                    size: 15,
                  ),
                ],
              ),
            ),
            AnimatedSwitcher(
              duration: animationDuration,
              child: widget.expanded
                  ? Column(
                      children: widget.service.options.map((e) {
                        return Service(
                          duration: e.duration,
                          name: e.name,
                          onTap: () => _selectService(e.id),
                          price: e.price,
                          selected: _selectedService.contains(e.id),
                        );
                      }).toList(),
                    )
                  : const SizedBox(),
            ),
          ],
        ),
      ),
    );
  }
}
