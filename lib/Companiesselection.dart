import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'Common/CommonUtils.dart';
import 'LoginScreen.dart';
import 'Model/CompanyModel.dart';

class Companiesselection extends StatefulWidget {
  const Companiesselection({super.key});

  @override
  Companies_selection createState() => Companies_selection();
}

class Companies_selection extends State<Companiesselection> {
  bool _isLoading = false;
  List<CompanyModel> companiesList = [];
  List<CompanyModel> companies = [];
  final TextStyle _titleStyle = const TextStyle(
    fontSize: 26,
    fontFamily: "Roboto",
    fontWeight: FontWeight.w700,
  );
  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);
    CommonUtils.checkInternetConnectivity().then(
          (isConnected) {
        if (isConnected) {
          fetchGetCompaniesData();
          print('The Internet Is Connected');
        } else {
          print('The Internet Is not  Connected');
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // title
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 20,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Select a Company',
                        style: _titleStyle,
                      ),
                      Text(
                        'to Proceed',
                        style: _titleStyle,
                      ),
                    ],
                  ),
                ),
                // Display the fetched companies
                const SizedBox(
                  height: 50, // Adjust the space height as needed
                ),
                // Using ListView.builder to add space between cards
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: companies.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        CardForScreenOne(
                          cardIndex: companies[index].companyId - 1,
                          cardImage: '',
                          companyName: companies[index].companyName,
                          companyAddress: companies[index].companyAddress,
                          companyId: companies[index].companyId,
                        ),
                        const SizedBox(
                          height: 30, // Adjust the space height as needed
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void fetchGetCompaniesData() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final response = await http.get(
        Uri.parse(
            'http://182.18.157.215/Srikar_Biotech_Dev/API/api/Account/GetCompanies/null'),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);

        final List<dynamic> listResult = responseData['response']['listResult'];
        final List<CompanyModel> fetchedCompanies =
        listResult.map((data) => CompanyModel.fromJson(data)).toList();

        setState(() {
          companies = fetchedCompanies;
        });
      } else {
        throw Exception('Failed to load data from the API');
      }
    } catch (e) {
      print('Error fetching data: $e');
    } finally {}
  }
}

class CardForScreenOne extends StatelessWidget {
  final int cardIndex;
  final String cardImage;
  final String companyName;
  final String companyAddress;
  final int companyId;
  CardForScreenOne({
    Key? key,
    required this.cardIndex,
    required this.cardImage,
    required this.companyName,
    required this.companyAddress,
    required this.companyId,
  }) : super(key: key);

  final List cardColors = [
    [HexColor('#ffefdf'), HexColor('#d9fde3')],
    [HexColor('#dd803a'), HexColor('#118630')],
    ['assets/srikar_biotech_logo.svg', 'assets/srikar-seed.png'],
  ];

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => LoginScreen(
                companyName: companyName,
                companyId: companyId,
              ),
            ),
          );
        },
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 10),
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 30,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: cardIndex == 0 ? cardColors[0][0] : cardColors[0][1],
              ),
              child: Row(
                children: [
                  // content
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      // crossAxisAlignment: CrossAxisAlignment.center, // Center the content horizontally
                      children: [
                        Container(
                          alignment:
                          Alignment.center, // Center the text vertically
                          child: RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text:
                                  "${companyName.split(" ")[0]}\n", // First word
                                  style: TextStyle(
                                    fontSize: 28,
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.w700,
                                    color: cardIndex == 0
                                        ? cardColors[1][0]
                                        : cardColors[1][1],
                                  ),
                                ),
                                const TextSpan(text: ''),
                                TextSpan(
                                  text: companyName
                                      .split(" ")
                                      .sublist(1)
                                      .join(" "), // Remaining words
                                  style: TextStyle(
                                    fontSize: 35,
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.w700,
                                    color: cardIndex == 0
                                        ? cardColors[1][0]
                                        : cardColors[1][1],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // const SizedBox(
                  //   width: 10,
                  // ),
                  const Spacer(),
                  // image
                  Expanded(
                    child: Container(
                      height: 100,
                      alignment:
                      Alignment.center, // Center the image horizontally
                      child: cardIndex == 0
                          ? SvgPicture.asset(cardColors[2][0])
                          : Image.asset(cardColors[2][1]),
                    ),
                  ),
                ],
              ),
            ),

            // card bottom space
          ],
        ));
  }
}
