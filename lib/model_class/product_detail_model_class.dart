class ProductDetails {
  int status;
  Data data;

  ProductDetails({this.status, this.data});

  ProductDetails.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class Data {
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
  List<ProductImages> productImages;

  Data(
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

  Data.fromJson(Map<String, dynamic> json) {
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
    if (json['product_images'] != null) {
      productImages = new List<ProductImages>();
      json['product_images'].forEach((v) {
        productImages.add(new ProductImages.fromJson(v));
      });
    }
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
    if (this.productImages != null) {
      data['product_images'] =
          this.productImages.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ProductImages {
  int id;
  int productId;
  String image;
  String created;
  String modified;

  ProductImages(
      {this.id, this.productId, this.image, this.created, this.modified});

  ProductImages.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['product_id'];
    image = json['image'];
    created = json['created'];
    modified = json['modified'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['product_id'] = this.productId;
    data['image'] = this.image;
    data['created'] = this.created;
    data['modified'] = this.modified;
    return data;
  }
}