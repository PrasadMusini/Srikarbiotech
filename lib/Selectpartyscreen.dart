
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:srikarbiotech/Common/CommonUtils.dart';
import 'package:srikarbiotech/Createorderscreen.dart';
import 'package:srikarbiotech/Services/api_config.dart';
import 'dart:convert';

import 'CreateCollectionscreen.dart';
import 'CreateReturnorderscreen.dart';
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
  // SharedPreferences prefs = await SharedPreferences.getInstance();

  @override
  void initState() {
    super.initState();
    fetchData();
getslpcode();

    print("screenFrom: ${widget.from}");

    screenFrom = '${widget.from}'.trim();
    print("screenFrom: ${screenFrom}");
  

  }

  Future<void> fetchData() async {
    final response = await http.get(
      Uri.parse(baseUrl+GetAllDealersBySlpCode),
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
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w600,
                color: Colors.white,
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
      body:
      Column(
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
                    child:
                    Row(
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
                                style:CommonUtils.Mediumtext_12,
                                decoration: InputDecoration(

                                  suffixIcon: Icon(
                                    Icons.search,
                                    color: Color(0xFFC4C2C2),
                                  ),
                                  hintText: 'Search for Party Name or Id',
                                  hintStyle: CommonUtils.hintstyle_14,

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
                SizedBox(height: 10.0),
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
    setState(() {
    selectedCardIndex = index; // Update selected index
    });
                  // onTap: () {
                  //   if (!FocusScope.of(context).hasPrimaryFocus) {
                  //     return;
                  //   }
                    print("Tapped on dealer with cardName: ${filteredDealers[index].cardName}");
                    print("screenFrom: $screenFrom");

                    if (screenFrom == "CreateOrder") {
                      print("Tapped on dealer with cardName:2 ${filteredDealers[index].cardName}");
                      try {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>  Createorderscreen(
                                cardName: filteredDealers[index].cardName,
                                cardCode: filteredDealers[index].cardCode,
                                address: filteredDealers[index].fullAddress,
                                state: filteredDealers[index].state,
                                phone: filteredDealers[index].phoneNumber,
                                proprietorName:  filteredDealers[index].proprietorName,
                                gstRegnNo:  filteredDealers[index].gstRegnNo
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
                          builder: (context) => CreateCollectionscreen(
                            cardName: filteredDealers[index].cardName,
                            cardCode: filteredDealers[index].cardCode,
                            address: filteredDealers[index].fullAddress,
                            state: filteredDealers[index].state,
                            phone: filteredDealers[index].phoneNumber,
                            proprietorName:  filteredDealers[index].proprietorName,
                            gstRegnNo:  filteredDealers[index].gstRegnNo
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
                              state: filteredDealers[index].state,
                              phone: filteredDealers[index].phoneNumber,
                              proprietorName:  filteredDealers[index].proprietorName,
                              gstRegnNo:  filteredDealers[index].gstRegnNo
                          ),
                        ),
                      );
                    }
   else if (screenFrom == "CreatereturnOrder") {
      print("Tapped on dealer with cardName:2 ${filteredDealers[index].cardName}");
      try {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CreateReturnorderscreen(
                cardName: filteredDealers[index].cardName,
                cardCode: filteredDealers[index].cardCode,
                address: filteredDealers[index].fullAddress,
                state: filteredDealers[index].state,
                phone: filteredDealers[index].phoneNumber,
                proprietorName:  filteredDealers[index].proprietorName,
                gstRegnNo:  filteredDealers[index].gstRegnNo
            ),
          ),
        );
      } catch (e) {
        print("Error navigating: $e");
      }

    }

                  },

                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
                    child: Card(
                      elevation: 0,
                      color: selectedCardIndex == index ? Color(0xFFfff5ec) : null,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        side: BorderSide(
                          color: selectedCardIndex == index
                              ?Color(0xFFe98d47)// Border color for selected item
                              : Colors.grey, // Border color for unselected items
                          width: 1,
                        ),
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
                                    style: CommonUtils.header_Styles16,
                                    maxLines: 2, // Display in 2 lines
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  SizedBox(height: 8.0),
                                  Text(
                                    filteredDealers[index].cardCode,
                                   style: CommonUtils.Mediumtext_14,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  SizedBox(height: 8.0),
                                  Text(
                                    filteredDealers[index].proprietorName,
                                    style:  CommonUtils.Mediumtext_12_0,
                                    maxLines: 2, // Display in 2 lines
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  SizedBox(height: 8.0),
                                  RichText(
                                    text: TextSpan(
                                      style: DefaultTextStyle.of(context).style,
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: 'GST No. ',
                                          style: CommonUtils.Mediumtext_12,
                                        ),
                                        TextSpan(
                                          text: filteredDealers[index].gstRegnNo,
                                          style:CommonUtils.Mediumtext_12_0,
                                        ),
                                      ],
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),

                                  SizedBox(height: 8.0),
                                  Text(
                                    'Address',
                                    style: CommonUtils.Mediumtext_12,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  SizedBox(height: 5.0),
                                  Text(
                                    filteredDealers[index].fullAddress,
                                    style: CommonUtils.Mediumtext_12_0,
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

  Future<void> getslpcode() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

// Retrieve userId and slpCode
    String? userId = prefs.getString("userId");
    String? slpCode = prefs.getString("slpCode");

// Check if they are not null before using them
    if (userId != null && slpCode != null) {
      // Use userId and slpCode in your code
      print('Retrieved userId: $userId');
      print('Retrieved slpCode: $slpCode');
      fetchData();
    } else {
      // Handle the case where userId or slpCode is null
      print('User not logged in or missing required data.');
    }
  }

}



