import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:srikarbiotech/Ordersubmit_screen.dart';

import 'Billing_screen.dart';
import 'Model/CartHelper.dart';


class transport_payment extends StatefulWidget {

  final String cardName;
  final String  cardCode;
  final String  address;
  final String proprietorName;
  final String gstRegnNo;
  final String state;
  final String phone;

  transport_payment(
      {required this.cardName, required this.cardCode, required this.address, required  this.state, required  this.phone,
        required  this.proprietorName, required  this.gstRegnNo});

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

    // for (SelectedProducts product in widget.productitems) {
    //   print(
    //       'transportscreenID: ${product.id}, transportscreenName: ${product.productName}');
    //   // Access other properties as needed
    // }
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar:
      AppBar(
        backgroundColor: Color(0xFFe78337),
        automaticallyImplyLeading: false, // This line removes the default back arrow
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 2),
              child: GestureDetector(
                onTap: () {
                  // Handle the click event for the back arrow icon
                  Navigator.of(context).pop();
                },
                child: Icon(
                  Icons.chevron_left,
                  size: 30.0,
                  color: Colors.white,
                ),
              ),
            ),
            Text(
              'Select Transport & Payment',
              style: TextStyle(
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w600,
                color: Colors.white,
                fontSize: 18,
              ),
            ),
          ],
        ),
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
                                  color: Color(0xFF5f5f5f),
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14
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
                                              color: Color(0xFF5f5f5f),
                                              fontFamily: 'Roboto',
                                              fontWeight: FontWeight.w600,
                                              fontSize: 14
                                          ),
                                          decoration: InputDecoration(
                                            hintText: 'Enter Booking Place',
                                            hintStyle: TextStyle(
                                                color: Color(0xFF5f5f5f),
                                                fontFamily: 'Roboto',
                                                fontWeight: FontWeight.w600,
                                                fontSize: 14

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

                                  color: Color(0xFF5f5f5f),
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
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

                                              color: Color(0xFF5f5f5f),
                                              fontFamily: 'Roboto',
                                              fontWeight: FontWeight.w600,
                                              fontSize: 14
                                          ),
                                          decoration: InputDecoration(
                                            hintText: 'Enter Parcel Service',
                                            hintStyle: TextStyle(
                                                color: Color(0xFF5f5f5f),
                                                fontFamily: 'Roboto',
                                                fontWeight: FontWeight.w600,
                                                fontSize: 14,

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
                      builder: (context) => Ordersubmit_screen(
                          cardName: '${widget.cardName}',
                          cardCode:'${widget.cardCode}',
                          address: '${widget.address}',
                          state:'${widget.state}',
                          phone: '${widget.phone}',
                          proprietorName: '${widget.proprietorName}',
                          gstRegnNo: '${widget.gstRegnNo}'),
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
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                            color: Colors.white,

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
