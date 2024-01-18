class Purpose {
  final String fldValue;
  final String descr;
  final String purposeName;

  Purpose({
    required this.fldValue,
    required this.descr,
    required this.purposeName,
  });

  factory Purpose.fromJson(Map<String, dynamic> json) {
    return Purpose(
      fldValue: json['fldValue'],
      descr: json['descr'],
      purposeName: json['purposeName'],
    );
  }
}
