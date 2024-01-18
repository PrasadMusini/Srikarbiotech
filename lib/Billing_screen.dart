import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Model/CartHelper.dart';

class billing_screen extends StatefulWidget {
  final List<SelectedProducts> productitems;

  billing_screen({required this.productitems});

  @override
  State<billing_screen> createState() => _billing_screenState();
}

class _billing_screenState extends State<billing_screen> {
  TextEditingController nacharamController = TextEditingController();
  List<SelectedProducts> savedCartItems = [];

  @override
  void initState() {
    super.initState();
    fetchData();
    // Set the default selected index to 0 when the screen is entered
    // convertProductListToStringList(widget.productitems);
    // for (SelectedProducts product in widget.productitems) {
    //   print(
    //       'billingscreenID: ${product.id}, billingscreenName: ${product.productName}');
    //   // Access other properties as needed
    // }
  }

  // Future<void> fetchData() async {
  //   // Retrieve saved cart items using CartHelper
  //   List<SelectedProducts> cartItems = await CartHelper.getFertCartData();
  //   print('cartiteminbillingscreen$cartItems');
  //   // Update the state with the retrieved data
  //   setState(() {
  //     savedCartItems = cartItems;
  //   });
  // }

  Future<List<String>> fetchData() async {
    // Retrieve saved cart items using CartHelper
    List<SelectedProducts> cartItems = await CartHelper.getFertCartData();
    print('cartiteminbillingscreen$cartItems');

    // Extract product names from SelectedProducts
    List<String> productNames =
        cartItems.map((product) => product.productName).toList();

    return productNames;
  }

  Future<List<String>> convertProductListToStringList(
      List<SelectedProducts> products) async {
    List<String> result = [];

    for (var product in products) {
      // Assuming there is a property in SelectedProducts that you want to convert to String
      result.add(
          product.productName); // Replace with the actual property or logic
    }

    return result;
  }

  // Future<List<SelectedProducts>> loadProductListFromSharedPreferences() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //
  //   // Retrieve the JSON string from SharedPreferences (replace 'productsKey' with your key)
  //   String? productListJson = prefs.getString('productsKey');
  //
  //   if (productListJson != null) {
  //     // Convert the JSON string to a list of maps
  //     List<Map<String, dynamic>> productListMapList =
  //         jsonDecode(productListJson);
  //
  //     // Convert the list of maps to a list of SelectedProducts
  //     List<SelectedProducts> productList = productListMapList
  //         .map((map) => SelectedProducts.fromJson(map))
  //         .toList();
  //
  //     return productList;
  //   } else {
  //     return [];
  //   }
  // }
  //
  // Future<void> saveProductListToSharedPreferences(
  //     List<SelectedProducts> products) async {
  //   // Convert the list of SelectedProducts to a list of maps
  //   List<Map<String, dynamic>> productListMapList =
  //       products.map((product) => product.toJson()).toList();
  //
  //   // Convert the list of maps to a JSON string
  //   String productListJson = jsonEncode(productListMapList);
  //
  //   // Save the JSON string to SharedPreferences (replace 'productsKey' with your key)
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   await prefs.setString('productsKey', productListJson);
  // }
  //
  // void deleteItem(BuildContext context, int index) async {
  //   // Remove the item from the list
  //   setState(() {
  //     widget.productitems.removeAt(index);
  //   });
  //
  //   // Update SharedPreferences with the modified list
  //   await saveProductListToSharedPreferences(widget.productitems);
  // }
  Future<void> deleteItem(BuildContext context, int index) async {
    // Implement your logic to delete the item at the specified index
    // ...

    // Update the state to trigger a rebuild and reflect the changes
    setState(() {
      // Remove the item at the specified index from the savedCartItems list
      savedCartItems.removeAt(index);

      // Save the updated list to SharedPreferences
      CartHelper.saveFertCartitems(savedCartItems);
    });
  }

  // Future<void> deleteItem(BuildContext context, int index) async {
  //   // Remove the item from the list
  //   setState(() {
  //     widget.productitems.removeAt(index);
  //   });
  //
  //   // Update SharedPreferences with the modified list
  //   await saveProductListToSharedPreferences(widget.productitems);
  // }

  // Future<void> saveProductListToSharedPreferences(
  //     List<SelectedProducts> products) async {
  //   // Convert the list of SelectedProducts to a list of maps
  //   List<Map<String, dynamic>> productListMapList =
  //       products.map((product) => product.toJson()).toList();
  //
  //   // Convert the list of maps to a JSON string
  //   String productListJson = jsonEncode(productListMapList);
  //
  //   // Save the JSON string to SharedPreferences (replace 'productsKey' with your key)
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   await prefs.setString('productsKey', productListJson);
  // }
  //
  // Future<List<SelectedProducts>> loadProductListFromSharedPreferences() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //
  //   // Replace 'productsKey' with your dynamic key or logic
  //   String? productListJson = prefs.getString('productsKey');
  //
  //   if (productListJson != null) {
  //     // Convert the JSON string to a list of maps
  //     List<Map<String, dynamic>> productListMapList =
  //         jsonDecode(productListJson);
  //
  //     // Convert the list of maps to a list of SelectedProducts
  //     List<SelectedProducts> productList = productListMapList
  //         .map((map) => SelectedProducts.fromJson(map))
  //         .toList();
  //
  //     return productList;
  //   } else {
  //     return [];
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFe78337),
        title: Text(
          'Cart',
          style: TextStyle(
            color: Colors.white, // Replace with your desired title text color
          ),
        ),
        // Add other app bar properties as needed
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          // Set mainAxisSize to min for intrinsic height
          children: [
            Container(
              width: screenWidth,
              padding: const EdgeInsets.all(10.0),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding:
                            EdgeInsets.only(top: 0.0, left: 0.0, right: 0.0),
                        child: Text(
                          'Party Details',
                          style: TextStyle(
                            fontSize: 13.0,
                            color: Color(0xFF414141),
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.start,
                        ),
                      ),
                      SizedBox(
                        height: 2.0,
                      ),
                      Padding(
                        padding:
                            EdgeInsets.only(top: 0.0, left: 0.0, right: 0.0),
                        child: Text(
                          'Priya Enterprises Pvt.Ltd',
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Color(0xFFe78337),
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.start,
                        ),
                      ),
                      SizedBox(
                        height: 1.0,
                      ),
                      Padding(
                        padding:
                            EdgeInsets.only(top: 0.0, left: 0.0, right: 0.0),
                        child: Text(
                          'Party Code or ID',
                          style: TextStyle(
                            fontSize: 13.0,
                            color: Color(0xFF414141),
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.start,
                        ),
                      ),
                      SizedBox(
                        height: 4.0,
                      ),
                      Padding(
                        padding:
                            EdgeInsets.only(top: 0.0, left: 0.0, right: 0.0),
                        child: Text(
                          'Address',
                          style: TextStyle(
                            fontSize: 12.0,
                            color: Color(0xFF414141),
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.start,
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.only(top: 0.0, left: 0.0, right: 0.0),
                        child: Text(
                          'Plotno: Adddress of the party details',
                          style: TextStyle(
                            fontSize: 12.0,
                            color: Color(0xFFe78337),
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.start,
                        ),
                      ),
                      // Add more widgets as needed
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 5),
            FutureBuilder<List<String>>(
                future:
                    fetchData(), // Use the function directly, it's already a Future

                // Replace with your function to retrieve list data from SharedPreferences
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Text('No data available');
                  } else {
                    List<String> productNames = snapshot.data!;
                    return ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          return Dismissible(
                              key: Key(snapshot.data![
                                  index]), // Use a unique key for each item
                              onDismissed: (direction) async {
                                // Call the deleteItem function when the item is dismissed
                                await deleteItem(context, index);
                              },
                              background: Container(
                                color: Colors
                                    .red, // Background color when swiping to delete
                                alignment: Alignment.centerRight,
                                child: Padding(
                                  padding: EdgeInsets.only(right: 16.0),
                                  child: Icon(
                                    Icons.delete,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              child: Container(
                                width: screenWidth,
                                padding: const EdgeInsets.all(10.0),
                                child: Card(
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        RichText(
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                          text: TextSpan(
                                            text:
                                                '${savedCartItems[index].productName}',
                                            style: TextStyle(
                                              color: Color(0xFF424242),
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16.0,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 8.0,
                                        ),
                                        RichText(
                                          maxLines: 1,
                                          text: TextSpan(
                                            text:
                                                '₹${savedCartItems[index].productPrice}',
                                            style: TextStyle(
                                              color: Colors.orange,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16.0,
                                            ),
                                            children: [
                                              TextSpan(
                                                text: 'MRP: ',
                                                style: TextStyle(
                                                  color: Color(0xFFa6a6a6),
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 13.0,
                                                  // decoration: TextDecoration.lineThrough,
                                                ),
                                              ),
                                              TextSpan(
                                                text:
                                                    '${savedCartItems[index].initialPrice}',
                                                style: TextStyle(
                                                  color: Color(0xFFa6a6a6),
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 13.0,
                                                  decoration: TextDecoration
                                                      .lineThrough,
                                                ),
                                              ),
                                              WidgetSpan(
                                                child: SizedBox(
                                                    width:
                                                        16), // Adjust the width as needed
                                              ),
                                              TextSpan(
                                                text:
                                                    '(${savedCartItems[index].discount}%)',
                                                style: TextStyle(
                                                  color: Colors.green,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15.0,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 8.0,
                                        ),
                                        Row(
                                          children: [
                                            Container(
                                              width: screenWidth / 3.9,
                                              height: 36,
                                              // Adjust the width as needed
                                              child: DropdownButton<int>(
                                                isExpanded: true,
                                                // Ensure the dropdown takes full width
                                                value: 1,
                                                // Set initial value
                                                onChanged: (newValue) {
                                                  // Implement your logic when the dropdown value changes
                                                },
                                                items: List.generate(
                                                  10,
                                                  (index) =>
                                                      DropdownMenuItem<int>(
                                                    value: index + 1,
                                                    child: Text(
                                                        (index + 1).toString()),
                                                  ),
                                                ),
                                                style: TextStyle(
                                                  fontSize: 16.0,
                                                  color: Colors.black,
                                                ),
                                                elevation:
                                                    2, // Adjust the elevation as needed
                                              ),
                                            ),
                                            SizedBox(
                                              width: 25.0,
                                            ),
                                            // Add your additional widget here
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 0, left: 0, bottom: 0),
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    height: 36,
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            2.2,
                                                    decoration: BoxDecoration(
                                                      color: Colors.orange,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.0),
                                                    ),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceAround,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        IconButton(
                                                          icon: Icon(
                                                              Icons.remove,
                                                              color:
                                                                  Colors.white),
                                                          onPressed: () {},
                                                          iconSize: 17.0,
                                                        ),
                                                        Expanded(
                                                          child: Align(
                                                            alignment: Alignment
                                                                .center,
                                                            child: Container(
                                                              height: 35,
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(
                                                                        2.0),
                                                                child:
                                                                    Container(
                                                                  alignment:
                                                                      Alignment
                                                                          .center,
                                                                  width: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width /
                                                                      5.1,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: Colors
                                                                        .white,
                                                                  ),
                                                                  child:
                                                                      TextField(
                                                                    onChanged:
                                                                        (value) {},
                                                                    decoration:
                                                                        InputDecoration(
                                                                      hintText:
                                                                          '0',
                                                                      border: InputBorder
                                                                          .none,
                                                                      focusedBorder:
                                                                          InputBorder
                                                                              .none,
                                                                      enabledBorder:
                                                                          InputBorder
                                                                              .none,
                                                                      contentPadding:
                                                                          EdgeInsets.symmetric(
                                                                              horizontal: 0.0),
                                                                    ),
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center,
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            12.5),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        IconButton(
                                                          icon: Icon(Icons.add,
                                                              color:
                                                                  Colors.white),
                                                          onPressed: () {},
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          iconSize: 17.0,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              width: 5.0,
                                            ),
                                            InkWell(
                                              onTap: () async {
                                                // Call the deleteItem function when the trash icon is tapped
                                                await deleteItem(
                                                    context, index);
                                              },
                                              child: Padding(
                                                padding: EdgeInsets.only(
                                                    right: 15.0, top: 8.0),
                                                child: SvgPicture.asset(
                                                  'assets/images/trash.svg',
                                                  width: 20.0,
                                                  height: 20.0,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ));
                        });
                  }
                }),
            SizedBox(height: 10),
            Container(
              width: screenWidth,
              padding: EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
              child: IntrinsicHeight(
                child: Card(
                  color: Colors.white,
                  child: Container(
                    width: screenWidth,
                    padding: EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding:
                                      EdgeInsets.only(left: 15.0, top: 8.0),
                                  child: Text(
                                    'Transport & Payment Details',
                                    style: TextStyle(
                                      fontSize: 13.0,
                                      color: Color(0xFF414141),
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.start,
                                  ),
                                ),
                                Padding(
                                  padding:
                                      EdgeInsets.only(right: 15.0, top: 8.0),
                                  child: GestureDetector(
                                    child: SvgPicture.asset(
                                      'assets/images/edit.svg',
                                      width: 20.0,
                                      height: 20.0,
                                      color: Color(0xFFe78337),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                          ],
                        ),
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color:
                                  Colors.grey, // specify your border color here
                              width: 1.0, // specify the border width
                            ),
                            borderRadius: BorderRadius.circular(
                                8.0), // specify the border radius
                          ),
                          width: MediaQuery.of(context).size.width,
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width / 2.2,
                                    padding: EdgeInsets.all(10.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(
                                            top: 0.0,
                                            left: 20.0,
                                            right: 0.0,
                                          ),
                                          child: Text(
                                            'Booking Place',
                                            style: TextStyle(
                                              fontSize: 13.0,
                                              color: Color(0xFF414141),
                                              fontWeight: FontWeight.bold,
                                            ),
                                            textAlign: TextAlign.start,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 4.0,
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              top: 0.0, left: 20.0, right: 0.0),
                                          child: Text(
                                            'Nacharam',
                                            style: TextStyle(
                                              fontSize: 13.0,
                                              color: Color(0xFFe78337),
                                              fontWeight: FontWeight.bold,
                                            ),
                                            textAlign: TextAlign.start,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width / 2.9,
                                    padding: EdgeInsets.all(10.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(
                                              top: 0.0, left: 0.0, right: 0.0),
                                          child: Text(
                                            'Transport Mode',
                                            style: TextStyle(
                                              fontSize: 13.0,
                                              color: Color(0xFF414141),
                                              fontWeight: FontWeight.bold,
                                            ),
                                            textAlign: TextAlign.start,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 4.0,
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              top: 0.0, left: 0.0, right: 0.0),
                                          child: Text(
                                            'Train  ',
                                            style: TextStyle(
                                              fontSize: 13.0,
                                              color: Color(0xFFe78337),
                                              fontWeight: FontWeight.bold,
                                            ),
                                            textAlign: TextAlign.start,
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(height: 5),
                              Container(
                                height: 1.0, // Set the height of the line
                                color: Colors.grey, // Set the color of the line
                              ),
                              SizedBox(height: 5),
                              Container(
                                width: MediaQuery.of(context).size.width,
                                padding: EdgeInsets.all(10.0),
                                child: Row(
                                  children: [
                                    Container(
                                      width:
                                          MediaQuery.of(context).size.width / 2,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(
                                                top: 0.0,
                                                left: 20.0,
                                                right: 0.0),
                                            child: Text(
                                              'Preferable Transport',
                                              style: TextStyle(
                                                fontSize: 13.0,
                                                color: Color(0xFF414141),
                                                fontWeight: FontWeight.bold,
                                              ),
                                              textAlign: TextAlign.start,
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                top: 0.0,
                                                left: 20.0,
                                                right: 0.0),
                                            child: Text(
                                              'Railway Parcel Service',
                                              style: TextStyle(
                                                fontSize: 13.0,
                                                color: Color(0xFFe78337),
                                                fontWeight: FontWeight.bold,
                                              ),
                                              textAlign: TextAlign.start,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10.0,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color:
                                  Colors.grey, // specify your border color here
                              width: 1.0, // specify the border width
                            ),
                            borderRadius: BorderRadius.circular(
                                8.0), // specify the border radius
                          ),
                          width: MediaQuery.of(context).size.width,
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width / 2.2,
                                    padding: EdgeInsets.all(10.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(
                                              top: 0.0, left: 20.0, right: 0.0),
                                          child: Text(
                                            'Payment Mode',
                                            style: TextStyle(
                                              fontSize: 13.0,
                                              color: Color(0xFF414141),
                                              fontWeight: FontWeight.bold,
                                            ),
                                            textAlign: TextAlign.start,
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              top: 0.0, left: 20.0, right: 0.0),
                                          child: Text(
                                            'Cheque',
                                            style: TextStyle(
                                              fontSize: 13.0,
                                              color: Color(0xFFe78337),
                                              fontWeight: FontWeight.bold,
                                            ),
                                            textAlign: TextAlign.start,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width / 2.9,
                                    padding: EdgeInsets.all(10.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(
                                              top: 0.0, left: 0.0, right: 0.0),
                                          child: Text(
                                            'Cheque Number',
                                            style: TextStyle(
                                              fontSize: 13.0,
                                              color: Color(0xFF414141),
                                              fontWeight: FontWeight.bold,
                                            ),
                                            textAlign: TextAlign.start,
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              top: 0.0, left: 0.0, right: 0.0),
                                          child: Text(
                                            '68467967956554',
                                            style: TextStyle(
                                              fontSize: 13.0,
                                              color: Color(0xFFe78337),
                                              fontWeight: FontWeight.bold,
                                            ),
                                            textAlign: TextAlign.start,
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(height: 5),
                              Container(
                                height: 1.0, // Set the height of the line
                                color: Colors.grey, // Set the color of the line
                              ),
                              SizedBox(height: 5),
                              Container(
                                width: MediaQuery.of(context).size.width,
                                child: Row(
                                  children: [
                                    Container(
                                      width:
                                          MediaQuery.of(context).size.width / 2,
                                      padding: EdgeInsets.all(10.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(
                                                top: 0.0,
                                                left: 20.0,
                                                right: 0.0),
                                            child: Text(
                                              'Cheque Issued Bank',
                                              style: TextStyle(
                                                fontSize: 13.0,
                                                color: Color(0xFF414141),
                                                fontWeight: FontWeight.bold,
                                              ),
                                              textAlign: TextAlign.start,
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                top: 0.0,
                                                left: 20.0,
                                                right: 0.0),
                                            child: Text(
                                              'Bank Name',
                                              style: TextStyle(
                                                fontSize: 13.0,
                                                color: Color(0xFFe78337),
                                                fontWeight: FontWeight.bold,
                                              ),
                                              textAlign: TextAlign.start,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10.0,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Container(
                width: screenWidth,
                padding: EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
                child: IntrinsicHeight(
                    child: Card(
                  color: Colors.white,
                  child: Container(
                    padding: EdgeInsets.all(10.0),
                    width: screenWidth,
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              child: Text(
                                'Sub Total',
                                style: TextStyle(
                                  color: Color(0xFF414141),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12.0,
                                ),
                              ),
                            ),
                            Spacer(),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Container(
                                  //   width: MediaQuery.of(context).size.width / 1.8,
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                        'Pcs',
                                        style: TextStyle(
                                          color: Color(0xFFe78337),
                                          fontWeight: FontWeight.w600,
                                          fontSize: 13.0,
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Container(
                          padding: EdgeInsets.all(12.0),
                          height: 1.0, // Set the height of the line
                          color: Colors.grey, // Set the color of the line
                        ),
                        Container(
                          child: Column(
                            children: [
                              Container(
                                //  width: screenWidth / 2,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(''),
                                        Text('Tax'),
                                        SizedBox(
                                          height: 4.0,
                                        ),
                                        Text('Transport Charge')
                                      ],
                                    ),
                                    Container(
                                      //   width: screenWidth / 2,
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                '(SGST)',
                                                style: TextStyle(
                                                  color: Color(0xFFe78337),
                                                ),
                                              ),
                                              Text(
                                                '846384',
                                                style: TextStyle(
                                                  color: Color(0xFFe78337),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 6.0,
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                '(SGST)',
                                                style: TextStyle(
                                                  color: Color(0xFFe78337),
                                                ),
                                              ),
                                              Text(
                                                '846384',
                                                style: TextStyle(
                                                  color: Color(0xFFe78337),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 3.0,
                                          ),
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Text(''),
                                              Text(
                                                '846384',
                                                style: TextStyle(
                                                  color: Color(0xFFe78337),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(12.0),
                          height: 1.0, // Set the height of the line
                          color: Colors.grey, // Set the color of the line
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              padding: EdgeInsets.only(top: 10.0),
                              child: Text(
                                'Total',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14.0,
                                ),
                              ),
                            ),
                            Spacer(),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Container(
                                  //   width: MediaQuery.of(context).size.width / 1.8,
                                  padding: EdgeInsets.only(top: 10.0),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                        'Pc',
                                        style: TextStyle(
                                          color: Color(0xFFe78337),
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14.0,
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                )))
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ElevatedButton(
          onPressed: () {
            // Add the functionality you want for the button
          },
          style: ElevatedButton.styleFrom(
            primary: Color(0xFFe78337), // Set your desired background color
          ),
          child: Text(
            'Place Your Order',
            style: TextStyle(
              color: Colors.white, // Set your desired text color
            ),
          ),
        ),
      ),
    );
  }
}
