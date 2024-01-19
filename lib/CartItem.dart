import 'package:flutter/cupertino.dart';



class CartItem {
  final int id;
  final String productName;
  final String unitTag;
  final String initialPrice;
  final String productPrice;
  final int productquantity;
  final ValueNotifier<int> quantity;
//  final String image;
  final String discount;

  CartItem(
      {required this.id,
      required this.productName,
      required this.unitTag,
      required this.initialPrice,
      required this.productPrice,
      required this.productquantity,
      required this.quantity,
      // required this.image,
      required this.discount});
}
