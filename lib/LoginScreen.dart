import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'HomeScreen.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // First half of the screen - ImageView
          Container(
            height: MediaQuery.of(context).size.height / 1.8,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20.0),
                bottomRight: Radius.circular(20.0),
              ),
              image: DecorationImage(
                image: AssetImage('assets/background.jpg'),
                fit: BoxFit.cover,
                alignment: Alignment.center,
              ),
            ),
            child: Center(
              child: Image.asset(
                'assets/login_screen_logo.png', // Replace with your logo image path
                width: MediaQuery.of(context).size.height /
                    3.2, // Adjust the width as needed
                height: MediaQuery.of(context).size.height /
                    3.2, // Adjust the height as needed
                // You can add more styling properties if necessary
              ),
            ),
          ),
          // Second half of the screen - CardView
          // Second half of the screen - CardView
          // Align(
          //   alignment: FractionalOffset.bottomCenter,
          //   child: Padding(
          //     padding:
          //     const EdgeInsets.only(left: 22.0, right: 22.0, bottom: 10.0),
          //     // Adjust the padding as needed
          //     child: Container(
          //       height: MediaQuery.of(context).size.height / 2,
          //       width: MediaQuery.of(context).size.width,
          //       child: Card(
          //         shape: RoundedRectangleBorder(
          //           borderRadius: BorderRadius.circular(20.0),
          //         ),
          //         child: Column(
          //           crossAxisAlignment: CrossAxisAlignment.center,
          //           children: [
          //             Align(
          //               alignment: Alignment.topCenter,
          //               child: Padding(
          //                 padding: const EdgeInsets.only(top: 6.0, left: 12.0, right: 12.0),
          //                 child: Text(
          //                   'LogIn',
          //                   style: TextStyle(
          //                     fontSize: 24.0,
          //                     color: Color(0xFFe78337),
          //                     fontWeight: FontWeight.bold,
          //                   ),
          //                 ),
          //               ),
          //             ),
          //             SizedBox(height: 8.0),
          //             Text(
          //               'Hi, Welcome to Srikar Bio Tech',
          //               style: TextStyle(
          //                 fontSize: 18.0,
          //                 color: Color(0xFFe78337),
          //                 fontWeight: FontWeight.w400,
          //               ),
          //             ),
          //             SizedBox(height: 8.0),
          //             Text(
          //               'Enter your credentials to continue',
          //               style: TextStyle(
          //                 fontSize: 15.0,
          //                 color: Color(0xFF5f5f5f),
          //               ),
          //             ),
          //             Padding(
          //               padding: EdgeInsets.only(top: 20.0, left: 30.0, right: 30.0),
          //               child: Column(
          //                 crossAxisAlignment: CrossAxisAlignment.start,
          //                 children: [
          //                   Text(
          //                     'Email/Username', // Add your desired text here
          //                     style: TextStyle(
          //                       fontSize: 12.0,
          //                       color: Color(0xFF5f5f5f),
          //                       fontWeight: FontWeight.bold,
          //                     ),
          //                   ),
          //                   SizedBox(height: 8.0),
          //                   GestureDetector(
          //                     onTap: () {
          //                       // Handle the click event for the second text view
          //                       print('first textview clicked');
          //                     },
          //                     child: Container(
          //                       width: MediaQuery.of(context).size.width,
          //                       height: 55.0,
          //                       decoration: BoxDecoration(
          //                         borderRadius: BorderRadius.circular(5.0),
          //                         border: Border.all(
          //                           color: Color(0xFFe78337),
          //                           width: 2,
          //                         ),
          //                       ),
          //                       child: Row(
          //                         children: [
          //                           Padding(
          //                             padding: EdgeInsets.only(left: 10.0, right: 5.0),
          //                             child: SvgPicture.asset(
          //                               'assets/envelope.svg',
          //                               width: 20.0,
          //                               color: Color(0xFFe78337),
          //                             ),
          //                           ),
          //                           Container(
          //                             width: 2.0,
          //                             height: 20.0,
          //                             color: Color(0xFFe78337),
          //                           ),
          //                           Expanded(
          //                             child: Align(
          //                               alignment: Alignment.centerLeft,
          //                               child: Padding(
          //                                 padding: EdgeInsets.only(left: 10.0, top: 0.0),
          //                                 child: TextFormField(
          //                                   keyboardType: TextInputType.name,
          //                                   style: TextStyle(
          //                                     fontSize: 14,
          //                                     fontWeight: FontWeight.w300,
          //                                   ),
          //                                   decoration: InputDecoration(
          //                                     hintText: 'Enter Email or Username',
          //                                     hintStyle: TextStyle(
          //                                       fontSize: 14,
          //                                       fontFamily: 'Roboto-Bold',
          //                                       fontWeight: FontWeight.w500,
          //                                       color: Color(0xFFC4C2C2),
          //                                     ),
          //                                     border: InputBorder.none,
          //                                   ),
          //                                 ),
          //                               ),
          //                             ),
          //                           ),
          //                         ],
          //                       ),
          //                     ),
          //                   ),
          //                 ],
          //               ),
          //             ),
          //
          //             // Padding(
          //             //   padding: const EdgeInsets.all(0.0),
          //             //   // Adjust the padding as needed
          //             //   child: Text(
          //             //     'LogIn',
          //             //     style: TextStyle(
          //             //       fontSize: 14.0,
          //             //       color: Color(0xFFe78337),
          //             //       fontWeight: FontWeight.bold,
          //             //     ),
          //             //   ),
          //             // ),
          //             Padding(
          //               padding: EdgeInsets.only(top: 20.0, left: 30.0, right: 30.0),
          //               child: Column(
          //                 crossAxisAlignment: CrossAxisAlignment.start,
          //                 children: [
          //                   Text(
          //                     'Password', // Add your desired text here
          //                     style: TextStyle(
          //                       fontSize: 12.0,
          //                       color: Color(0xFF5f5f5f),
          //                       fontWeight: FontWeight.bold,
          //                     ),
          //                   ),
          //                   SizedBox(height: 8.0),
          //                   GestureDetector(
          //                     onTap: () {
          //                       // Handle the click event for the second text view
          //                       print('first textview clicked');
          //                     },
          //                     child: Container(
          //                       width: MediaQuery.of(context).size.width,
          //                       height: 55.0,
          //                       decoration: BoxDecoration(
          //                         borderRadius: BorderRadius.circular(5.0),
          //                         border: Border.all(
          //                           color: Color(0xFFe78337),
          //                           width: 2,
          //                         ),
          //                       ),
          //                       child: Row(
          //                         children: [
          //                           Padding(
          //                             padding: EdgeInsets.only(left: 10.0, right: 5.0),
          //                             child: SvgPicture.asset(
          //                               'assets/lock.svg',
          //                               width: 20.0,
          //                               color: Color(0xFFe78337),
          //                             ),
          //                           ),
          //                           Container(
          //                             width: 2.0,
          //                             height: 20.0,
          //                             color: Color(0xFFe78337),
          //                           ),
          //                           Expanded(
          //                             child: Align(
          //                               alignment: Alignment.centerLeft,
          //                               child: Padding(
          //                                 padding: EdgeInsets.only(left: 10.0, top: 0.0),
          //                                 child: TextFormField(
          //                                   keyboardType: TextInputType.name,
          //                                   style: TextStyle(
          //                                     fontSize: 14,
          //                                     fontWeight: FontWeight.w300,
          //                                   ),
          //                                   decoration: InputDecoration(
          //                                     hintText: 'Enter Password',
          //                                     hintStyle: TextStyle(
          //                                       fontSize: 14,
          //                                       fontFamily: 'Roboto-Bold',
          //                                       fontWeight: FontWeight.w500,
          //                                       color: Color(0xFFC4C2C2),
          //                                     ),
          //                                     border: InputBorder.none,
          //                                   ),
          //                                 ),
          //                               ),
          //                             ),
          //                           ),
          //                         ],
          //                       ),
          //                     ),
          //                   ),
          //                 ],
          //               ),
          //             ),
          //             Padding(
          //               padding:
          //               EdgeInsets.only(top: 20.0, left: 30.0, right: 30.0),
          //               child: Container(
          //                 width: MediaQuery.of(context).size.width,
          //                 height: 55.0,
          //                 child: Center(
          //                   child: GestureDetector(
          //                     onTap: () {
          //                       // Navigate to HomeScreen when the "LogIn" text is tapped
          //                       Navigator.push(
          //                         context,
          //                         MaterialPageRoute(builder: (context) => HomeScreen()),
          //                       );
          //                     },
          //                     child: Container(
          //                       // width: desiredWidth * 0.9,
          //                       width: MediaQuery.of(context).size.width,
          //                       height: 55.0,
          //                       decoration: BoxDecoration(
          //                         borderRadius: BorderRadius.circular(6.0),
          //                         color: Color(0xFFe78337),
          //                       ),
          //                       child: Row(
          //                           crossAxisAlignment:
          //                           CrossAxisAlignment.center,
          //                           mainAxisAlignment: MainAxisAlignment.center,
          //                           children: [
          //                             Text(
          //                               'LogIn',
          //                               style: TextStyle(
          //                                 fontFamily: 'Calibri',
          //                                 fontSize: 14,
          //                                 color: Colors.white,
          //                                 fontWeight: FontWeight.bold,
          //                               ),
          //                             ),
          //                             Image.asset(
          //                               'assets/right_arrow.png',
          //                               width: 20,
          //                               height: 10,
          //                               color: Colors.white,
          //                             )
          //                           ]),
          //
          //                     ),
          //                   ),
          //                 ),
          //               ),
          //             ),
          //             Padding(
          //               padding: const EdgeInsets.only(
          //                   top: 12.0, left: 12.0, right: 12.0,bottom: 0),
          //               child: Row(
          //                 mainAxisAlignment: MainAxisAlignment.center,
          //                 children: [
          //                   Text(
          //                     'Forgot Password?',
          //                     style: TextStyle(
          //                       fontSize: 14.0,
          //                       color: Colors.black,
          //                       fontWeight: FontWeight.bold,
          //                     ),
          //                   ),
          //                   SizedBox(width: 8.0),
          //                   // Adjust the width as needed for spacing
          //                   GestureDetector(
          //                     onTap: () {
          //                       // Handle the click event for the "Click here!" text
          //                       print('Click here! clicked');
          //                       // Add your custom logic or navigation code here
          //                     },
          //                     child: Text(
          //                       'Click here!',
          //                       style: TextStyle(
          //                         fontSize: 14.0,
          //                         color: Color(0xFFe78337),
          //                         fontWeight: FontWeight.bold,
          //                       ),
          //                     ),
          //                   )
          //                 ],
          //               ),
          //             )
          //           ],
          //         ),
          //       ),
          //     ),
          //   ),
          // ),
          Align(
            alignment: FractionalOffset.bottomCenter,
            child: Padding(
              padding:
                  const EdgeInsets.only(left: 22.0, right: 22.0, bottom: 20.0),
              // Adjust the padding as needed
              child: Container(
                height: MediaQuery.of(context).size.height / 2,
                width: MediaQuery.of(context).size.width,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Align(
                        alignment: Alignment.topCenter,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 6.0, left: 12.0, right: 12.0),
                          child: Text(
                            'LogIn',
                            style: TextStyle(
                              fontSize: 24.0,
                              color: Color(0xFFe78337),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        'Hi, Welcome to Srikar Bio Tech',
                        style: TextStyle(
                          fontSize: 18.0,
                          color: Color(0xFFe78337),
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        'Enter your credentials to continue',
                        style: TextStyle(
                          fontSize: 15.0,
                          color: Color(0xFF5f5f5f),
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.only(top: 14.0, left: 30.0, right: 30.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Email/Username', // Add your desired text here
                              style: TextStyle(
                                fontSize: 12.0,
                                color: Color(0xFF5f5f5f),
                                fontWeight: FontWeight.bold,
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
                                  borderRadius: BorderRadius.circular(5.0),
                                  border: Border.all(
                                    color: Color(0xFFe78337),
                                    width: 2,
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: 10.0, right: 5.0),
                                      child: SvgPicture.asset(
                                        'assets/envelope.svg',
                                        width: 20.0,
                                        color: Color(0xFFe78337),
                                      ),
                                    ),
                                    Container(
                                      width: 2.0,
                                      height: 20.0,
                                      color: Color(0xFFe78337),
                                    ),
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
                                              hintText:
                                                  'Enter Email or Username',
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

                      // Padding(
                      //   padding: const EdgeInsets.all(0.0),
                      //   // Adjust the padding as needed
                      //   child: Text(
                      //     'LogIn',
                      //     style: TextStyle(
                      //       fontSize: 14.0,
                      //       color: Color(0xFFe78337),
                      //       fontWeight: FontWeight.bold,
                      //     ),
                      //   ),
                      // ),
                      Padding(
                        padding:
                            EdgeInsets.only(top: 15.0, left: 30.0, right: 30.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Password', // Add your desired text here
                              style: TextStyle(
                                fontSize: 12.0,
                                color: Color(0xFF5f5f5f),
                                fontWeight: FontWeight.bold,
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
                                  borderRadius: BorderRadius.circular(5.0),
                                  border: Border.all(
                                    color: Color(0xFFe78337),
                                    width: 2,
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: 10.0, right: 5.0),
                                      child: SvgPicture.asset(
                                        'assets/lock.svg',
                                        width: 20.0,
                                        color: Color(0xFFe78337),
                                      ),
                                    ),
                                    Container(
                                      width: 2.0,
                                      height: 20.0,
                                      color: Color(0xFFe78337),
                                    ),
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
                                              hintText: 'Enter Password',
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
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                                top: 8.0, left: 30.0, right: 30.0),
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: 55.0,
                              child: Center(
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => HomeScreen()),
                                    );
                                  },
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: 55.0,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(6.0),
                                      color: Color(0xFFe78337),
                                    ),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'LogIn',
                                          style: TextStyle(
                                            fontFamily: 'Calibri',
                                            fontSize: 14,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Image.asset(
                                          'assets/right_arrow.png',
                                          width: 20,
                                          height: 10,
                                          color: Colors.white,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 12.0,
                                left: 12.0,
                                right: 12.0,
                                bottom: 13.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Forgot Password?',
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(width: 8.0),
                                GestureDetector(
                                  onTap: () {
                                    // Handle the click event for the "Click here!" text
                                    print('Click here! clicked');
                                    // Add your custom logic or navigation code here
                                  },
                                  child: Text(
                                    'Click here!',
                                    style: TextStyle(
                                      fontSize: 14.0,
                                      color: Color(0xFFe78337),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
