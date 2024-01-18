import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'Billing_screen.dart';
import 'Model/CartHelper.dart';


class transport_payment extends StatefulWidget {
  final List<SelectedProducts> productitems;
  transport_payment({required this.productitems});

  // final SelectedProducts selectedProduct;
  //
  // ProductDetatransport_paymentilScreen({required this.selectedProduct});

  @override
  _transportstate createState() => _transportstate();
}

class _transportstate extends State<transport_payment> {
  int selectedIndex = -1;
  int selectedIndexPayment = -1;
  @override
  void initState() {
    super.initState();
    // Set the default selected index to 0 when the screen is entered
    selectedIndex = 0;
    selectedIndexPayment = 0;

    for (SelectedProducts product in widget.productitems) {
      print(
          'transportscreenID: ${product.id}, transportscreenName: ${product.productName}');
      // Access other properties as needed
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFe78337),
        title: Text(
          'Select Transport & Payment',
          style: TextStyle(
            color: Colors.white, // Replace with your desired title text color
          ),
        ),
        // Add other app bar properties as needed
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              // height: screenHeight / 2.8,
              width: screenWidth,
              alignment: Alignment.center,
              padding:
                  EdgeInsets.only(top: 10.0, left: 10, right: 10, bottom: 10),
              child: Card(
                color: Colors.white,
                elevation: 5.0,
                // You can adjust the elevation as needed
                // Other card properties go here
                child: IntrinsicHeight(
                    child: Column(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding:
                          EdgeInsets.only(top: 15.0, left: 15.0, right: 15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                                top: 0.0, left: 5.0, right: 0.0),
                            child: Text(
                              'Booking Place',
                              style: TextStyle(
                                fontSize: 12.0,
                                color: Color(0xFF5f5f5f),
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.start,
                            ),
                          ),
                          SizedBox(height: 4.0),
                          //  SizedBox(height: 8.0),
                          GestureDetector(
                            onTap: () {
                              // Handle the click event for the second text view
                              print('first textview clicked');
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: 55.0,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12.0),
                                border: Border.all(
                                  color: Color(0xFFe78337),
                                  width: 2,
                                ),
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            left: 10.0, top: 0.0),
                                        child: TextFormField(
                                          keyboardType: TextInputType.name,
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w300,
                                          ),
                                          decoration: InputDecoration(
                                            hintText: 'Enter Booking Place',
                                            hintStyle: TextStyle(
                                              fontSize: 14,
                                              fontFamily: 'Roboto-Bold',
                                              fontWeight: FontWeight.w500,
                                              color: Color(0xFFC4C2C2),
                                            ),
                                            border: InputBorder.none,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.only(top: 8.0, left: 14.0, right: 15.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Box 1
                          Padding(
                            padding: EdgeInsets.only(
                                top: 0.0, left: 5.0, right: 0.0),
                            child: Text(
                              'Transport Mode',
                              style: TextStyle(
                                fontSize: 12.0,
                                color: Color(0xFF5f5f5f),
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.start,
                            ),
                          ),
                          Row(
                            children: [
                              buildTransportCard(
                                  0, 'Road', 'assets/images/road.svg', () {}),
                              buildTransportCard(
                                  1, 'Rail', 'assets/images/train.svg', () {}),
                              buildTransportCard(2, 'Air',
                                  'assets/images/planedeparture.svg', () {}),
                            ],
                          ),
                        ],
                      ),

                      // Add more widgets inside the card as needed
                    ),
                    Padding(
                      padding:
                          EdgeInsets.only(top: 8.0, left: 15.0, right: 15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                                top: 0.0, left: 5.0, right: 0.0),
                            child: Text(
                              'Preferable Transport',
                              style: TextStyle(
                                fontSize: 12.0,
                                color: Color(0xFF5f5f5f),
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.start,
                            ),
                          ),
                          SizedBox(height: 4.0),
                          //  SizedBox(height: 8.0),
                          GestureDetector(
                            onTap: () {
                              // Handle the click event for the second text view
                              print('first textview clicked');
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: 55.0,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12.0),
                                border: Border.all(
                                  color: Color(0xFFe78337),
                                  width: 2,
                                ),
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            left: 10.0, top: 0.0),
                                        child: TextFormField(
                                          keyboardType: TextInputType.name,
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w300,
                                          ),
                                          decoration: InputDecoration(
                                            hintText: 'Enter Parcel Service',
                                            hintStyle: TextStyle(
                                              fontSize: 14,
                                              fontFamily: 'Roboto-Bold',
                                              fontWeight: FontWeight.w500,
                                              color: Color(0xFFC4C2C2),
                                            ),
                                            border: InputBorder.none,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 15.0),
                  ],
                )),
              ),
            ),
            Container(
              //height: screenHeight / 2,
              width: screenWidth,
              alignment: Alignment.center,
              padding: EdgeInsets.all(10.0),
              child: Card(
                color: Colors.white,
                elevation: 5.0,
                // You can adjust the elevation as needed
                // Other card properties go here
                child: IntrinsicHeight(
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding:
                            EdgeInsets.only(top: 15.0, left: 15.0, right: 15.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                  top: 0.0, left: 5.0, right: 0.0),
                              child: Text(
                                'Payment Mode',
                                style: TextStyle(
                                  fontSize: 12.0,
                                  color: Color(0xFF5f5f5f),
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.start,
                              ),
                            ),

                            //  SizedBox(height: 8.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                buildpaymentmode(0, 'Check',
                                    'assets/images/road.svg', () {}),
                                buildpaymentmode(1, 'Online',
                                    'assets/images/train.svg', () {}),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Visibility(
                          visible: selectedIndexPayment == 0,
                          child: Padding(
                            padding: EdgeInsets.only(
                                top: 10.0, left: 15.0, right: 15.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                      top: 0.0, left: 5.0, right: 0.0),
                                  child: Text(
                                    'Check Number',
                                    style: TextStyle(
                                      fontSize: 12.0,
                                      color: Color(0xFF5f5f5f),
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.start,
                                  ),
                                ),
                                SizedBox(height: 4.0),
                                GestureDetector(
                                  onTap: () {
                                    // Handle the click event for the second text view
                                    print('first textview clicked');
                                  },
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: 55.0,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12.0),
                                      border: Border.all(
                                        color: Color(0xFFe78337),
                                        width: 2,
                                      ),
                                    ),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: Padding(
                                              padding: EdgeInsets.only(
                                                  left: 10.0, top: 0.0),
                                              child: TextFormField(
                                                keyboardType:
                                                    TextInputType.name,
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w300,
                                                ),
                                                decoration: InputDecoration(
                                                  hintText:
                                                      'Enter Check Number',
                                                  hintStyle: TextStyle(
                                                    fontSize: 14,
                                                    fontFamily: 'Roboto-Bold',
                                                    fontWeight: FontWeight.w500,
                                                    color: Color(0xFFC4C2C2),
                                                  ),
                                                  border: InputBorder.none,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )),
                      Visibility(
                          visible: selectedIndexPayment == 0,
                          child: Padding(
                            padding: EdgeInsets.only(
                                top: 10.0, left: 15.0, right: 15.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                      top: 0.0, left: 5.0, right: 0.0),
                                  child: Text(
                                    'Cheque Date',
                                    style: TextStyle(
                                      fontSize: 12.0,
                                      color: Color(0xFF5f5f5f),
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.start,
                                  ),
                                ),
                                //  SizedBox(height: 8.0),
                                SizedBox(height: 4.0),
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: 0, top: 0.0, right: 0),
                                  child: GestureDetector(
                                    onTap: () async {
                                      // _selectDate(isTodayHoliday);
                                    },
                                    child: Container(
                                      width: MediaQuery.of(context).size.width,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Color(0xFFe78337), width: 2),
                                        borderRadius:
                                            BorderRadius.circular(12.0),
                                        // color: Colors
                                        //     .white, // Add white background color
                                      ),
                                      child: AbsorbPointer(
                                        child: SizedBox(
                                          child: TextFormField(
                                            keyboardType: TextInputType.name,
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w300,
                                            ),
                                            decoration: InputDecoration(
                                              hintText: 'Enter Check Number',
                                              hintStyle: TextStyle(
                                                fontSize: 14,
                                                fontFamily: 'Roboto-Bold',
                                                fontWeight: FontWeight.w500,
                                                color: Color(0xFFC4C2C2),
                                              ),
                                              //  border: InputBorder.none,

                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                      horizontal: 16.0,
                                                      vertical: 12.0),
                                              // Adjust padding as needed
                                              suffixIcon: Padding(
                                                padding: EdgeInsets.all(10.0),
                                                child: Icon(
                                                  Icons.calendar_today,
                                                  // Replace with your desired icon
                                                  color: Colors.black54,
                                                ),
                                              ),
                                              border: InputBorder.none,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )),
                      Visibility(
                          visible: selectedIndexPayment == 0,
                          child: Padding(
                            padding: EdgeInsets.only(
                                top: 10.0, left: 15.0, right: 15.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                      top: 0.0, left: 5.0, right: 0.0),
                                  child: Text(
                                    'Check Issued Bank',
                                    style: TextStyle(
                                      fontSize: 12.0,
                                      color: Color(0xFF5f5f5f),
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.start,
                                  ),
                                ),
                                //  SizedBox(height: 8.0),
                                SizedBox(height: 4.0),
                                GestureDetector(
                                  onTap: () {
                                    // Handle the click event for the second text view
                                    print('first textview clicked');
                                  },
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: 55.0,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12.0),
                                      border: Border.all(
                                        color: Color(0xFFe78337),
                                        width: 2,
                                      ),
                                    ),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: Padding(
                                              padding: EdgeInsets.only(
                                                  left: 10.0, top: 0.0),
                                              child: TextFormField(
                                                keyboardType:
                                                    TextInputType.name,
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w300,
                                                ),
                                                decoration: InputDecoration(
                                                  hintText: 'Enter Issued Bank',
                                                  hintStyle: TextStyle(
                                                    fontSize: 14,
                                                    fontFamily: 'Roboto-Bold',
                                                    fontWeight: FontWeight.w500,
                                                    color: Color(0xFFC4C2C2),
                                                  ),
                                                  border: InputBorder.none,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )),
                      Visibility(
                          visible: selectedIndexPayment == 1,
                          child: Padding(
                            padding: EdgeInsets.only(
                                top: 10.0, left: 15.0, right: 15.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                      top: 0.0, left: 5.0, right: 0.0),
                                  child: Text(
                                    'Credit Account No',
                                    style: TextStyle(
                                      fontSize: 12.0,
                                      color: Color(0xFF5f5f5f),
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.start,
                                  ),
                                ),
                                //  SizedBox(height: 8.0),
                                GestureDetector(
                                  onTap: () {
                                    // Handle the click event for the second text view
                                    print('first textview clicked');
                                  },
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: 55.0,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12.0),
                                      border: Border.all(
                                        color: Color(0xFFe78337),
                                        width: 2,
                                      ),
                                    ),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: Padding(
                                              padding: EdgeInsets.only(
                                                  left: 10.0, top: 0.0),
                                              child: TextFormField(
                                                keyboardType:
                                                    TextInputType.name,
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w300,
                                                ),
                                                decoration: InputDecoration(
                                                  hintText:
                                                      'Enter Credit Account No',
                                                  hintStyle: TextStyle(
                                                    fontSize: 14,
                                                    fontFamily: 'Roboto-Bold',
                                                    fontWeight: FontWeight.w500,
                                                    color: Color(0xFFC4C2C2),
                                                  ),
                                                  border: InputBorder.none,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )),
                      Visibility(
                          visible: selectedIndexPayment == 1,
                          child: Padding(
                            padding: EdgeInsets.only(
                                top: 10.0, left: 15.0, right: 15.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                      top: 0.0, left: 5.0, right: 0.0),
                                  child: Text(
                                    'Credit Bank',
                                    style: TextStyle(
                                      fontSize: 12.0,
                                      color: Color(0xFF5f5f5f),
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.start,
                                  ),
                                ),
                                //  SizedBox(height: 8.0),
                                GestureDetector(
                                  onTap: () {
                                    // Handle the click event for the second text view
                                    print('first textview clicked');
                                  },
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: 55.0,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12.0),
                                      border: Border.all(
                                        color: Color(0xFFe78337),
                                        width: 2,
                                      ),
                                    ),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: Padding(
                                              padding: EdgeInsets.only(
                                                  left: 10.0, top: 0.0),
                                              child: TextFormField(
                                                keyboardType:
                                                    TextInputType.name,
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w300,
                                                ),
                                                decoration: InputDecoration(
                                                  hintText: 'Enter Credit Bank',
                                                  hintStyle: TextStyle(
                                                    fontSize: 14,
                                                    fontFamily: 'Roboto-Bold',
                                                    fontWeight: FontWeight.w500,
                                                    color: Color(0xFFC4C2C2),
                                                  ),
                                                  border: InputBorder.none,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )),
                      Visibility(
                          visible: selectedIndexPayment == 1,
                          child: Padding(
                            padding: EdgeInsets.only(
                                top: 10.0, left: 15.0, right: 15.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                      top: 0.0, left: 5.0, right: 0.0),
                                  child: Text(
                                    'UTR Number',
                                    style: TextStyle(
                                      fontSize: 12.0,
                                      color: Color(0xFF5f5f5f),
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.start,
                                  ),
                                ),
                                //  SizedBox(height: 8.0),
                                GestureDetector(
                                  onTap: () {
                                    // Handle the click event for the second text view
                                    print('first textview clicked');
                                  },
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: 55.0,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12.0),
                                      border: Border.all(
                                        color: Color(0xFFe78337),
                                        width: 2,
                                      ),
                                    ),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: Padding(
                                              padding: EdgeInsets.only(
                                                  left: 10.0, top: 0.0),
                                              child: TextFormField(
                                                keyboardType:
                                                    TextInputType.name,
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w300,
                                                ),
                                                decoration: InputDecoration(
                                                  hintText: 'Enter UTR Number',
                                                  hintStyle: TextStyle(
                                                    fontSize: 14,
                                                    fontFamily: 'Roboto-Bold',
                                                    fontWeight: FontWeight.w500,
                                                    color: Color(0xFFC4C2C2),
                                                  ),
                                                  border: InputBorder.none,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )),
                      SizedBox(
                        height: 15.0,
                      )
                    ],
                  ),
                ),
              ),
            ),
            // Padding(
            //   padding: EdgeInsets.only(top: 0.0, left: 14.0, right: 14.0),
            //   child: Container(
            //     alignment: Alignment.bottomCenter,
            //     width: MediaQuery.of(context).size.width,
            //     height: 55.0,
            //     child: Center(
            //       child: GestureDetector(
            //         onTap: () {},
            //         child: Container(
            //           // width: desiredWidth * 0.9,
            //           width: MediaQuery.of(context).size.width,
            //           height: 55.0,
            //           decoration: BoxDecoration(
            //             borderRadius: BorderRadius.circular(6.0),
            //             color: Color(0xFFe78337),
            //           ),
            //           child: Row(
            //               crossAxisAlignment: CrossAxisAlignment.center,
            //               mainAxisAlignment: MainAxisAlignment.center,
            //               children: [
            //                 Text(
            //                   'Save & Goto Cart',
            //                   style: TextStyle(
            //                     fontFamily: 'Calibri',
            //                     fontSize: 14,
            //                     color: Colors.white,
            //                     fontWeight: FontWeight.bold,
            //                   ),
            //                 ),
            //               ]),
            //         ),
            //       ),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
      bottomNavigationBar: InkWell(
        onTap: () {
          // ScaffoldMessenger.of(context).showSnackBar(
          //   const SnackBar(
          //     content: Text('Payment Successful'),
          //     duration: Duration(seconds: 2),
          //   ),
          // );
          print('clicked ');
        },
        child: Padding(
          padding:
              EdgeInsets.only(top: 0.0, left: 14.0, right: 14.0, bottom: 10.0),
          child: Container(
            alignment: Alignment.bottomCenter,
            width: MediaQuery.of(context).size.width,
            height: 55.0,
            child: Center(
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => billing_screen(
                        productitems: widget.productitems.toList(),
                      ),
                    ),
                  );
                },
                child: Container(
                  // width: desiredWidth * 0.9,
                  width: MediaQuery.of(context).size.width,
                  height: 55.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6.0),
                    color: Color(0xFFe78337),
                  ),
                  child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Save & Goto Cart',
                          style: TextStyle(
                            fontFamily: 'Calibri',
                            fontSize: 14,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ]),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildTransportCard(
      int index, String mode, String svgAsset, Function onTap) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex = index;
        });
        onTap(); // Call the onTap function passed as a parameter
      },
      child: Container(
        width: 80,
        height: 50,
        child: Card(
          elevation: 0.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(7.0),
            side: BorderSide(
              color: index == selectedIndex ? Colors.white : Color(0xFFe78337),
            ),
          ),
          color: index == selectedIndex ? Color(0xFFe78337) : Color(0xFFF8dac2),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                svgAsset,
                color: index == selectedIndex ? Colors.white : null,
                width: 20,
                height: 15,
              ),
              SizedBox(width: 5.0),
              Text(
                mode,
                style: TextStyle(
                  color: index == selectedIndex ? Colors.white : null,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildpaymentmode(
      int index, String mode, String svgAsset, Function onTap) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndexPayment = index;
        });
        onTap(); // Call the onTap function passed as a parameter
      },
      child: Container(
        width: 80,
        height: 50,
        child: Card(
          elevation: 0.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(7.0),
            side: BorderSide(
              color: index == selectedIndexPayment
                  ? Colors.white
                  : Color(0xFFe78337),
            ),
          ),
          color: index == selectedIndexPayment
              ? Color(0xFFe78337)
              : Color(0xFFF8dac2),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                svgAsset,
                color: index == selectedIndexPayment ? Colors.white : null,
                width: 20,
                height: 15,
              ),
              SizedBox(width: 5.0),
              Text(
                mode,
                style: TextStyle(
                  color: index == selectedIndexPayment ? Colors.white : null,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
