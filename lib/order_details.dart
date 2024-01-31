import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:srikarbiotech/HomeScreen.dart';
import 'package:http/http.dart' as http;
import 'Model/OrderDetailsResponse.dart';

class orderdetails extends StatefulWidget {
  final int orderid;
  final String orderdate;
  final double totalprice;
  final String bookingplace;
  final String Preferabletransport;
  final int lrnumber;
  final String lrdate;
  final String paymentmode;
  final String transportmode;
  final String statusname;
  final String partyname;
  final String partycode;
  final String proprietorName;
  final String partyGSTNumber;
  final String ordernumber;
  final String partyAddress;

  orderdetails(
      {required this.partyname,
        required this.orderid,
        required this.orderdate,
        required this.totalprice,
        required this.bookingplace,
        required this.Preferabletransport,
        required this.lrnumber,
        required this.lrdate,
        required this.ordernumber,
        required this.partycode,
        required this.proprietorName,
        required this.partyAddress,
        required this.paymentmode,
        required this.transportmode,
        required this.partyGSTNumber,
        required this.statusname});

  @override
  State<orderdetails> createState() => _orderdetailsPageState();
}

class _orderdetailsPageState extends State<orderdetails> {
  List tableCellTitles = [
    ['Order Date', 'Booking Place', 'Preferabale Transport', 'LR Number'],
    [
      'Total',
      'Transport Mode',
      'Payment Mode',
      'LR Date',
    ]
  ];
  int orderid = 0;

  //List<OrderDetailsResponse> orderdetailslist = [];
  late List tableCellValues;
  late Future<OrderDetailsResponse?> orderDetailsList;
  String? partyname,
      partycode,
      itemname,
      salesname,
      partygstnumber,
      partyaddress,
      ordernumber;
  OrderItemXref? orderItemXref;
  List<OrderItemXref> orderitemxreflist = [];
  List<Map<String, dynamic>> itemList = [];
  int orderqty = 0;
  double price = 0.0;
  double totalcost = 0.0;
  @override
  void initState() {
    // TODO: implement initState
    fetchData();
    orderid = widget.orderid;
    print('$orderid');
    fetchorderproducts();
    getorderdetails();

    super.initState();
  }

  Future<OrderDetailsResponse?> getorderdetails() async {
    final String apiUrl =
        "http://182.18.157.215/Srikar_Biotech_Dev/API/api/Order/GetOrderDetailsById/${orderid}";

    try {
      final response = await http.get(Uri.parse(apiUrl));
      print('>>urltofetchorderdeatils: $apiUrl');
      if (response.statusCode == 200) {
        final Map<String, dynamic>? data = json.decode(response.body);

        if (data != null && data['isSuccess'] != null && data['isSuccess']) {
          print('API successfully hit!');
          print('URL: $apiUrl');

          final dynamic responseMap = data['response'];
          if (responseMap is Map<String, dynamic>) {
            final dynamic getOrderDetailsResult =
            responseMap['getOrderDetailsResult'];
            if (getOrderDetailsResult is List<dynamic>) {
              for (final orderDetail in getOrderDetailsResult) {
                if (orderDetail is Map<String, dynamic>) {
                  print('ID: ${orderDetail['id']}');
                  // Print other fields as needed
                  print('---');
                }
                setState(() {
                  partyname = orderDetail['partyName'];
                  partyaddress = orderDetail['partyAddress'];
                  partycode = orderDetail['partyCode'];
                  partygstnumber = orderDetail['partyGSTNumber'];
                  salesname = orderDetail['proprietorName'];
                  ordernumber = orderDetail['orderNumber'];
                  totalcost = orderDetail['totalCost'];
                  print('partyname :$partyname');
                });
              }
            } else {
              throw Exception(
                  'Invalid format: getOrderDetailsResult is not a List.');
            }
          } else {
            throw Exception('Invalid format: response is not a Map.');
          }
        } else {
          throw Exception('Failed to load data. Error:');
        }
      } else {
        throw Exception(
            'Failed to load data. Status Code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error: $error');
      return null;
    }
  }

  Future<void> fetchorderproducts() async {
    final response = await http.get(Uri.parse(
        'http://182.18.157.215/Srikar_Biotech_Dev/API/api/Order/GetOrderDetailsById/${orderid}'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);

      // Access the itemGrpName values and print them
      // for (final item in data['response']['orderItemXrefList']) {
      //   print('itemGrpName: ${item['itemGrpName']}');
      // }
//      final Map<String, dynamic> data = json.decode(response.body);

      // Extract item details
      List<Map<String, dynamic>> items = [];
      for (final item in data['response']['orderItemXrefList']) {
        items.add({
          'itemGrpName': item['itemGrpName'],
          // Replace 'fieldX' with the actual field name you want to use
          // Add other fields as needed
        });
        setState(() {
          itemname = item['itemGrpName'];
          itemList = items;
          orderqty = item['orderQty'];
          price = item['price'];
          print('>>itemanme$itemname');
        });
      }
    } else {
      print('Failed to load data. Status code: ${response.statusCode}');
    }
  }

  Future<List<String>> fetchData() async {
    // Retrieve saved cart items using CartHelper
    tableCellValues = [
      [
        widget.orderdate,
        widget.bookingplace,
        widget.transportmode,
        widget.lrnumber
      ],
      [
        widget.totalprice,
        widget.transportmode,
        widget.paymentmode,
        widget.lrdate
      ]
    ];

    // Convert the elements to strings if needed
    List<String> stringList =
    tableCellValues.expand((row) => row).map((element) {
      return element.toString(); // Adjust the conversion as needed
    }).toList();

    return stringList;
  }

  Color getStatusTypeBackgroundColor(String statusTypeId) {
    switch (statusTypeId) {
      case 'Pending':
        return Color(0xFFE58338).withOpacity(0.1);
      case 'Shipped':
      // Set background color for statusTypeId 8
        return Color(0xFF0d6efd).withOpacity(0.1);
      case 'Accept':
      // Set background color for statusTypeId 9
        return Color(0xFF198754).withOpacity(0.1);
      case 'Partially Shipped':
      // Set background color for statusTypeId 9
        return Color(0xFF0dcaf0).withOpacity(0.1);
      case 'Reject':
        return Color(0xFFdc3545).withOpacity(0.1);
        break;
    // Add more cases as needed for other statusTypeId values

      default:
      // Default background color or handle other cases if needed
        return Colors.white;
    }
  }

  Color getStatusTypeTextColor(String statusTypeId) {
    switch (statusTypeId) {
      case 'Pending':
        return Color(0xFFe58338);
      case 'Shipped':
      // Set background color for statusTypeId 8
        return Color(0xFF0d6efd);
      case 'Accept':
      // Set background color for statusTypeId 9
        return Color(0xFF198754);
      case 'Partially Shipped':
      // Set background color for statusTypeId 9
        return Color(0xFF0dcaf0);
      case 'Reject':
        return Color(0xFFdc3545);
        break;

      default:
        return Colors.white;
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFFe78337),
          automaticallyImplyLeading: false,
          elevation: 5,
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
                    'Order Details',
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
        body: SingleChildScrollView(
            child: Column(
              //mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                // Set mainAxisSize to min for intrinsic height
                children: [
                  Container(
                    width: screenWidth,
                    padding: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    child: Card(
                      color: Colors.white,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                        ),
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                              EdgeInsets.only(top: 0.0, left: 0.0, right: 0.0),
                              child: Text(
                                '${partyname}',
                                style: TextStyle(
                                  fontSize: 16.0,
                                  color: Color(0xFFe78337),
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.start,
                              ),
                            ),
                            SizedBox(
                              height: 1.0,
                            ),
                            Padding(
                              padding:
                              EdgeInsets.only(top: 0.0, left: 0.0, right: 0.0),
                              child: Text(
                                '${partycode}',
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
                              padding:
                              EdgeInsets.only(top: 0.0, left: 0.0, right: 0.0),
                              child: Text(
                                '${salesname}',
                                style: TextStyle(
                                  fontSize: 14.0,
                                  color: Color(0xFFe78337),
                                  fontWeight: FontWeight.w500,
                                ),
                                textAlign: TextAlign.start,
                              ),
                            ),
                            Padding(
                                padding: EdgeInsets.only(
                                    top: 0.0, left: 0.0, right: 0.0),
                                child: Container(
                                  child: Row(
                                    children: [
                                      Text(
                                        'GST NO.',
                                        style: TextStyle(
                                          fontSize: 14.0,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500,
                                        ),
                                        textAlign: TextAlign.start,
                                      ),
                                      Text(
                                        '${partygstnumber}',
                                        style: TextStyle(
                                          fontSize: 14.0,
                                          color: Color(0xFFe78337),
                                          fontWeight: FontWeight.w500,
                                        ),
                                        textAlign: TextAlign.start,
                                      ),
                                    ],
                                  ),
                                )),
                            Padding(
                              padding:
                              EdgeInsets.only(top: 0.0, left: 0.0, right: 0.0),
                              child: Text(
                                'Address',
                                style: TextStyle(
                                  fontSize: 12.0,
                                  color: Color(0xFF414141),
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.start,
                              ),
                            ),
                            Padding(
                              padding:
                              EdgeInsets.only(top: 0.0, left: 0.0, right: 0.0),
                              child: Text(
                                '${partyaddress}',
                                style: TextStyle(
                                  fontSize: 12.0,
                                  color: Color(0xFFe78337),
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.start,
                              ),
                            ),
                            // Add more widgets as needed
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(5.0),
                    child: Card(
                        elevation: 7,
                        child: Container(
                            padding: const EdgeInsets.all(10),
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                            ),
                            child: Column(children: [
                              // Table
                              Row(
                                //  crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Order ID',
                                        textAlign: TextAlign.start,
                                      ),
                                      Text(
                                        '${ordernumber}',
                                        style: TextStyle(
                                            fontFamily: 'Roboto',
                                            fontSize: 13,
                                            color: Color(0xFFe58338),
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ],
                                  ),

                                  //+  Spacer(),
                                  Container(
                                    height: 30,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(25),
                                      color: getStatusTypeBackgroundColor(
                                          widget.statusname),
                                    ),
                                    child: IntrinsicWidth(
                                      stepWidth: 80.0,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            '${widget.statusname}',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              color: getStatusTypeTextColor(
                                                  widget.statusname),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  //     Text('${widget.statusname}')
                                ],
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              Table(
                                border: TableBorder.all(
                                  width: 1,
                                  color: Colors.grey.shade500,
                                  //     borderRadius: BorderRadius.circular(10),
                                ),
                                children: [
                                  ...List.generate(4, (index) {
                                    return TableRow(
                                      children: [
                                        TableCell(
                                          child: Container(
                                            padding: const EdgeInsets.all(10),
                                            child: Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Text(
                                                  tableCellTitles[0][index],
                                                  //   style: _titleTextStyle,
                                                ),
                                                SizedBox(height: 5),
                                                Text(
                                                  tableCellValues[0][index]
                                                      .toString(),
                                                  style: TextStyle(
                                                      fontFamily: 'Roboto',
                                                      fontSize: 13,
                                                      color: Color(0xFFe58338),
                                                      fontWeight: FontWeight.w600),
                                                  //style: _dataTextStyle,
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                        TableCell(
                                          child: Container(
                                            padding: EdgeInsets.all(10),
                                            child: Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Text(
                                                  tableCellTitles[1][index],
                                                  //    style: _titleTextStyle,
                                                ),
                                                SizedBox(height: 5),
                                                Text(
                                                  tableCellValues[1][index]
                                                      .toString(),
                                                  style: TextStyle(
                                                      fontFamily: 'Roboto',
                                                      fontSize: 13,
                                                      color: Color(0xFFe58338),
                                                      fontWeight: FontWeight.w600),

                                                  ///   style: _dataTextStyle,
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    );
                                  })
                                ],
                              ),
                            ]))),
                  ),
                  SizedBox(
                    height: 0.0,
                  ),
                  // Container(
                  //   width: screenWidth,
                  //   height: screenHeight / 2.5,
                  //   padding: EdgeInsets.all(10),
                  // child:
                  // Expanded(
                  //   child:
                  Container(
                    width: screenWidth,
                    //   height: screenHeight / 2,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: PageScrollPhysics(),
                      itemCount: itemList.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            // Navigator.of(context)
                            //     .pushNamed('/statusScreen', arguments: widget.listResult);
                            // Navigator.of(context).push(
                            //   MaterialPageRoute(
                            //     builder: (context) => ViewCollectionCheckOut(
                            //       //
                            //       listResult: widget.listResult,
                            //       position: widget.index, // Assuming you have the index available
                            //     ),
                            //   ),
                            // );
                          },
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 10),
                            color: Colors.transparent,
                            child: Card(
                              elevation: 5,
                              color: Colors.white,
                              child: Container(
                                padding: const EdgeInsets.all(10),
                                //   width: double.infinity,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.white),

                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      // height: 70,
                                      // width: double.infinity,
                                      // margin: const EdgeInsets.only(bottom: 12),
                                      width: MediaQuery.of(context).size.width,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Row(
                                        children: [
                                          // starting icon of card

                                          // beside info
                                          Container(
                                            //height: 90,
                                            // width: ,
                                            width:
                                            MediaQuery.of(context).size.width /
                                                1.8,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 10, top: 0, bottom: 0),
                                              child: Column(
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Text(
                                                    itemname!,
                                                    style: TextStyle(
                                                        fontFamily: 'Roboto',
                                                        fontSize: 14,
                                                        color: Colors.black,
                                                        fontWeight:
                                                        FontWeight.bold),
                                                    softWrap: true,
                                                    maxLines: 2,
                                                    overflow: TextOverflow.ellipsis,
                                                  ),
                                                  SizedBox(
                                                    height: 5.0,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                    children: [
                                                      Container(
                                                        child: Row(
                                                          children: [
                                                            Text(
                                                              'Qty: ',
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                  'Roboto',
                                                                  fontSize: 14,
                                                                  color:
                                                                  Colors.black,
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .w400),
                                                            ),
                                                            Text(
                                                              '${orderqty}',
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                  'Roboto',
                                                                  fontSize: 13,
                                                                  color:
                                                                  Colors.black,
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 5.0,
                                                  ),
                                                  Container(
                                                    child: Row(
                                                      children: [
                                                        Text(
                                                          '₹${price}',
                                                          style: TextStyle(
                                                              fontFamily: 'Roboto',
                                                              fontSize: 14,
                                                              color:
                                                              Color(0xFFe58338),
                                                              fontWeight:
                                                              FontWeight.w600),
                                                        ),
                                                        SizedBox(
                                                          width: 15.0,
                                                        ),
                                                        // Text(
                                                        //   '',
                                                        //   style: TextStyle(
                                                        //     color:
                                                        //         Color(0xFFa6a6a6),
                                                        //     fontWeight:
                                                        //         FontWeight.bold,
                                                        //     fontSize: 13.0,
                                                        //     decoration:
                                                        //         TextDecoration
                                                        //             .lineThrough,
                                                        //   ),
                                                        // ),
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  //     ),
                  //    ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Container(
                      width: screenWidth,
                      padding: EdgeInsets.only(top: 0.0, left: 10.0, right: 10.0),
                      child: IntrinsicHeight(
                          child: Card(
                            color: Colors.white,
                            child: Container(
                              padding: EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                              ),
                              width: screenWidth,
                              child: Column(
                                children: [
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                        padding: EdgeInsets.only(top: 0.0),
                                        child: Text(
                                          'Total',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: 'Roboto',
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16.0,
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
                                            padding: EdgeInsets.only(top: 0.0),
                                            child: Row(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                              mainAxisAlignment: MainAxisAlignment.end,
                                              children: [
                                                Text(
                                                  '₹${totalcost}',
                                                  style: TextStyle(
                                                    color: Color(0xFFe78337),
                                                    fontFamily: 'Roboto',
                                                    fontWeight: FontWeight.w600,
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
                ])));
  }
}
