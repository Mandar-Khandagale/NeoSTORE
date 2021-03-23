class StoreLocatorModel {
  String storeName;
  String storeAddress;
  String storeDesc;
  double storeRating;
  String storeContact;
  String storeWebsite;
  String storeImage;
  String storeLatitude;
  String storeLongitude;

  StoreLocatorModel(
      {this.storeName,
        this.storeAddress,
        this.storeDesc,
        this.storeRating,
        this.storeContact,
        this.storeWebsite,
        this.storeImage,
        this.storeLatitude,
        this.storeLongitude});

  StoreLocatorModel.fromJson(Map<String, dynamic> json) {
    storeName = json['store_name'];
    storeAddress = json['store_address'];
    storeDesc = json['store_desc'];
    storeRating = json['store_rating'];
    storeContact = json['store_contact'];
    storeWebsite = json['store_website'];
    storeImage = json['store_image'];
    storeLatitude = json['store_latitude'];
    storeLongitude = json['store_longitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['store_name'] = this.storeName;
    data['store_address'] = this.storeAddress;
    data['store_desc'] = this.storeDesc;
    data['store_rating'] = this.storeRating;
    data['store_contact'] = this.storeContact;
    data['store_website'] = this.storeWebsite;
    data['store_image'] = this.storeImage;
    data['store_latitude'] = this.storeLatitude;
    data['store_longitude'] = this.storeLongitude;
    return data;
  }
}