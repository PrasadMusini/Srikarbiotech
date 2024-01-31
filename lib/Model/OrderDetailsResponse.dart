class OrderDetailsResponse {
  Response response;
  bool isSuccess;
  int affectedRecords;
  String endUserMessage;
  dynamic links;
  List<dynamic> validationErrors;
  dynamic exception;

  OrderDetailsResponse({
    required this.response,
    required this.isSuccess,
    required this.affectedRecords,
    required this.endUserMessage,
    required this.links,
    required this.validationErrors,
    required this.exception,
  });

  factory OrderDetailsResponse.fromJson(Map<String, dynamic> json) {
    return OrderDetailsResponse(
      response: Response.fromJson(json['response']),
      isSuccess: json['isSuccess'],
      affectedRecords: json['affectedRecords'],
      endUserMessage: json['endUserMessage'],
      links: json['links'],
      validationErrors: json['validationErrors'],
      exception: json['exception'],
    );
  }
}

class Response {
  List<OrderDetailsResult> getOrderDetailsResult;

  Response({required this.getOrderDetailsResult});

  factory Response.fromJson(Map<String, dynamic> json) {
    return Response(
      getOrderDetailsResult: (json['getOrderDetailsResult'] as List)
          .map((data) => OrderDetailsResult.fromJson(data))
          .toList(),
    );
  }
}

class OrderDetailsResult {
  int id;
  int companyId;
  String orderNumber;
  String orderDate;
  String partyCode;
  String partyName;
  String partyAddress;
  String partyState;
  String partyPhoneNumber;
  String partyGSTNumber;
  String proprietorName;
  double partyOutStandingAmount;
  String bookingPlace;
  String transportName;
  int statusTypeId;
  String fileName;
  String fileLocation;
  String fileExtension;
  dynamic fileUrl;
  String statusName;
  double discount;
  double igst;
  double cgst;
  double sgst;
  double totalCost;
  int noOfItems;
  dynamic remarks;
  bool isActive;
  String createdBy;
  String createdDate;
  String updatedBy;
  String updatedDate;
  List<OrderItemXref> orderItemXrefList;

  OrderDetailsResult({
    required this.id,
    required this.companyId,
    required this.orderNumber,
    required this.orderDate,
    required this.partyCode,
    required this.partyName,
    required this.partyAddress,
    required this.partyState,
    required this.partyPhoneNumber,
    required this.partyGSTNumber,
    required this.proprietorName,
    required this.partyOutStandingAmount,
    required this.bookingPlace,
    required this.transportName,
    required this.statusTypeId,
    required this.fileName,
    required this.fileLocation,
    required this.fileExtension,
    required this.fileUrl,
    required this.statusName,
    required this.discount,
    required this.igst,
    required this.cgst,
    required this.sgst,
    required this.totalCost,
    required this.noOfItems,
    required this.remarks,
    required this.isActive,
    required this.createdBy,
    required this.createdDate,
    required this.updatedBy,
    required this.updatedDate,
    required this.orderItemXrefList,
  });

  factory OrderDetailsResult.fromJson(Map<String, dynamic> json) {
    return OrderDetailsResult(
      id: json['id'],
      companyId: json['companyId'],
      orderNumber: json['orderNumber'],
      orderDate: json['orderDate'],
      partyCode: json['partyCode'],
      partyName: json['partyName'],
      partyAddress: json['partyAddress'],
      partyState: json['partyState'],
      partyPhoneNumber: json['partyPhoneNumber'],
      partyGSTNumber: json['partyGSTNumber'],
      proprietorName: json['proprietorName'],
      partyOutStandingAmount: json['partyOutStandingAmount'],
      bookingPlace: json['bookingPlace'],
      transportName: json['transportName'],
      statusTypeId: json['statusTypeId'],
      fileName: json['fileName'],
      fileLocation: json['fileLocation'],
      fileExtension: json['fileExtension'],
      fileUrl: json['fileUrl'],
      statusName: json['statusName'],
      discount: json['discount'],
      igst: json['igst'],
      cgst: json['cgst'],
      sgst: json['sgst'],
      totalCost: json['totalCost'],
      noOfItems: json['noOfItems'],
      remarks: json['remarks'],
      isActive: json['isActive'],
      createdBy: json['createdBy'],
      createdDate: json['createdDate'],
      updatedBy: json['updatedBy'],
      updatedDate: json['updatedDate'],
      orderItemXrefList: (json['orderItemXrefList'] as List)
          .map((data) => OrderItemXref.fromJson(data))
          .toList(),
    );
  }
}

class OrderItemXref {
  int id;
  int orderId;
  String itemGrpCod;
  String itemGrpName;
  String itemCode;
  String itemName;
  String noOfPcs;
  int orderQty;
  double price;
  double igst;
  double cgst;
  double sgst;

  OrderItemXref({
    required this.id,
    required this.orderId,
    required this.itemGrpCod,
    required this.itemGrpName,
    required this.itemCode,
    required this.itemName,
    required this.noOfPcs,
    required this.orderQty,
    required this.price,
    required this.igst,
    required this.cgst,
    required this.sgst,
  });

  factory OrderItemXref.fromJson(Map<String, dynamic> json) {
    return OrderItemXref(
      id: json['id'],
      orderId: json['orderId'],
      itemGrpCod: json['itemGrpCod'],
      itemGrpName: json['itemGrpName'],
      itemCode: json['itemCode'],
      itemName: json['itemName'],
      noOfPcs: json['noOfPcs'],
      orderQty: json['orderQty'],
      price: json['price'],
      igst: json['igst'],
      cgst: json['cgst'],
      sgst: json['sgst'],
    );
  }
}
