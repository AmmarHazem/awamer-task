import 'package:flutter/foundation.dart';

class Provider {
  final int id;
  final int rate;
  final String name;
  final String location;
  final String distance;
  final double lat;
  final double lng;
  final double transitionCost;
  final List<PaymentMethod> paymentMethods;
  final List<ServiceModel> services;

  Provider({
    @required this.id,
    @required this.name,
    @required this.location,
    @required this.lat,
    @required this.lng,
    @required this.rate,
    @required this.transitionCost,
    @required this.distance,
    @required this.paymentMethods,
    @required this.services,
  });
}

class ServiceModel {
  final int id;
  final String name;
  final List<ServiceOption> options;

  ServiceModel({
    @required this.id,
    @required this.name,
    @required this.options,
  });
}

class ServiceOption {
  final int id;
  final String name;
  final double price;
  final Duration duration;

  ServiceOption({
    @required this.id,
    @required this.name,
    @required this.price,
    @required this.duration,
  });
}

class PaymentMethod {
  final int id;
  final String name;

  PaymentMethod(this.id, this.name);
}
