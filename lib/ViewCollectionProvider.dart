import 'package:flutter/material.dart';
import 'package:srikarbiotech/Model/card_collection.dart';

class ViewCollectionProvider extends ChangeNotifier {
  List<ListResult> providerData = [];

  void storeIntoProvider(List<ListResult> items) {
    providerData.clear();
    providerData.addAll(items);
    print('providerData $providerData');
    notifyListeners();
  }
}
