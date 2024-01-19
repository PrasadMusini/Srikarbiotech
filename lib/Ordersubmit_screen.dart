import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:path_provider/path_provider.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share/share.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:srikarbiotech/Common/CommonUtils.dart';
import 'package:http/http.dart' as http;
import 'package:srikarbiotech/sb_status.dart';

import 'HomeScreen.dart';
import 'orderStatusScreen.dart';

class Ordersubmit_screen extends StatefulWidget {
  final String cardName;
  final String  cardCode;
  final String  address;
  final String proprietorName;
  final String gstRegnNo;
  final String state;
  final String phone;

  Ordersubmit_screen(
      {required this.cardName, required this.cardCode, required this.address, required  this.state, required  this.phone,
        required  this.proprietorName, required  this.gstRegnNo});
  @override
  Order_submit_screen createState() => Order_submit_screen();
}

class Order_submit_screen extends State<Ordersubmit_screen> {

  List<String>? cartItems = [];
  List<TextEditingController> textEditingControllers =[];
  List<int> quantities =[];
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
                  'Order Submission ',
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
              child: Card(
                color: Colors.white,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding:
                                EdgeInsets.only(left: 15.0, top: 8.0),
                                child: Text(
                                  'Transport & Payment Details',
                                  style: TextStyle(
                                    fontSize: 13.0,
                                    color: Color(0xFF414141),
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.start,
                                ),
                              ),
                              Padding(
                                padding:
                                EdgeInsets.only(right: 15.0, top: 8.0),
                                child: GestureDetector(
                                  child: SvgPicture.asset(
                                    'assets/images/edit.svg',
                                    width: 20.0,
                                    height: 20.0,
                                    color: Color(0xFFe78337),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                        ],
                      ),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color:
                            Colors.grey, // specify your border color here
                            width: 1.0, // specify the border width
                          ),
                          borderRadius: BorderRadius.circular(
                              8.0), // specify the border radius
                        ),
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Container(
                                  width:
                                  MediaQuery.of(context).size.width / 2.2,
                                  padding: EdgeInsets.all(10.0),
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                          top: 0.0,
                                          left: 20.0,
                                          right: 0.0,
                                        ),
                                        child: Text(
                                          'Booking Place',
                                          style: TextStyle(
                                            fontSize: 13.0,
                                            color: Color(0xFF414141),
                                            fontWeight: FontWeight.bold,
                                          ),
                                          textAlign: TextAlign.start,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 4.0,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            top: 0.0, left: 20.0, right: 0.0),
                                        child: Text(
                                          'Nacharam',
                                          style: TextStyle(
                                            fontSize: 13.0,
                                            color: Color(0xFFe78337),
                                            fontWeight: FontWeight.bold,
                                          ),
                                          textAlign: TextAlign.start,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  width:
                                  MediaQuery.of(context).size.width / 2.9,
                                  padding: EdgeInsets.all(10.0),
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                    MainAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                            top: 0.0, left: 0.0, right: 0.0),
                                        child: Text(
                                          'Transport Mode',
                                          style: TextStyle(
                                            fontSize: 13.0,
                                            color: Color(0xFF414141),
                                            fontWeight: FontWeight.bold,
                                          ),
                                          textAlign: TextAlign.start,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 4.0,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            top: 0.0, left: 0.0, right: 0.0),
                                        child: Text(
                                          'Train  ',
                                          style: TextStyle(
                                            fontSize: 13.0,
                                            color: Color(0xFFe78337),
                                            fontWeight: FontWeight.bold,
                                          ),
                                          textAlign: TextAlign.start,
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                            SizedBox(height: 5),
                            Container(
                              height: 1.0, // Set the height of the line
                              color: Colors.grey, // Set the color of the line
                            ),
                            SizedBox(height: 5),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              padding: EdgeInsets.all(10.0),
                              child: Row(
                                children: [
                                  Container(
                                    width:
                                    MediaQuery.of(context).size.width / 2,
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(
                                              top: 0.0,
                                              left: 20.0,
                                              right: 0.0),
                                          child: Text(
                                            'Preferable Transport',
                                            style: TextStyle(
                                              fontSize: 13.0,
                                              color: Color(0xFF414141),
                                              fontWeight: FontWeight.bold,
                                            ),
                                            textAlign: TextAlign.start,
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              top: 0.0,
                                              left: 20.0,
                                              right: 0.0),
                                          child: Text(
                                            'Railway Parcel Service',
                                            style: TextStyle(
                                              fontSize: 13.0,
                                              color: Color(0xFFe78337),
                                              fontWeight: FontWeight.bold,
                                            ),
                                            textAlign: TextAlign.start,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10.0,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),

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
              MaterialPageRoute(builder: (context) => orderStatusScreen()),
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
                  Padding(
                    padding: const EdgeInsets.only(right: 0, left: 0, bottom: 0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          height: 36,
                          width: MediaQuery.of(context).size.width / 2.2,
                          decoration: BoxDecoration(
                            color: Colors.orange,
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              IconButton(
                                icon: Icon(Icons.remove, color: Colors.white),
                                onPressed: () {
                                  setState(() {
                                    if (quantities[index] > 1) {
                                      quantities[index]--;
                                      textEditingControllers[index].text =
                                          quantities[index].toString();
                                    }
                                  });
                                },
                                iconSize: 17.0,
                              ),
                              Expanded(
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Container(
                                    height: 35,
                                    child: Padding(
                                      padding: const EdgeInsets.all(2.0),
                                      child: Container(
                                        alignment: Alignment.center,
                                        width: MediaQuery.of(context).size.width / 5.1,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                        ),
                                        child: TextField(
                                          controller: textEditingControllers[index],
                                          keyboardType: TextInputType.number,
                                          inputFormatters: <TextInputFormatter>[
                                            FilteringTextInputFormatter.digitsOnly,
                                            LengthLimitingTextInputFormatter(5),
                                          ],
                                          onChanged: (value) {
                                            setState(() {
                                              quantities[index] =
                                                  int.parse(value.isEmpty ? '0' : value);
                                            });
                                          },
                                          decoration: InputDecoration(
                                            hintText: '0',
                                            border: InputBorder.none,
                                            focusedBorder: InputBorder.none,
                                            enabledBorder: InputBorder.none,
                                            contentPadding: EdgeInsets.symmetric(
                                              horizontal: 0.0,
                                            ),
                                          ),
                                          textAlign: TextAlign.center,
                                          style: TextStyle(fontSize: 12.5),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              IconButton(
                                icon: Icon(Icons.add, color: Colors.white),
                                onPressed: () {
                                  setState(() {
                                    quantities[index]++;
                                    textEditingControllers[index].text =
                                        quantities[index].toString();
                                  });
                                },
                                alignment: Alignment.centerLeft,
                                iconSize: 17.0,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),



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







