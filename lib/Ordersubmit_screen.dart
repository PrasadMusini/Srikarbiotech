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
import 'package:srikarbiotech/transport_payment.dart';

import 'HomeScreen.dart';
import 'Model/CartHelper.dart';
import 'orderStatusScreen.dart';

class Ordersubmit_screen extends StatefulWidget {
  final String cardName;
  final String cardCode;
  final String address;
  final String proprietorName;
  final String gstRegnNo;
  final String state;
  final String phone;
  final String BookingPlace;
  final String TransportName;
  Ordersubmit_screen(
      {required this.cardName,
      required this.cardCode,
      required this.address,
      required this.state,
      required this.phone,
      required this.proprietorName,
      required this.gstRegnNo,
      required this.BookingPlace,
      required this.TransportName});
  @override
  Order_submit_screen createState() => Order_submit_screen();
}

class Order_submit_screen extends State<Ordersubmit_screen> {
  List<String> cartItems = [];

  List<String> cartlistItems = [];
  List<TextEditingController> textEditingControllers = [];
  List<int> quantities = [];
  @override
  initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);
    fetchData();
    loadData();
    print('cardName: ${widget.cardName}');
    print('cardCode: ${widget.cardCode}');
    print('address: ${widget.address}');
  }

  Future<List<String>> fetchData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    cartItems = prefs.getStringList('cartItems') ?? [];
    print('CartItems: $cartItems');

    return cartItems;
  }

  Future<void> loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      cartlistItems = prefs.getStringList('cartItems') ?? [];

      print('cartlistItems: $cartlistItems');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFe78337),
        automaticallyImplyLeading: false,
        // This line removes the default back arrow
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 2, vertical: 2),
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
                  '(' + '${cartlistItems.length}' + ')',
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
      body: Column(children: [
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 5.0, left: 10.0, right: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
                // Container(
                //   child: cartItems != null && cartItems!.isNotEmpty
                //       ?
                // SingleChildScrollView(
                //   scrollDirection: Axis.vertical,
                //   child:
                FutureBuilder<List<String>>(
                  future: fetchData(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return Text('No data available');
                    } else {
                      // Use the length of cartItems as itemCount
                      return ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemCount: cartItems.length,
                        itemBuilder: (context, index) {
                          print(
                              'Length of cartItems: ${cartItems.length}, Index: $index');
                          if (index < cartItems.length) {
                            return buildCartItem(index);
                          } else {
                            return Text('Invalid index: $index');
                          }
                        },
                      );
                    }
                  },
                  // ),
                ),
                // : Center(
                //     child: Text('No items in the cart'),
                //      ),
                //   ),
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding:
                                          EdgeInsets.only(left: 15.0, top: 8.0),
                                      child: Text(
                                        'Transport  Details',
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
                                          right: 15.0, top: 8.0),
                                      child: GestureDetector(
                                        onTap: () {
                                          Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    transport_payment(
                                                      cardName: widget.cardName,
                                                      cardCode: widget.cardCode,
                                                      address: widget.address,
                                                      state: widget.state,
                                                      phone: widget.phone,
                                                      proprietorName:
                                                          widget.proprietorName,
                                                      gstRegnNo:
                                                          widget.gstRegnNo,
                                                      preferabletransport:
                                                          widget.TransportName,
                                                      bookingplace:
                                                          widget.BookingPlace,
                                                    )),
                                          );
                                        },
                                        child: SvgPicture.asset(
                                          'assets/edit.svg',
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
                                  color: Colors
                                      .grey, // specify your border color here
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
                                            MediaQuery.of(context).size.width /
                                                2.2,
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
                                                  top: 0.0,
                                                  left: 20.0,
                                                  right: 0.0),
                                              child: Text(
                                                '${widget.BookingPlace}',
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
                                            MediaQuery.of(context).size.width /
                                                2.9,
                                        padding: EdgeInsets.all(10.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  top: 0.0,
                                                  left: 0.0,
                                                  right: 0.0),
                                              child: Text(
                                                'Transport Name',
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
                                                  top: 0.0,
                                                  left: 0.0,
                                                  right: 0.0),
                                              child: Text(
                                                '${widget.TransportName}',
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
                    padding:
                        EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
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
          ),
        ),
      ]),
      bottomNavigationBar: Container(
        height: 60,
        margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Expanded(
              child: InkWell(
                onTap: () {
                  AddOrder();
                  // Add logic for the download button

                  print(' button clicked');
                },
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color(0xFFe78337),
                  ),
                  child: const Center(
                    child: Text(
                      'Place Your Order',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight:
                            FontWeight.w700, // Set the font weight to bold
                        fontFamily: 'Roboto', // Set the font family to Roboto
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),

      //    ),
    );
  }

  Widget buildCartItem(int index) {
    // Parse the cart item data
    List<String> itemData = cartItems[index].split(',');
    String itemName = itemData[1];

    int quantity = int.parse(itemData[2]);

    print('ordersubmitscreenquntity$quantity');
    // List<String> weightOptions = ['10 KG', '20 KG', '40 KG', '50 KG'];
    // String? selectedWeight;

    quantities = List<int>.filled(itemData.length, quantity);
    if (textEditingControllers.length <= index) {
      textEditingControllers.add(TextEditingController());
    }
    // textEditingControllers =
    //     List.generate(itemData.length, (index) => TextEditingController());

    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 10.0),
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
                //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Container(
                  //   padding: EdgeInsets.symmetric(horizontal: 8.0),
                  //   decoration: BoxDecoration(
                  //     color: Colors.white,
                  //     borderRadius: BorderRadius.circular(5.0),
                  //     border: Border.all(color: Colors.orange),
                  //   ),
                  //   child: DropdownButton<String>(
                  //     value: selectedWeight,
                  //     onChanged: (value) {
                  //       // setState(() {
                  //       //   // Set value to null temporarily
                  //       //   selectedWeight = null;
                  //       // });
                  //
                  //       // Set the selected value
                  //       setState(() {
                  //         selectedWeight = value!;
                  //       });
                  //     },
                  //     items: weightOptions.map((option) {
                  //       return DropdownMenuItem<String>(
                  //         value: option,
                  //         child: Text(
                  //           option,
                  //           style: TextStyle(color: Colors.orange),
                  //         ),
                  //       );
                  //     }).toList(),
                  //   ),
                  // ),
                  // SizedBox(width: 8.0),
                  Container(
                    height: 36,
                    width: MediaQuery.of(context).size.width / 2.5,
                    decoration: BoxDecoration(
                      color: Color(0xFFe78337),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Row(
                      children: [
                        IconButton(
                          icon: Icon(Icons.remove, color: Colors.white),
                          onPressed: () {
                            if (quantities[index] > 1) {
                              setState(() {
                                quantities[index]--;
                                textEditingControllers[index].text =
                                    quantities[index].toString();
                              });
                            }
                          },
                          iconSize: 25.0,
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
                                  width:
                                      MediaQuery.of(context).size.width / 5.1,
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
                                        quantities[index] = int.parse(value
                                                .isEmpty
                                            ? '$quantity'
                                            : value); // Default to 1 if empty
                                      });
                                    },
                                    decoration: InputDecoration(
                                      hintText: '1',
                                      hintStyle: CommonUtils.Mediumtext_o_14,
                                      border: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                      enabledBorder: InputBorder.none,
                                      contentPadding:
                                          EdgeInsets.only(bottom: 10.0),
                                    ),
                                    textAlign: TextAlign.center,
                                    style: CommonUtils.Mediumtext_o_14,
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
                          iconSize: 25.0,
                        ),
                      ],
                    ),
                  ),
                  // Row(
                  //   children: [
                  //     Text(
                  //       'Quantity: ',
                  //       style: TextStyle(
                  //         fontWeight: FontWeight.bold,
                  //         fontSize: 14.0,
                  //       ),
                  //     ),
                  //     Text(
                  //       '$quantity',
                  //       style: TextStyle(
                  //         fontSize: 14.0,
                  //       ),
                  //     ),
                  //   ],
                  // ),

                  IconButton(
                    icon: Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      // Remove the item from cartItems
                      setState(() {
                        cartItems.removeAt(index);
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

  void AddOrder() async {
    final String apiUrl =
        'http://182.18.157.215/Srikar_Biotech_Dev/API/api/Order/AddOrder';

    Map<String, dynamic> orderData = {
      "OrderItemXrefTypeList": [
        {
          "Id": 1,
          "OrderId": 2,
          "ItemGrpCod": "sample string 3",
          "ItemGrpName": "sample string 4",
          "ItemCode": "sample string 5",
          "ItemName": "sample string 6",
          "NoOfPcs": "sample string 7",
          "OrderQty": 8,
          "Price": 9.1,
          "IGST": 1.1,
          "CGST": 1.1,
          "SGST": 1.1
        },
        {
          "Id": 1,
          "OrderId": 2,
          "ItemGrpCod": "sample string 3",
          "ItemGrpName": "sample string 4",
          "ItemCode": "sample string 5",
          "ItemName": "sample string 6",
          "NoOfPcs": "sample string 7",
          "OrderQty": 8,
          "Price": 9.1,
          "IGST": 1.1,
          "CGST": 1.1,
          "SGST": 1.1
        }
      ],
      "Id": 1,
      "CompanyId": 2,
      "OrderNumber": "123",
      "OrderDate": "2024-01-24T10:39:00.9845541+05:30",
      "PartyCode": '${widget.cardCode}',
      "PartyName": '${widget.cardName}',
      "PartyAddress": '${widget.address}',
      "PartyState": '${widget.state}',
      "PartyPhoneNumber": '${widget.phone}',
      "PartyGSTNumber": '${widget.gstRegnNo}',
      "ProprietorName": '${widget.proprietorName}',
      "PartyOutStandingAmount": 1.1,
      "BookingPlace": '${widget.BookingPlace}',
      "TransportName": '${widget.TransportName}',
      "FileName": "",
      "FileLocation": "",
      "FileExtension": "",
      "StatusTypeId": 2,
      "Discount": 1.1,
      "IGST": 1.1,
      "CGST": 1.1,
      "SGST": 1.1,
      "TotalCost": 1.1,
      "Remarks": "test",
      "IsActive": true,
      "CreatedBy": "e39536e2-89d3-4cc7-ae79-3dd5291ff156",
      "CreatedDate": "2024-01-24T10:39:00.9865556+05:30",
      "UpdatedBy": "e39536e2-89d3-4cc7-ae79-3dd5291ff156",
      "UpdatedDate": "2024-01-24T10:39:00.9865556+05:30"
    };

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(orderData),
      );

      if (response.statusCode == 200) {
        // Successful request
        final responseData = jsonDecode(response.body);
        print(responseData);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => orderStatusScreen()),
        );

        // Handle the response accordingly
      } else {
        // Handle errors
        print('Error: ${response.reasonPhrase}');
      }
    } catch (e) {
      // Handle exceptions
      print('Exception: $e');
    }
  }
}
