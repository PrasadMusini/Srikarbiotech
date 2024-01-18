import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:srikarbiotech/view_collection_checkout.dart';

import 'HomeScreen.dart';
import 'Model/card_collection.dart';


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
      color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold);

  // ... Other variables and methods
  final _primaryOrange = HexColor('#e58338');
  int selectedChipIndex = 1;

  final _titleTextStyle = const TextStyle(
      color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold);

  final _clearTextStyle = TextStyle(
    color: HexColor('#e58338'),
    fontSize: 16,
    decoration: TextDecoration.underline,
    decorationColor: HexColor('#e58338'),
  );

  final _textStyle = TextStyle(
      fontSize: 14, color: HexColor('#e58338'), fontWeight: FontWeight.bold);
  final _orangeColor = HexColor('#e58338');
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

  @override
  Widget build(BuildContext context) {
    return Padding(
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
              GestureDetector(
                onTap: () async {
                  // Perform something.
                },
                child: Container(
                  width: double.infinity,
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: HexColor('#e58338'),
                    ),
                  ),
                  margin: const EdgeInsets.only(top: 3, bottom: 15),
                  child: DropdownButton<String>(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    value: selectedValue,
                    underline: const SizedBox(),
                    elevation: 0,
                    isExpanded: true,
                    hint: Text(
                      'Select something',
                      style: _textStyle,
                    ),
                    items: dropDownItems.map((item) {
                      return DropdownMenuItem<String>(
                        value: item,
                        child: Text(item),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedValue = newValue;
                      });
                    },
                    // Add selectedItemBuilder to display the selected value
                  ),
                ),
              ),
            ],
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 12),
            child: Row(
              children: [
                ...List.generate(
                  4,
                      (index) {
                    return Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              // issue
                              selectedChipIndex = index;
                            });
                          },
                          child: Chip(
                            backgroundColor: selectedChipIndex == index
                                ? _primaryOrange
                                : Colors.white,
                            side: BorderSide(
                              color: _primaryOrange,
                            ),
                            label: const Text('chip'),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),

          // From date
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 5.0),
                child: Text(
                  'To Date',
                  style: _labelTextStyle,
                ),
              ),
              GestureDetector(
                onTap: () async {
                  // Perform something.
                  final DateTime? time = await showDatePicker(
                    context: context,
                    initialDate: toDate,
                    firstDate: DateTime(2023, 12, 30),
                    lastDate: DateTime(2024, 12, 30),
                  );
                  if (time != null) {
                    setState(() {
                      toDate = time;
                    });
                  }
                },
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(8),
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
                        ' ${toDate.day} - ${toDate.month} - ${toDate.year} ',
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
            ],
          ),

          // To Date
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 5.0),
                child: Text(
                  'From Date',
                  style: _labelTextStyle,
                ),
              ),
              GestureDetector(
                onTap: () async {
                  // Perform something.
                  final DateTime? time = await showDatePicker(
                    context: context,
                    initialDate: fromDate,
                    firstDate: DateTime(2023, 12, 30),
                    lastDate: DateTime(2024, 12, 30),
                  );
                  if (time != null) {
                    setState(() {
                      fromDate = time;
                    });
                  }
                },
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(8),
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
                        ' ${fromDate.day} - ${fromDate.month} - ${fromDate.year} ',
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
            ],
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
                  onPressed: () {},
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
    );
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
