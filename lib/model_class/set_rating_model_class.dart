class SetRating {
  int status;
  Data data;
  String message;
  String userMsg;

  SetRating({this.status, this.data, this.message, this.userMsg});

  SetRating.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    message = json['message'];
    userMsg = json['user_msg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    data['message'] = this.message;
    data['user_msg'] = this.userMsg;
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
  double rating;
  int viewCount;
  String created;
  String modified;

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
        this.modified});

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
    return data;
  }
}