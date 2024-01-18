import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:connectivity/connectivity.dart';
class CommonUtils{

  static  void showCustomToastMessageLong(String message,
      BuildContext context,
      int backgroundColorType,
      int length,) {
    final double screenWidth = MediaQuery
        .of(context)
        .size
        .width;
    final double textWidth = screenWidth / 1.5; // Adjust multiplier as needed

    final double toastWidth = textWidth + 32.0; // Adjust padding as needed
    final double toastOffset = (screenWidth - toastWidth) / 2;

    OverlayEntry overlayEntry;
    overlayEntry = OverlayEntry(
      builder: (BuildContext context) =>
          Positioned(
            bottom: 16.0,
            left: toastOffset,
            child: Material(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.0),
              child: Container(
                width: toastWidth,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: backgroundColorType == 0 ? Colors.green : Colors.red,
                    width: 2.0,
                  ),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 10.0),
                  child: Center(
                    child: Text(
                      message,
                      style: TextStyle(fontSize: 16.0, color: Colors.black,fontFamily: 'Calibri'),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ),
          ),
    );


    Overlay.of(context).insert(overlayEntry);
    Future.delayed(Duration(seconds: length)).then((value) {
      overlayEntry.remove();
    });
  }




  static Future<bool> checkInternetConnectivity() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      return true; // Connected to the internet
    } else {
      return false; // Not connected to the internet
    }
  }
  static void myCommonMethod() {
    // Your common method logic here
    print('This is a common method');
  }
  static Widget buildCard(
      String title,
      String subtitle1,
      String subtitle2,
      String subtitle3,
      String subtitle4,
      Color backgroundColor,
      BorderRadius borderRadius,
      ) {
    return Card(
      elevation: 2.0,
      shape: RoundedRectangleBorder(
        borderRadius: borderRadius,
      ),
      color: backgroundColor,
      child: Container(
        width: double.infinity, // Make the width match the parent
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Party Details",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                fontFamily: 'Roboto', // Use 'Roboto-Bold' font family
                 // Orange color for the title
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              title,
              style: TextStyle(
                color: Colors.orange,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w700,
                fontSize: 14,
              ),
              maxLines: 2, // Display in 2 lines
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: 8.0),
            Text(
              subtitle1,
              style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w600,
                  fontSize: 12
              ),
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: 8.0),
            Text(
              subtitle2,
              style: TextStyle(
                  color: Colors.orange,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w600,
                  fontSize: 12
              ),
              maxLines: 2, // Display in 2 lines
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: 8.0),
            RichText(
              text: TextSpan(

                children: <TextSpan>[
                  TextSpan(
                    text: 'GST No. ',
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Roboto',
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  TextSpan(
                    text: subtitle3,
                    style: TextStyle(
                      color: Colors.orange,
                      fontFamily: 'Roboto',
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              overflow: TextOverflow.ellipsis,
            ),

            SizedBox(height: 8.0),
            Text(
              'Address',
              style: TextStyle(
                color: Colors.black,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w600,
                fontSize: 12,
              ),
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: 8.0),
            Text(
              subtitle4,
              style: TextStyle(
                color: Colors.orange,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w600,
                fontSize: 12,
              ),
              maxLines: 2, // Display in 2 lines
              overflow: TextOverflow.ellipsis,
            ),

          ],
        ),
      ),
    );
  }
}