
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

class Createorderscreen extends StatefulWidget {


  @override
  Createorder_screen createState() => Createorder_screen();
}

class Createorder_screen extends State<Createorderscreen> {
  List<String> images = [
    "https://static.javatpoint.com/tutorial/flutter/images/flutter-logo.png",
    "https://static.javatpoint.com/tutorial/flutter/images/flutter-logo.png",
    "https://static.javatpoint.com/tutorial/flutter/images/flutter-logo.png",
    "https://static.javatpoint.com/tutorial/flutter/images/flutter-logo.png"
  ];

  @override
  initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);
// Print the userId
  //  navigateproductdetailsscreen();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(


      appBar: AppBar(
        backgroundColor: Color(0xFFe78337),
        automaticallyImplyLeading: false, // This line removes the default back arrow
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 2),
              child: Icon(
                Icons.chevron_left,
                size: 30.0,// Change this to the icon you want
                color: Colors.white,
              ),
            ),
            Text(
              'Order',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
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
                        color: Colors.black26,
                        width: 2,
                      ),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Padding(
                              padding: EdgeInsets.only(left: 10.0, top: 0.0),
                              child: TextFormField(
                                keyboardType: TextInputType.name,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w300,
                                ),
                                decoration: InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.search, // Add the search icon here
                                    color: Color(0xFFC4C2C2),
                                  ),
                                  hintText: 'Product Search',
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


    //   _isLoading
          //     ? Center(
          //   child: CircularProgressIndicator(),
          // )
          //     : Expanded(
          // child: ListView.builder(
          //   shrinkWrap: true,
          //   itemCount: brancheslist.length,
          //   itemBuilder: (context, index) {
          //     BranchModel branch = brancheslist[index];
          //
          //     return Padding(
          //       padding: EdgeInsets.symmetric(
          //           horizontal: 15.0, vertical: 5.0),
          //       child: IntrinsicHeight(
          //         child: ClipRRect(
          //             borderRadius: BorderRadius.only(
          //               topRight: Radius.circular(42.5),
          //               bottomLeft: Radius.circular(42.5),
          //             ),
          //             child: GestureDetector(
          //               onTap: () {
          //                 Navigator.of(context).push(
          //                   MaterialPageRoute(builder:
          //                       (context) => appointmentlist(
          //                       userId: widget.userId,
          //                       branchid: branch.id,
          //                       branchname: branch.name,
          //                       filepath: branch.filePath,
          //                       phonenumber: branch.mobileNumber,
          //                       branchaddress: branch.address)),);
          //               },
          //               child: Card(
          //                 shadowColor: Colors.transparent,
          //                 surfaceTintColor: Colors.transparent,
          //                 child: ClipRRect(
          //                   borderRadius: BorderRadius.only(
          //                     topRight: Radius.circular(29.0),
          //                     bottomLeft: Radius.circular(29.0),
          //                   ),
          //                   //surfaceTintColor : Colors.red,
          //
          //                   child: Container(
          //                     decoration: BoxDecoration(
          //                       gradient: LinearGradient(
          //                         colors: [
          //                           Color(0xFFFEE7E1), // Start color
          //                           Color(0xFFD7DEFA),
          //                         ],
          //                         begin: Alignment.centerLeft,
          //                         end: Alignment.centerRight,
          //
          //                       ),
          //                       // borderRadius: BorderRadius.only(
          //                       //   topRight: Radius.circular(30.0),
          //                       //   bottomLeft: Radius.circular(30.0),
          //                       //
          //                       // ),
          //
          //                     ),
          //                     child: Row(
          //                       crossAxisAlignment: CrossAxisAlignment.center,
          //                       children: [
          //                         Padding(
          //                           padding: EdgeInsets.only(left: 15.0),
          //                           child: Container(
          //                             width: 110,
          //                             height: 65,
          //                             decoration: BoxDecoration(
          //                               borderRadius: BorderRadius.circular(
          //                                   10.0),
          //                               border: Border.all(
          //                                 color: Color(0xFF9FA1EE),
          //                                 width: 3.0,
          //                               ),
          //                             ),
          //                             child: ClipRRect(
          //                               borderRadius: BorderRadius.circular(
          //                                   7.0),
          //                               child: Image.network(
          //                                 imagesflierepo +
          //                                     branch.filePath,
          //                                 width: 110,
          //                                 height: 65,
          //                                 fit: BoxFit.fill,
          //                               ),
          //                             ),
          //                           ),
          //                         ),
          //                         Expanded(
          //                           child: Padding(
          //                             padding: EdgeInsets.only(left: 15.0),
          //                             child: Column(
          //                               mainAxisAlignment: MainAxisAlignment
          //                                   .start,
          //                               crossAxisAlignment: CrossAxisAlignment
          //                                   .start,
          //                               children: [
          //                                 Padding(
          //                                   padding: EdgeInsets.only(
          //                                       top: 15.0),
          //                                   child: Text(
          //                                     branch.name,
          //                                     style: TextStyle(
          //                                       fontSize: 18,
          //                                       color: Color(0xFFFB4110),
          //                                       fontWeight: FontWeight.bold,
          //                                       fontFamily: 'Calibri',
          //                                     ),
          //                                   ),
          //                                 ),
          //                                 SizedBox(height: 4.0),
          //                                 Expanded(
          //                                   child: Padding(
          //                                     padding: EdgeInsets.only(
          //                                         right: 10.0),
          //                                     child: Column(
          //                                       crossAxisAlignment: CrossAxisAlignment
          //                                           .start,
          //                                       children: [
          //                                         Row(
          //                                           mainAxisAlignment: MainAxisAlignment
          //                                               .spaceEvenly,
          //                                           children: [
          //                                             Image.asset(
          //                                               'assets/location_icon.png',
          //                                               width: 20,
          //                                               height: 18,
          //                                             ),
          //                                             SizedBox(width: 4.0),
          //                                             Expanded(
          //                                               child: Text(
          //                                                 branch.address,
          //                                                 style: TextStyle(
          //                                                   fontFamily: 'Calibri',
          //                                                   fontSize: 12,
          //                                                   color: Color(
          //                                                       0xFF000000),
          //                                                 ),
          //                                               ),
          //                                             ),
          //                                           ],
          //                                         ),
          //                                         Spacer(flex: 3),
          //                                       ],
          //                                     ),
          //                                   ),
          //                                 ),
          //                                 Align(
          //                                   alignment: Alignment.bottomRight,
          //                                   child: Container(
          //                                     height: 26,
          //                                     margin: EdgeInsets.only(
          //                                         bottom: 10.0, right: 10.0),
          //                                     decoration: BoxDecoration(
          //                                       color: Colors.white,
          //                                       border: Border.all(
          //                                         color: Color(0xFF8d97e2),
          //                                       ),
          //                                       borderRadius: BorderRadius
          //                                           .circular(10.0),
          //                                     ),
          //                                     child: ElevatedButton(
          //                                       onPressed: () {
          //                                         // Handle button press
          //                                       },
          //                                       style: ElevatedButton
          //                                           .styleFrom(
          //                                         primary: Colors.transparent,
          //                                         onPrimary: Color(
          //                                             0xFF8d97e2),
          //                                         elevation: 0,
          //                                         shadowColor: Colors
          //                                             .transparent,
          //                                         shape: RoundedRectangleBorder(
          //                                           borderRadius: BorderRadius
          //                                               .circular(10.0),
          //                                         ),
          //                                       ),
          //                                       child: GestureDetector(
          //                                         onTap: () {
          //                                           print(
          //                                               'Appointment Clicked ');
          //
          //                                           // Handle button press, navigate to a new screen
          //                                           Navigator.of(context)
          //                                               .push(
          //                                             MaterialPageRoute(
          //                                                 builder:
          //                                                     (context) =>
          //                                                     appointmentlist(
          //                                                         userId: widget
          //                                                             .userId,
          //                                                         branchid: branch
          //                                                             .id,
          //                                                         branchname: branch
          //                                                             .name,
          //                                                         filepath: branch
          //                                                             .filePath,
          //                                                         phonenumber: branch
          //                                                             .mobileNumber,
          //                                                         branchaddress: branch
          //                                                             .address)),);
          //                                         },
          //                                         child: Row(
          //                                           mainAxisSize: MainAxisSize
          //                                               .min,
          //                                           children: [
          //                                             SvgPicture.asset(
          //                                               'assets/datepicker_icon.svg',
          //                                               width: 15.0,
          //                                               height: 15.0,
          //                                             ),
          //                                             SizedBox(width: 5),
          //                                             Text(
          //                                               'Check Appointment',
          //                                               style: TextStyle(
          //                                                 fontSize: 12,
          //                                                 color: Color(
          //                                                     0xFF8d97e2),
          //                                               ),
          //                                             ),
          //                                           ],
          //                                         ),
          //                                       ),
          //                                     ),
          //                                   ),
          //                                 ),
          //                               ],
          //                             ),
          //                           ),
          //                         ),
          //
          //                       ],
          //                     ),
          //                   ),
          //                 ),
          //               ),
          //               // child: Card(
          //               //   shadowColor: Colors.grey,
          //               //   elevation: 10,
          //               //   child: Container(
          //               //     decoration: BoxDecoration(
          //               //       gradient: LinearGradient(
          //               //         colors: [
          //               //           Color(0xFFFEE7E1), // Start color
          //               //           Color(0xFFD7DEFA)
          //               //         ],
          //               //         begin: Alignment.centerLeft,
          //               //         end: Alignment.centerRight,
          //               //       ),
          //               //       borderRadius: BorderRadius.only(
          //               //         topRight: Radius.circular(30.0),
          //               //         bottomLeft: Radius.circular(30.0),
          //               //       ),
          //               //     ),
          //               //     child: Row(
          //               //       crossAxisAlignment: CrossAxisAlignment.center,
          //               //       children: [
          //               //         Padding(
          //               //           padding: EdgeInsets.only(left: 15.0),
          //               //           child: Container(
          //               //             width: 110,
          //               //             height: 65,
          //               //             decoration: BoxDecoration(
          //               //               borderRadius: BorderRadius.circular(10.0),
          //               //               border: Border.all(
          //               //                 color: Color(0xFF9FA1EE),
          //               //                 width: 3.0,
          //               //               ),
          //               //             ),
          //               //             child: ClipRRect(
          //               //               borderRadius: BorderRadius.circular(7.0),
          //               //               child: Image.network(
          //               //                 branch.filePath,
          //               //                 width: 110,
          //               //                 height: 65,
          //               //                 fit: BoxFit.fill,
          //               //               ),
          //               //             ),
          //               //           ),
          //               //         ),
          //               //         Expanded(
          //               //           child: Padding(
          //               //             padding: EdgeInsets.only(left: 15.0),
          //               //             child: Column(
          //               //               mainAxisAlignment: MainAxisAlignment.start,
          //               //               crossAxisAlignment: CrossAxisAlignment.start,
          //               //               children: [
          //               //                 Padding(
          //               //                   padding: EdgeInsets.only(top: 15.0),
          //               //                   child: Text(
          //               //                     branch.name,
          //               //                     style: TextStyle(
          //               //                       fontSize: 18,
          //               //                       color: Color(0xFFFB4110),
          //               //                       fontWeight: FontWeight.bold,
          //               //                       fontFamily: 'Calibri',
          //               //                     ),
          //               //                   ),
          //               //                 ),
          //               //                 SizedBox(height: 4.0),
          //               //                 Expanded(
          //               //                   child: Padding(
          //               //                     padding: EdgeInsets.only(right: 10.0),
          //               //                     child: Column(
          //               //                       crossAxisAlignment: CrossAxisAlignment.start,
          //               //                       children: [
          //               //                         Row(
          //               //                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //               //                           children: [
          //               //                             Image.asset(
          //               //                               'assets/location_icon.png',
          //               //                               width: 20,
          //               //                               height: 18,
          //               //                             ),
          //               //                             SizedBox(width: 4.0),
          //               //                             Expanded(
          //               //                               child: Text(
          //               //                                 branch.address,
          //               //                                 style: TextStyle(
          //               //                                   fontFamily: 'Calibri',
          //               //                                   fontSize: 12,
          //               //                                   color: Color(0xFF000000),
          //               //                                 ),
          //               //                               ),
          //               //                             ),
          //               //                           ],
          //               //                         ),
          //               //                         Spacer(
          //               //                           flex: 3,
          //               //                         ),
          //               //                       ],
          //               //                     ),
          //               //                   ),
          //               //                 ),
          //               //                 Align(
          //               //                   alignment: Alignment.bottomRight,
          //               //                   child: Container(
          //               //                     height: 26,
          //               //                     margin: EdgeInsets.only(bottom: 10.0, right: 10.0),
          //               //                     decoration: BoxDecoration(
          //               //                       color: Colors.white,
          //               //                       border: Border.all(
          //               //                         color: Color(0xFF8d97e2),
          //               //                       ),
          //               //                       borderRadius: BorderRadius.circular(10.0),
          //               //                     ),
          //               //                     child: ElevatedButton(
          //               //                       onPressed: () {
          //               //                         Navigator.of(context).push(MaterialPageRoute(builder:
          //               //                             (context)=>appointmentlist(userId:widget.userId, branchid:branch.id,branchname:branch.name ,filepath:branch.filePath) ),);
          //               //                         // Handle button press
          //               //                         //  _handleButtonPress();
          //               //                       },
          //               //                       style: ElevatedButton.styleFrom(
          //               //                         primary: Colors.transparent,
          //               //                         onPrimary: Color(0xFF8d97e2),
          //               //                         elevation: 0,
          //               //                         shadowColor: Colors.transparent,
          //               //                         shape: RoundedRectangleBorder(
          //               //                           borderRadius: BorderRadius.circular(10.0),
          //               //                         ),
          //               //                       ),
          //               //                       child: GestureDetector(
          //               //                         onTap: () {
          //               //                           // Handle button press, navigate to a new screen
          //               //                           // Navigator.push(
          //               //                           //   context,
          //               //                           //   MaterialPageRoute(builder: (context) => appointmentlist(userId:widget.userId, branchid:branch.id,branchname:branch.name   )),
          //               //                           // );
          //               //                         },
          //               //                         child: Row(
          //               //                           mainAxisSize: MainAxisSize.min,
          //               //                           children: [
          //               //                             SvgPicture.asset(
          //               //                               'assets/datepicker_icon.svg',
          //               //                               width: 15.0,
          //               //                               height: 15.0,
          //               //                             ),
          //               //                             SizedBox(width: 5),
          //               //                             Text(
          //               //                               'Check Appointment',
          //               //                               style: TextStyle(
          //               //                                   fontSize: 12,
          //               //                                   color: Color(0xFF8d97e2),
          //               //                                   fontWeight: FontWeight.bold,
          //               //                                   fontFamily: 'Calibri'
          //               //                               ),
          //               //                             ),
          //               //                           ],
          //               //                         ),
          //               //                       ),
          //               //                     ),
          //               //                   ),
          //               //                 ),
          //               //               ],
          //               //             ),
          //               //           ),
          //               //         ),
          //               //       ],
          //               //     ),
          //               //   ),
          //               // ),
          //             )
          //
          //         ),
          //       ),
          //     );
          //   },
          // ),

        ],

        
      ),


    );
  }

  navigateproductdetailsscreen() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => Createorderscreen()),
    );
  }



// Perform your operations here

// After the operations are completed, update the state to hide the progress indicator

}


