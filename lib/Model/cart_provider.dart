import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/foundation.dart';
import '../CartItem.dart';

// import 'package:shopping_cart_app/database/db_helper.dart';
// import 'package:shopping_cart_app/model/cart_model.dart';



class CartProvider with ChangeNotifier {
  List<CartItem> _cartItems = [];

  List<CartItem> get cartItems => _cartItems;

  // Getter for the total count of items in the cart
  int get itemCount => _cartItems.length;

  void addToCart(CartItem cartItem) {
    _cartItems.add(cartItem);
    notifyListeners();
  }

  void addToCartitems(List<CartItem> items) {
    _cartItems.addAll(items);
    // Perform any other necessary operations
  }

// Other methods related to managing the cart
}
