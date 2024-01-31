import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
// import 'package:shopping_cart_app/database/db_helper.dart';
// import 'package:shopping_cart_app/model/cart_model.dart';
// import 'package:shopping_cart_app/provider/cart_provider.dart';
import 'package:badges/src/badge.dart' as badge;

import 'Model/cart_provider.dart';



class CartScreen extends StatefulWidget {
  const CartScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {

  List<bool> tapped = [];

  @override
  void initState() {
    super.initState();
    // context.read<CartProvider>().getData();
  }

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('My Shopping Cart'),
        actions: [
          badge.Badge(
            badgeContent: Consumer<CartProvider>(
              builder: (context, value, child) {
                return Text(
                  value.itemCount.toString(),
                  // Change from getCounter to itemCount
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                );
              },
            ),
            position: const BadgePosition(start: 30, bottom: 30),
            child: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.shopping_cart),
            ),
          ),
          const SizedBox(
            width: 20.0,
          ),
        ],
      ),
      body: Column(
        children: [
          // Expanded(
          //   child: Consumer<CartProvider>(
          //     builder: (BuildContext context, provider, widget) {
          //       if (provider.itemCount == 0) {
          //         return const Center(
          //           child: Text(
          //             'Your Cart is Empty',
          //             style: TextStyle(
          //               fontWeight: FontWeight.bold,
          //               fontSize: 18.0,
          //             ),
          //           ),
          //         );
          //       } else {
          //         return ListView.builder(
          //           shrinkWrap: true,
          //           itemCount: provider.itemCount,
          //           itemBuilder: (context, index) {
          //             final cartItem = provider.cartItems[index];
          //             return Card(
          //               color: Colors.blueGrey.shade200,
          //               elevation: 5.0,
          //               child: Padding(
          //                 padding: const EdgeInsets.all(4.0),
          //                 child: Row(
          //                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //                   mainAxisSize: MainAxisSize.max,
          //                   children: [
          //                     SizedBox(
          //                       width: 130,
          //                       child: Column(
          //                         crossAxisAlignment: CrossAxisAlignment.start,
          //                         children: [
          //                           const SizedBox(
          //                             height: 5.0,
          //                           ),
          //                           RichText(
          //                             overflow: TextOverflow.ellipsis,
          //                             maxLines: 1,
          //                             text: TextSpan(
          //                               text: 'Name: ',
          //                               style: TextStyle(
          //                                 color: Colors.blueGrey.shade800,
          //                                 fontSize: 16.0,
          //                               ),
          //                               children: [
          //                                 TextSpan(
          //                                   text: '${cartItem.productName!}\n',
          //                                   style: const TextStyle(
          //                                     fontWeight: FontWeight.bold,
          //                                   ),
          //                                 ),
          //                               ],
          //                             ),
          //                           ),
          //                           RichText(
          //                             maxLines: 1,
          //                             text: TextSpan(
          //                               text: 'Unit: ',
          //                               style: TextStyle(
          //                                 color: Colors.blueGrey.shade800,
          //                                 fontSize: 16.0,
          //                               ),
          //                               children: [
          //                                 TextSpan(
          //                                   text: '${cartItem.unitTag!}\n',
          //                                   style: const TextStyle(
          //                                     fontWeight: FontWeight.bold,
          //                                   ),
          //                                 ),
          //                               ],
          //                             ),
          //                           ),
          //                           RichText(
          //                             maxLines: 1,
          //                             text: TextSpan(
          //                               text: 'Price: ' r"$",
          //                               style: TextStyle(
          //                                 color: Colors.blueGrey.shade800,
          //                                 fontSize: 16.0,
          //                               ),
          //                               children: [
          //                                 TextSpan(
          //                                   text: '${cartItem.productPrice!}\n',
          //                                   style: const TextStyle(
          //                                     fontWeight: FontWeight.bold,
          //                                   ),
          //                                 ),
          //                               ],
          //                             ),
          //                           ),
          //                         ],
          //                       ),
          //                     ),
          //                     ValueListenableBuilder<int>(
          //                       valueListenable: cartItem.quantity!!,
          //                       builder: (context, val, child) {
          //                         return PlusMinusButtons(
          //                           addQuantity: () {
          //                             provider.addQuantity(cartItem.id!);
          //                             dbHelper!
          //                                 .updateQuantity(
          //                               Cart(
          //                                 id: cartItem.id!,
          //                                 productId: cartItem.id.toString(),
          //                                 productName: cartItem.productName,
          //                                 initialPrice: cartItem.initialPrice,
          //                                 productPrice: cartItem.productPrice,
          //                                 productquantity:
          //                                     cartItem.productquantity,
          //                                 quantity: ValueNotifier(
          //                                   cartItem.quantity!.value,
          //                                 ),
          //                                 unitTag: cartItem.unitTag,
          //                                 image: cartItem.image,
          //                               ),
          //                             )
          //                                 .then((value) {
          //                               setState(() {
          //                                 provider.addTotalPrice(
          //                                   double.parse(
          //                                     cartItem.productPrice.toString(),
          //                                   ),
          //                                 );
          //                               });
          //                             });
          //                           },
          //                           deleteQuantity: () {
          //                             provider.deleteQuantity(cartItem.id!);
          //                             provider.removeTotalPrice(
          //                               double.parse(
          //                                 cartItem.productPrice.toString(),
          //                               ),
          //                             );
          //                           },
          //                           text: val.toString(),
          //                         );
          //                       },
          //                     ),
          //                     IconButton(
          //                       onPressed: () {
          //                         dbHelper!.deleteCartItem(cartItem.id!);
          //                         provider.removeItem(cartItem.id!);
          //                         provider.removeCounter();
          //                       },
          //                       icon: Icon(
          //                         Icons.delete,
          //                         color: Colors.red.shade800,
          //                       ),
          //                     ),
          //                   ],
          //                 ),
          //               ),
          //             );
          //           },
          //         );
          //       }
          //     },
          //   ),
          // ),
          // Consumer<CartProvider>(
          //   builder: (BuildContext context, value, Widget? child) {
          //     final ValueNotifier<double?> totalPrice = ValueNotifier(null);
          //     for (var cartItem in value.cartItems) {
          //       totalPrice.value =
          //           (cartItem.productPrice! * cartItem.quantity!) +
          //               (totalPrice.value ?? 0);
          //     }
          //     return Column(
          //       children: [
          //         ValueListenableBuilder<double?>(
          //           valueListenable: totalPrice,
          //           builder: (context, val, child) {
          //             return ReusableWidget(
          //               title: 'Sub-Total',
          //               value: r'$' + (val?.toStringAsFixed(2) ?? '0'),
          //             );
          //           },
          //         ),
          //       ],
          //     );
          //   },
          // )
        ],
      ),
      bottomNavigationBar: InkWell(
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Payment Successful'),
              duration: Duration(seconds: 2),
            ),
          );
        },
        child: Container(
          color: Colors.yellow.shade600,
          alignment: Alignment.center,
          height: 50.0,
          child: const Text(
            'Proceed to Pay',
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}

class PlusMinusButtons extends StatelessWidget {
  final VoidCallback deleteQuantity;
  final VoidCallback addQuantity;
  final TextEditingController textController; // Use the correct parameter name

  const PlusMinusButtons({
    Key? key,
    required this.addQuantity,
    required this.deleteQuantity,
    required this.textController, // Use the correct parameter name
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: deleteQuantity,
          icon: const Icon(Icons.remove),
        ),
        Expanded(
          child: Align(
            alignment: Alignment.center,
            child: Container(
              height: 36,
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  child: TextField(
                    controller: textController,
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(5),
                    ],
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      contentPadding: EdgeInsets.only(bottom: 10.0),
                    ),
                    textAlign: TextAlign.center,
                    // style: CommonUtils.Mediumtext_o_14, // Add your text style if needed
                  ),
                ),
              ),
            ),
          ),
        ),
        IconButton(
          onPressed: addQuantity,
          icon: const Icon(Icons.add),
        ),
      ],
    );
  }
}


class ReusableWidget extends StatelessWidget {
  final String title, value;
  const ReusableWidget({Key? key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.subtitle1,
          ),
          Text(
            value.toString(),
            style: Theme.of(context).textTheme.subtitle2,
          ),
        ],
      ),
    );
  }
}
