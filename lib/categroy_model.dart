class ItemGroup {
  final String itmsGrpCod;
  final String itmsGrpNam;
  final String itemClass;

  ItemGroup({
    required this.itmsGrpCod,
    required this.itmsGrpNam,
    required this.itemClass,
  });

  factory ItemGroup.fromJson(Map<String, dynamic> json) {
    return ItemGroup(
      itmsGrpCod: json['itmsGrpCod'],
      itmsGrpNam: json['itmsGrpNam'],
      itemClass: json['itemClass'],
    );
  }
}