

class CartProductItemData {
  int? id;
  String? slug;
  String? title;
  String? description;
  int? price;
  String? featuredImage;
  String? status;
  String? createdAt;

  CartProductItemData(
      {this.id,
        this.slug,
        this.title,
        this.description,
        this.price,
        this.featuredImage,
        this.status,
        this.createdAt});

  CartProductItemData copy({
    int? id,
    String? slug,
    String? title,
    String? description,
    int? price,
    String? featuredImage,
    String? status,
    String? createdAt,
  }) =>
      CartProductItemData(
        id: id ?? this.id,
        slug: slug ?? this.slug,
        title: title ?? this.title,
        description: description ?? this.description,
        price: price ?? this.price,
        featuredImage: featuredImage ?? this.featuredImage,
        status: status ?? this.status,
      );

  CartProductItemData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    slug = json['slug'];
    title = json['title'];
    description = json['description'];
    price = json['price'];
    featuredImage = json['featured_image'];
    status = json['status'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['slug'] = this.slug;
    data['title'] = this.title;
    data['description'] = this.description;
    data['price'] = this.price;
    data['featured_image'] = this.featuredImage;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    return data;
  }
}