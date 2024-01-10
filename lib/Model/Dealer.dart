

class Dealer {
  final String cardCode;
  final String cardName;
  final String address;
  final String fullAddress;

  Dealer({
    required this.cardCode,
    required this.cardName,
    required this.address,
    required this.fullAddress,
  });

  factory Dealer.fromJson(Map<String, dynamic> json) {
    return Dealer(
      cardCode: json['cardCode'] ?? '',
      cardName: json['cardName'] ?? '',
      address: json['address'] ?? '',
      fullAddress: json['fullAddress'] ?? '',
    );
  }
}
