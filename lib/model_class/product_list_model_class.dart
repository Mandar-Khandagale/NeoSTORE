class ProductList {
  int status;
  List<ProductData> data;

  ProductList({this.status, this.data});

  ProductList.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = new List<ProductData>();
      json['data'].forEach((v) {
        data.add(new ProductData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ProductData {
  int id;
  int productCategoryId;
  String name;
  String producer;
  String description;
  int cost;
  int rating;
  int viewCount;
  String created;
  String modified;
  String productImages;

  ProductData(
      {this.id,
        this.productCategoryId,
        this.name,
        this.producer,
        this.description,
        this.cost,
        this.rating,
        this.viewCount,
        this.created,
        this.modified,
        this.productImages});

  ProductData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productCategoryId = json['product_category_id'];
    name = json['name'];
    producer = json['producer'];
    description = json['description'];
    cost = json['cost'];
    rating = json['rating'];
    viewCount = json['view_count'];
    created = json['created'];
    modified = json['modified'];
    productImages = json['product_images'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['product_category_id'] = this.productCategoryId;
    data['name'] = this.name;
    data['producer'] = this.producer;
    data['description'] = this.description;
    data['cost'] = this.cost;
    data['rating'] = this.rating;
    data['view_count'] = this.viewCount;
    data['created'] = this.created;
    data['modified'] = this.modified;
    data['product_images'] = this.productImages;
    return data;
  }
}