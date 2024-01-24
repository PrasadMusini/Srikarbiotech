import 'dart:convert';
import 'package:badges/badges.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:badges/src/badge.dart' as badge;
import 'package:shared_preferences/shared_preferences.dart';
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
  final String proprietorName;
  final String gstRegnNo;
  final String state;
  final String phone;

  Createorderscreen(
      {required this.cardName, required this.cardCode, required this.address, required  this.state, required  this.phone,
        required  this.proprietorName, required  this.gstRegnNo});



  @override
  State<Createorderscreen > createState() => _ProductListState();
}

class _ProductListState extends State<Createorderscreen > {
  // DBHelper dbHelper = DBHelper();
  bool isLoading = false;
  List<ProductResponse> products = [];
  // List<int> quantities =[];
  // List<TextEditingController> textEditingControllers =[];
  bool isSelectedWeight1 = false;
  bool isSelectedWeight2 = false;
  bool isSelectedWeight3 = false;
  int selectedProductIndex = -1;
  int selectedIndex = -1;
  // late List<bool> isSelectedList;
  List<ItemGroup> filtereditemgroup = [];
  TextEditingController searchController = TextEditingController();
  bool isButtonClicked = false;
 // List<int> selectedIndices = [];
  String Groupname = "";
  String ItemCode = "";
  int selectindex = 0;
  List<ProductResponse> productresponse = [];
  String getgropcode = "";
  ApiResponse? apiResponse;
  String parts = "";
  List<String>? cartItems = [];

  List<int> quantities = [1]; // Initialize with default quantity
  List<TextEditingController> textEditingControllers = [TextEditingController()];
  List<bool> isSelectedList = [false];
// Declare ApiResponse globally
  @override
  void initState() {
    super.initState();
    print('Total items in the cart: ${cartItems!.length}');
    // fetchProducts();
    //  fetchProducts();
    fetchProducts().then((response) {
      setState(() {
        isLoading = true; // or false
        clearSharedPreferences();
        apiResponse = response;
        fetchproductlist('102');
      });
    });
  }

  Future<ApiResponse> fetchProducts() async {
    try {
      final response = await http.get(Uri.parse(
          'http://182.18.157.215/Srikar_Biotech_Dev/API/api/Item/GetItemGroups/1/null'));
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
        'http://182.18.157.215/Srikar_Biotech_Dev/API/api/Item/GetAllItemsByItemGroupCode/1/'+'$Gropcode',
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

              isLoading = true; // or false
              productresponse = appointmentsData
                .map((appointment) => ProductResponse.fromJson(appointment))
                .toList();

     quantities = List<int>.filled(productresponse.length, 0);
          isSelectedList = List<bool>.filled(productresponse.length, false);
            textEditingControllers = List.generate(productresponse.length, (index) => TextEditingController());
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
          'Select Products',
          style: TextStyle(fontSize: 18, color: Colors.white, letterSpacing: 1),
        ),
        titleSpacing: -10,
        centerTitle: false,
    actions: [
    Stack(
    children: [
    IconButton(
    onPressed: () {
    // Navigator.push(
    // context,
    // MaterialPageRoute(
    // builder: (context) => const CartScreen(),
    // ),
    // );
    },
    icon: const Icon(Icons.shopping_cart),
    ),

    Positioned(
    right: 8,
    top: 8,
    child: Container(
    padding: const EdgeInsets.all(5),
    decoration: BoxDecoration(
    shape: BoxShape.circle,
    color: Colors.red, // Customize the badge color
    ),
    child: Text(
   '${cartItems!.length}',
    style: TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.bold,
    ),
    ),
    ),
    ),
    ],
    ),
    const SizedBox(
    width: 20.0,
    ),
    ],
    ),




      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 8.0),
                GestureDetector(
                  onTap: () {
                    // Handle the click event for the second text view
                    print('first textview clicked');
                  },
                  child:
                  Container(
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

              ],
            ),
          ),
          SizedBox(
            height: 10.0,
          ),

          Padding(
            padding: EdgeInsets.all(5.0),
            child: Container(
              height: 50.0,
              child: apiResponse == null
                  ? Center(
                child: CircularProgressIndicator.adaptive(), // Loading indicator
              )
                  : ListView.builder(
                shrinkWrap: false,
                scrollDirection: Axis.horizontal,
                itemCount: apiResponse?.listResult.length,
                itemBuilder: (BuildContext context, int i) {
                  bool isSelected = i == selectindex;

                  ItemGroup? itemGroup = apiResponse?.listResult[i];

                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          selectindex = i;
                        });
                        getgropcode = itemGroup!.itmsGrpCod;
                        print('getitemgroupcode:$getgropcode');
                        fetchproductlist(getgropcode);
                      },
                      style: ButtonStyle(
                        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                          EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0), // Adjust the padding as needed
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
                                  : Color(0xFFfff6eb), // Default border color
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
                      child: Text(
                        '${itemGroup?.itmsGrpNam}',
                        style: TextStyle(
                          color: isSelected ? Colors.white : Colors.black,
                          fontFamily: 'Calibri',
                          fontSize: 12,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),




          Expanded(

            child: productresponse == null
                ? (isLoading
                ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator.adaptive(),
                  SizedBox(height: 16.0),
                  Text(
                    'Loading, please wait...',
                    style: TextStyle(fontSize: 18.0, color: Color(0xFF424242)),
                  ),
                ],
              ),
            )
                : Center(
              child: Text(
                'No products available for this Category',
                style: TextStyle(fontSize: 18.0,
                color: Color(0xFF424242),
                fontWeight: FontWeight.bold)

              ),
            ))
                :
            ListView.builder(
              itemCount: productresponse.length,
              itemBuilder: (context, index) {
                if (index < 0 || index >= productresponse.length) {
                  return Container(
                    child: Text('Error: Index out of bounds'),
                  );
                }

                final productresp = productresponse[index];

                return GestureDetector(
                    onTap: () {
                      print('Tapped on ID: ${productresp.itemCode}');
                    },


                    child: Container(
                      child: Card(
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

                                Row(
                                  // crossAxisAlignment: CrossAxisAlignment.start,
                                  // mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      child: Text(
                                        '${productresp.itmsGrpNam.toString()}',
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
                                                '${productresp.ugpName.toString()}',
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
                                        text: '/ ',
                                        style: TextStyle(
                                          color: Color(0xFFa6a6a6),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 13.0,
                                          // decoration: TextDecoration.lineThrough,
                                        ),
                                      ),
                                      TextSpan(
                                        text: '${productresp.uMuom}',
                                        style: TextStyle(
                                          color: Color(0xFFa6a6a6),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 13.0,

                                        ),
                                      ),

                                    ],
                                  ),
                                ),

                                SizedBox(
                                  height: 5.0,
                                ),
                          Padding(
                            padding: const EdgeInsets.only(right: 0, left: 0, bottom: 0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                buildQuantitySelector(0), // Adjust the index as needed
                                SizedBox(width: 8.0),
                                buildAddToCartButton(0), // Adjust the index as needed
                              ],
                            ),
                          )
                              ],
                            ),
                          ),
                        ),
                      ));
                  // rest of your code...

              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ElevatedButton(
          onPressed: () async {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => transport_payment( cardName: '${widget.cardName}',
                    cardCode:'${widget.cardCode}',
                    address: '${widget.address}',
                    state:'${widget.state}',
                    phone: '${widget.phone}',
                    proprietorName: '${widget.proprietorName}',
                    gstRegnNo: '${widget.gstRegnNo}'),
              ),
            );

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

  void saveData(int index) async {
    // Get the SharedPreferences instance
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Get existing cart data from SharedPreferences
   cartItems = prefs.getStringList('cartItems') ?? [];

    // Add the current product data to the cart
    String productData = '${productresponse[index].itemCode},${productresponse[index].itemName},${quantities[index]}';
    cartItems!.add(productData);

    // Save the updated cart data in SharedPreferences
    prefs.setStringList('cartItems', cartItems!);

    // Print the items saved in the cart
    print('Items saved in the cart:');
    for (String item in cartItems!) {
      print(item);
    }

    // Print the count of items in the cart
    print('Total items in the cart: ${cartItems!.length}');
  }

  Future<void> clearSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  Widget buildQuantitySelector(int index) {
    return Container(
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
                textEditingControllers[index].text = quantities[index].toString();
              }
            },
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
                    width: MediaQuery.of(context).size.width / 5.1,
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                    child: TextField(
                      controller: textEditingControllers[index],
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(5),
                      ],
                      onChanged: (value) {
                        setState(() {
                          quantities[index] = int.parse(value.isEmpty ? '0' : value);
                        });
                      },
                      decoration: InputDecoration(
                        hintText: '0',
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: 0.0),
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
              textEditingControllers[index].text = quantities[index].toString();
            },
            alignment: Alignment.centerLeft,
            iconSize: 17.0,
          ),
        ],
      ),
    );
  }

  Widget buildAddToCartButton(int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: GestureDetector(
        onTap: () {
          setState(() {
            isSelectedList[index] = !isSelectedList[index];
          });
          if (quantities[index] > 0) {
            saveData(index);
          }
        },
        child: Container(
          height: 36,
          decoration: BoxDecoration(
            color: isSelectedList[index] ? Colors.orange : Colors.white,
            border: Border.all(
              color: Colors.orange,
              width: 1.0,
            ),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2.0),
            child: Row(
              children: [
                IconButton(
                  icon: Icon(
                    Icons.add_shopping_cart,
                    size: 18.0,
                    color: isSelectedList[index] ?Color(0xFFfff6eb) : Colors.orange,
                  ),
                  onPressed: () {
                    setState(() {
                      isSelectedList[index] = !isSelectedList[index];
                      if (quantities[index] > 0) {
                        saveData(index);
                      }
                    });
                  },
                ),
                Text(
                  isSelectedList[index] ? 'Added' : 'Add',
                  style: TextStyle(
                    color: isSelectedList[index] ? Color(0xFFfff6eb) : Colors.orange,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                // SizedBox(width: 8.0),
              ],
            ),
          ),
        ),
      ),
    );
  }


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
      itemCode: json['itemCode'] ?? "",
      itemName: json['itemName'] ?? "",
      frgnName: json['frgnName'] ?? "",
      itmsGrpCod: json['itmsGrpCod'] ?? "",
      itmsGrpNam: json['itmsGrpNam'] ?? "",
      cstGrpCode: json['cstGrpCode'] ?? "",
      priceUnit: json['priceUnit'] ?? "",
      gstTaxCtg: json['gstTaxCtg'] ?? "",
      excRate: json['excRate'] ?? "",
      exitPrice: json['exitPrice'] ?? "",
      uGroup: json['u_Group'] ?? "",
      uMuom: json['u_muom'] ?? "",
      uSize: json['u_size'] ?? "",
      uEwayRate: json['u_EwayRate'] ?? "",
      ugpEntry: json['ugpEntry'] ?? "",
      ugpCode: json['ugpCode'] ?? "",
      ugpName: json['ugpName'] ?? "",
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
