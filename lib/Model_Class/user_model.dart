import 'dart:convert';

///Response Model
class SuccessModel {
  int status;
  UserData data;
  String message;
  String userMsg;

  SuccessModel({this.status, this.data, this.message, this.userMsg});

  SuccessModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? new UserData.fromJson(json['data']) : null;
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

class UserData {
  int id;
  int roleId;
  String firstName;
  String lastName;
  String email;
  String username;
  String profilePic;
  String countryId;
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

  static Map<String, dynamic> toMap(UserData data) {
    return {'id': data.id, 'roleID': data.roleId, 'firstName': data.firstName, 'lastName': data.lastName,' email': data.email, 'username': data.username,
      'profilePic': data.profilePic,  'countryId': data.countryId, 'gender': data.gender, 'phoneNo': data.phoneNo,'dob': data.dob, 'isActive': data.isActive,
      'created': data.created,'modified': data.modified,'accessToken': data.accessToken};
  }




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

  static String encode(List<UserData> user) => json.encode(
    user.map<Map<String, dynamic>>((value) => UserData.toMap(value)).toList(),
  );

  static List<UserData> decode(String users) =>
      (json.decode(users) as List<dynamic>).map<UserData>((item) => UserData.fromJson(item)).toList();

}




// ///Success Model
// class SuccessModel {
//   SuccessModel({
//     this.message,
//     this.userMsg,
//   });
//
//   String message;
//   String userMsg;
//
//   factory SuccessModel.fromJson(Map<String, dynamic> json) => SuccessModel(
//     message: json["message"],
//     userMsg: json["user_msg"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "message": message,
//     "user_msg": userMsg,
//   };
// }




///Login Error Model
class ErrorModel {
  ErrorModel({
    this.message,
    this.userMsg,
  });

  String message;
  String userMsg;

  factory ErrorModel.fromJson(Map<String, dynamic> json) => ErrorModel(
    message: json[" message"],
    userMsg: json["user_msg"],
  );

  Map<String, dynamic> toJson() => {
    " message": message,
    "user_msg": userMsg,
  };
}





