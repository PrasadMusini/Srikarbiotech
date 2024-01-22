import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:srikarbiotech/view_collection_checkout.dart';

import 'HomeScreen.dart';
import 'Model/card_collection.dart';
import 'OrctResponse.dart';
import 'Payment_model.dart';


class ViewCollectionPage extends StatefulWidget {
  const ViewCollectionPage({super.key});

  @override
  State<ViewCollectionPage> createState() => _ViewCollectionPageState();
}

class _ViewCollectionPageState extends State<ViewCollectionPage> {
  String url = 'http://182.18.157.215/Srikar_Biotech_Dev/API/api/Collections/GetCollections/null';

  late Future<List<ListResult>> apiData;

  final _orangeColor = HexColor('#e58338');
  final _borderforContainer = BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      border: Border.all(
        color: HexColor('#e58338'),
      ));

  final _hintTextStyle = const TextStyle(
      fontSize: 14, color: Colors.black38, fontWeight: FontWeight.bold);

  @override
  void initState() {
    apiData = getCollection();
    super.initState();
  }

  Future<List<ListResult>> getCollection() async {
    final response = await http.get(Uri.parse(url));

    // await Future.delayed(const Duration(seconds: 2));

    try {
      if (response.statusCode == 200) {
        Map<String, dynamic> json = jsonDecode(response.body);
        List<dynamic> listResult = json['response']['listResult'];
        List<ListResult> result =
            listResult.map((element) => ListResult.fromJson(element)).toList();
        return result;
      } else {
        throw Exception('Error occurred');
      }
    } catch (error) {
      throw Exception(error.toString());
    }
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
                  'View Collection',
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
      body: FutureBuilder(
        future: apiData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator.adaptive());
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error occurred: ${snapshot.error}'),
            );
          } else {
            if (snapshot.hasData) {
              List<ListResult> data = snapshot.data!;
              return Padding(
                // wrap FutureBuilder here with padding widget
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // search bar
                    Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: SizedBox(
                              height: 45,
                              child: TextField(
                                decoration: InputDecoration(
                                  hintText: 'Collection Search',
                                  hintStyle: _hintTextStyle,
                                  suffixIcon: const Icon(Icons.search),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide:
                                        const BorderSide(color: Colors.black),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          GestureDetector(
                            onTap: () {
                              // Handle the click action here
                              print('Container clicked!');
                              showModalBottomSheet(
                                context: context,
                                builder: (context) => const FilterBottomSheet(),
                              );
                              // Add your specific logic or navigation here
                            },
                            child: Container(
                              height: 45,
                              width: 45,
                              decoration: _borderforContainer,
                              child: Center(
                                child: SvgPicture.asset(
                                  'assets/apps-sort.svg',
                                  color: _orangeColor,
                                ),
                              ),
                            ),
                          )

                        ],
                      ),
                    ),

                    // cards
                    Expanded(
                      child: ListView.builder(
                        itemCount: data.length,
                        itemBuilder: ((context, index) {
                          return MyCard(listResult: data[index], index: index);

                        }),
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return const Center(
                child: Text('No data available'),
              );
            }
          }
        },
      ),
    );
  }
}

class FilterBottomSheet extends StatefulWidget {
  const FilterBottomSheet({super.key});

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  final _labelTextStyle = const TextStyle(
      color: Colors.black, fontSize: 14, fontWeight: FontWeight.bold);
 // List<Dealer> dealers = [];
  int selectedCardCode = -1;

  // ... Other variables and methods
  final _primaryOrange = Color(0xFFe58338);
  int selectedChipIndex = 1;

  final _titleTextStyle = const TextStyle(
      color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold);

  final _clearTextStyle = TextStyle(
      color: Color(0xFFe58338),
      fontSize: 16,
      decoration: TextDecoration.underline,
      decorationColor: Color(0xFFe58338));

  final _textStyle = TextStyle(
      fontSize: 14, color: Color(0xFFe58338), fontWeight: FontWeight.bold);
  final _orangeColor = Color(0xFFe58338);
  DateTime toDate = DateTime.now();
  DateTime fromDate = DateTime.now();
  String? selectedValue;
  List dropDownItems = [
    'item 1',
    'item 2',
    'item 3',
    'item 4',
    'item 5',
  ];
  List<dynamic> dropdownItems = [];
  PaymentMode? selectedPaymode;
  int? payid;
  late String selectedName;
  ApiResponse? apiResponse;
  int indexselected = -1;
  String? Selected_PaymentMode = "";
  TextEditingController todateController = TextEditingController();
  TextEditingController fromdateController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  DateTime selectedfromdateDate = DateTime.now();
  List<Purpose> purposeList = [];
  String? selectedPurpose, selectformattedfromdate, selectformattedtodate;
  Purpose? selectedPurposeObj; // Declare it globally
  String purposename = '';
  int? savedCompanyId = 0;

  @override
  void initState() {
    fetchData();

    print(savedCompanyId);
    getpaymentmethods();
    fetchdropdownitems();
    super.initState();
  }

  Future<void> fetchdropdownitems() async {
    final apiUrl =
        'http://182.18.157.215/Srikar_Biotech_Dev/API/api/Collections/GetPurposes';

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final listResult = data['response']['listResult'] as List;

        setState(() {
          purposeList =
              listResult.map((item) => Purpose.fromJson(item)).toList();
        });
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> getpaymentmethods() async {
    final response = await http.get(Uri.parse(
        'http://182.18.157.215/Srikar_Biotech_Dev/API/api/Master/GetAllTypeCdDmt/3'));

    if (response.statusCode == 200) {
      setState(() {
        apiResponse = ApiResponse.fromJson(jsonDecode(response.body));
        print('========>apiResponse$apiResponse');
      });
    } else {
      throw Exception('Failed to load data');
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
        print("todate selected: $selectedDate");

        // Print formatted date
        print("fromatted todate: ${DateFormat('yyyy-MM-dd').format(picked)}");
        selectformattedtodate = DateFormat('yyyy-MM-dd').format(picked);
        print("selectformattedtodate: $selectformattedtodate");
      }
    } catch (e) {
      print("Error selecting date: $e");
      // Handle the error, e.g., show a message to the user or log it.
    }
  }

  Widget buildDateInput(
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
              fontSize: 16.0,
              color: Color(0xFF5f5f5f),
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.start,
          ),
        ),
        SizedBox(height: 4.0), // Add space between labelText and TextFormField
        GestureDetector(
          onTap: onTap,
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: 40.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.0),
              border: Border.all(
                color: Color(0xFFe78337),
                width: 1.0,
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
                        enabled: false,
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
        selectedfromdateDate = picked;
        print("fromdate selected: $selectedfromdateDate");

        // Print formatted date
        print("fromattedfromdate: ${DateFormat('yyyy-MM-dd').format(picked)}");
        selectformattedfromdate = DateFormat('yyyy-MM-dd').format(picked);
        print("selectformattedfromdate: $selectformattedfromdate");
      }
    } catch (e) {
      print("Error selecting date: $e");
      // Handle the error, e.g., show a message to the user or log it.
    }
  }

  Widget buildDateInputfromdate(
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
              fontSize: 16.0,
              color: Color(0xFF5f5f5f),
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.start,
          ),
        ),
        SizedBox(height: 4.0), // Add space between labelText and TextFormField
        GestureDetector(
          onTap: onTap,
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: 40.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.0),
              border: Border.all(
                color: Color(0xFFe78337),
                width: 1.0,
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
                        enabled: false,
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

  Future<void> fetchData() async {
    final response = await http.get(Uri.parse(
        'http://182.18.157.215/Srikar_Biotech_Dev/API/api/Account/GetAllDealersBySlpCode/100'));

    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);

      // if (data['isSuccess']) {
      //   List<dynamic> dealerList = data['response']['listResult'];
      //
      //   setState(() {
      //     // dealers = dealerList
      //     //     .map((dealer) => Dealer(
      //     //           cardCode: dealer['cardCode'],
      //     //           cardName: dealer['cardName'],
      //     //         ))
      //     //     .toList();
      //
      //     setState(() {
      //       dropdownItems = data['listResult'];
      //     });
      //   });
      // }
      // Map<String, dynamic> data1 = json.decode(response.body);

      if (data['isSuccess']) {
        // Check if 'listResult' key exists and is not null
        if (data['response']['listResult'] != null) {
          setState(() {
            dropdownItems = List.from(data['response']['listResult']);
          });
        }
      }
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Filter By',
                    style: _titleTextStyle,
                  ),
                  // Text('Clear all filters', style: _labelTextStyle,),
                  Text(
                    'Clear all filters',
                    style: _clearTextStyle,
                  ),
                ],
              ),
              Container(
                margin: const EdgeInsets.only(top: 5, bottom: 12),
                child: const Divider(
                  height: 5,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 5.0),
                    child: Text(
                      'Party',
                      style: _labelTextStyle,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 0, top: 5.0, right: 0),
                    child: Container(
                      // width: double.infinity,
                      height: 40.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: Color(0xFFe58338),
                        ),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: ButtonTheme(
                          alignedDropdown: true,
                          child: DropdownButton<int>(
                              value: selectedCardCode,
                              iconSize: 20,
                              icon: null,
                              isExpanded: true,
                              underline: const SizedBox(),
                              style: TextStyle(
                                color: Color(0xFFe58338),
                              ),
                              onChanged: (value) {
                                setState(() {
                                  selectedCardCode = value!;
                                  if (selectedCardCode != -1) {
                                    selectedValue =
                                    dropdownItems[selectedCardCode]['cardCode'];
                                    selectedName =
                                    dropdownItems[selectedCardCode]['cardName'];

                                    print("selectedValue:$selectedValue");
                                    print("selectedName:$selectedName");
                                  } else {
                                    print("==========");
                                    print(selectedValue);
                                    print(selectedName);
                                  }
                                  // isDropdownValid = selectedTypeCdId != -1;
                                });
                              },
                              items: [
                                DropdownMenuItem<int>(
                                  value: -1,
                                  child: Text('Select Party'), // Static text
                                ),
                                ...dropdownItems.asMap().entries.map((entry) {
                                  final index = entry.key;
                                  final item = entry.value;
                                  return DropdownMenuItem<int>(
                                      value: index,
                                      child: Text(
                                        item['cardName'],
                                        overflow: TextOverflow.visible,
                                        // wrapText: true,
                                      ));
                                }).toList(),
                              ]),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 5.0),
                    child: Text(
                      'Purpose',
                      style: _labelTextStyle,
                    ),
                  ),
                  SizedBox(
                    height: 4.0,
                  ),
                  Container(
                      width: MediaQuery.of(context).size.width,
                      height: 40.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.0),
                        border: Border.all(
                          color: Color(0xFFe78337),
                          width: 1.0,
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: purposeList.isEmpty
                            ? CircularProgressIndicator
                            .adaptive() // Show a loading indicator
                            : DropdownButton<String>(
                          hint: Text(
                            'Select Purpose',
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: 'Roboto',
                              //    fontWeight: FontWeight.w600,
                              color: Color(0xFFe78337),
                            ),
                          ),
                          value: selectedPurpose,
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedPurpose = newValue;

                              // Find the selected Purpose object
                              selectedPurposeObj = purposeList.firstWhere(
                                    (purpose) => purpose.fldValue == newValue,
                                orElse: () => Purpose(
                                    fldValue: '', descr: '', purposeName: ''),
                              );

                              // Print the selected values
                              print(
                                  'fldValue: ${selectedPurposeObj?.fldValue}');
                              print('descr: ${selectedPurposeObj?.descr}');
                              print(
                                  'purposeName: ${selectedPurposeObj?.purposeName}');

                              purposename = selectedPurposeObj!.purposeName;
                              print('selectpurposeName: $purposename');
                            });
                          },
                          items: purposeList.map((Purpose purpose) {
                            return DropdownMenuItem<String>(
                              value: purpose.fldValue,
                              child: Text(
                                purpose.purposeName,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFFe78337),
                                ),
                              ),
                            );
                          }).toList(),
                          icon: Icon(Icons.arrow_drop_down),
                          iconSize: 24,
                          isExpanded: true,
                          underline: SizedBox(),
                        ),
                      ))
                ],
              ),

              SizedBox(
                height: 10.0,
              ),
              Container(
                height: 40,
                child: Expanded(
                  child: apiResponse == null
                      ? Center(child: CircularProgressIndicator.adaptive())
                      : ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: apiResponse!.listResult.length,
                    itemBuilder: (BuildContext context, int index) {
                      bool isSelected = index == indexselected;
                      PaymentMode currentPaymode = apiResponse!.listResult[
                      index]; // Store the current paymode in a local variable

                      IconData iconData;
                      switch (currentPaymode.desc) {
                        case 'Cheque':
                        // iconData = Icons.payment;
                          break;
                        case 'Online':
                        //   iconData = Icons.access_alarm;
                          break;
                        case 'UPI':
                        //   iconData = Icons.payment;
                          break;
                      // Add more cases as needed
                        default:
                        //   iconData = Icons.payment; // Default icon
                          break;
                      }

                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            indexselected = index;
                            selectedPaymode =
                                currentPaymode; // Update the selectedPaymode outside the build method
                          });
                          payid = currentPaymode.typeCdId;
                          Selected_PaymentMode = currentPaymode.desc;
                          print('payid:$payid');
                          print(
                              'Selected Payment Mode: ${currentPaymode.desc}, TypeCdId: $payid');
                          print(
                              'Selected Payment Mode: ${Selected_PaymentMode}, TypeCdId: $payid');
                        },
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 4.0),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? Color(0xFFe78337)
                                : Color(0xFFe78337).withOpacity(0.1),
                            border: Border.all(
                              color: isSelected
                                  ? Color(0xFFe78337)
                                  : Color(0xFFe78337),
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: IntrinsicWidth(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  padding:
                                  EdgeInsets.symmetric(horizontal: 10.0),
                                  child: Row(
                                    children: [
                                      // Icon(
                                      //   iconData, // Use the dynamically determined icon
                                      //   color: isSelected
                                      //       ? Colors.white
                                      //       : Colors.black,
                                      // ),
                                      // SizedBox(
                                      //     width:
                                      //         8.0), // Add some spacing between icon and text
                                      Text(
                                        '${currentPaymode.desc.toString()}',
                                        style: TextStyle(
                                          color: isSelected
                                              ? Colors.white
                                              : Colors.black,
                                        ),
                                      ),
                                    ],
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
              ),

              SizedBox(
                height: 10.0,
              ), // From date
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildDateInput(
                    context,
                    'To Date',
                    todateController,
                        () => _selectDate(context, todateController),
                  ),
                ],
              ),
              SizedBox(
                height: 10.0,
              ),
              // To Date
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildDateInputfromdate(
                    context,
                    'From Date',
                    fromdateController,
                        () => _selectfromDate(context, fromdateController),
                  ),
                ],
              ),
              SizedBox(
                height: 10.0,
              ),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        textStyle: const TextStyle(
                          color: Colors.red,
                        ),
                        side: const BorderSide(
                          color: Colors.red,
                        ),
                        backgroundColor: Colors.white,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                      ),
                      child: const Text(
                        'Cancel',
                        style: TextStyle(
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        getappliedflitters();
                      },
                      style: ElevatedButton.styleFrom(
                        textStyle: const TextStyle(
                          color: Colors.white,
                        ),
                        backgroundColor: _primaryOrange,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                      ),
                      child: const Text(
                        'Apply',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ));
  }

  Future<void> getappliedflitters() async {
    // savedCompanyId = await getIntFromPreferences('companyIdKey');
    print('getCompanyId:$savedCompanyId');
    try {
      final url = Uri.parse(
          'http://182.18.157.215/Srikar_Biotech_Dev/API/api/Collections/GetCollectionsbyMobileSearch');
      print('applyfilter: $url');
      final request = {
        "PurposeName": purposename,
        "StatusId": payid,
        "PartyCode": selectedValue,
        "FormDate": selectformattedfromdate,
        "ToDate": selectformattedtodate,
        "CompanyId": savedCompanyId
      };
      // final headers = {
      //   'Authorization': '$accessToken',
      // };
      // Map<String, String> _header = {
      //   'Authorization': '$accessToken',
      // };
      // String at = accessToken;
      // print('Request Headers: $_header');
      print('Request Body: ${json.encode(request)}');

      final response = await http.post(
        url,
        body: json.encode(request),
        headers: {
          'Content-Type': 'application/json',
        },
      );
      //  print('access: $at');
      // if (response.body == "Server errorNullable object must have a value.") {
      //   Commonutils.showCustomToastMessageLong(
      //       'Leave Applied', context, 0, 3);
      // }
      print('Applyresponse: ${response.body}');

      if (response.statusCode == 200) {
        print('response is success');
      } else {
        print('response is not success');
        // Commonutils.showCustomToastMessageLong(
        //     '${response.body}', context, 0, 3);
        print(
            'Failed to send the request. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }
}


class MyCard extends StatefulWidget {
  final ListResult listResult;
  final int index;

  const MyCard({
    Key? key,
    required this.listResult,
    required this.index,
  }) : super(key: key);

  @override
  State<MyCard> createState() => _MyCardState();
}

class _MyCardState extends State<MyCard> {
  final _boxBorder = BoxDecoration(
    borderRadius: BorderRadius.circular(10),
  );

  final _iconBoxBorder = BoxDecoration(
    borderRadius: BorderRadius.circular(10),
    color: Colors.white30,
  );

  final _textStyle = const TextStyle(
      fontFamily: 'Roboto',
      fontSize: 12,
      color: Colors.black,
      fontWeight: FontWeight.bold);

  final _orangeTextStyle = TextStyle(
      fontFamily: 'Roboto',
      fontSize: 13,
      color: HexColor('#e58338'),
      fontWeight: FontWeight.w600);

  @override
  Widget build(BuildContext context) {
    String dateString = widget.listResult.date;
    DateTime date = DateTime.parse(dateString);
    String formattedDate = DateFormat('dd MMM, yyyy').format(date);
    return GestureDetector(
      onTap: () {
        // Navigator.of(context)
        //     .pushNamed('/statusScreen', arguments: widget.listResult);
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => ViewCollectionCheckOut(//
                listResult: widget.listResult,
                position: widget.index,// Assuming you have the index available
            ),
          ),
        );

        // Navigator.of(context).pushReplacement(
        //   MaterialPageRoute(builder: (context) => ViewCollectionCheckOut()),
        // );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        color: Colors.transparent,
        child: Card(
          elevation: 5,
          color: Colors.white,
          child: Container(
            padding: const EdgeInsets.all(12),
            //   width: double.infinity,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  // height: 70,
                  // width: double.infinity,
                  // margin: const EdgeInsets.only(bottom: 12),
                  width: MediaQuery.of(context).size.width,
                  decoration: _boxBorder,
                  child: Row(
                    children: [
                      // starting icon of card
                      Card(
                        elevation: 2,
                        color: Colors.white70,
                        child: Container(
                          height: 65,
                          width: 60,
                          padding: const EdgeInsets.all(10),
                          decoration: _iconBoxBorder,
                          child: Center(
                            child: getStatusTypeImage(
                                widget.listResult.statusTypeId),
                          ),
                        ),
                      ),

                      // beside info
                      Container(
                        //height: 90,
                        // width: ,
                        width: MediaQuery.of(context).size.width / 1.6,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 10, top: 0, bottom: 0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                widget.listResult.partyName,
                                style: _textStyle,
                                softWrap: true,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(
                                height: 5.0,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    child: Row(
                                      children: [
                                        Text(
                                          'Purpose: ',
                                          style: _textStyle,
                                        ),
                                        Text(
                                          widget.listResult.purposeName,
                                          style: _orangeTextStyle,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 5.0,
                              ),
                              Container(
                                  child: Row(
                                children: [
                                  Text(
                                    'Payment Mode: ',
                                    style: _textStyle,
                                  ),
                                  Text(
                                    widget.listResult.paymentTypeName,
                                    style: _orangeTextStyle,
                                  ),
                                ],
                              ))
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 5.0,
                ),
                //bottom date and amount in card
                Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Container(
                    //   height: 30,
                    //   width: 65,
                    //   decoration: BoxDecoration(
                    //       borderRadius: BorderRadius.circular(10),
                    //       color: HexColor('#e58338').withOpacity(0.1)),
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.center,
                    //     children: [
                    //       Text(
                    //         widget.listResult.statusName,
                    //         style: _orangeTextStyle,
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    Container(
                      height: 30,
                      width: 65,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: getStatusTypeBackgroundColor(
                            widget.listResult.statusTypeId),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            widget.listResult.statusName,
                            style: TextStyle(
                              color: getStatusTypeTextColor(
                                  widget.listResult.statusTypeId),
                              // Add other text styles as needed
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(
                      width: 10.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                            child: Row(
                          children: [
                            Text(
                              'Date: ',
                              style: _textStyle,
                            ),
                            Text(
                              formattedDate,
                              style: _orangeTextStyle,
                            ),
                          ],
                        )),
                        SizedBox(
                          width: 10.0,
                        ),
                        //Spacer(),
                        Container(
                          child: Row(
                            children: [
                              Text(
                                'Amount: ',
                                style: _textStyle,
                              ),
                              Text(
                                '${widget.listResult.amount}',
                                style: _orangeTextStyle,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    // SizedBox(
                    //   width: 10.0,
                    // ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Color getStatusTypeBackgroundColor(int statusTypeId) {
    switch (statusTypeId) {
      case 7:
        return Colors.green.withOpacity(0.1);
      case 8:
        // Set background color for statusTypeId 8
        return Color(0xFFE58338).withOpacity(0.1);
      case 9:
        // Set background color for statusTypeId 9
        return Colors.red.withOpacity(0.1);
      // Add more cases as needed for other statusTypeId values

      default:
        // Default background color or handle other cases if needed
        return Colors.white;
    }
  }

  Color getStatusTypeTextColor(int statusTypeId) {
    switch (statusTypeId) {
      case 7:
        return Colors.green;
      case 8:
        // Set text color for statusTypeId 8
        return Color(0xFFE58338);
      case 9:
        // Set text color for statusTypeId 9
        return Colors.red;
      // Add more cases as needed for other statusTypeId values

      default:
        // Default text color or handle other cases if needed
        return Colors.black;
    }
  }

  Widget getStatusTypeImage(int statusTypeId) {
    String assetPath;
    late Color iconColor;

    switch (statusTypeId) {
      case 7:
        assetPath = 'assets/hourglass-start.svg';
        iconColor = Color.fromARGB(255, 0, 146, 5);
        break;
      case 8:
        assetPath = 'assets/sb_money-bill-wave.svg';
        iconColor = Color(0xFFE58338); // Color for statusTypeId 8

        // Set color filter or other customization as needed
        break;
      case 9:
        assetPath = 'assets/sensor-alert.svg';
        iconColor = Colors.red;
        // Set color filter or other customization as needed
        break;
      // Add more cases as needed for other statusTypeId values

      default:
        assetPath = 'assets/sb_home.svg';
      // Set default image or handle other cases if needed
    }

    return SvgPicture.asset(
      assetPath,
      width: 50,
      height: 50,
      color: iconColor,
    );
  }
}
