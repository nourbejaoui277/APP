class SearchFilters {
  int? boutiqueId;
  int? categoryId;
  List<int>? sectionId; // changed from int? to List<int>?
  double? minPrice;
  double? maxPrice;
  String? searchWord;

  SearchFilters({
    this.boutiqueId,
    this.categoryId,
    this.sectionId,
    this.minPrice,
    this.maxPrice,
    this.searchWord,
  });

  factory SearchFilters.fromJson(Map<String, dynamic> json) {
    return SearchFilters(
      boutiqueId: json['boutiqueId'],
      categoryId: json['categoryId'],
      sectionId:
          (json['sectionId'] as List<dynamic>?)?.map((e) => e as int).toList(),
      minPrice: (json['minPrice'] as num?)?.toDouble(),
      maxPrice: (json['maxPrice'] as num?)?.toDouble(),
      searchWord: json['searchWord'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'boutiqueId': boutiqueId,
      'categoryId': categoryId,
      'sectionId': sectionId,
      'minPrice': minPrice,
      'maxPrice': maxPrice,
      'searchWord': searchWord,
    };
  }
}
