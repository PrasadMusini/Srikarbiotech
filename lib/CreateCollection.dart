import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';

import 'Common/CommonUtils.dart';
import 'HomeScreen.dart';

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

  bool status = false;
  final _titleTextStyle = const TextStyle(
      fontWeight: FontWeight.bold, color: Colors.black, fontSize: 17);

  final _addressTextStyle = const TextStyle(color: Colors.red, fontSize: 13);
  final _orangeColor = HexColor('#e58338');

  final _border = OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: BorderSide(
      color: HexColor('#e58338'),
    ),
  );

  final _textStyle = TextStyle(
      fontSize: 15, color: HexColor('#e58338'), fontWeight: FontWeight.bold);

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

      // AppBar(
      //   backgroundColor: Color(0xFFe78337),
      //   automaticallyImplyLeading: false,
      //   // This line removes the default back arrow
      //   title: Row(
      //     mainAxisAlignment: MainAxisAlignment.start,
      //     mainAxisSize: MainAxisSize.min,
      //     children: [
      //       Padding(
      //         padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 2),
      //         child: GestureDetector(
      //           onTap: () {
      //             // Handle the click event for the home icon
      //             print('Home icon clicked');
      //           },
      //           child: Icon(
      //             Icons.chevron_left,
      //             size: 30.0,
      //             color: Colors.white,
      //           ),
      //         ),
      //       ),
      //       SizedBox(width: 8.0),
      //       Text(
      //         'Create Collection',
      //         style: TextStyle(
      //           color: Colors.white,
      //           fontSize: 18,
      //         ),
      //       ),
      //       SizedBox(width: 8.0),
      //       Icon(
      //         Icons.home,
      //         size: 30,
      //         color: Colors.white,
      //
      //       ),
      //     ],
      //   ),
      // ),

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
                        padding: const EdgeInsets.only(left: 5.0),
                        child: Text(
                          'Amount',
                          style: _titleTextStyle,
                        ),
                      ),
                      Container(
                        height: 50,
                        margin: const EdgeInsets.only(top: 3, bottom: 15),
                        child: TextField(
                          decoration: InputDecoration(
                            hintStyle: _textStyle,
                            hintText: 'Enter Amount',
                            border: _border,
                            enabled: true,
                            enabledBorder: _border,
                            focusedBorder: _border,
                          ),
                        ),
                      ),

                      // Payment Mode
                      Padding(
                        padding: const EdgeInsets.only(left: 5.0),
                        child: Text(
                          'Payment Mode',
                          style: _titleTextStyle,
                        ),
                      ),
                      Row(
                        children: [
                          Container(
                            height: 50,
                            margin: const EdgeInsets.only(
                              top: 3,
                              bottom: 15,
                              right: 15,
                            ),
                            child: Chip(
                              avatar: const Icon(
                                Icons.home,
                                color: Colors.black,
                              ),
                              side: BorderSide(
                                color: _orangeColor,
                              ),
                              backgroundColor: _orangeColor,
                              label: const Text('Cheque'),
                              labelStyle: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontSize: 17,
                              ),
                            ),
                          ),
                          Container(
                            height: 50,
                            margin: const EdgeInsets.only(top: 3, bottom: 15),
                            child: Chip(
                              avatar: const Icon(
                                Icons.home,
                                color: Colors.black,
                              ),
                              side: BorderSide(
                                color: _orangeColor,
                              ),
                              backgroundColor:
                              const Color.fromARGB(255, 248, 237, 221),
                              label: const Text('Online'),
                              labelStyle: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontSize: 17,
                              ),
                            ),
                          ),
                        ],
                      ),
                      // Check Number
                      Padding(
                        padding: const EdgeInsets.only(left: 5.0),
                        child: Text(
                          'Check Number',
                          style: _titleTextStyle,
                        ),
                      ),
                      Container(
                        height: 50,
                        margin: const EdgeInsets.only(top: 3, bottom: 15),
                        child: TextField(
                          decoration: InputDecoration(
                            hintStyle: _textStyle,
                            hintText: 'xxxxxxxxxxx',
                            border: _border,
                            enabled: true,
                            enabledBorder: _border,
                            focusedBorder: _border,
                          ),
                        ),
                      ),

                      // Check Date
                      Padding(
                        padding: const EdgeInsets.only(left: 5.0),
                        child: Text(
                          'Check Date',
                          style: _titleTextStyle,
                        ),
                      ),

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
                        padding: const EdgeInsets.only(left: 5.0),
                        child: Text(
                          'Check Issued Bank',
                          style: _titleTextStyle,
                        ),
                      ),
                      Container(
                        height: 50,
                        margin: const EdgeInsets.only(top: 3, bottom: 15),
                        child: TextField(
                          decoration: InputDecoration(
                            hintStyle: _textStyle,
                            hintText: 'State Bank of India',
                            border: _border,
                            enabled: true,
                            enabledBorder: _border,
                            focusedBorder: _border,
                          ),
                        ),
                      ),

                      // Purpose
                      Padding(
                        padding: const EdgeInsets.only(left: 5.0),
                        child: Text(
                          'Purpose',
                          style: _titleTextStyle,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          // dropdown.
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
                              // Text(
                              //   '$purpose',
                              //   style: _textStyle,
                              // ),
                              // Icon(
                              //   Icons.keyboard_arrow_down_outlined,
                              //   color: _orangeColor,
                              // ),
                              DropdownButton<String>(
                                value: selectedValue,
                                hint: const Text('Select something'),
                                items: const [
                                  DropdownMenuItem(
                                    value: 'Onew',
                                    child: Text("One"),
                                  ),
                                  DropdownMenuItem<String>(
                                    value: 'Twow',
                                    child: Text("Two"),
                                  ),
                                  DropdownMenuItem(
                                    value: 'Threew',
                                    child: Text("Three"),
                                  ),
                                ],
                                onChanged: (String? newValue) {
                                  setState(() {
                                    selectedValue = newValue;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      ),

                      // Category
                      Padding(
                        padding: const EdgeInsets.only(left: 5.0),
                        child: Text(
                          'Category',
                          style: _titleTextStyle,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          // perform something.
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
                                '$category',
                                style: _textStyle,
                              ),
                              Icon(
                                Icons.keyboard_arrow_down_outlined,
                                color: _orangeColor,
                              ),
                            ],
                          ),
                        ),
                      ),
                      // Transaction Reference Number
                      Padding(
                        padding: const EdgeInsets.only(left: 5.0),
                        child: Text(
                          'Transaction Reference Number',
                          style: _titleTextStyle,
                        ),
                      ),
                      Container(
                        height: 50,
                        margin: const EdgeInsets.only(top: 3, bottom: 15),
                        child: TextField(
                          decoration: InputDecoration(
                            hintStyle: _textStyle,
                            hintText: 'Enter Transaction Reference Number',
                            border: _border,
                            enabled: true,
                            enabledBorder: _border,
                            focusedBorder: _border,
                          ),
                        ),
                      ),

                      // Attanchment
                      Padding(
                        padding: const EdgeInsets.only(left: 5.0),
                        child: Text(
                          'Attanchment',
                          style: _titleTextStyle,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          // here
                          showBottomSheetForImageSelection(context);
                        },
                        child: Container(
                          padding: const EdgeInsets.all(15),
                          margin: const EdgeInsets.only(top: 3, bottom: 15),
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: HexColor('#ffeee0'),
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: _orangeColor)),
                          child: Column(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(6),
                                margin: const EdgeInsets.only(bottom: 5),
                                decoration: BoxDecoration(
                                  color: _orangeColor,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: const Icon(
                                  Icons.folder_rounded,
                                  color: Colors.black,
                                ),
                              ),
                              Text(
                                'Choose file to upload',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: _orangeColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const Text(
                                'Supported formats: jpg,png',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      // diplay choose image by user
                      SizedBox(
                        width: _imageFile != null ? 100 : 0,
                        height: _imageFile != null ? 100 : 0,
                        child: _imageFile != null
                            ? Image.file(_imageFile!)
                            : Image.asset('assets/shopping_bag.png'),
                      ),
                      // display choose image by user

                      // Submit Button
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
