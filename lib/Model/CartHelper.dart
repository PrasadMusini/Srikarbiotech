// import 'dart:convert';
// import 'package:flutter/cupertino.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// class SelectedProducts {
//   final int id;
//   final String productName;
//   final String unitTag;
//   final double initialPrice;
//   final double productPrice;
//   final int productQuantity;
//   final ValueNotifier<int> quantity;
//
//   final int discount;
//
//   // Add other attributes if needed
//
//   SelectedProducts({
//     required this.id,
//     required this.productName,
//     required this.unitTag,
//     required this.initialPrice,
//     required this.productPrice,
//     required this.productQuantity,
//     required this.quantity,
//     required this.discount,
//     // Add other attributes here
//   });
//   SelectedProducts.withQuantity({
//     required this.id,
//     required this.productName,
//     required this.unitTag,
//     required this.initialPrice,
//     required this.productPrice,
//     required this.productQuantity,
//     required int initialQuantity,
//     required this.discount,
//     // ... other attributes ...
//   }) : quantity = ValueNotifier<int>(initialQuantity);
//
//   factory SelectedProducts.fromJson(Map<String, dynamic> json) {
//     return SelectedProducts(
//       id: json['id'] ?? 0,
//       productName: json['productName'] ?? '',
//       unitTag: json['unitTag'] ?? '',
//       initialPrice: (json['initialPrice'] ?? 0.0).toDouble(),
//       productPrice: (json['productPrice'] ?? 0.0).toDouble(),
//       productQuantity: json['productQuantity'] ?? 0,
//       quantity: ValueNotifier<int>(0), // Initialize with 0, update as needed
//
//       discount: json['discount'] ?? 0,
//       // Add other attributes here
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'productName': productName,
//       'unitTag': unitTag,
//       'initialPrice': initialPrice,
//       'productPrice': productPrice,
//       'productQuantity': productQuantity,
//       'quantity': quantity.value,
//
//       'discount': discount,
//       // Add other attributes here
//     };
//   }
// }
//
// class CartHelper {
//   static const String CHURCH_DATA = "church_data";
//
//   static void saveFertCartitems(List<SelectedProducts> myProducts) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     String json = jsonEncode(myProducts);
//     print('carthelperlist$json');
//     await prefs.setString("cart", json);
//   }
//
//   static Future<List<SelectedProducts>> getFertCartData() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     String json = prefs.getString("cart") ?? "";
//
//     if (json.isNotEmpty) {
//       try {
//         List<dynamic> decoded = jsonDecode(json);
//         List<SelectedProducts> obj =
//             decoded.map((e) => SelectedProducts.fromJson(e)).toList();
//         return obj;
//       } catch (e) {
//         print('Error decoding JSON: $e');
//       }
//     }
//
//     // Return an empty list if JSON is empty or decoding fails
//     return [];
//   }
//
//   static Future<void> printSavedCartItems() async {
//     List<SelectedProducts> savedCartItems = await getFertCartData();
//
//     if (savedCartItems.isNotEmpty) {
//       print('Saved Cart Items:');
//       for (SelectedProducts product in savedCartItems) {
//         print(
//             'ID: ${product.id}, Name: ${product.productName}'); // Add other properties as needed
//       }
//     } else {
//       print('No saved cart items.');
//     }
//   }
// }
// // static Future<List<SelectedProducts>> getFertCartData() async {
// //   SharedPreferences prefs = await SharedPreferences.getInstance();
// //   String json = prefs.getString("cart") ?? "";
// //   List<dynamic> decoded = jsonDecode(json);
// //   List<SelectedProducts> obj =
// //       decoded.map((e) => SelectedProducts.fromJso
// //             n(e)).toList();
// //   return obj;
// // }
