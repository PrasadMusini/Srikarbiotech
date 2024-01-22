import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:path_provider/path_provider.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share/share.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:srikarbiotech/Common/CommonUtils.dart';
import 'package:http/http.dart' as http;
import 'package:srikarbiotech/sb_status.dart';

import 'HomeScreen.dart';
import 'ReturnorderStatusScreen.dart';
import 'orderStatusScreen.dart';

class ReturnOrdersubmit_screen extends StatefulWidget {
  final String cardName;
  final String  cardCode;
  final String  address;
  final String proprietorName;
  final String gstRegnNo;
  final String state;
  final String phone;

  ReturnOrdersubmit_screen(
      {required this.cardName, required this.cardCode, required this.address, required  this.state, required  this.phone,
        required  this.proprietorName, required  this.gstRegnNo});
  @override
  returnOrder_submit_screen createState() => returnOrder_submit_screen();
}

class returnOrder_submit_screen extends State<ReturnOrdersubmit_screen> {

  List<String>? cartItems = [];
  List<TextEditingController> textEditingControllers =[];
  List<int> quantities =[];
  final _orangeColor = HexColor('#e58338');

  final _titleTextStyle = const TextStyle(
    fontFamily: 'Roboto',
    fontWeight: FontWeight.w700,
    color: Colors.black,
    fontSize: 15,
  );

  final _dataTextStyle = TextStyle(
    fontFamily: 'Roboto',
    fontWeight: FontWeight.bold,
    color: HexColor('#e58338'),
    fontSize: 13,
  );

  final dividerForHorizontal = Container(
    width: double.infinity,
    height: 1,
    color: Colors.grey,
  );
  final dividerForVertical = Container(
    width: 1,
    height: 60,
    color: Colors.grey,
  );
  @override
  initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);
    loadData();
    print('cardName: ${widget.cardName}');
    print('cardCode: ${widget.cardCode}');
    print('address: ${widget.address}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
      AppBar(
        backgroundColor: Color(0xFFe78337),
        automaticallyImplyLeading: false,
        // This line removes the default back arrow
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,

          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 2),
                  child: GestureDetector(
                    onTap: () {
                      // Handle the click event for the back button
                      Navigator.of(context).pop();
                    },
                    child: Icon(
                      Icons.chevron_left,
                      size: 30.0,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(width: 8.0),
                Text(
                  'Return Order Submission ',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
                Text(
                  '( ' +'${cartItems!.length}' + ')',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
            GestureDetector(
              onTap: () {
                // Handle the click event for the home icon
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => HomeScreen()),
                );
              },
              child: Icon(
                Icons.home,
                size: 30,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 10.0, left: 20.0, right: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 8.0),
                CommonUtils.buildCard(
                  widget.cardName,
                  widget.cardCode,
                  widget.proprietorName,
                  widget.gstRegnNo,
                  widget.address,
                  Colors.white,
                  BorderRadius.circular(10.0),
                ),
                SizedBox(height: 16.0),
              ],
            ),
          ),
          Expanded(
            child: cartItems != null && cartItems!.isNotEmpty
                ? ListView.builder(
              itemCount: cartItems!.length,
              itemBuilder: (context, index) {
                return buildCartItem(index);
              },
            )
                : Center(
              child: Text('No items in the cart'),
            ),
          ),

          SizedBox(height: 10),
          Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
            child: IntrinsicHeight(
              child:
              Card(
                elevation: 5,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white10,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  width: double.infinity, // remove padding here
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      // row one
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              'Trasport Details',
                              style: _titleTextStyle,
                            ),
                            const Icon(Icons.home),
                          ],
                        ),
                      ),

                      dividerForHorizontal,

                      // row two
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'LR Number',
                                    style: _titleTextStyle,
                                  ),
                                  Text(
                                    'xx-xx-xxxx',
                                    style: _dataTextStyle,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          dividerForVertical,
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'LR Date',
                                    style: _titleTextStyle,
                                  ),
                                  Text(
                                    'xxxxxx',
                                    style: _dataTextStyle,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),

                      dividerForHorizontal,

                      // row three
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Transport Mode',
                                    style: _titleTextStyle,
                                  ),
                                  Text(
                                    'Train',
                                    style: _dataTextStyle,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          dividerForVertical,
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Transport Name',
                                    style: _titleTextStyle,
                                  ),
                                  Text(
                                    'Railway Parcel Service',
                                    style: _dataTextStyle,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),

                      dividerForHorizontal,

                      // row four
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 10),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.orange.shade100,
                            border: Border.all(
                              color: _orangeColor,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Icons.link),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                'Attachment',
                                style: _titleTextStyle,
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
              child: IntrinsicHeight(
                  child: Card(
                    color: Colors.white,
                    child: Container(
                      padding: EdgeInsets.all(10.0),
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        children: [


                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                padding: EdgeInsets.only(top: 10.0),
                                child: Text(
                                  'Total',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14.0,
                                  ),
                                ),
                              ),
                              Spacer(),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Container(
                                    //   width: MediaQuery.of(context).size.width / 1.8,
                                    padding: EdgeInsets.only(top: 10.0),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text(
                                          '₹${12765.00}',
                                          style: TextStyle(
                                            color: Color(0xFFe78337),
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16.0,
                                          ),



                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  )))
        ],
      ),

      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ReturnorderStatusScreen()),
            );
          },
          style: ElevatedButton.styleFrom(
            primary: Color(0xFFe78337), // Set your desired background color
          ),
          child: Text(
            'Place Your Order',
            style: TextStyle(
              color: Colors.white, // Set your desired text color
            ),
          ),
        ),
      ),

      //    ),
    );




  }


  Future<void> loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      cartItems = prefs.getStringList('cartItems') ?? [];

      print('Cart Items: $cartItems');
    });
  }
  Widget buildCartItem(int index) {
    // Parse the cart item data
    List<String> itemData = cartItems![index].split(',');
    String itemName = itemData[1];
    int quantity = int.parse(itemData[2]);
    print('ordersubmitscreenquntity$quantity');
    List<String> weightOptions = ['10 KG', '20 KG', '40 KG', '50 KG'];
    String selectedWeight = weightOptions[0]; // Default to the first option

    quantities = List<int>.filled(itemData.length, quantity);
    textEditingControllers = List.generate(itemData.length, (index) => TextEditingController());

    return Padding(
      padding: const EdgeInsets.only(left: 16.0,right: 16.0),
      child: Card(
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                itemName,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                '₹${430} ',
                style: TextStyle(
                  color: Colors.orange,
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                ),
              ),
              SizedBox(height: 8.0),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5.0),
                      border: Border.all(color: Colors.orange),
                    ),
                    child: DropdownButton<String>(
                      value: selectedWeight,
                      onChanged: (value) {
                        setState(() {
                          selectedWeight = value!;
                        });
                      },
                      items: weightOptions.map((option) {
                        return DropdownMenuItem<String>(
                          value: option,
                          child: Text(
                            option,
                            style: TextStyle(color: Colors.orange),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  SizedBox(width: 8.0),

                  Row(
                    children: [
                      Text(
                        'Quantity: ',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14.0,
                        ),
                      ),
                      Text(
                        '$quantity',
                        style: TextStyle(
                          fontSize: 14.0,
                        ),
                      ),
                    ],
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.only(right: 0, left: 0, bottom: 0),
                  //   child: Row(
                  //     crossAxisAlignment: CrossAxisAlignment.start,
                  //     mainAxisAlignment: MainAxisAlignment.start,
                  //     children: [
                  //       Container(
                  //         height: 36,
                  //         width: MediaQuery.of(context).size.width / 2.2,
                  //         decoration: BoxDecoration(
                  //           color: Colors.orange,
                  //           borderRadius: BorderRadius.circular(10.0),
                  //         ),
                  //         child: Row(
                  //           mainAxisAlignment: MainAxisAlignment.spaceAround,
                  //           crossAxisAlignment: CrossAxisAlignment.center,
                  //           children: [
                  //             IconButton(
                  //               icon: Icon(Icons.remove, color: Colors.white),
                  //               onPressed: () {
                  //                 setState(() {
                  //                   if (quantities[index] > 1) {
                  //                     quantities[index]--;
                  //                     textEditingControllers[index].text =
                  //                         quantities[index].toString();
                  //                   }
                  //                 });
                  //               },
                  //               iconSize: 17.0,
                  //             ),
                  //             Expanded(
                  //               child: Align(
                  //                 alignment: Alignment.center,
                  //                 child: Container(
                  //                   height: 35,
                  //                   child: Padding(
                  //                     padding: const EdgeInsets.all(2.0),
                  //                     child: Container(
                  //                       alignment: Alignment.center,
                  //                       width: MediaQuery.of(context).size.width / 5.1,
                  //                       decoration: BoxDecoration(
                  //                         color: Colors.white,
                  //                       ),
                  //                       child: TextField(
                  //                         controller: textEditingControllers[index],
                  //                         keyboardType: TextInputType.number,
                  //                         inputFormatters: <TextInputFormatter>[
                  //                           FilteringTextInputFormatter.digitsOnly,
                  //                           LengthLimitingTextInputFormatter(5),
                  //                         ],
                  //                         onChanged: (value) {
                  //                           setState(() {
                  //                             quantities[index] =
                  //                                 int.parse(value.isEmpty ? '0' : value);
                  //                           });
                  //                         },
                  //                         decoration: InputDecoration(
                  //                           hintText: '0',
                  //                           border: InputBorder.none,
                  //                           focusedBorder: InputBorder.none,
                  //                           enabledBorder: InputBorder.none,
                  //                           contentPadding: EdgeInsets.symmetric(
                  //                             horizontal: 0.0,
                  //                           ),
                  //                         ),
                  //                         textAlign: TextAlign.center,
                  //                         style: TextStyle(fontSize: 12.5),
                  //                       ),
                  //                     ),
                  //                   ),
                  //                 ),
                  //               ),
                  //             ),
                  //             IconButton(
                  //               icon: Icon(Icons.add, color: Colors.white),
                  //               onPressed: () {
                  //                 setState(() {
                  //                   quantities[index]++;
                  //                   textEditingControllers[index].text =
                  //                       quantities[index].toString();
                  //                 });
                  //               },
                  //               alignment: Alignment.centerLeft,
                  //               iconSize: 17.0,
                  //             ),
                  //           ],
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),



                  IconButton(
                    icon: Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      // Remove the item from cartItems
                      setState(() {
                        cartItems!.removeAt(index);
                      });

                      // Save the updated cart data in SharedPreferences
                      saveCartData();

                      // Update the UI
                      setState(() {});

                      // You can add any additional logic or display a message if needed
                      print('Item deleted from cart.');
                    },
                  ),
                ],
              ),

            ],
          ),
        ),
      ),
    );
  }



  void saveCartData() async {
    // Get the SharedPreferences instance
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Save the updated cart data in SharedPreferences
    prefs.setStringList('cartItems', cartItems!);

    // Print the items saved in the cart
    print('Items saved in the cart:');
    for (String item in cartItems!) {
      print(item);
    }

    // Print the count of items in the cart
    print('Total items in the cart: ${cartItems!.length}');
  }



}







