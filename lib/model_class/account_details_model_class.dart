class AccountInfoDetails {
  int status;
  Data data;

  AccountInfoDetails({this.status, this.data});

  AccountInfoDetails.fromJson(Map<String, dynamic> json) {
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
  UserData userData;
  List<ProductCategories> productCategories;
  int totalCarts;
  int totalOrders;

  Data(
      {this.userData,
        this.productCategories,
        this.totalCarts,
        this.totalOrders});

  Data.fromJson(Map<String, dynamic> json) {
    userData = json['user_data'] != null
        ? new UserData.fromJson(json['user_data'])
        : null;
    if (json['product_categories'] != null) {
      productCategories = new List<ProductCategories>();
      json['product_categories'].forEach((v) {
        productCategories.add(new ProductCategories.fromJson(v));
      });
    }
    totalCarts = json['total_carts'];
    totalOrders = json['total_orders'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.userData != null) {
      data['user_data'] = this.userData.toJson();
    }
    if (this.productCategories != null) {
      data['product_categories'] =
          this.productCategories.map((v) => v.toJson()).toList();
    }
    data['total_carts'] = this.totalCarts;
    data['total_orders'] = this.totalOrders;
    return data;
  }
}

class UserData {
  int id;
  int roleId;
  String firstName;
  String lastName;
  String email;
  String username;
  String profilePic;
  Null countryId;
  String gender;
  String phoneNo;
  String dob;
  bool isActive;
  String created;
  String modified;
  String accessToken;

  UserData(
      {this.id,
        this.roleId,
        this.firstName,
        this.lastName,
        this.email,
        this.username,
        this.profilePic,
        this.countryId,
        this.gender,
        this.phoneNo,
        this.dob,
        this.isActive,
        this.created,
        this.modified,
        this.accessToken});

  UserData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    roleId = json['role_id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    username = json['username'];
    profilePic = json['profile_pic'];
    countryId = json['country_id'];
    gender = json['gender'];
    phoneNo = json['phone_no'];
    dob = json['dob'];
    isActive = json['is_active'];
    created = json['created'];
    modified = json['modified'];
    accessToken = json['access_token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['role_id'] = this.roleId;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['email'] = this.email;
    data['username'] = this.username;
    data['profile_pic'] = this.profilePic;
    data['country_id'] = this.countryId;
    data['gender'] = this.gender;
    data['phone_no'] = this.phoneNo;
    data['dob'] = this.dob;
    data['is_active'] = this.isActive;
    data['created'] = this.created;
    data['modified'] = this.modified;
    data['access_token'] = this.accessToken;
    return data;
  }
}

class ProductCategories {
  int id;
  String name;
  String iconImage;
  String created;
  String modified;

  ProductCategories(
      {this.id, this.name, this.iconImage, this.created, this.modified});

  ProductCategories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    iconImage = json['icon_image'];
    created = json['created'];
    modified = json['modified'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['icon_image'] = this.iconImage;
    data['created'] = this.created;
    data['modified'] = this.modified;
    return data;
  }
}