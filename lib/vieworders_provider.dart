import 'package:flutter/material.dart';
import 'package:srikarbiotech/OrderResponse.dart';

class ViewOrdersProvider extends ChangeNotifier {
  List<OrderResult> viewOrderProviderData = [];

  void storeIntoViewOrderProvider(List<OrderResult> items) {
    viewOrderProviderData.clear();
    viewOrderProviderData.addAll(items);
    notifyListeners();
  }
}
