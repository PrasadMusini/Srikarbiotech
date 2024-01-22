import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hexcolor/hexcolor.dart';

import 'HomeScreen.dart';

class ReturnOrderDetailsPage extends StatefulWidget {
  const ReturnOrderDetailsPage({super.key});

  @override
  State<ReturnOrderDetailsPage> createState() => _OrderDetailsPageState();
}

class _OrderDetailsPageState extends State<ReturnOrderDetailsPage> {
  final _orangeColor = HexColor('#e58338');

  final _titleTextStyle = const TextStyle(
    fontFamily: 'Roboto',
    fontWeight: FontWeight.w700,
    color: Colors.black,
    fontSize: 15,
  );
  final _dataTextStyle = const TextStyle(
    fontFamily: 'Roboto',
    fontWeight: FontWeight.w600,
    color: Color.fromARGB(255, 185, 105, 0),
    fontSize: 14,
  );

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
                  'Return Order Details',
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
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              Card(
                elevation: 5,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Party Details',
                        style: _titleTextStyle,
                      ),
                      Text(
                        'Priya Enterprises Pvt.Ltd',
                        style: _dataTextStyle,
                      ),
                      Text(
                        'PTX2383916',
                        style: _dataTextStyle,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Address',
                        style: _titleTextStyle,
                      ),
                      Text(
                        'xxxxxxxxxxxxxx',
                        style: _dataTextStyle,
                      ),
                    ],
                  ),
                ),
              ),

              // shipment details card
              const ShipmentDetailsCard(),

              // item card
              ListView(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                children: List.generate(
                  3,
                      (index) => const ItemCard(),
                ),
              ),

              const SizedBox(
                height: 20,
              ),

              // payment details card
              const PaymentDetailsCard(),
            ],
          ),
        ),
      ),
    );
  }
}

class ShipmentDetailsCard extends StatefulWidget {
  const ShipmentDetailsCard({super.key});

  @override
  State<ShipmentDetailsCard> createState() => _ShipmentDetailsCardState();
}

class _ShipmentDetailsCardState extends State<ShipmentDetailsCard> {
  final _orangeColor = HexColor('#e58338');

  final _titleTextStyle = const TextStyle(
    fontFamily: 'Roboto',
    fontWeight: FontWeight.w700,
    color: Colors.black,
    fontSize: 15,
  );

  final _dataTextStyle = TextStyle(
    fontFamily: 'Roboto',
    fontWeight: FontWeight.bold,
    color: HexColor('#e58338'),
    fontSize: 13,
  );

  final dividerForHorizontal = Container(
    width: double.infinity,
    height: 1,
    color: Colors.grey,
  );
  final dividerForVertical = Container(
    width: 1,
    height: 60,
    color: Colors.grey,
  );

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        width: double.infinity, // remove padding here
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // row one
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'LR Number',
                        style: _titleTextStyle,
                      ),
                      Text(
                        'IRTCP8932654',
                        style: _dataTextStyle,
                      ),
                    ],
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 243, 214, 175),
                      ),
                      padding: const EdgeInsets.symmetric(
                          vertical: 4, horizontal: 12),
                      child: Row(
                        children: [
                          // Icon(
                          //   Icons.shopify,
                          //   color: _orangeColor,
                          // ),
                          SvgPicture.asset(
                            'assets/shipping-fast.svg',
                            fit: BoxFit.fill,
                            width: 15,
                            height: 15,
                            color:_orangeColor ,

                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            'Shipped',
                            style: _dataTextStyle,
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),

            dividerForHorizontal,

            // row two
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'LR Date',
                          style: _titleTextStyle,
                        ),
                        Text(
                          'xx-xx-xxxx',
                          style: _dataTextStyle,
                        ),
                      ],
                    ),
                  ),
                ),
                dividerForVertical,
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Total',
                          style: _titleTextStyle,
                        ),
                        Text(
                          'xxxxxx',
                          style: _dataTextStyle,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            dividerForHorizontal,

            // row three
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Transport Mode',
                          style: _titleTextStyle,
                        ),
                        Text(
                          'Train',
                          style: _dataTextStyle,
                        ),
                      ],
                    ),
                  ),
                ),
                dividerForVertical,
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Transport Name',
                          style: _titleTextStyle,
                        ),
                        Text(
                          'Railway Parcel Service',
                          style: _dataTextStyle,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            dividerForHorizontal,

            // row four
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              child: Container(
                padding:
                const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.orange.shade100,
                  border: Border.all(
                    color: _orangeColor,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.link),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      'Attachment',
                      style: _titleTextStyle,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

// class ItemCard extends StatelessWidget {
//   const ItemCard({super.key});

//   final _titleTextStyle = const TextStyle(
//     fontFamily: 'Roboto',
//     fontWeight: FontWeight.w700,
//     color: Colors.black,
//     fontSize: 15,
//   );
//   final _dataTextStyle = const TextStyle(
//     fontFamily: 'Roboto',
//     fontWeight: FontWeight.w600,
//     color: Color.fromARGB(255, 185, 105, 0),
//     fontSize: 14,
//   );

//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//         itemCount: 1,
//         itemBuilder: (context, index) {
//           return ClipRRect(
//             borderRadius: BorderRadius.circular(25.0),
//             child: Card(
//               elevation: 5,
//               child: Container(
//                 color: Colors.white,
//                 width: double.infinity,
//                 padding: const EdgeInsets.all(12),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: <Widget>[
//                     Text(
//                       'Nuca-11 (Calcium 11% SC) - 1 Liter',
//                       style: _titleTextStyle,
//                     ),
//                     Row(
//                       children: [
//                         Text(
//                           'Qty: ',
//                           style: _titleTextStyle,
//                         ),
//                         Text(
//                           '12',
//                           style: _dataTextStyle,
//                         ),
//                       ],
//                     ),
//                     const SizedBox(
//                       height: 10,
//                     ),
//                     Row(
//                       children: [
//                         Text(
//                           '\$5475.00 ',
//                           style: _dataTextStyle,
//                         ),
//                         const SizedBox(
//                           width: 10,
//                         ),
//                         const Text(
//                           '\$8500.00 ',
//                           style: TextStyle(
//                             fontSize: 12,
//                             fontFamily: 'Roboto',
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           );
//         });
//   }
// }

class ItemCard extends StatelessWidget {
  const ItemCard({super.key});

  final _titleTextStyle = const TextStyle(
    fontFamily: 'Roboto',
    fontWeight: FontWeight.w700,
    color: Colors.black,
    fontSize: 15,
  );
  final _dataTextStyle = const TextStyle(
    fontFamily: 'Roboto',
    fontWeight: FontWeight.w600,
    color: Color.fromARGB(255, 185, 105, 0),
    fontSize: 14,
  );

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        width: double.infinity,
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Nuca-11 (Calcium 11% SC) - 1 Liter',
              style: _titleTextStyle,
            ),
            Row(
              children: [
                Text(
                  'Qty: ',
                  style: _titleTextStyle,
                ),
                Text(
                  '12',
                  style: _dataTextStyle,
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Text(
                  '\$5475.00 ',
                  style: _dataTextStyle,
                ),
                const SizedBox(
                  width: 10,
                ),
                const Text(
                  '\$8500.00 ',
                  style: TextStyle(
                    fontSize: 12,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class PaymentDetailsCard extends StatefulWidget {
  const PaymentDetailsCard({super.key});

  @override
  State<PaymentDetailsCard> createState() => _PaymentDetailsCardState();
}

class _PaymentDetailsCardState extends State<PaymentDetailsCard> {
  final _titleTextStyle = const TextStyle(
    fontFamily: 'Roboto',
    fontWeight: FontWeight.w700,
    color: Colors.black,
    fontSize: 15,
  );

  final _dataTextStyle = TextStyle(
    fontFamily: 'Roboto',
    fontWeight: FontWeight.bold,
    color: HexColor('#e58338'),
    fontSize: 13,
  );

  final dividerForHorizontal = Container(
    margin: const EdgeInsets.symmetric(vertical: 5),
    width: double.infinity,
    height: 1,
    color: Colors.grey,
  );

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        width: double.infinity, // remove padding here
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Total',
                    style: _titleTextStyle,
                  ),
                  Text(
                    'xxxxx',
                    style: _dataTextStyle,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}



// apply code in OrderDetailsPage