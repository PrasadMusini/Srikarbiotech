
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:srikarbiotech/Createorderscreen.dart';
import 'dart:convert';

import 'CreateCollection.dart';
import 'CreateCollectionscreen.dart';
import 'Ledgerscreen.dart';
import 'Model/Dealer.dart';

class Selectpartyscreen extends StatefulWidget {
  String from;
  Selectpartyscreen({required this.from});

  @override
  Selectparty_screen createState() => Selectparty_screen();
}

class Selectparty_screen extends State<Selectpartyscreen> {
  bool _isLoading = false;
  List<Dealer> dealers = [];
  late String screenFrom;
  int selectedCardIndex = -1; // Variable to track selected card index

  List<Dealer> filteredDealers = [];
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();

    fetchData();
    print("screenFrom: ${widget.from}");

    screenFrom = '${widget.from}'.trim();
    print("screenFrom: ${screenFrom}");
  }

  Future<void> fetchData() async {
    final response = await http.get(
      Uri.parse('http://182.18.157.215/Srikar_Biotech_Dev/API/api/Account/GetAllDealersBySlpCode/100'),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List<dynamic> listResult = data['response']['listResult'];

      setState(() {
        dealers = listResult.map((json) => Dealer.fromJson(json)).toList();
        filteredDealers = List.from(dealers);
      });


    } else {
      throw Exception('Failed to load data');
    }


}
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar:
      AppBar(
        backgroundColor: Color(0xFFe78337),
        automaticallyImplyLeading: false, // This line removes the default back arrow
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 2),
              child: GestureDetector(
                onTap: () {
                  // Handle the click event for the back arrow icon
                  Navigator.of(context).pop();
                },
                child: Icon(
                  Icons.chevron_left,
                  size: 30.0,
                  color: Colors.white,
                ),
              ),
            ),
            Text(
              'Select Party',
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
                                controller: searchController,
                                onChanged: (value) {
                                  filterDealers();
                                },
                                keyboardType: TextInputType.name,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w300,
                                ),
                                decoration: InputDecoration(

                                  suffixIcon: Icon(
                                    Icons.search,
                                    color: Color(0xFFC4C2C2),
                                  ),
                                  hintText: 'Search for Party Name or Id',
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
                SizedBox(height: 20.0),
              ],
            ),
          ),
          // Add Expanded around the ListView.builder
          Expanded(
            child: ListView.builder(
              itemCount: filteredDealers.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    if (!FocusScope.of(context).hasPrimaryFocus) {
                      return;
                    }
                    print("Tapped on dealer with cardName: ${filteredDealers[index].cardName}");
                    print("screenFrom: $screenFrom");

                    if (screenFrom == "CreateOrder") {
                      print("Tapped on dealer with cardName:2 ${filteredDealers[index].cardName}");
                      try {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Createorderscreen(
                              cardName: filteredDealers[index].cardName,
                              cardCode: filteredDealers[index].cardCode,
                              address: filteredDealers[index].fullAddress,
                            ),
                          ),
                        );
                      } catch (e) {
                        print("Error navigating: $e");
                      }

                    }
                    else if (screenFrom == "CreateCollections") {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CreateCollection(
                            cardName: filteredDealers[index].cardName,
                            cardCode: filteredDealers[index].cardCode,
                            address: filteredDealers[index].fullAddress,
                          ),
                        ),
                      );
                    }
                    else if (screenFrom == "Ledger") {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Ledgerscreen(
                            cardName: filteredDealers[index].cardName,
                            cardCode: filteredDealers[index].cardCode,
                            address: filteredDealers[index].fullAddress,
                          ),
                        ),
                      );
                    }
                    // else {
                    //   Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //       builder: (context) => Ledgerscreen(
                    //         cardName: filteredDealers[index].cardName,
                    //         cardCode: filteredDealers[index].cardCode,
                    //         address: filteredDealers[index].address,
                    //       ),
                    //     ),
                    //   );
                    // }
                  },

                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    child: Card(
                        elevation: 0,
                        color: selectedCardIndex == index ? Colors.orange : null,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          side: BorderSide(color: Colors.grey, width: 1),
                        ),
                      child: Container(
                        padding: EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    filteredDealers[index].cardName,
                                    style: TextStyle(
                                      color: Colors.orange,
                                      fontFamily: 'Roboto',
                                      fontWeight: FontWeight.w700,
                                    ),
                                    maxLines: 2, // Display in 2 lines
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  SizedBox(height: 5.0),
                                  Text(
                                    filteredDealers[index].cardCode,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: 'Roboto',
                                      fontWeight: FontWeight.w700,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  SizedBox(height: 5.0),
                                  Text(
                                    'Address',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: 'Roboto',
                                      fontWeight: FontWeight.w700,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  SizedBox(height: 5.0),
                                  Text(
                                    filteredDealers[index].fullAddress,
                                    style: TextStyle(
                                      color: Colors.orange,
                                      fontFamily: 'Roboto',
                                      fontWeight: FontWeight.w700,
                                    ),
                                    maxLines: 2, // Display in 2 lines
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                            Icon(
                              Icons.chevron_right,
                              color: Colors.orange,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),




        ]   ),

    );
  }

  void filterDealers() {
    final String searchTerm = searchController.text.toLowerCase();
    setState(() {
      filteredDealers = dealers.where((dealer) {
        return dealer.cardCode.toLowerCase().contains(searchTerm) ||
            dealer.cardName.toLowerCase().contains(searchTerm);
      }).toList();
    });
  }
}



