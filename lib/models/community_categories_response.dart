class CommunityCategoriesResponse {
  List<CommunityCategory>? categories;

  CommunityCategoriesResponse({this.categories});

  factory CommunityCategoriesResponse.fromJson(Map<String, dynamic> json) {
    List<dynamic>? categoriesData = json['data'];
    if (categoriesData == null) {
      return CommunityCategoriesResponse(categories: []);
    }

    List<CommunityCategory> categoriesList = categoriesData
        .map((categoryJson) => CommunityCategory.fromJson(categoryJson))
        .toList();

    return CommunityCategoriesResponse(categories: categoriesList);
  }
}

class CommunityCategory {
  String? id;
  String? name;
  String? imageUrl;

  CommunityCategory({this.id, this.name, this.imageUrl});

  factory CommunityCategory.fromJson(Map<String, dynamic> json) {
    return CommunityCategory(
      id: json['id']?.toString(),
      name: json['name'] as String?,
      imageUrl: json['imageUrl'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> categoryData = {
      'id': id,
      'name': name,
      'imageUrl': imageUrl,
    };
    return categoryData;
  }
}
