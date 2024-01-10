import 'dart:convert';
import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:srikarbiotech/Payment_model.dart';
import 'package:srikarbiotech/categroy_model.dart';
import 'Common/CommonUtils.dart';
import 'HomeScreen.dart';
import 'OrctResponse.dart';

class CreateCollection extends StatefulWidget {
  final String cardName;
  final String cardCode;
  final String address;

  CreateCollection(
      {required this.cardName, required this.cardCode, required this.address});

  @override
  State<CreateCollection> createState() => _CreateCollectionState();
}

class _CreateCollectionState extends State<CreateCollection> {
  File? _imageFile;
  String? purpose = 'Regular';
  String? category = 'Pesticides';
  String? chooseDate = 'dd-mm-yyyy';
  String? checkDate = 'dd-mm-yyyy';
  DateTime selectedDate = DateTime.now();
  DateTime selectedCheckDate = DateTime.now();
  String? selectedValue;
  int selectedIndex = -1;
  bool isImageAdded = false;
  int indexselected = -1;

  List<PaymentMode> paymentmode = [];
  bool status = false;
  final _titleTextStyle = const TextStyle(
      fontWeight: FontWeight.bold, color: Colors.black, fontSize: 17);
  late List<bool> isSelectedList;
  final _addressTextStyle = const TextStyle(color: Colors.red, fontSize: 13);
  final _orangeColor = HexColor('#e58338');
  ApiResponse? apiResponse;
  final _border = OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: BorderSide(
      color: HexColor('#e58338'),
    ),
  );
  String paymentname = "";
  int paymentid = 0;
  String? purposename;
  List<String> Purposelist = [];

  String? categroyname;
  List<String> categroylist = [];
  final _textStyle = TextStyle(
      fontSize: 15, color: HexColor('#e58338'), fontWeight: FontWeight.bold);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selectedIndex = 0;
    fetchdropdownitems();
    fetchdropdownitemscategory();
    fetchPayment().then((response) {
      setState(() {
        apiResponse = response;
      });
    });
  }

  Future<ApiResponse> fetchPayment() async {
    try {
      final response = await http.get(Uri.parse(
          'http://182.18.157.215/Srikar_Biotech_Dev/API/api/Master/GetAllTypeCdDmt/2'));
      print('payment: ${response.body}');

      if (response.statusCode == 200) {
        final ApiResponse apiResponse =
            ApiResponse.fromJson(json.decode(response.body));

        if (response.statusCode == 200) {
          return ApiResponse.fromJson(json.decode(response.body));
        } else {
          throw Exception('Failed to load products');
        }
      } else {
        throw Exception('Failed to load products');
      }
    } catch (error) {
      print('Error: $error');
      throw error; // Rethrow the error to be caught by the FutureBuilder
    }
  }

  Future<ApiResponse> fetchProducts() async {
    try {
      final response = await http.get(Uri.parse(
          'http://182.18.157.215/Srikar_Biotech_Dev/API/api/Item/GetItemGroups/null'));
      print('product group response: ${response.body}');

      if (response.statusCode == 200) {
        final ApiResponse apiResponse =
            ApiResponse.fromJson(json.decode(response.body));

        if (response.statusCode == 200) {
          return ApiResponse.fromJson(json.decode(response.body));
        } else {
          throw Exception('Failed to load products');
        }
      } else {
        throw Exception('Failed to load products');
      }
    } catch (error) {
      print('Error: $error');
      throw error; // Rethrow the error to be caught by the FutureBuilder
    }
  }

  Future<void> fetchdropdownitems() async {
    try {
      final response = await http.get(Uri.parse(
          'http://182.18.157.215/Srikar_Biotech_Dev/API/api/Collections/GetPurposes'));
      print('PurposeResponse: ${response.body}');

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        final List<Purpose> purposes =
            (jsonResponse['response']['listResult'] as List)
                .map((data) => Purpose.fromJson(data))
                .toList();
        List<String> purposeNames =
            purposes.map((purpose) => purpose.purposeName).toList();
        setState(() {
          purposename = Purposelist.isNotEmpty ? Purposelist.first : null;
          Purposelist = purposeNames;
          print('Purposelist:$Purposelist');
        });
        // Now you have a list of Purpose objects, you can use it to populate your dropdown items
      } else {
        throw Exception('Failed to load products');
      }
    } catch (error) {
      print('Error: $error');
      throw error; // Rethrow the error to be caught by the FutureBuilder
    }
  }

  Future<void> fetchdropdownitemscategory() async {
    try {
      final response = await http.get(Uri.parse(
          'http://182.18.157.215/Srikar_Biotech_Dev/API/api/Item/GetItemGroups/null'));
      print('PurposeResponse: ${response.body}');

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        final List<ItemGroup> categroyresp =
            (jsonResponse['response']['listResult'] as List)
                .map((data) => ItemGroup.fromJson(data))
                .toList();
        List<String> categoryNames =
            categroyresp.map((purpose) => purpose.itmsGrpNam).toList();

        setState(() {
          categroyname = categroylist.isNotEmpty ? categroylist.first : null;
          categroylist = categoryNames;
          print('categroylist:$categroylist');
        });
        // Now you have a list of Purpose objects, you can use it to populate your dropdown items
      } else {
        throw Exception('Failed to load products');
      }
    } catch (error) {
      print('Error: $error');
      throw error; // Rethrow the error to be caught by the FutureBuilder
    }
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Column(
            children: [
              CommonUtils.buildCard(
                widget.cardName,
                widget.cardCode,
                widget.address,
                Colors.white,
                BorderRadius.circular(10.0),
              ),
              const SizedBox(
                height: 20,
              ),
              Card(
                elevation: 3,
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 5.0),
                        child: Text(
                          'Date',
                          style: _titleTextStyle,
                        ),
                      ),
                      InkWell(
                        onTap: () async {
                          // Perform something.
                          final DateTime? time = await showDatePicker(
                            context: context,
                            initialDate: selectedDate,
                            firstDate: DateTime(2023, 12, 30),
                            lastDate: DateTime(2024, 12, 30),
                          );
                          if (time != null) {
                            setState(() {
                              selectedDate = time;
                            });
                          }
                        },
                        child: Container(
                          height: 50,
                          width: double.infinity,
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: HexColor('#e58338'),
                            ),
                          ),
                          margin: const EdgeInsets.only(top: 3, bottom: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                ' ${selectedDate.day} - ${selectedDate.month} - ${selectedDate.year} ',
                                style: _textStyle,
                              ),
                              Icon(
                                Icons.date_range_outlined,
                                color: _orangeColor,
                              ),
                            ],
                          ),
                        ),
                      ),

                      // amount input box
                      Padding(
                        padding:
                            EdgeInsets.only(top: 0.0, left: 0.0, right: 0.0),
                        child: Text(
                          'Amount',
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
                                    padding:
                                        EdgeInsets.only(left: 5.0, top: 0.0),
                                    child: TextFormField(
                                      keyboardType: TextInputType.name,
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w300,
                                      ),
                                      decoration: InputDecoration(
                                        hintText: 'Enter Amount',
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

                      // Payment Mode
                      Padding(
                        padding:
                            EdgeInsets.only(top: 10.0, left: 0.0, right: 0.0),
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
                      SizedBox(height: 4.0),

                      Container(
                        height: 50,
                        child: GridView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: apiResponse?.listResult.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            //  mainAxisExtent: 60,
                            crossAxisCount:
                                1, // Set to 1 for horizontal scrolling
                          ),
                          itemBuilder: (BuildContext context, int index) {
                            bool isSelected = index == indexselected;
                            PaymentMode? paymode =
                                apiResponse?.listResult[index];
                            print('paymentmode$paymode');
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  indexselected = index;
                                });
                                int? payid = paymode?.typeCdId;
                                print('payid:$payid');
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                margin: EdgeInsets.all(3.0),
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? Color(0xFFe78337)
                                      : Colors.white,
                                  border: Border.all(
                                    color: isSelected
                                        ? Color(0xFFe78337)
                                        : Color(0xFFe78337),
                                    width: 2.0,
                                  ),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                child: IntrinsicWidth(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        // Use Expanded to make sure the Text takes up all available width
                                        child: Center(
                                          child: Text(
                                            '${paymode?.desc.toString()}',
                                            style: TextStyle(
                                              color: isSelected
                                                  ? Colors.white
                                                  : Colors.black,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),

                      SizedBox(height: 4.0),
                      // Check Number
                      Padding(
                        padding:
                            EdgeInsets.only(top: 10.0, left: 0.0, right: 0.0),
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
                                    padding:
                                        EdgeInsets.only(left: 5.0, top: 0.0),
                                    child: TextFormField(
                                      keyboardType: TextInputType.name,
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w300,
                                      ),
                                      decoration: InputDecoration(
                                        hintText: 'XXXXXXXXXX',
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

                      // Check Date
                      Padding(
                        padding:
                            EdgeInsets.only(top: 10.0, left: 0.0, right: 0.0),
                        child: Text(
                          'Check Date',
                          style: TextStyle(
                            fontSize: 12.0,
                            color: Color(0xFF5f5f5f),
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.start,
                        ),
                      ),
                      SizedBox(height: 4.0),
                      InkWell(
                        onTap: () async {
                          // Perform something.
                          final DateTime? time = await showDatePicker(
                            context: context,
                            initialDate: selectedCheckDate,
                            firstDate: DateTime(2023, 12, 30),
                            lastDate: DateTime(2024, 12, 30),
                          );
                          if (time != null) {
                            setState(() {
                              selectedCheckDate = time;
                            });
                          }
                        },
                        child: Container(
                          height: 50,
                          width: double.infinity,
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: HexColor('#e58338'),
                            ),
                          ),
                          margin: const EdgeInsets.only(top: 3, bottom: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                ' ${selectedCheckDate.day} - ${selectedCheckDate.month} - ${selectedCheckDate.year} ',
                                style: _textStyle,
                              ),
                              Icon(
                                Icons.date_range_outlined,
                                color: _orangeColor,
                              ),
                            ],
                          ),
                        ),
                      ),

                      // Check Issued Bank
                      Padding(
                        padding:
                            EdgeInsets.only(top: 10.0, left: 0.0, right: 0.0),
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
                                    padding:
                                        EdgeInsets.only(left: 5.0, top: 0.0),
                                    child: TextFormField(
                                      keyboardType: TextInputType.name,
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

                      // Purpose
                      Padding(
                        padding:
                            EdgeInsets.only(top: 10.0, left: 0.0, right: 0.0),
                        child: Text(
                          'Purpose',
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
                          // Handle the click event for the container
                          print('Container clicked');
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
                                    padding:
                                        EdgeInsets.only(left: 5.0, top: 0.0),
                                    child: Container(
                                      width: MediaQuery.of(context).size.width,
                                      child: DropdownButton<String>(
                                        hint: Text(
                                          'Select Purpose',
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontFamily: 'Roboto-Bold',
                                            fontWeight: FontWeight.w500,
                                            color: Color(0xFFC4C2C2),
                                          ),
                                        ),
                                        value: purposename,
                                        onChanged: (String? newValue) {
                                          setState(() {
                                            purposename = newValue;
                                          });
                                        },
                                        items: Purposelist.map((String bank) {
                                          return DropdownMenuItem<String>(
                                            value: bank,
                                            child: Text(
                                              bank,
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontFamily: 'Roboto-Bold',
                                                fontWeight: FontWeight.w500,
                                                color: Color(0xFF414141),
                                              ),
                                            ),
                                          );
                                        }).toList(),
                                        icon: Icon(Icons.arrow_drop_down),
                                        iconSize: 24,
                                        isExpanded: true,
                                        underline: SizedBox(),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      // Category
                      Padding(
                        padding:
                            EdgeInsets.only(top: 10.0, left: 0.0, right: 0.0),
                        child: Text(
                          'Category',
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
                          // Handle the click event for the container
                          print('Container clicked');
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
                                    padding:
                                        EdgeInsets.only(left: 5.0, top: 0.0),
                                    child: Container(
                                      width: MediaQuery.of(context).size.width,
                                      child: DropdownButton<String>(
                                        hint: Text(
                                          'Select Purpose',
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontFamily: 'Roboto-Bold',
                                            fontWeight: FontWeight.w500,
                                            color: Color(0xFFC4C2C2),
                                          ),
                                        ),
                                        value: categroyname,
                                        onChanged: (String? newValue) {
                                          setState(() {
                                            categroyname = newValue;
                                          });
                                        },
                                        items: categroylist
                                            .map((String categname) {
                                          return DropdownMenuItem<String>(
                                            value: categname,
                                            child: Text(
                                              categname,
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontFamily: 'Roboto-Bold',
                                                fontWeight: FontWeight.w500,
                                                color: Color(0xFF414141),
                                              ),
                                            ),
                                          );
                                        }).toList(),
                                        icon: Icon(Icons.arrow_drop_down),
                                        iconSize: 24,
                                        isExpanded: true,
                                        underline: SizedBox(),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      // Transaction Reference Number
                      // Padding(
                      //   padding:
                      //       EdgeInsets.only(top: 10.0, left: 0.0, right: 0.0),
                      //   child: Text(
                      //     'Transaction Reference Number',
                      //     style: TextStyle(
                      //       fontSize: 12.0,
                      //       color: Color(0xFF5f5f5f),
                      //       fontWeight: FontWeight.bold,
                      //     ),
                      //     textAlign: TextAlign.start,
                      //   ),
                      // ),
                      // SizedBox(height: 4.0),
                      // GestureDetector(
                      //   onTap: () {
                      //     // Handle the click event for the second text view
                      //     print('first textview clicked');
                      //   },
                      //   child: Container(
                      //     width: MediaQuery.of(context).size.width,
                      //     height: 55.0,
                      //     decoration: BoxDecoration(
                      //       borderRadius: BorderRadius.circular(12.0),
                      //       border: Border.all(
                      //         color: Color(0xFFe78337),
                      //         width: 2,
                      //       ),
                      //     ),
                      //     child: Row(
                      //       children: [
                      //         Expanded(
                      //           child: Align(
                      //             alignment: Alignment.centerLeft,
                      //             child: Padding(
                      //               padding:
                      //                   EdgeInsets.only(left: 5.0, top: 0.0),
                      //               child: TextFormField(
                      //                 keyboardType: TextInputType.name,
                      //                 style: TextStyle(
                      //                   fontSize: 14,
                      //                   fontWeight: FontWeight.w300,
                      //                 ),
                      //                 decoration: InputDecoration(
                      //                   hintText:
                      //                       'Enter Transaction Reference Number',
                      //                   hintStyle: TextStyle(
                      //                     fontSize: 14,
                      //                     fontFamily: 'Roboto-Bold',
                      //                     fontWeight: FontWeight.w500,
                      //                     color: Color(0xFFC4C2C2),
                      //                   ),
                      //                   border: InputBorder.none,
                      //                 ),
                      //               ),
                      //             ),
                      //           ),
                      //         ),
                      //       ],
                      //     ),
                      //   ),
                      // ),

                      // Attanchment
                      Padding(
                        padding:
                            EdgeInsets.only(top: 10.0, left: 0.0, right: 0.0),
                        child: Text(
                          'Attachment',
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
                          // here
                          showBottomSheetForImageSelection(context);
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          padding: EdgeInsets.all(0.0),
                          child: DottedBorder(
                            borderType: BorderType.RRect,
                            color: Color(0xFFe78337),
                            padding: const EdgeInsets.only(top: 0, bottom: 0.0),
                            strokeWidth: 2,
                            child: Container(
                              //padding: const EdgeInsets.all(15),
                              // margin: const EdgeInsets.only(top: 3, bottom: 15),
                              //   height: 70,
                              width: MediaQuery.of(context).size.width,
                              padding: EdgeInsets.all(10.0),

                              decoration: BoxDecoration(
//                                borderRadius: BorderRadius.circular(12.0),

                                color: HexColor('#ffeee0'),
                                //  borderRadius: BorderRadius.circular(10),
                                // border: Border.all(
                                //   color: _orangeColor,
                                //   width:      1, // You can adjust the width of the border as needed
                                //   //style: BorderStyle.solid, // Use dotted style
                                // ),
                              ),
                              child: Column(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(6),
                                    // margin: const EdgeInsets.only(bottom: 5),
                                    decoration: BoxDecoration(
                                      color: _orangeColor,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: const Icon(
                                      Icons.folder_rounded,
                                      color: Colors.black,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 4.0,
                                  ),
                                  Text(
                                    'Choose file to upload',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Color(0xFFe78337),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const Text(
                                    'Supported formats: jpg,png',
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: Color(0xFF414141),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 10.0),
                      // diplay choose image by user
                      // SizedBox(
                      //   width: _imageFile != null
                      //       ? MediaQuery.of(context).size.width
                      //       : MediaQuery.of(context).size.width,
                      //   height: _imageFile != null ? 100 : 0,
                      //   child: _imageFile != null
                      //       ? Image.file(
                      //           _imageFile!,
                      //           width: MediaQuery.of(context).size.width,
                      //           fit: BoxFit.fitWidth,
                      //         )
                      //       : Image.asset(
                      //           'assets/shopping_bag.png',
                      //           width: MediaQuery.of(context).size.width,
                      //           fit: BoxFit.fitWidth,
                      //         ),
                      // ),

                      GestureDetector(
                        onTap: () {
                          // Handle tap on uploaded image to remove it
                          setState(() {
                            _imageFile =
                                null; // Set _imageFile to null to remove the image
                          });
                        },
                        child: SizedBox(
                          width: _imageFile != null
                              ? MediaQuery.of(context).size.width
                              : MediaQuery.of(context).size.width,
                          height: _imageFile != null ? 100 : 0,
                          child: Stack(
                            alignment: Alignment.topRight,
                            // Align cross mark icon to the top right
                            children: [
                              _imageFile != null
                                  ? Image.file(
                                      _imageFile!,
                                      width: MediaQuery.of(context).size.width,
                                      fit: BoxFit.fitWidth,
                                    )
                                  : Image.asset(
                                      'assets/shopping_bag.png',
                                      width: MediaQuery.of(context).size.width,
                                      fit: BoxFit.fitWidth,
                                    ),
                              if (_imageFile != null)
                                GestureDetector(
                                  onTap: () {
                                    // Handle tap on cross mark icon (optional)
                                    setState(() {
                                      _imageFile =
                                          null; // Set _imageFile to null to remove the image
                                    });
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(5.0),
                                    margin:
                                        EdgeInsets.only(top: 5, right: 10.0),
                                    color: HexColor(
                                        '#ffeee0'), // Optional overlay color
                                    child: SvgPicture.asset(
                                      'assets/crosscircle.svg',
                                      color: Color(0xFFe78337),
                                      width: 24.0, // Set the width as needed
                                      height: 24.0, // Set the height as needed
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),

                      // Submit Button
                      SizedBox(height: 18.0),
                      Container(
                        padding: const EdgeInsets.all(10),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: _orangeColor,
                        ),
                        child: const Center(
                          child: Text(
                            'Submit',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  pickImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
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
              SizedBox(width: 2.0),
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

  void showBottomSheetForImageSelection(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: Color(0xFFFFFFFF),
      shape: ShapeBorder.lerp(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          1),
      context: context,
      builder: (context) {
        return Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.width / 4,
          child: Row(
            children: <Widget>[
              Expanded(
                child: InkWell(
                  onTap: () {
                    pickImage(ImageSource.camera);
                  },
                  child: const Center(
                    child: Icon(
                      Icons.camera_alt,
                      size: 40,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: InkWell(
                  onTap: () {
                    pickImage(ImageSource.gallery);
                  },
                  child: const Center(
                    child: Icon(
                      Icons.folder,
                      size: 40,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
