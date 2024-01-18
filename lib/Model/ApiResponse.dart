class ApiResponse {
  final bool isSuccess;
  final List<Item> listResult;

  ApiResponse({required this.isSuccess, required this.listResult});

  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    return ApiResponse(
      isSuccess: json['isSuccess'] ?? false,
      listResult: (json['response']['listResult'] as List)
          .map((itemJson) => Item.fromJson(itemJson))
          .toList(),
    );
  }
}

class Item {
  final int id;
  final String date;
  final String partyCode;
  final String partyName;
  final String stateName;
  final int slpCode;
  final String salesPersonName;
  final String address;
  final String phoneNumber;
  final double amount;
  final int paymentType;
  final String paymentTypeName;
  final String purposeValue;
  final String purposeDesc;
  final String purposeName;
  final String checkNumber;
  final String checkDate;
  final String checkIssuedBank;
  final String fileName;
  final String fileLocation;
  final String fileExtension;
  final String fileUrl;
  final String statusName;
  final bool isActive;
  final String createdBy;
  final String createdDate;
  final String updatedBy;
  final String updatedDate;

  Item({
    required this.id,
    required this.date,
    required this.partyCode,
    required this.partyName,
    required this.stateName,
    required this.slpCode,
    required this.salesPersonName,
    required this.address,
    required this.phoneNumber,
    required this.amount,
    required this.paymentType,
    required this.paymentTypeName,
    required this.purposeValue,
    required this.purposeDesc,
    required this.purposeName,
    required this.checkNumber,
    required this.checkDate,
    required this.checkIssuedBank,
    required this.fileName,
    required this.fileLocation,
    required this.fileExtension,
    required this.fileUrl,
    required this.statusName,
    required this.isActive,
    required this.createdBy,
    required this.createdDate,
    required this.updatedBy,
    required this.updatedDate,
  });

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      id: json['id'] ?? 0,
      date: json['date'] ?? "",
      partyCode: json['partyCode'] ?? "",
      partyName: json['partyName'] ?? "",
      stateName: json['stateName'] ?? "",
      slpCode: json['slpCode'] ?? 0,
      salesPersonName: json['salesPersonName'] ?? "",
      address: json['address'] ?? "",
      phoneNumber: json['phoneNumber'] ?? "",
      amount: json['amount'] ?? 0.0,
      paymentType: json['paymentType'] ?? 0,
      paymentTypeName: json['paymentTypeName'] ?? "",
      purposeValue: json['purposeValue'] ?? "",
      purposeDesc: json['purposeDesc'] ?? "",
      purposeName: json['purposeName'] ?? "",
      checkNumber: json['checkNumber'] ?? "",
      checkDate: json['checkDate'] ?? "",
      checkIssuedBank: json['checkIssuedBank'] ?? "",
      fileName: json['fileName'] ?? "",
      fileLocation: json['fileLocation'] ?? "",
      fileExtension: json['fileExtension'] ?? "",
      fileUrl: json['fileUrl'] ?? "",
      statusName: json['statusName'] ?? "",
      isActive: json['isActive'] ?? false,
      createdBy: json['createdBy'] ?? "",
      createdDate: json['createdDate'] ?? "",
      updatedBy: json['updatedBy'] ?? "",
      updatedDate: json['updatedDate'] ?? "",
    );
  }
}
