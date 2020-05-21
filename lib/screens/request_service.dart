import 'package:awamer_task/models.dart';
import 'package:awamer_task/widgets/my_home_form.dart';
import 'package:awamer_task/widgets/provider_home_form.dart';
import 'package:awamer_task/widgets/select_radio.dart';
import 'package:awamer_task/widgets/success_dialog.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class RequestService extends StatefulWidget {
  final List<int> selectedServices;
  final List<int> selectedOptions;
  final Provider provider;

  const RequestService({
    Key key,
    @required this.selectedServices,
    @required this.selectedOptions,
    @required this.provider,
  }) : super(key: key);

  @override
  _RequestServiceState createState() => _RequestServiceState();
}

const xPadding = const EdgeInsets.symmetric(horizontal: 30);

class _RequestServiceState extends State<RequestService> {
  final _formKey = GlobalKey<FormState>();
  var _selecedMethod = 0;
  LatLng _selectedLocation;
  DateTime _selectedDate;
  TimeOfDay _selectedTime;
  List<ServiceOption> _options = [];

  @override
  void initState() {
    super.initState();

    widget.provider.services
        .where((service) => widget.selectedServices.contains(service.id))
        .forEach((service) {
      final selectedOptions = service.options
          .where((option) => widget.selectedOptions.contains(option.id))
          .toList();
      _options.addAll(selectedOptions);
    });
  }

  double _getTotalPrice() {
    var total = 0.0;
    _options.forEach((element) {
      total += element.price;
    });
    return total;
  }

  void _onTimeSelected(TimeOfDay time) {
    _selectedTime = time;
  }

  void _onDateSelected(DateTime date) {
    _selectedDate = date;
  }

  void _onLocationSelected(LatLng location) {
    _selectedLocation = location;
  }

  void _selectMethod(int index) {
    if (_selecedMethod == index) return;
    setState(() {
      _selecedMethod = index;
    });
  }

  void _completeReservation() {
    if (!_formKey.currentState.validate()) return;
    showDialog(
      context: context,
      builder: (cxt) => SuccessDialog(
        selecedMethod: _selecedMethod,
        selectedLocation: _selectedLocation,
        selectedDate: _selectedDate,
        selectedTime: _selectedTime,
        options: _options,
        totalPrice: _getTotalPrice(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final listItems = <Widget>[
      Container(
        width: double.infinity,
        padding: const EdgeInsets.only(top: 30),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(40),
            topLeft: Radius.circular(40),
          ),
        ),
        child: Column(
          children: <Widget>[
            const SizedBox(height: 15),
            Padding(
              padding: xPadding,
              child: Row(
                children: <Widget>[
                  Text(
                    'خدماتك',
                    style: TextStyle(
                      color: Theme.of(context).accentColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 15),
            ..._options.map<Widget>((option) {
              return ServiceOptionRow(option: option);
            }).toList(),
            Divider(
              color: Colors.grey,
              height: 20,
            ),
            Padding(
              padding: xPadding,
              child: Row(
                children: <Widget>[
                  Text(
                    'طريقة تلقى الخدمة',
                    style: TextStyle(
                      color: Theme.of(context).accentColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: xPadding,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: SelectRadio(
                      onTap: () => _selectMethod(0),
                      selected: _selecedMethod == 0,
                      text: 'منزلى',
                    ),
                  ),
                  Expanded(
                    child: SelectRadio(
                      onTap: () => _selectMethod(1),
                      selected: _selecedMethod == 1,
                      text: 'منزل مقدم الخدمة',
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              color: Colors.grey,
              height: 20,
            ),
            if (_selecedMethod == 0)
              Form(
                key: _selecedMethod == 0 ? _formKey : null,
                child: MyHomeForm(
                  onTimeSelected: _onTimeSelected,
                  onDateSelected: _onDateSelected,
                  onLocationSelected: _onLocationSelected,
                ),
              )
            else
              Form(
                key: _selecedMethod == 1 ? _formKey : null,
                child: ProviderHomeFrom(
                  onTimeSelected: _onTimeSelected,
                  onDateSelected: _onDateSelected,
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
                    'إجمالى التكلفة',
                    style: TextStyle(
                      color: Theme.of(context).accentColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: xPadding,
              child: Row(
                children: <Widget>[
                  Icon(
                    FontAwesomeIcons.wallet,
                    color: Colors.grey[600],
                  ),
                  const SizedBox(width: 15),
                  Text('${_getTotalPrice().toStringAsFixed(0)} رس'),
                  Spacer(),
                  Text(
                    '(شامل دفع قيمة المشوار)',
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 30),
            SizedBox(
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
                child: Text('إتمام الحجز'),
                onPressed: _completeReservation,
                color: Theme.of(context).accentColor,
                textColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    ];
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              automaticallyImplyLeading: false,
              pinned: true,
              expandedHeight: 300,
              backgroundColor: Theme.of(context).accentColor,
              title: Row(
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: () {},
                  ),
                ],
              ),
              flexibleSpace: FlexibleSpaceBar(
                background: Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                    image: AssetImage('images/1.png'),
                    fit: BoxFit.cover,
                  )),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(40),
                            topRight: Radius.circular(40),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.white,
                              spreadRadius: 1,
                              blurRadius: 0,
                              offset: Offset(0, 2),
                            )
                          ],
                        ),
                        width: double.infinity,
                        height: 40,
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Theme.of(context).accentColor,
                          ),
                          height: 3,
                          width: 150,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (cxt, index) => listItems[index],
                childCount: listItems.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ServiceOptionRow extends StatelessWidget {
  final ServiceOption option;
  final bool showDetails;

  const ServiceOptionRow({
    @required this.option,
    Key key,
    this.showDetails: true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: xPadding,
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 4,
            child: Text(option.name),
          ),
          Expanded(
            flex: showDetails ? 3 : 4,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Icon(
                  FontAwesomeIcons.moneyBillAlt,
                  color: Colors.grey[600],
                ),
                const SizedBox(width: 10),
                Text('${option.price.toStringAsFixed(0)} رس'),
              ],
            ),
          ),
          // const SizedBox(width: 10),
          if (showDetails)
            Expanded(
              flex: 2,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.access_time,
                    color: Colors.grey[600],
                  ),
                  const SizedBox(width: 10),
                  Text('${option.duration.inMinutes} د'),
                ],
              ),
            ),
          if (showDetails)
            SizedBox(
              width: 30,
              child: IconButton(
                padding: const EdgeInsets.all(0),
                icon: Icon(
                  FontAwesomeIcons.trash,
                  size: 18,
                ),
                onPressed: () {},
                color: Colors.grey[600],
              ),
            ),
        ],
      ),
    );
  }
}
