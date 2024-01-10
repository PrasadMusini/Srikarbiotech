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
import 'package:srikarbiotech/Common/CommonUtils.dart';
import 'package:http/http.dart' as http;

import 'HomeScreen.dart';

class Ledgerscreen extends StatefulWidget {
  final String cardName;
  final String  cardCode;
  final String  address;
  Ledgerscreen({required this.cardName,required this.cardCode,required this.address});
  @override
  Ledger_screen createState() => Ledger_screen();
}

class Ledger_screen extends State<Ledgerscreen> {

  TextEditingController fromDateController = TextEditingController();
  TextEditingController toDateController = TextEditingController();
  // CalendarFormat calendarFormat = CalendarFormat.month;
  DateTime selectedFromDate = DateTime.now();
  DateTime selectedToDate = DateTime.now();

  @override
  initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);
    checkStoragePermission();
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
                  'Create Collection',
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
                  widget.address,
                  Colors.white,
                  BorderRadius.circular(10.0),
                ),
                SizedBox(height: 16.0),

    Card(
    elevation: 2.0,
    shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(10.0),
    ),
    color: Colors.white,
    child: Container(
    width: double.infinity,
    padding: EdgeInsets.all(16.0),
    child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
    // From Date TextFormField with Calendar Icon
    buildDateInput(
    context,
    'From Date',
    fromDateController,
    () => _selectfromDate(context, fromDateController),
    ),
    SizedBox(height: 16.0),
    // To Date TextFormField with Calendar Icon
    buildDateInput(
    context,
    'To Date',
    toDateController,
    () => _selectDate(context, toDateController),
    ),


    SizedBox(height: 16.0),

    // Download and Share buttons

    ],
    ),
    ))]))]),
      bottomNavigationBar: Container(
        height: 60,
        margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Expanded(
              child: InkWell(
                onTap: () {
                   // Add logic for the download button

                  downloadData();
                    print('Download button clicked');

                },
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color(0xFFe78337),
                  ),
                  child: const Center(
                    child:  Text(
                      'Download',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold, // Set the font weight to bold
                        fontFamily: 'Roboto', // Set the font family to Roboto
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 15,
            ),
            InkWell(
              onTap: () {
                print('Share button clicked');
                 shareData();
              },

              child: Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Color(0xFFe78337),
                  ),
                ),
                child: SvgPicture.asset(
                  'assets/share.svg', // Replace with your SVG file path
                  color: Colors.orange,
                  width: 30,
                  height: 30,
                ),
              ),
            )
          ],
        ),
      ),
 //        bottomNavigationBar: Padding(
 //    padding: const EdgeInsets.all(8.0),
 //    child: Row(
 //    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
 //    children: [
 //    ElevatedButton(
 //    onPressed: () {
 //      downloadData();
 //    // Add logic for the download button
 //    print('Download button clicked');
 //    },
 //    child: Text('Download'),
 //    ),
 //    ElevatedButton(
 //    onPressed: () {
 //    // Add logic for the share button
 //    print('Share button clicked');
 // shareData();
 //    },
 //    child: Text('Share'),
 //    ),
 //    ],
 //    ),
 //    ),
    );








  }

  static Widget buildDateInput(
      BuildContext context,
      String labelText,
      TextEditingController controller,
      VoidCallback onTap,
      ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 0.0, left: 5.0, right: 0.0),
          child: Text(
            labelText,
            style: TextStyle(
              fontSize: 12.0,
              color: Color(0xFF5f5f5f),
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.start,
          ),
        ),
        SizedBox(height: 8.0), // Add space between labelText and TextFormField
        GestureDetector(
          onTap: onTap,
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
                      padding: EdgeInsets.only(left: 10.0, top: 0.0),
                      child: TextFormField(
                        controller: controller,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w300,
                        ),
                        decoration: InputDecoration(
                          hintText: labelText,
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
                InkWell(
                  onTap: onTap,
                  child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Icon(
                      Icons.calendar_today,
                      color: Colors.orange,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }



  Future<void> _selectfromDate(
      BuildContext context,
      TextEditingController controller,
      ) async {
    DateTime currentDate = DateTime.now();
    DateTime initialDate;

    if (controller.text.isNotEmpty) {
      try {
        initialDate = DateTime.parse(controller.text);
      } catch (e) {
        // Handle the case where the current text is not a valid date format
        print("Invalid date format: $e");
        initialDate = currentDate;
      }
    } else {
      initialDate = currentDate;
    }

    try {
      DateTime? picked = await showDatePicker(
        context: context,
        initialDate: initialDate,
        firstDate: DateTime(2000),
        lastDate: DateTime(2101),
      );

      if (picked != null) {
        String formattedDate = DateFormat('dd-MM-yyyy').format(picked);
        controller.text = formattedDate;

        // Save selected dates as DateTime objects
        selectedFromDate = picked;
        print("Selected From Date: $selectedFromDate");


        // Print formatted date
        print("Selected To Date: ${DateFormat('yyyy-MM-dd').format(picked)}");
      }
    } catch (e) {
      print("Error selecting date: $e");
      // Handle the error, e.g., show a message to the user or log it.
    }
  }

  Future<void> _selectDate(
      BuildContext context,
      TextEditingController controller,
      ) async {
    DateTime currentDate = DateTime.now();
    DateTime initialDate;

    if (controller.text.isNotEmpty) {
      try {
        initialDate = DateTime.parse(controller.text);
      } catch (e) {
        // Handle the case where the current text is not a valid date format
        print("Invalid date format: $e");
        initialDate = currentDate;
      }
    } else {
      initialDate = currentDate;
    }

    try {
      DateTime? picked = await showDatePicker(
        context: context,
        initialDate: initialDate,
        firstDate: DateTime(2000),
        lastDate: DateTime(2101),
      );

      if (picked != null) {
        String formattedDate = DateFormat('dd-MM-yyyy').format(picked);
        controller.text = formattedDate;

        // Save selected dates as DateTime objects
        selectedToDate = picked;
        print("Selected to Date: $selectedToDate");


        // Print formatted date
        print("Selected To Date: ${DateFormat('yyyy-MM-dd').format(picked)}");
      }
    } catch (e) {
      print("Error selecting date: $e");
      // Handle the error, e.g., show a message to the user or log it.
    }
  }
  Future<void> downloadData() async {
    bool isValid = true;
    bool hasValidationFailed = false;
    String fromdate = DateFormat('yyyy-MM-dd').format(selectedFromDate);
    String todate = DateFormat('yyyy-MM-dd').format(selectedToDate);
    if (isValid && fromDateController.text.isEmpty) {
      CommonUtils.showCustomToastMessageLong(
          'Please Select From Date', context, 1, 4);
      isValid = false;
      hasValidationFailed = true;
    }
    if (isValid && toDateController.text.isEmpty) {
      CommonUtils.showCustomToastMessageLong(
          'Please Select to Date', context, 1, 4);
      isValid = false;
      hasValidationFailed = true;
    }

    if (isValid && todate.compareTo(fromdate) < 0) {
      CommonUtils.showCustomToastMessageLong(
          "To Date is less than From Date", context, 1, 5);
      isValid = false;
      hasValidationFailed = true;
    }

    if (isValid) {
      final apiUrl = 'http://182.18.157.215/Srikar_Biotech_Dev/API/api/Party/GetCustomerLedgerReport';
      final requestHeaders = {'Content-Type': 'application/json'};

      final requestBody = {
        "PartyCode":'${widget.cardCode}',
        "FromDate": fromdate,
        "ToDate": todate
      };

      try {
        final response = await http.post(
          Uri.parse(apiUrl),
          headers: requestHeaders,
          body: jsonEncode(requestBody),
        );

        if (response.statusCode == 200) {
          final jsonResponse = json.decode(response.body);

          if (jsonResponse['isSuccess']) {
            // Convert base64 string to bytes
            List<int> pdfBytes = base64.decode(jsonResponse['response']);
            var status = await Permission.storage.request();
            if (status.isGranted) {
              Directory downloadsDirectory = Directory(
                  '/storage/emulated/0/Download');

              String fileName = "srikar_${DateFormat('yyyyMMdd_HHmmss').format(
                  DateTime.now())}.pdf";

              String filePath = '${downloadsDirectory.path}/$fileName';

              // Write the bytes to a file
              await File(filePath).writeAsBytes(pdfBytes);
              // Permission granted, proceed with file operations
              // ... (your existing code)
              print('PDF saved to: $filePath');
              CommonUtils.showCustomToastMessageLong(
                  'Downloaded Successfully', context, 0, 4);
            } else {
              print('Permission denied');

              CommonUtils.showCustomToastMessageLong(
                  'Permission denied', context, 0, 4);
            }

            // Get the directory for saving files


          } else {
            print('API Error: ${jsonResponse['endUserMessage']}');
          }
        } else {
          print('Error: ${response.reasonPhrase}');
        }
      } catch (error) {
        print('Error: $error');
      }
    }
  }



  Future<void> shareData() async {
    final apiUrl = 'http://182.18.157.215/Srikar_Biotech_Dev/API/api/Party/GetCustomerLedgerReport';
    final requestHeaders = {'Content-Type': 'application/json'};

    final requestBody = {
      "PartyCode": "SRIKARTS00139",
      "FromDate": "2023-05-24",
      "ToDate": "2023-06-05"
    };

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: requestHeaders,
        body: jsonEncode(requestBody),
      );

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);

        if (jsonResponse['isSuccess']) {
          // Convert base64 string to bytes
          List<int> pdfBytes = base64.decode(jsonResponse['response']);
       //   var status = await Permission.storage.request();
          final status = await Permission.storage.request();
          // if (status.isDenied ||
          //     status.isPermanentlyDenied ||
          //     status.isRestricted) {
          if (status.isGranted) {
            Directory downloadsDirectory = Directory('/storage/emulated/0/Download');

            String fileName = "srikar_${DateFormat('yyyyMMdd_HHmmss').format(DateTime.now())}.pdf";

            String filePath = '${downloadsDirectory.path}/$fileName';

            // Write the bytes to a file
            await File(filePath).writeAsBytes(pdfBytes);
            // Permission granted, proceed with file operations
            // ... (your existing code)
            print('PDF saved to: $filePath');
            await _sharePdf(filePath);
          } else {
          //  requestPermission();
            print('Permission denied');
          }

          // Get the directory for saving files



        } else {
          print('API Error: ${jsonResponse['endUserMessage']}');
        }
      } else {
        print('Error: ${response.reasonPhrase}');
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  Future<void> _sharePdf(String filePath) async {
    try {
      // Check if the file exists
      File file = File(filePath);
      if (await file.exists()) {
        // Share the file
        await Share.shareFiles([filePath], text: 'Check out this PDF file');
      } else {
        print('File not found: $filePath');
      }
    } catch (error) {
      print('Error sharing PDF: $error');
    }
  }

  Future<void> checkStoragePermission() async {
    if (await Permission.storage.request().isGranted) {
    // Permission is granted, you can proceed with your tasks
    print('Storage permission is granted');
    } else {
    // Permission is not granted, request it
    Map<Permission, PermissionStatus> status = await [
    Permission.storage,
    ].request();

    if (status[Permission.storage] == PermissionStatus.granted) {
    // Permission granted, you can proceed with your tasks
    print('Storage permission is granted');
    } else {
    // Permission denied, handle accordingly
    print('Storage permission is denied');
    // You might want to show a dialog or message to inform the user
    }
    }
  }




}







