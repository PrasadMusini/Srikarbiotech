import 'dart:convert';
import 'package:badges/badges.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:badges/src/badge.dart' as badge;
import 'package:srikarbiotech/transport_payment.dart';

import 'CartItem.dart';
import 'Item.dart';
import 'Model/CartHelper.dart';
import 'Model/GetItemGroups.dart';
import 'Model/cart_provider.dart';
import 'cart_screen.dart';
class Createorderscreen extends StatefulWidget {
  final String cardName;
  final String  cardCode;
  final String  address;
  Createorderscreen({required this.cardName,required this.cardCode,required this.address});


  @override
  State<Createorderscreen > createState() => _ProductListState();
}

class _ProductListState extends State<Createorderscreen > {
  // DBHelper dbHelper = DBHelper();
  bool isLoading = false;
  List<ProductResponse> products = [];
  List<int> quantities = List.generate(10, (index) => 0, growable: true);
  List<TextEditingController> textEditingControllers =
  List.generate(10, (index) => TextEditingController());
  bool isSelectedWeight1 = false;
  bool isSelectedWeight2 = false;
  bool isSelectedWeight3 = false;
  int selectedProductIndex = -1;
  int selectedIndex = -1;
  late List<bool> isSelectedList;
  List<ItemGroup> filtereditemgroup = [];
  TextEditingController searchController = TextEditingController();
  bool isButtonClicked = false;
  List<int> selectedIndices = [];
  String Groupname = "";
  String ItemCode = "";
  int selectindex = 0;
  List<ProductResponse> productresponse = [];
  String getgropcode = "";
  ApiResponse? apiResponse; // Declare ApiResponse globally
  @override
  void initState() {
    super.initState();

    // fetchProducts();
    //  fetchProducts();
    fetchProducts().then((response) {
      setState(() {
        apiResponse = response;
        fetchproductlist(getgropcode);
      });
    });
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

  void filterDealers() {
    final String searchTerm = searchController.text.toLowerCase();
    setState(() {
      filtereditemgroup = filtereditemgroup.where((dealer) {
        return dealer.itmsGrpNam.toLowerCase().contains(searchTerm);
      }).toList();
    });
  }

  void fetchproductlist(String Gropcode) async {
    productresponse.clear();
    final response = await http.get(
      Uri.parse(
        'http://182.18.157.215/Srikar_Biotech_Dev/API/api/Item/GetAllItemsByItemGroupCode/' +
            '$Gropcode',
      ),
    );
    print('productlistresponse: ${response.body}');
    try {
      if (response.statusCode == 200) {
        final Map<String, dynamic>? responseData = jsonDecode(response.body);

        if (responseData == null) {
          throw Exception('Response data is null');
        }

        final List<dynamic>? appointmentsData =
        responseData['response']['listResult'];

        if (appointmentsData == null) {
          print('List result is null');
        } else {
          // Print the length directly on the list
          print('productlength ${appointmentsData.length}');

          setState(() {
            productresponse = appointmentsData
                .map((appointment) => ProductResponse.fromJson(appointment))
                .toList();
            isSelectedList =
                List.generate(productresponse.length, (index) => true);
            print('productresponse ${productresponse.length}');
          });
        }
      } else {
        throw Exception('Failed to fetch Products');
      }
    } catch (error) {
      print('Error: $error');
      throw Exception('Failed to connect to the API');
    }
  }

  @override
  Widget build(BuildContext context) {
    // ... (the rest of your existing build method)

    return Scaffold(

      appBar: AppBar(
        backgroundColor: Color(0xFFe78337),
        leading: IconButton(
          icon: Icon(Icons.chevron_left, color: Colors.white),
          onPressed: () {
            Navigator.pop(context); // This line will navigate back
          },
        ),
        title: Text(
          'Orders',
          style: TextStyle(fontSize: 25, color: Colors.white, letterSpacing: 1),
        ),
        titleSpacing: -10,
        centerTitle: false,
        actions: [
          badge.Badge(
            badgeContent: Consumer<CartProvider>(
              builder: (context, cartProvider, child) {
                return Text(
                  cartProvider.itemCount.toString(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                );
              },
            ),
            position: const BadgePosition(start: 30, bottom: 30),
            child: IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CartScreen(),
                  ),
                );
              },
              icon: const Icon(Icons.shopping_cart),
            ),
          ),
          const SizedBox(
            width: 20.0,
          ),
        ],
    ),



      body: Column(
        children: [
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
                            hintText: 'Search for Product Name',
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
          SizedBox(
            height: 10.0,
          ),
          Container(
            height: 50.0,
            child: GridView.builder(
              shrinkWrap: false,
              scrollDirection: Axis.horizontal,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                mainAxisExtent: 140,
                mainAxisSpacing: 10.0,
                childAspectRatio: 10.0,
              ),
              itemCount: apiResponse?.listResult.length,
              itemBuilder: (BuildContext context, int i) {
                bool isSelected = i == selectindex;
                // final ApiResponse apiResponse = snapshot.data!;

                ItemGroup? itemGroup = apiResponse?.listResult[i];
                // final List<ItemGroup> itemGroups = apiResponse!.listResult;
                //
                // for (ItemGroup itemGroup in itemGroups) {
                //   String itemsgropcode = itemGroup.itmsGrpCod;
                //   print('itmsGrpCod: ${itemGroup.itmsGrpCod}');
                //
                //   setState(() {
                //     ItemCode = itemsgropcode;
                //     print('ItemCode: $ItemCode');
                //   });
                // }
                return Container(
                  width: 60.0,
                  height: 50.0,
                  margin: EdgeInsets.symmetric(vertical: 2, horizontal: 2),
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        // Toggle selection
                        selectindex = i;
                      });
                      getgropcode = itemGroup!.itmsGrpCod;
                      print('getitemgroupcode:$getgropcode');
                      fetchproductlist(getgropcode);
                    },
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                        EdgeInsets.symmetric(vertical: 1.0, horizontal: 1.0),
                      ),
                      backgroundColor: MaterialStateProperty.resolveWith<Color>(
                            (Set<MaterialState> states) {
                          return isSelected
                              ? Color(0xFFe78337) // Color when selected
                              : Colors.white; // Default background color
                        },
                      ),
                      side: MaterialStateProperty.resolveWith<BorderSide>(
                            (Set<MaterialState> states) {
                          return BorderSide(
                            color: isSelected
                                ? Color(0xFFe78337) // Border when selected
                                : Color(0xFFe78337), // Default border color
                            width: 2.0,
                          );
                        },
                      ),
                      shape: MaterialStateProperty.all<OutlinedBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                      ),
                      textStyle: MaterialStateProperty.resolveWith<TextStyle>(
                            (Set<MaterialState> states) {
                          return TextStyle(
                            color: isSelected ? Colors.white : Colors.black,
                          );
                        },
                      ),
                    ),
                    child: IntrinsicWidth(
                      child: Text(
                        '${itemGroup?.itmsGrpNam}',
                        style: TextStyle(
                          color: isSelected ? Colors.white : Colors.black,
                          fontFamily: 'Calibri',
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Expanded(
            child: productresponse.isEmpty
                ? (isLoading
                ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 16.0),
                  Text(
                    'Loading, please wait...',
                    style: TextStyle(fontSize: 18.0),
                  ),
                ],
              ),
            )
                : Center(
              child: Text(
                'No products available for this Category',
                style: TextStyle(fontSize: 18.0),
              ),
            ))
                : ListView.builder(
              itemCount: productresponse.length,
              // Combine static and dynamic products
              itemBuilder: (context, index) {
                // if (index < productresponse.length) {
                //   // Display static product details
                //
                //   // Display dynamic (API) product details
                //   return buildProductCard(productresponse, index);
                // }
                if (index >= 0 && index < productresponse.length) {
                  // your existing code for building the list item
                  final productresp = productresponse[index];
                  return GestureDetector(
                      onTap: () {
                        // Handle tap event here, you can print the ID or perform any other action
                        print('Tapped on ID: ${productresp.itemCode}');
                      },
                      child: Container(
                        // Adjust the height as needed
                        child: Card(
                          // color: Colors.white,
                          color: Colors.white,
                          elevation: 5.0,
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                RichText(
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  text: TextSpan(
                                    text:
                                    '${productresp.itemName.toString()}\n',
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
                                    '₹${productresp.cstGrpCode.toString()}  ',
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
                                        text: '${productresp.exitPrice}',
                                        style: TextStyle(
                                          color: Color(0xFFa6a6a6),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 13.0,
                                          decoration:
                                          TextDecoration.lineThrough,
                                        ),
                                      ),
                                      WidgetSpan(
                                        child: SizedBox(
                                            width:
                                            16), // Adjust the width as needed
                                      ),
                                      TextSpan(
                                        text:
                                        '(${productresp.gstTaxCtg}%)',
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
                                  height: 4.0,
                                ),
                                Row(
                                  // crossAxisAlignment: CrossAxisAlignment.start,
                                  // mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      child: Text(
                                        '${productresp.priceUnit.toString()} Items Available',
                                        style: TextStyle(
                                          color: Color(0xFF848484),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12.0,
                                        ),
                                      ),
                                    ),
                                    Spacer(),
                                    Row(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.end,
                                      mainAxisAlignment:
                                      MainAxisAlignment.end,
                                      children: [
                                        Container(
                                          //   width: MediaQuery.of(context).size.width / 1.8,
                                          child: Row(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                            mainAxisAlignment:
                                            MainAxisAlignment.end,
                                            children: [
                                              Text(
                                                '1Case -',
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight:
                                                  FontWeight.w600,
                                                  fontSize: 13.0,
                                                ),
                                              ),
                                              Text(
                                                '${productresp.frgnName.toString()}Pcs',
                                                style: TextStyle(
                                                  color:
                                                  Color(0xFFe78337),
                                                  fontWeight:
                                                  FontWeight.w600,
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
                                  height: 5.0,
                                ),
                                Row(
                                  children: [
                                    buildweight(
                                        0,
                                        '${productresp.ugpEntry.toString()}',
                                            () {}),
                                    buildweight(
                                        1,
                                        '${productresp.ugpEntry.toString()}',
                                            () {}),
                                    buildweight(
                                        2,
                                        '${productresp.ugpEntry.toString()}',
                                            () {}),
                                  ],
                                ),

                                // Row(
                                //   children: [
                                //     buildweight(0, '${staticProducts[index].unit.toString()}',
                                //         () {
                                //       print('${selectedIndexForProduct}');
                                //       setState(() {
                                //         selectedIndexForProduct = 0;
                                //       });
                                //     }, isSelected: selectedIndexForProduct == 0),
                                //     buildweight(1, '${staticProducts[index].unit.toString()}',
                                //         () {
                                //       setState(() {
                                //         selectedIndexForProduct = 1;
                                //       });
                                //     }, isSelected: selectedIndexForProduct == 1),
                                //     buildweight(2, '${staticProducts[index].unit.toString()}',
                                //         () {
                                //       setState(() {
                                //         selectedIndexForProduct = 2;
                                //       });
                                //     }, isSelected: selectedIndexForProduct == 2),
                                //   ],
                                // ),

                                SizedBox(
                                  height: 5.0,
                                ),
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
                                        width: MediaQuery.of(context)
                                            .size
                                            .width /
                                            2.2,
                                        decoration: BoxDecoration(
                                          color: Colors.orange,
                                          borderRadius:
                                          BorderRadius.circular(10.0),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment
                                              .spaceAround,
                                          crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                          children: [
                                            IconButton(
                                              icon: Icon(Icons.remove,
                                                  color: Colors.white),
                                              onPressed: () {
                                                if (quantities[index] >
                                                    1) {
                                                  setState(() {
                                                    quantities[index]--;
                                                  });
                                                  textEditingControllers[
                                                  index]
                                                      .text =
                                                      quantities[index]
                                                          .toString();
                                                }
                                              },
                                              //alignment: Alignment.center,
                                              iconSize: 17.0,
                                            ),
                                            Expanded(
                                              child: Align(
                                                alignment:
                                                Alignment.center,
                                                child: Container(
                                                  height: 35,
                                                  child: Padding(
                                                    padding:
                                                    const EdgeInsets
                                                        .all(2.0),
                                                    child: Container(
                                                      alignment: Alignment
                                                          .center,
                                                      width: MediaQuery.of(
                                                          context)
                                                          .size
                                                          .width /
                                                          5.1,
                                                      decoration:
                                                      BoxDecoration(
                                                        color:
                                                        Colors.white,
                                                      ),
                                                      child: TextField(
                                                        // controller:
                                                        //     textEditingControllers[
                                                        //         index],
                                                        keyboardType:
                                                        TextInputType
                                                            .number,
                                                        inputFormatters: <TextInputFormatter>[
                                                          FilteringTextInputFormatter
                                                              .digitsOnly,
                                                          LengthLimitingTextInputFormatter(
                                                              5),
                                                        ],
                                                        onChanged:
                                                            (value) {
                                                          setState(() {
                                                            quantities[
                                                            index] = int.parse(value
                                                                .isEmpty
                                                                ? '0'
                                                                : value);
                                                          });
                                                        },
                                                        decoration:
                                                        InputDecoration(
                                                          hintText: '0',
                                                          border:
                                                          InputBorder
                                                              .none,
                                                          focusedBorder:
                                                          InputBorder
                                                              .none,
                                                          enabledBorder:
                                                          InputBorder
                                                              .none,
                                                          contentPadding:
                                                          EdgeInsets.symmetric(
                                                              horizontal:
                                                              0.0),
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
                                                  color: Colors.white),
                                              onPressed: () {
                                                setState(() {
                                                  quantities[index]++;
                                                });
                                                textEditingControllers[
                                                index]
                                                    .text =
                                                    quantities[index]
                                                        .toString();
                                              },
                                              alignment:
                                              Alignment.centerLeft,
                                              iconSize: 17.0,
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        width: 8.0,
                                      ),
                                      Padding(
                                        padding:
                                        const EdgeInsets.symmetric(
                                            horizontal: 0.0),
                                        child: Container(
                                          height: 36,
                                          width: 95,
                                          padding:
                                          const EdgeInsets.all(0.0),
                                          decoration: BoxDecoration(
                                            color: isSelectedList[index]
                                                ? Colors.orange
                                                : Colors.white,
                                            border: Border.all(
                                              color: Colors.orange,
                                              width: 1.0,
                                            ),
                                            borderRadius:
                                            BorderRadius.circular(
                                                8.0),
                                          ),
                                          child: Row(
                                            children: [
                                              IconButton(
                                                icon: Icon(
                                                  Icons.add_shopping_cart,
                                                  size: 20.0,
                                                  color: isSelectedList[
                                                  index]
                                                      ? Colors.white
                                                      : Colors.orange,
                                                ),
                                                onPressed: () {
                                                  setState(() {
                                                    //saveData(index);
                                                  });
                                                },
                                                alignment:
                                                Alignment.centerLeft,
                                                iconSize: 18.0,
                                              ),
                                              SizedBox(width: 2.0),
                                              Text(
                                                isSelectedList[index]
                                                    ? 'Added'
                                                    : 'Add',
                                                style: TextStyle(
                                                  color: isSelectedList[
                                                  index]
                                                      ? Colors.white
                                                      : Colors.orange,
                                                  fontWeight:
                                                  FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ));
                  // rest of your code...
                } else {
                  Container(
                    child: Text('error'),
                  );
                }
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ElevatedButton(
          onPressed: () async {
            // Check if there are saved cart items
            List<SelectedProducts> savedCartItems =
            await CartHelper.getFertCartData();

            if (_isValidCart(savedCartItems)) {
              // Navigate to the next screen if items are saved and have valid data
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => transport_payment(
                    productitems: savedCartItems.toList(),
                  ),
                ),
              );
            } else {
              // Show a message or perform some action if no valid items are saved
              print('No valid items are saved or cart is empty.');
            }
          },
          style: ElevatedButton.styleFrom(
            primary: Color(0xFFe78337), // Set your desired background color
          ),
          child: Text(
            'Select Transport & Payment',
            style: TextStyle(
              color: Colors.white, // Set your desired text color
            ),
          ),
        ),
      ),
    );
  }

  bool _isValidCart(List<SelectedProducts> cartItems) {
    // Check if the cart items have valid data (replace with your own validation logic)
    return cartItems.isNotEmpty &&
        cartItems.any((product) =>
        product.productName.isNotEmpty && product.productPrice > 0);
  }

  Widget buildProductCard(List<ProductResponse> product, int index) {
    int selectedIndexForProduct = -1;

    return GestureDetector(
        onTap: () {
          // Handle tap event here, you can print the ID or perform any other action
          print('Tapped on ID: ${product[index].itmsGrpCod}');
        },
        child: Container(
          // Adjust the height as needed
          child: Card(
            // color: Colors.white,
            color: Colors.white,
            elevation: 5.0,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  RichText(
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    text: TextSpan(
                      text: '${product[index].itemName.toString()}\n',
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
                      text: '₹${product[index].cstGrpCode.toString()}  ',
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
                          text: '${product[index].exitPrice}',
                          style: TextStyle(
                            color: Color(0xFFa6a6a6),
                            fontWeight: FontWeight.bold,
                            fontSize: 13.0,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                        WidgetSpan(
                          child:
                          SizedBox(width: 16), // Adjust the width as needed
                        ),
                        TextSpan(
                          text: '(${product[index].gstTaxCtg}%)',
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
                    height: 4.0,
                  ),
                  Row(
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    // mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        child: Text(
                          '${product[index].priceUnit.toString()} Items Available',
                          style: TextStyle(
                            color: Color(0xFF848484),
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
                                  '1Case -',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 13.0,
                                  ),
                                ),
                                Text(
                                  '${product[index].frgnName.toString()}Pcs',
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
                    height: 5.0,
                  ),
                  Row(
                    children: [
                      buildweight(
                          0, '${product[index].ugpEntry.toString()}', () {}),
                      buildweight(
                          1, '${product[index].ugpEntry.toString()}', () {}),
                      buildweight(
                          2, '${product[index].ugpEntry.toString()}', () {}),
                    ],
                  ),

                  // Row(
                  //   children: [
                  //     buildweight(0, '${staticProducts[index].unit.toString()}',
                  //         () {
                  //       print('${selectedIndexForProduct}');
                  //       setState(() {
                  //         selectedIndexForProduct = 0;
                  //       });
                  //     }, isSelected: selectedIndexForProduct == 0),
                  //     buildweight(1, '${staticProducts[index].unit.toString()}',
                  //         () {
                  //       setState(() {
                  //         selectedIndexForProduct = 1;
                  //       });
                  //     }, isSelected: selectedIndexForProduct == 1),
                  //     buildweight(2, '${staticProducts[index].unit.toString()}',
                  //         () {
                  //       setState(() {
                  //         selectedIndexForProduct = 2;
                  //       });
                  //     }, isSelected: selectedIndexForProduct == 2),
                  //   ],
                  // ),

                  SizedBox(
                    height: 5.0,
                  ),
                  Padding(
                    padding:
                    const EdgeInsets.only(right: 0, left: 0, bottom: 0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          height: 36,
                          width: MediaQuery.of(context).size.width / 2.2,
                          decoration: BoxDecoration(
                            color: Colors.orange,
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              IconButton(
                                icon: Icon(Icons.remove, color: Colors.white),
                                onPressed: () {
                                  if (quantities[index] > 1) {
                                    setState(() {
                                      quantities[index]--;
                                    });
                                    textEditingControllers[index].text =
                                        quantities[index].toString();
                                  }
                                },
                                //alignment: Alignment.center,
                                iconSize: 17.0,
                              ),
                              Expanded(
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Container(
                                    height: 35,
                                    child: Padding(
                                      padding: const EdgeInsets.all(2.0),
                                      child: Container(
                                        alignment: Alignment.center,
                                        width:
                                        MediaQuery.of(context).size.width /
                                            5.1,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                        ),
                                        child: TextField(
                                          controller:
                                          textEditingControllers[index],
                                          keyboardType: TextInputType.number,
                                          inputFormatters: <TextInputFormatter>[
                                            FilteringTextInputFormatter
                                                .digitsOnly,
                                            LengthLimitingTextInputFormatter(5),
                                          ],
                                          onChanged: (value) {
                                            setState(() {
                                              quantities[index] = int.parse(
                                                  value.isEmpty ? '0' : value);
                                            });
                                          },
                                          decoration: InputDecoration(
                                            hintText: '0',
                                            border: InputBorder.none,
                                            focusedBorder: InputBorder.none,
                                            enabledBorder: InputBorder.none,
                                            contentPadding:
                                            EdgeInsets.symmetric(
                                                horizontal: 0.0),
                                          ),
                                          textAlign: TextAlign.center,
                                          style: TextStyle(fontSize: 12.5),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              IconButton(
                                icon: Icon(Icons.add, color: Colors.white),
                                onPressed: () {
                                  setState(() {
                                    quantities[index]++;
                                  });
                                  textEditingControllers[index].text =
                                      quantities[index].toString();
                                },
                                alignment: Alignment.centerLeft,
                                iconSize: 17.0,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 8.0,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 0.0),
                          child: Container(
                            height: 36,
                            width: 95,
                            padding: const EdgeInsets.all(0.0),
                            decoration: BoxDecoration(
                              color: isSelectedList[index]
                                  ? Colors.orange
                                  : Colors.white,
                              border: Border.all(
                                color: Colors.orange,
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Row(
                              children: [
                                IconButton(
                                  icon: Icon(
                                    Icons.add_shopping_cart,
                                    size: 20.0,
                                    color: isSelectedList[index]
                                        ? Colors.white
                                        : Colors.orange,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                     //saveData(index);
                                    });
                                  },
                                  alignment: Alignment.centerLeft,
                                  iconSize: 18.0,
                                ),
                                SizedBox(width: 2.0),
                                Text(
                                  isSelectedList[index] ? 'Added' : 'Add',
                                  style: TextStyle(
                                    color: isSelectedList[index]
                                        ? Colors.white
                                        : Colors.orange,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }

  // Future<void> saveData(int index) async {
  //   Item selectedProduct = staticProducts[index];
  //   CartProvider cartProvider =
  //   Provider.of<CartProvider>(context, listen: false);
  //   int selectedQuantity = quantities[index];
  //
  //   // Create a new CartItem for the selected product
  //   // CartItem cartItem = CartItem(
  //   //   id: selectedProduct.id,
  //   //   productName: selectedProduct.name,
  //   //   unitTag: 'Kg',
  //   //   initialPrice: selectedProduct.price,
  //   //   discount: selectedProduct.discount,
  //   //   productPrice: selectedProduct.price,
  //   //   productquantity: selectedQuantity,
  //   //   quantity: ValueNotifier(1),
  //   // );
  //
  //   // Add the CartItem to the cartProvider
  //   cartProvider.addToCartitems([cartItem]);
  //
  //   // Retrieve the existing saved cart items
  //   List<SelectedProducts> savedCartItems = await CartHelper.getFertCartData();
  //
  //   // Create a new SelectedProducts object for the selected product
  //   SelectedProducts selectedProductData = SelectedProducts(
  //     id: cartItem.id,
  //     productName: cartItem.productName,
  //     unitTag: 'Kg',
  //     initialPrice: cartItem.initialPrice,
  //     discount: cartItem.discount,
  //     productPrice: cartItem.productPrice,
  //     productQuantity: cartItem.productquantity,
  //     quantity: ValueNotifier(1),
  //   );
  //
  //   // Add the new selected product to the list of saved cart items
  //   savedCartItems.add(selectedProductData);
  //
  //   // Save the updated list of saved cart items using CartHelper
  //   CartHelper.saveFertCartitems(savedCartItems);
  //
  //   print('Added to cart: ${selectedProduct.name}, '
  //       'ID: ${selectedProduct.id}, '
  //       'Quantity: $selectedQuantity, '
  //       'Price: ${selectedProduct.price}, '
  //       'Discount: ${selectedProduct.discount}, '
  //       'Initial Price: ${selectedProduct.initalprice}');
  //   await CartHelper.printSavedCartItems();
  // }

  Widget buildweight(int index, String mode, Function onTap,
      {bool isSelected = false}) {
    return GestureDetector(
      onTap: () {
        onTap(); // Call the onTap function passed as a parameter
      },
      child: Container(
        width: 60,
        height: 36,
        child: Card(
          elevation: 0.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(7.0),
            side: BorderSide(
              color: isSelected ? Color(0xFFe78337) : Color(0xFFe78337),
            ),
          ),
          color: isSelected ? Color(0xFFe78337) : Color(0xFFF8dac2),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                mode,
                style: TextStyle(
                  color: isSelected ? Colors.white : null,
                  fontSize: 12.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


// void saveData(int index) {
//   // Check if the item is selected
//   if (isSelectedList[index]) {
//     CartProvider cartProvider =
//         Provider.of<CartProvider>(context, listen: false);
//
//     Item selectedProduct = index < staticProducts.length
//         ? staticProducts[index]
//         : products[index - staticProducts.length];
//
//     String selectedWeight = isSelectedWeight1
//         ? '15 Kg'
//         : isSelectedWeight2
//             ? '25 Kg'
//             : isSelectedWeight3
//                 ? '50 Kg'
//                 : 'N/A';
//
//     CartItem cartItem = CartItem(
//       id: selectedProduct.id,
//       productName: '',
//       unitTag: 'Kg',
//       initialPrice: 10.0,
//       productPrice: 8.0,
//       productquantity: quantities[index],
//       quantity: ValueNotifier(1),
//       image: 'assets/images/sample_product.png',
//     );
//
//     // Add the CartItem to the cartProvider
//     cartProvider.addToCart(cartItem);
//
//     // Reset the selection after adding the product to the cart
//     setState(() {
//       isSelectedList[index] = false; // Unselect the item after saving data
//       selectedProductIndex = -1;
//       isSelectedWeight1 = false;
//       isSelectedWeight2 = false;
//       isSelectedWeight3 = false;
//
//       print('cartitemadded:${selectedProduct.id}');
//     });
//
//     // Show a confirmation or perform any other actions if needed
//     // ...
//   }
// }

// void saveData(int index) {
//   // Check if a product is selected
//   if (selectedProductIndex != -1) {
//     CartProvider cartProvider =
//         Provider.of<CartProvider>(context, listen: false);
//
//     Item selectedProduct = index < staticProducts.length
//         ? staticProducts[index]
//         : products[index - staticProducts.length];
//
//     String selectedWeight = isSelectedWeight1
//         ? '15 Kg'
//         : isSelectedWeight2
//             ? '25 Kg'
//             : isSelectedWeight3
//                 ? '50 Kg'
//                 : 'N/A';
//
//     // CartItem cartItem = CartItem(
//     //   product: selectedProduct,
//     //   quantity: quantities[index],
//     //   weight: selectedWeight,
//     // );
//     CartItem cartItem = CartItem(
//       id: 1,
//       productName: 'Sample Product',
//       unitTag: 'Kg',
//       initialPrice: 10.0,
//       productPrice: 8.0,
//       productquantity: quantities[index],
//       quantity: ValueNotifier(1),
//       image: 'assets/images/sample_product.png',
//     );
//     // Add the CartItem to the cartProvider
//     cartProvider.addToCart(cartItem);
//
//     // Reset the selection after adding the product to the cart
//     setState(() {
//       selectedProductIndex = -1;
//       isSelectedWeight1 = false;
//       isSelectedWeight2 = false;
//       isSelectedWeight3 = false;
//     });
//
//     // Show a confirmation or perform any other actions if needed
//     // ...
//   }
// }
// Widget buildweight(int index, String mode, Function onTap,
//     ) {
//   return GestureDetector(
//     onTap: () {
//       setState(() {
//         selectedIndex = index;
//       });
//       onTap(); // Call the onTap function passed as a parameter
//     },
//     child: Container(
//       width: 60,
//       height: 36,
//       child: Card(
//         elevation: 0.0,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(7.0),
//           side: BorderSide(
//             color: index == selectedIndex
//                 ? Color(0xFFe78337)
//                 : Color(0xFFe78337),
//           ),
//         ),
//         color: index == selectedIndex ? Color(0xFFe78337) : Color(0xFFF8dac2),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(
//               mode,
//               style: TextStyle(
//                 color: index == selectedIndex ? Colors.white : null,
//                 fontSize: 12.0,
//               ),
//             ),
//           ],
//         ),
//       ),
//     ),
//   );
// }
// Future<void> saveData(List<int> selectedIndices) async {
//   CartProvider cartProvider =
//       Provider.of<CartProvider>(context, listen: false);
//
//   // Retrieve the existing saved cart items
//   List<SelectedProducts> savedCartItems = await CartHelper.getFertCartData();
//
//   // Iterate through selected indices and save/update each product
//   for (int index in selectedIndices) {
//     Item selectedProduct = staticProducts[index];
//     int selectedQuantity = quantities[index];
//
//     // Create a new CartItem for the selected product
//     CartItem cartItem = CartItem(
//       id: selectedProduct.id,
//       productName: selectedProduct.name,
//       unitTag: 'Kg',
//       initialPrice: selectedProduct.price,
//       discount: selectedProduct.discount,
//       productPrice: selectedProduct.price,
//       productquantity: selectedQuantity,
//       quantity: ValueNotifier(1),
//     );
//
//     // Add the CartItem to the cartProvider
//     cartProvider.addToCartitems([cartItem]);
//
//     // Check if the selected product is already in the saved list
//     bool isProductExists =
//         savedCartItems.any((item) => item.id == cartItem.id);
//
//     if (isProductExists) {
//       // Update the quantity if the product already exists in the list
//       savedCartItems.firstWhere((item) => item.id == cartItem.id);
//     } else {
//       // Add the new selected product to the list of saved cart items
//       SelectedProducts selectedProductData = SelectedProducts(
//         id: cartItem.id,
//         productName: cartItem.productName,
//         unitTag: 'Kg',
//         initialPrice: cartItem.initialPrice,
//         discount: cartItem.discount,
//         productPrice: cartItem.productPrice,
//         productQuantity: cartItem.productquantity,
//         quantity: ValueNotifier(1),
//       );
//
//       savedCartItems.add(selectedProductData);
//     }
//   }
//
//   // Save the updated list of saved cart items using CartHelper
//   CartHelper.saveFertCartitems(savedCartItems);
//
//   // Print debug information
//   for (int index in selectedIndices) {
//     Item selectedProduct = staticProducts[index];
//     int selectedQuantity = quantities[index];
//     print('Added to cart: ${selectedProduct.name}, '
//         'ID: ${selectedProduct.id}, '
//         'Quantity: $selectedQuantity, '
//         'Price: ${selectedProduct.price}, '
//         'Discount: ${selectedProduct.discount}, '
//         'Initial Price: ${selectedProduct.initalprice}');
//   }
//
//   await CartHelper.printSavedCartItems();
// }
}

// Static product details
class ProductResponse {
  final String itemCode;
  final String itemName;
  final String frgnName;
  final String itmsGrpCod;
  final String itmsGrpNam;
  final String cstGrpCode;
  final String priceUnit;
  final String gstTaxCtg;
  final String excRate;
  final String exitPrice;
  final String uGroup;
  final String uMuom;
  final String uSize;
  final String uEwayRate;
  final String ugpEntry;
  final String ugpCode;
  final String ugpName;

  ProductResponse({
    required this.itemCode,
    required this.itemName,
    required this.frgnName,
    required this.itmsGrpCod,
    required this.itmsGrpNam,
    required this.cstGrpCode,
    required this.priceUnit,
    required this.gstTaxCtg,
    required this.excRate,
    required this.exitPrice,
    required this.uGroup,
    required this.uMuom,
    required this.uSize,
    required this.uEwayRate,
    required this.ugpEntry,
    required this.ugpCode,
    required this.ugpName,
  });

  factory ProductResponse.fromJson(Map<String, dynamic> json) {
    return ProductResponse(
      itemCode: json['itemCode'],
      itemName: json['itemName'],
      frgnName: json['frgnName'],
      itmsGrpCod: json['itmsGrpCod'],
      itmsGrpNam: json['itmsGrpNam'],
      cstGrpCode: json['cstGrpCode'],
      priceUnit: json['priceUnit'],
      gstTaxCtg: json['gstTaxCtg'],
      excRate: json['excRate'],
      exitPrice: json['exitPrice'],
      uGroup: json['u_Group'],
      uMuom: json['u_muom'],
      uSize: json['u_size'],
      uEwayRate: json['u_EwayRate'],
      ugpEntry: json['ugpEntry'],
      ugpCode: json['ugpCode'],
      ugpName: json['ugpName'],
    );
  }
}

class Product {
  final List<ProductResponse> listResult;
  final int count;
  final int affectedRecords;
  final bool isSuccess;

  Product({
    required this.listResult,
    required this.count,
    required this.affectedRecords,
    required this.isSuccess,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      listResult: (json['listResult'] as List)
          .map((itemJson) => ProductResponse.fromJson(itemJson))
          .toList(),
      count: json['count'],
      affectedRecords: json['affectedRecords'],
      isSuccess: json['isSuccess'],
    );
  }
}
