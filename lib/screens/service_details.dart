import 'package:awamer_task/helpers.dart';
import 'package:awamer_task/models.dart';
import 'package:awamer_task/screens/request_service.dart';
import 'package:awamer_task/widgets/service_group.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fluttertoast/fluttertoast.dart';

const xPadding = const EdgeInsets.symmetric(horizontal: 30);

class ServiceDetails extends StatefulWidget {
  @override
  _ServiceDetailsState createState() => _ServiceDetailsState();
}

class _ServiceDetailsState extends State<ServiceDetails> {
  var _loading = true;
  int _expandedService;
  List<int> _selectedOption = [];
  List<int> _selectedServices = [];
  Provider _provider;

  @override
  void initState() {
    super.initState();

    _getProviderData();
  }

  void _getProviderData() async {
    _provider = await APIHelper.getProviderData();
    if (!mounted) return;
    setState(() {
      _loading = false;
    });
  }

  void _expandGroup(int id) {
    setState(() {
      if (_expandedService == id) {
        _expandedService = null;
      } else {
        _expandedService = id;
      }
    });
  }

  void _onOptionSelected(int optionId, int serviceId) {
    _selectedOption.add(optionId);
    if (_selectedServices.contains(serviceId)) return;
    _selectedServices.add(serviceId);
  }

  void _requestService() {
    if (_selectedOption.isEmpty) {
      Fluttertoast.showToast(
        msg: "برجاء أختيار خدمة اولا",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
      );
      return;
    }
    Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (cxt) => RequestService(
          selectedOptions: _selectedOption,
          selectedServices: _selectedServices,
          provider: _provider,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> child;
    if (_loading) {
      child = [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Row(
            children: <Widget>[CircularProgressIndicator()],
            mainAxisAlignment: MainAxisAlignment.center,
          ),
        )
      ];
    } else if (_provider == null) {
      child = [
        Row(
          children: <Widget>[Text('Error')],
          mainAxisAlignment: MainAxisAlignment.center,
        )
      ];
    } else {
      final starsNumber = _provider.rate;
      final borderStarsNumber = 5 - _provider.rate;
      child = <Widget>[
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Theme.of(context).accentColor,
          ),
          height: 3,
          width: 150,
        ),
        const SizedBox(height: 15),
        Padding(
          padding: xPadding,
          child: Row(
            children: <Widget>[
              Text(
                _provider.name,
                style: TextStyle(
                  color: Theme.of(context).accentColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Spacer(),
              ...List.generate(
                starsNumber,
                (index) => Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
              ),
              Spacer(),
              ...List.generate(
                borderStarsNumber,
                (index) => Icon(
                  Icons.star_border,
                  color: Colors.amber,
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
              Icon(
                Icons.location_on,
                color: Colors.grey[600],
              ),
              const SizedBox(width: 10),
              Text(_provider.location)
            ],
          ),
        ),
        Padding(
          padding: xPadding,
          child: Row(
            children: <Widget>[
              const SizedBox(width: 35),
              Text(_provider.distance)
            ],
          ),
        ),
        Padding(
          padding: xPadding,
          child: Row(
            children: <Widget>[
              Icon(
                FontAwesomeIcons.female,
                color: Colors.grey[600],
              ),
              const SizedBox(width: 10),
              Text('للسيدات فقط')
            ],
          ),
        ),
        const SizedBox(height: 15),
        Padding(
          padding: xPadding,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(
              'images/2.png',
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
        ),
        Divider(
          height: 40,
          color: Colors.grey,
        ),
        Padding(
          padding: xPadding,
          child: Row(
            children: <Widget>[
              Text(
                'أختارى الخدمة',
                style: TextStyle(
                  color: Theme.of(context).accentColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 15,
          ),
          // height: 100,
          decoration: BoxDecoration(
            border: Border.all(
              color: Theme.of(context).accentColor,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            children: _provider.services.map((e) {
              return ServicesGroup(
                service: e,
                onTap: () => _expandGroup(e.id),
                expanded: _expandedService == e.id,
                onOptionSelected: _onOptionSelected,
              );
            }).toList(),
          ),
        ),
        Divider(
          height: 40,
          color: Colors.grey,
        ),
        Padding(
          padding: xPadding,
          child: Row(
            children: <Widget>[
              Text(
                'وسائل الدفع',
                style: TextStyle(
                  color: Theme.of(context).accentColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        ..._provider.paymentMethods.map((e) {
          return Padding(
            padding: xPadding,
            child: Row(
              children: <Widget>[
                Icon(FontAwesomeIcons.coins, color: Colors.grey[600]),
                const SizedBox(width: 10),
                Text(
                  e.name,
                ),
              ],
            ),
          );
        }).toList(),
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
            child: Text('طلب الخدمة'),
            onPressed: _requestService,
            color: Theme.of(context).accentColor,
            textColor: Colors.white,
          ),
        ),
      ];
    }
    final listItems = <Widget>[
      SizedBox(
        height: 220,
        child: Padding(
          padding: const EdgeInsets.only(top: 15),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {},
                color: Colors.white,
              ),
            ],
          ),
        ),
      ),
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
          children: child,
        ),
      ),
    ];
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Positioned(
              child: Container(
                width: double.infinity,
                height: 300,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('images/1.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              top: 0,
              left: 0,
              right: 0,
            ),
            ListView.builder(
              itemBuilder: (cxt, index) => listItems[index],
              itemCount: listItems.length,
            ),
          ],
        ),
      ),
    );
  }
}
