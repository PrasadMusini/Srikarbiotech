import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:srikarbiotech/view_collection_page.dart';

import 'HomeScreen.dart';

class StatusScreen extends StatelessWidget {
  const StatusScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // final arguments = ModalRoute.of(context)?.settings.arguments as ListResult;
    final primaryGreen = HexColor('#11872f');
    final primaryOrange = HexColor('#dc762b');

    String orderId = 'xxxxxxxxxx';
    return WillPopScope(
        onWillPop: () async {
      // Disable the back button functionality
      return false;
    },
    child:  Scaffold(

      body: Center(
        child: Column(
          // mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            DottedBorder(
              borderType: BorderType.Circle,
              strokeWidth: 3,
              dashPattern: const <double>[9, 5], //const <double>[3, 1]
              padding: const EdgeInsets.all(30),
              color: primaryGreen,
              child: SvgPicture.asset(
                'assets/check.svg',
                width: 50,
                height: 50,
                color: primaryGreen,
                // colorFilter: ColorFilter.mode(primaryGreen, BlendMode.srcIn),
              ),
            ),
            const SizedBox(
              height: 35,
            ),
            Text(
              'Your Collection Submitted successfully',
              style: TextStyle(
                fontSize: 19,
                letterSpacing: 0,
                fontWeight: FontWeight.bold,
                color: primaryGreen,
              ),
            ),
            const Text(
              'Thank you for shopping with Srikar Bio Tech',
              style: TextStyle(
                fontSize: 18,
                letterSpacing: 0,
              ),
            ),
            // const SizedBox(
            //   height: 5,
            // ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   crossAxisAlignment: CrossAxisAlignment.center,
            //   children: [
            //     const Text(
            //       'Order ID: ',
            //       style: TextStyle(fontWeight: FontWeight.bold),
            //     ),
            //     Text(
            //       orderId,
            //       style: TextStyle(
            //         fontWeight: FontWeight.bold,
            //         fontSize: 20,
            //         color: primaryOrange,
            //       ),
            //     ),
            //   ],
            // ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: GestureDetector(
                onTap: () {
                  // Navigate to the "View Collections" screen
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ViewCollectionPage()),
                  );
                },
              child:
              Container(
                padding: const EdgeInsets.all(13),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: primaryOrange,
                ),
                child: const Center(
                  child: Text(
                    'Go to View Collections',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
              ),
            ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: GestureDetector(
                onTap: () {
                  // Navigate to the "View Collections" screen
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomeScreen()),
                  );
                },
              child: Container(
                padding: const EdgeInsets.all(13),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.white,
                    border: Border.all(
                      color: primaryOrange,
                    )),
                child: Center(
                  child: Text(
                    'Back to Home',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: primaryOrange,
                    ),
                  ),
                ),
              ),
            ),
            ),
          ],
        ),
      ),
    ));
  }
}
