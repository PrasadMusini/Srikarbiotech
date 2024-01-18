

class Dealer {
  final String cardCode;
  final String cardName;
  final String address;
  final String fullAddress;
  final String phoneNumber;
  final String state;
  final String proprietorName;
  final String gstRegnNo;

  Dealer({
    required this.cardCode,
    required this.cardName,
    required this.address,
    required this.fullAddress,
    required this.phoneNumber,
    required this.state,
    required this.proprietorName,
    required this.gstRegnNo,
  });

  factory Dealer.fromJson(Map<String, dynamic> json) {
    return Dealer(
      cardCode: json['cardCode'] ?? '',
      cardName: json['cardName'] ?? '',
      address: json['address'] ?? '',
      fullAddress: json['fullAddress'] ?? '',
      phoneNumber: json['phoneNumber'] ?? '',
      state: json['state'] ?? '',
      proprietorName: json['proprietorName'] ?? '',
      gstRegnNo: json['gstRegnNo'] ?? '',
    );
  }
}

