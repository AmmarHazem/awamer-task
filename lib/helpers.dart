import 'package:dio/dio.dart';

import 'models.dart';

class APIHelper {
  static Future<Provider> getProviderData() async {
    final res = await Dio()
        .get<Map>('http://hena.aait-sa.com/api/provider-info?provider_id=233');
    final data = res.data['data'];
    return Provider(
      distance: data['distance'],
      id: data['id'],
      lat: double.parse(data['lat']),
      lng: double.parse(data['lng']),
      location: data['location'],
      name: data['name'],
      rate: data['rate'],
      transitionCost: data['transition_cost'],
      services: data['services'].map<ServiceModel>((service) {
        return ServiceModel(
          id: service['id'],
          name: service['value'],
          options: service['options'].map<ServiceOption>((option) {
            return ServiceOption(
              duration: Duration(minutes: option['duration']),
              id: option['id'],
              name: option['value'],
              price: option['price'].toDouble(),
            );
          }).toList(),
        );
      }).toList(),
      paymentMethods: data['pay_types'].map<PaymentMethod>((method) {
        return PaymentMethod(method['id'], method['value']);
      }).toList(),
    );
  }
}

String validateLocation(String value) {
  if (value.isEmpty) {
    return '* لابد من تحديد موقعك';
  }
  return null;
}

String validateTime(String value) {
  if (value.isEmpty) {
    return '* لا بد من تحديد الوقت';
  }
  return null;
}

String validateDate(String value) {
  if (value.isEmpty) {
    return '* لابد من تحديد التاريخ';
  }
  return null;
}
