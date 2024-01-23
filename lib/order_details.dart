import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:srikarbiotech/HomeScreen.dart';

class orderdetails extends StatefulWidget {
  final String orderid;
  final String orderdate;
  final double totalprice;
  final String bookingplace;
  final String Preferabletransport;
  final int lrnumber;
  final String lrdate;
  final String paymentmode;
  final String transportmode;
  final String statusname;
  final String partyname;

  orderdetails(
      {required this.partyname,
      required this.orderid,
      required this.orderdate,
      required this.totalprice,
      required this.bookingplace,
      required this.Preferabletransport,
      required this.lrnumber,
      required this.lrdate,
      required this.paymentmode,
      required this.transportmode,
      required this.statusname});

  @override
  State<orderdetails> createState() => _orderdetailsPageState();
}

class _orderdetailsPageState extends State<orderdetails> {
  List tableCellTitles = [
    ['Order Date', 'Booking Place', 'Preferabale Transport', 'LR Number'],
    [
      'Total',
      'Transport Mode',
      'Payment Mode',
      'LR Date',
    ]
  ];
  late List tableCellValues;
  @override
  void initState() {
    // TODO: implement initState
    fetchData();
    super.initState();
  }

  Future<List<String>> fetchData() async {
    // Retrieve saved cart items using CartHelper
    tableCellValues = [
      [
        widget.orderdate,
        widget.bookingplace,
        widget.transportmode,
        widget.lrnumber
      ],
      [
        widget.totalprice,
        widget.transportmode,
        widget.paymentmode,
        widget.lrdate
      ]
    ];

    // Convert the elements to strings if needed
    List<String> stringList =
        tableCellValues.expand((row) => row).map((element) {
      return element.toString(); // Adjust the conversion as needed
    }).toList();

    return stringList;
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
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
                    'Order Details',
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
        body: SingleChildScrollView(
            child: Column(
                //mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                // Set mainAxisSize to min for intrinsic height
                children: [
              Container(
                width: screenWidth,
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                child: Card(
                  color: Colors.white,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding:
                              EdgeInsets.only(top: 0.0, left: 0.0, right: 0.0),
                          child: Text(
                            '${widget.partyname}',
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
                            'XXXXX05',
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
                            'Salesman Name',
                            style: TextStyle(
                              fontSize: 14.0,
                              color: Color(0xFFe78337),
                              fontWeight: FontWeight.w500,
                            ),
                            textAlign: TextAlign.start,
                          ),
                        ),
                        Padding(
                            padding: EdgeInsets.only(
                                top: 0.0, left: 0.0, right: 0.0),
                            child: Container(
                              child: Row(
                                children: [
                                  Text(
                                    'GST NO.',
                                    style: TextStyle(
                                      fontSize: 14.0,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    textAlign: TextAlign.start,
                                  ),
                                  Text(
                                    ' 65486GGG13588RL5',
                                    style: TextStyle(
                                      fontSize: 14.0,
                                      color: Color(0xFFe78337),
                                      fontWeight: FontWeight.w500,
                                    ),
                                    textAlign: TextAlign.start,
                                  ),
                                ],
                              ),
                            )),
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
                            'Plotno:149/2,BHEL, Hyderbad -435667',
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
              Container(
                padding: const EdgeInsets.all(5.0),
                child: Card(
                    elevation: 7,
                    child: Container(
                        padding: const EdgeInsets.all(10),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                        ),
                        child: Column(children: [
                          // Table
                          Row(
                            //  crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  Text(
                                    'Order ID',
                                    textAlign: TextAlign.start,
                                  ),
                                  Text(
                                    '${widget.orderid}',
                                    style: TextStyle(
                                        fontFamily: 'Roboto',
                                        fontSize: 13,
                                        color: Color(0xFFe58338),
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),

                              //+  Spacer(),

                              Text('${widget.statusname}')
                            ],
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Table(
                            border: TableBorder.all(
                              width: 1,
                              color: Colors.grey.shade500,
                              //     borderRadius: BorderRadius.circular(10),
                            ),
                            children: [
                              ...List.generate(4, (index) {
                                return TableRow(
                                  children: [
                                    TableCell(
                                      child: Container(
                                        padding: const EdgeInsets.all(10),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              tableCellTitles[0][index],
                                              //   style: _titleTextStyle,
                                            ),
                                            SizedBox(height: 5),
                                            Text(
                                              tableCellValues[0][index]
                                                  .toString(),
                                              style: TextStyle(
                                                  fontFamily: 'Roboto',
                                                  fontSize: 13,
                                                  color: Color(0xFFe58338),
                                                  fontWeight: FontWeight.w600),
                                              //style: _dataTextStyle,
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    TableCell(
                                      child: Container(
                                        padding: EdgeInsets.all(10),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              tableCellTitles[1][index],
                                              //    style: _titleTextStyle,
                                            ),
                                            SizedBox(height: 5),
                                            Text(
                                              tableCellValues[1][index]
                                                  .toString(),
                                              style: TextStyle(
                                                  fontFamily: 'Roboto',
                                                  fontSize: 13,
                                                  color: Color(0xFFe58338),
                                                  fontWeight: FontWeight.w600),

                                              ///   style: _dataTextStyle,
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              })
                            ],
                          ),
                        ]))),
              ),
              SizedBox(
                height: 0.0,
              ),
              // Container(
              //   width: screenWidth,
              //   height: screenHeight / 2.5,
              //   padding: EdgeInsets.all(10),
              // child:
              // Expanded(
              //   child:
              Container(
                width: screenWidth,
                //   height: screenHeight / 2,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount:
                      3, // Change this to the number of static items you want
                  itemBuilder: (context, index) {
                    List<String> staticPartyNames = [
                      'Calibrage info System pvt ltd',
                      'AMC Enterprisese',
                      'In rthym solutions',
                      'Isha Enterprise',
                      'Manya Enterprise',
                      'Sudha rani Enterprise',
                      // Add more names as needed
                    ];

                    List<String> staticdates = [
                      '9-12-2023',
                      '8-01-2023',
                      '8-05-2023',
                      '8-08-2023',
                      '8-10-2023',
                      '8-01-2023',
                      // Add more names as needed
                    ];
                    List<String> lrdates = [
                      '9-2-2023',
                      '8-09-2023',
                      '8-06-2023',
                      '8-02-2023',
                      '8-11-2023',
                      '8-5-2023',
                      // Add more names as needed
                    ];

                    List<String> status = [
                      'Pending',
                      'Shipped',
                      'Delivered',
                      'Partially Shipped',
                      'Rejected',
                      'Pending',
                      // Add more names as needed
                    ];

                    List<String> paymode = [
                      'Online',
                      'Cheque',
                      'UPI',
                      'Cheque',
                      'Cheque',
                      'Online',
                      // Add more names as needed
                    ];
                    List<String> staticOrderIds = [
                      '638468486486486',
                      '123456789',
                      '987654321',
                      '4586842684',
                      '65432154846',
                      '9367468476',

                      // Add more order IDs as needed
                    ];
                    List<String> bookingplace = [
                      'Hyderabad',
                      'chennai',
                      'Pune',
                      'Banglore',
                      'Goa',
                      'Ayyodha',

                      // Add more order IDs as needed
                    ];
                    List<String> transportplace = [
                      'Road',
                      'Road',
                      'Road',
                      'Fly',
                      'Fly',
                      'Train',

                      // Add more order IDs as needed
                    ];
                    List<double> staticprice = [
                      550.0,
                      858.0,
                      415.0,
                      104.0,
                      476.3,
                      5295.2
                    ];
                    List<int> lrnumber = [62, 81, 48, 10, 46, 52];
                    List<int> staticNumberOfItems = [6, 8, 4, 10, 47, 52];

                    //// Use the static names based on the index
                    String partyName =
                        staticPartyNames[index % staticPartyNames.length];
                    String orderId =
                        staticOrderIds[index % staticOrderIds.length];
                    int numberOfItems =
                        staticNumberOfItems[index % staticNumberOfItems.length];
                    int lrnum = lrnumber[index % staticNumberOfItems.length];
                    String fromatteddates =
                        staticdates[index % staticNumberOfItems.length];
                    String statusnames =
                        status[index % staticNumberOfItems.length];
                    String booking =
                        bookingplace[index % staticNumberOfItems.length];
                    String transport =
                        transportplace[index % staticNumberOfItems.length];
                    double price =
                        staticprice[index % staticNumberOfItems.length];

                    String lr_dates =
                        lrdates[index % staticNumberOfItems.length];
                    String paymentmode =
                        paymode[index % staticNumberOfItems.length];

                    return GestureDetector(
                      onTap: () {
                        // Navigator.of(context)
                        //     .pushNamed('/statusScreen', arguments: widget.listResult);
                        // Navigator.of(context).push(
                        //   MaterialPageRoute(
                        //     builder: (context) => ViewCollectionCheckOut(
                        //       //
                        //       listResult: widget.listResult,
                        //       position: widget.index, // Assuming you have the index available
                        //     ),
                        //   ),
                        // );
                      },
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        color: Colors.transparent,
                        child: Card(
                          elevation: 5,
                          color: Colors.white,
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            //   width: double.infinity,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white),

                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  // height: 70,
                                  // width: double.infinity,
                                  // margin: const EdgeInsets.only(bottom: 12),
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Row(
                                    children: [
                                      // starting icon of card

                                      // beside info
                                      Container(
                                        //height: 90,
                                        // width: ,
                                        width:
                                            MediaQuery.of(context).size.width /
                                                1.8,
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 10, top: 0, bottom: 0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                '${partyName}',
                                                style: TextStyle(
                                                    fontFamily: 'Roboto',
                                                    fontSize: 12,
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.bold),
                                                softWrap: true,
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              SizedBox(
                                                height: 5.0,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Container(
                                                    child: Row(
                                                      children: [
                                                        Text(
                                                          'Order id :',
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  'Roboto',
                                                              fontSize: 12,
                                                              color:
                                                                  Colors.black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400),
                                                        ),
                                                        Text(
                                                          ' $orderId',
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  'Roboto',
                                                              fontSize: 13,
                                                              color:
                                                                  Colors.black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
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
                                                      '₹$price',
                                                      style: TextStyle(
                                                          fontFamily: 'Roboto',
                                                          fontSize: 16,
                                                          color:
                                                              Color(0xFFe58338),
                                                          fontWeight:
                                                              FontWeight.w600),
                                                    ),
                                                    SizedBox(
                                                      width: 15.0,
                                                    ),
                                                    Text(
                                                      '₹500',
                                                      style: TextStyle(
                                                        color:
                                                            Color(0xFFa6a6a6),
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 13.0,
                                                        decoration:
                                                            TextDecoration
                                                                .lineThrough,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
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
              //     ),
              //    ),
              SizedBox(
                height: 5.0,
              ),
              Container(
                  width: screenWidth,
                  padding: EdgeInsets.only(top: 0.0, left: 10.0, right: 10.0),
                  child: IntrinsicHeight(
                      child: Card(
                    color: Colors.white,
                    child: Container(
                      padding: EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                      ),
                      width: screenWidth,
                      child: Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                padding: EdgeInsets.only(top: 0.0),
                                child: Text(
                                  'Total',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16.0,
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
                                    padding: EdgeInsets.only(top: 0.0),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text(
                                          '₹5550.0',
                                          style: TextStyle(
                                            color: Color(0xFFe78337),
                                            fontFamily: 'Roboto',
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16.0,
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
            ])));
  }
}
