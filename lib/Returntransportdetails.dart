import 'dart:convert';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'dart:convert';
import 'dart:io';

import 'ReturnOrdersubmit_screen.dart';
class Returntransportdetails extends StatefulWidget {
  final String cardName;
  final String  cardCode;
  final String  address;
  final String proprietorName;
  final String gstRegnNo;
  final String state;
  final String phone;

  Returntransportdetails(
  {required this.cardName, required this.cardCode, required this.address, required  this.state, required  this.phone,
  required  this.proprietorName, required  this.gstRegnNo});

  @override
  State<Returntransportdetails> createState() => _createreturnorderPageState();
}

class _createreturnorderPageState extends State<Returntransportdetails> {
  //File? _imageFile;
  String filename = '';
  String fileExtension = '';
  String base64Image = '';
  File? _imageFile;

  String filenameorderreciept = '';
  String fileExtensionorderreciept = '';
  String base64Imageorderreciept = '';
  File? _imageFileorderreciept;

  String filenameaddlattchments = '';
  String fileExtensionaddlattchments = '';
  String base64Imageaddlattchments = '';
  File? _imageFileaddlattchments;
  TextEditingController _leavetext = TextEditingController();
  TextEditingController DateController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  @override
  Widget build(BuildContext context) {
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
                  'My Orders',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(10.0),
          child: Card(
            elevation: 5,
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 15.0, left: 15.0, right: 15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding:
                        EdgeInsets.only(top: 0.0, left: 5.0, right: 0.0),
                        child: Text(
                          'LR Number',
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
                                    EdgeInsets.only(left: 10.0, top: 0.0),
                                    child: TextFormField(
                                      keyboardType: TextInputType.name,
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w300,
                                      ),
                                      decoration: InputDecoration(
                                        hintText: 'Enter LR Number',
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
                  padding: EdgeInsets.only(left: 15, top: 4.0, right: 15),
                  child: buildDateInput(
                    context,
                    'LR Date',
                    DateController,
                        () => _selectDate(context, DateController),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 15, top: 4.0, right: 15),
                  child: GestureDetector(
                      onTap: () async {},
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                                top: 5.0, left: 5.0, right: 0.0),
                            child: Text(
                              'Remarks',
                              style: TextStyle(
                                fontSize: 12.0,
                                color: Color(0xFF5f5f5f),
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.start,
                            ),
                          ),
                          Container(
                            height: 120,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: Color(0xFFe78337), width: 1.5),
                              borderRadius: BorderRadius.circular(12.0),
                              color: Colors.white,
                            ),
                            child: TextFormField(
                              controller: _leavetext,
                              style: TextStyle(
                                fontFamily: 'Calibri',
                                fontSize: 14,
                                fontWeight: FontWeight.w300,
                              ),
                              maxLines:
                              null, // Set maxLines to null for multiline input
                              decoration: InputDecoration(
                                hintText: 'Enter Return Order remarks',
                                hintStyle: TextStyle(
                                  color: Colors.black26,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Calibri',
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 10.0,
                                  vertical: 0.0,
                                ),
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ],
                      )),
                ),
                SizedBox(height: 10.0),




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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                    EdgeInsets.only(top: 10.0, left: 15.0, right: 15.0),
                    child: Text(
                      'LR Attachment',
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
                    padding: EdgeInsets.only(left: 15.0,right: 15.0),
                    child: DottedBorder(
                      borderType: BorderType.RRect,
                      color: Color(0xFFe78337),
                      padding: const EdgeInsets.only(top: 0, bottom: 0.0),
                      strokeWidth: 2,
                      child: Container(

                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.all(10.0),

                        decoration: BoxDecoration(
                          color: Color(0xFFffeee0),

                        ),
                        child: Column(

                          children: [
                            Container(
                              padding: const EdgeInsets.all(6),
                              // margin: const EdgeInsets.only(bottom: 5),
                              decoration: BoxDecoration(
                                color: Color(0xFFe78337),
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
                    ) ,
                  )
                 
                ],
              )

            ),
          ),
          SizedBox(height: 10.0),


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
                          _imageFile = null; // Set _imageFile to null to remove the image
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.all(5.0),
                        margin:
                        EdgeInsets.only(top: 5, right: 10.0),
                        color: Color(0xFFffeee0), // Optional overlay color
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



                GestureDetector(
                  onTap: () {
                    // here
                    showBottomSheetForImageSelectionordereceipt(context);
                  },
                  child: Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      padding: EdgeInsets.all(0.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding:
                            EdgeInsets.only(top: 10.0, left: 15.0, right: 15.0),
                            child: Text(
                              'Return Order Receipt',
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
                            padding: EdgeInsets.only(left: 15.0,right: 15.0),
                            child: DottedBorder(
                              borderType: BorderType.RRect,
                              color: Color(0xFFe78337),
                              padding: const EdgeInsets.only(top: 0, bottom: 0.0),
                              strokeWidth: 2,
                              child: Container(

                                width: MediaQuery.of(context).size.width,
                                padding: EdgeInsets.all(10.0),

                                decoration: BoxDecoration(
                                  color: Color(0xFFffeee0),

                                ),
                                child: Column(

                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(6),
                                      // margin: const EdgeInsets.only(bottom: 5),
                                      decoration: BoxDecoration(
                                        color: Color(0xFFe78337),
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
                            ) ,
                          )

                        ],
                      )

                  ),
                ),
                SizedBox(height: 10.0),


                GestureDetector(
                  onTap: () {
                    // Handle tap on uploaded image to remove it
                    setState(() {
                      _imageFileorderreciept =
                      null; // Set _imageFile to null to remove the image
                    });
                  },
                  child: SizedBox(
                    width: _imageFileorderreciept != null
                        ? MediaQuery.of(context).size.width
                        : MediaQuery.of(context).size.width,
                    height: _imageFileorderreciept != null ? 100 : 0,
                    child: Stack(
                      alignment: Alignment.topRight,
                      // Align cross mark icon to the top right
                      children: [
                        _imageFileorderreciept != null
                            ? Image.file(
                          _imageFileorderreciept!,
                          width: MediaQuery.of(context).size.width,
                          fit: BoxFit.fitWidth,
                        )
                            : Image.asset(
                          'assets/shopping_bag.png',
                          width: MediaQuery.of(context).size.width,
                          fit: BoxFit.fitWidth,
                        ),
                        if (_imageFileorderreciept != null)
                          GestureDetector(
                            onTap: () {
                              // Handle tap on cross mark icon (optional)
                              setState(() {
                                _imageFileorderreciept = null; // Set _imageFile to null to remove the image
                              });
                            },
                            child: Container(
                              padding: EdgeInsets.all(5.0),
                              margin:
                              EdgeInsets.only(top: 5, right: 10.0),
                              color: Color(0xFFffeee0), // Optional overlay color
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


                GestureDetector(
                  onTap: () {
                    // here
                    showBottomSheetForImageSelectionaddlattachment(context);
                  },
                  child: Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      padding: EdgeInsets.all(0.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding:
                            EdgeInsets.only(top: 10.0, left: 15.0, right: 15.0),
                            child: Text(
                              'Addl. Attachments',
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
                            padding: EdgeInsets.only(left: 15.0,right: 15.0),
                            child: DottedBorder(
                              borderType: BorderType.RRect,
                              color: Color(0xFFe78337),
                              padding: const EdgeInsets.only(top: 0, bottom: 0.0),
                              strokeWidth: 2,
                              child: Container(

                                width: MediaQuery.of(context).size.width,
                                padding: EdgeInsets.all(10.0),

                                decoration: BoxDecoration(
                                  color: Color(0xFFffeee0),

                                ),
                                child: Column(

                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(6),
                                      // margin: const EdgeInsets.only(bottom: 5),
                                      decoration: BoxDecoration(
                                        color: Color(0xFFe78337),
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
                            ) ,
                          )

                        ],
                      )

                  ),
                ),
                SizedBox(height: 10.0),


                GestureDetector(
                  onTap: () {
                    // Handle tap on uploaded image to remove it
                    setState(() {
                      _imageFileaddlattchments =
                      null; // Set _imageFile to null to remove the image
                    });
                  },
                  child: SizedBox(
                    width: _imageFileaddlattchments != null
                        ? MediaQuery.of(context).size.width
                        : MediaQuery.of(context).size.width,
                    height: _imageFileaddlattchments != null ? 100 : 0,
                    child: Stack(
                      alignment: Alignment.topRight,
                      // Align cross mark icon to the top right
                      children: [
                        _imageFileaddlattchments != null
                            ? Image.file(
                          _imageFileaddlattchments!,
                          width: MediaQuery.of(context).size.width,
                          fit: BoxFit.fitWidth,
                        )
                            : Image.asset(
                          'assets/shopping_bag.png',
                          width: MediaQuery.of(context).size.width,
                          fit: BoxFit.fitWidth,
                        ),
                        if (_imageFileaddlattchments != null)
                          GestureDetector(
                            onTap: () {
                              // Handle tap on cross mark icon (optional)
                              setState(() {
                                _imageFileaddlattchments = null; // Set _imageFile to null to remove the image
                              });
                            },
                            child: Container(
                              padding: EdgeInsets.all(5.0),
                              margin:
                              EdgeInsets.only(top: 5, right: 10.0),
                              color: Color(0xFFffeee0), // Optional overlay color
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

              ],
            ),
          ),
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
                      builder: (context) => ReturnOrdersubmit_screen(
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
                          'Goto Cart',
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
        1,
      ),
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
                    pickImage(ImageSource.camera, context);
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
                    pickImage(ImageSource.gallery, context);
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

  pickImage(ImageSource source, BuildContext context) async {
    final pickedFile = await ImagePicker().pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
        print('===> _imageFile: $_imageFile');
      });
      filename = basename(_imageFile!.path);
      fileExtension = extension(_imageFile!.path);
      List<int> imageBytes = await _imageFile!.readAsBytes();
      base64Image = base64Encode(imageBytes);

      print('===> Filename: $filename');
      print('===> File Extension: $fileExtension');
      print('===> Base64 Image: $base64Image');

      // Dismiss the bottom sheet after picking an image
      Navigator.pop(context);
    }
  }



  void showBottomSheetForImageSelectionordereceipt(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: Color(0xFFFFFFFF),
      shape: ShapeBorder.lerp(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        1,
      ),
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
                    pickImageordereceipt(ImageSource.camera, context);
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
                    pickImageordereceipt(ImageSource.gallery, context);
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

  pickImageordereceipt(ImageSource source, BuildContext context) async {
    final pickedFile1 = await ImagePicker().pickImage(source: source);
    if (pickedFile1 != null) {
      setState(() {
        _imageFileorderreciept = File(pickedFile1.path);
        print('===> _imageFileorderreciept: $_imageFileorderreciept');
      });
      filenameorderreciept = basename(_imageFileorderreciept!.path);
      fileExtensionorderreciept = extension(_imageFileorderreciept!.path);
      List<int> imageBytes1 = await _imageFileorderreciept!.readAsBytes();
      base64Imageorderreciept = base64Encode(imageBytes1);

      print('===> filenameorderreciept: $filenameorderreciept');
      print('===> File Extension: $fileExtensionorderreciept');
      print('===> Base64 Image: $base64Imageorderreciept');

      // Dismiss the bottom sheet after picking an image
      Navigator.pop(context);
    }
  }



  void showBottomSheetForImageSelectionaddlattachment(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: Color(0xFFFFFFFF),
      shape: ShapeBorder.lerp(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        1,
      ),
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
                    pickImageddlattachment(ImageSource.camera, context);
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
                    pickImageddlattachment(ImageSource.gallery, context);
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

  pickImageddlattachment(ImageSource source, BuildContext context) async {
    final pickedFile2 = await ImagePicker().pickImage(source: source);
    if (pickedFile2 != null) {
      setState(() {
        _imageFileaddlattchments = File(pickedFile2.path);
        print('===> _imageFileaddlattchments: $_imageFileaddlattchments');
      });
      filenameaddlattchments = basename(_imageFileaddlattchments!.path);
      fileExtensionaddlattchments = extension(_imageFileaddlattchments!.path);
      List<int> imageBytes2 = await _imageFileaddlattchments!.readAsBytes();
      base64Imageaddlattchments = base64Encode(imageBytes2);

      print('===> filenameaddlattchments: $filenameaddlattchments');
      print('===> File Extension: $fileExtensionaddlattchments');
      print('===> Base64 Image: $base64Imageaddlattchments');

      // Dismiss the bottom sheet after picking an image
      Navigator.pop(context);
    }
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
          padding: EdgeInsets.only(top: 5.0, left: 0.0, right: 0.0),
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
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w600,
                          color: Color(0xFFe78337),
                        ),
                        decoration: InputDecoration(
                          hintText: labelText,
                          hintStyle: TextStyle(
                            fontSize: 14,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w500,
                            color: Color(0xFFe78337),
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
                      color: Color(0xFFe78337),
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
        selectedDate = picked;
        print("Selected  Date: $selectedDate");

        // Print formatted date
        print("Selected  Date: ${DateFormat('yyyy-MM-dd').format(picked)}");
      }
    } catch (e) {
      print("Error selecting date: $e");
      // Handle the error, e.g., show a message to the user or log it.
    }
  }
}

// enum ImageSource {
//   camera,
//
//   /// Opens the user's photo gallery.
//   gallery,
// }
