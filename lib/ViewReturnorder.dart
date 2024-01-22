import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hexcolor/hexcolor.dart';

import 'HomeScreen.dart';
import 'ReturnOrderDetailsPage.dart';
import 'ViewOrders.dart';


class ViewReturnorder extends StatefulWidget {
  const ViewReturnorder({super.key});

  @override
  State<ViewReturnorder> createState() => _MyReturnOrdersPageState();
}

class _MyReturnOrdersPageState extends State<ViewReturnorder> {
  final _orangeColor = HexColor('#e58338');

  final _hintTextStyle = const TextStyle(
    fontSize: 14,
    color: Colors.black38,
    fontWeight: FontWeight.bold,
  );
  final searchBarBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: const BorderSide(color: Colors.black),
  );
  final _borderforContainer = BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      border: Border.all(
        color: HexColor('#e58338'),
      ));

  final List<String> orderStatusList = [
    'Shipped',
    'Pending',
    'Delivered',
    'Pending',
    'Rejected',
    'Shipped',
    'Delivered',
  ];

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
                  'My Return Orders',
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

      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
                            borderSide: const BorderSide(color: Colors.black),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Container(
                    height: 45,
                    width: 45,
                    decoration: _borderforContainer,
                    child: GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (context) => const FilterBottomSheet(),
                        );
                      },
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

            // options (chips)
            // SizedBox(
            //   height: 50,
            //   width: double.infinity,
            //   child: ListView.separated(
            //     scrollDirection: Axis.horizontal,
            //     itemCount: 6,
            //     itemBuilder: (context, index) {
            //       return Chip(
            //         shape: RoundedRectangleBorder(
            //           borderRadius: BorderRadius.circular(7),
            //         ),
            //         padding: const EdgeInsets.all(0),
            //         label: Text('Option $index'),
            //         side: BorderSide(width: 2, color: _orangeColor),
            //       );
            //     },
            //     separatorBuilder: (context, index) {
            //       return const SizedBox(
            //         width: 10,
            //       );
            //     },
            //   ),
            // ),

            // card items
            // Iterating the list
            Expanded(
              child: ListView.builder(
                itemCount: orderStatusList.length,
                itemBuilder: (context, index) {
                  return ReturnCarditem(orderStatus: orderStatusList[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ReturnCarditem extends StatefulWidget {
  final String orderStatus;
  const ReturnCarditem({super.key, required this.orderStatus});

  @override
  State<ReturnCarditem> createState() => _ReturnCarditemState();
}

class _ReturnCarditemState extends State<ReturnCarditem> {
  final _iconBoxBorder = BoxDecoration(
    borderRadius: BorderRadius.circular(10),
    color: Colors.white30,
  );

  final _textStyle = const TextStyle(
      fontFamily: 'Roboto',
      fontSize: 13,
      color: Colors.black,
      fontWeight: FontWeight.bold);

  final _orangeTextStyle = TextStyle(
      fontFamily: 'Roboto',
      fontSize: 13,
      color: HexColor('#e58338'),
      fontWeight: FontWeight.w600);

  late Color statusColor;
  late Color statusBgColor;
  Widget getSvgAsset(String status) {
    String assetPath;
    late Color iconColor;
    switch (status) {
      case "Pending":
        assetPath = 'assets/shipping-timed.svg';
        iconColor = const Color(0xFFe58338);
        statusColor = const Color(0xFFe58338);
        statusBgColor = const Color.fromARGB(255, 250, 214, 187);
        break;
      case 'Shipped':
        assetPath = 'assets/shipping-fast.svg';
        iconColor = Colors.blue;
        statusColor = Colors.blue;
        statusBgColor = Colors.blue.shade100;
        break;
      case 'Delivered':
        assetPath = 'assets/box-circle-check.svg';
        iconColor = Colors.green;
        statusColor = Colors.green;
        statusBgColor = Colors.green.shade100;
        break;
      case 'Partially Shipped':
        assetPath = 'assets/boxes.svg';
        iconColor = Colors.purple;
        statusColor = Colors.purple;
        statusBgColor = Colors.purple.shade100;
        break;
      case 'Rejected':
        assetPath = 'assets/shipping-timed.svg';
        iconColor = Colors.red;
        statusColor = Colors.red;
        statusBgColor = Colors.red.shade100;
        break;
      default:
        assetPath = 'assets/sb_home.svg';
        iconColor = Colors.black26;
        statusColor = Colors.black26;
        statusBgColor = const Color.fromARGB(31, 124, 124, 124);
        break;
    }
    return SvgPicture.asset(
      assetPath,
      width: 50,
      height: 50,
      fit: BoxFit.fill,
      color: iconColor,

    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const ReturnOrderDetailsPage(),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        child: Card(
          color: Colors.white,
          elevation: 5,
          child: Container(
            padding: const EdgeInsets.all(10), // here
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              // two part of row left icon and right info
              children: [
                SizedBox(
                  // part one
                  width: MediaQuery.of(context).size.width / 4.7,
                  child: Column(
                    children: [
                      // top card icon
                      Card(
                        elevation: 5,
                        color: Colors.white,
                        child: Container(
                          height: 80,
                          width: 75,
                          decoration: _iconBoxBorder,
                          child: Center(
                            child: getSvgAsset(widget.orderStatus),
                          ),
                        ),
                      ),

                      // bottom status name
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 2, horizontal: 11),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: statusBgColor,
                        ),
                        child: Text(
                          widget.orderStatus,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w500,
                              color: statusColor),
                        ),
                      ),
                    ],
                  ),
                ),

                // part two
                Expanded(
                  child: Container(
                    height: 100,
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Sri Venkateswara Traders',
                          style: _textStyle,
                        ),
                        Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  'Order ID: ',
                                  style: _textStyle,
                                ),
                                Text(
                                  'data',
                                  style: _orangeTextStyle,
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      'LR No: ',
                                      style: _textStyle,
                                    ),
                                    Text(
                                      'data',
                                      style: _orangeTextStyle,
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      'No of items: ',
                                      style: _textStyle,
                                    ),
                                    Text(
                                      'data',
                                      style: _orangeTextStyle,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text(
                                  'Date: ',
                                  style: _textStyle,
                                ),
                                Text(
                                  'data',
                                  style: _orangeTextStyle,
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  'Total Amount: ',
                                  style: _textStyle,
                                ),
                                Text(
                                  'data',
                                  style: _orangeTextStyle,
                                ),
                              ],
                            ),
                          ],
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
    );
  }
}
