class Purpose {
  final String tableID;
  final int fieldID;
  final int indexID;
  final String fldValue;
  final String descr;
  final String purposeName;

  Purpose({
    required this.tableID,
    required this.fieldID,
    required this.indexID,
    required this.fldValue,
    required this.descr,
    required this.purposeName,
  });

  factory Purpose.fromJson(Map<String, dynamic> json) {
    return Purpose(
      tableID: json['tableID'],
      fieldID: json['fieldID'],
      indexID: json['indexID'],
      fldValue: json['fldValue'],
      descr: json['descr'],
      purposeName: json['purposeName'],
    );
  }
}
