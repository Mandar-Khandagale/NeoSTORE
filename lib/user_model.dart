import 'dart:convert';

// ///Registration Model
// Register registerFromJson(String str) => Register.fromJson(json.decode(str));
// String registerToJson(Register data) => json.encode(data.toJson());
//
// class Register {
//   Register({
//     this.firstName,
//     this.lastName,
//     this.email,
//     this.password,
//     this.confirmPassword,
//     this.gender,
//     this.phoneNo,
//   });
//
//   String firstName;
//   String lastName;
//   String email;
//   String password;
//   String confirmPassword;
//   String gender;
//   String phoneNo;
//
//   factory Register.fromJson(Map<String, dynamic> json) => Register(
//     firstName: json["first_name"],
//     lastName: json["last_name"],
//     email: json["email"],
//     password: json["password"],
//     confirmPassword: json["confirm_password"],
//     gender: json["gender"],
//     phoneNo: json["phone_no"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "first_name": firstName,
//     "last_name": lastName,
//     "email": email,
//     "password": password,
//     "confirm_password": confirmPassword,
//     "gender": gender,
//     "phone_no": phoneNo,
//   };
// }


// ///Login Model:-
// Login loginFromJson(String str) => Login.fromJson(json.decode(str));
// String loginToJson(Login data) => json.encode(data.toJson());
//
// class Login {
//   Login({
//     this.email,
//     this.password,
//   });
//
//   String email;
//   String password;
//
//   factory Login.fromJson(Map<String, dynamic> json) => Login(
//     email: json["email"],
//     password: json["password"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "email": email,
//     "password": password,
//   };
// }

///Forget Model:-
Forget forgetFromJson(String str) => Forget.fromJson(json.decode(str));
String forgetToJson(Forget data) => json.encode(data.toJson());
class Forget {
  Forget({
    this.email,
  });
  String email;
  factory Forget.fromJson(Map<String, dynamic> json) => Forget(
    email: json["email"],
  );
  Map<String, dynamic> toJson() => {
    "email": email,
  };
}


///Register Success Model
class RegisterSuccess {
  RegisterSuccess({
    this.message,
    this.userMsg,
  });

  String message;
  String userMsg;

  factory RegisterSuccess.fromJson(Map<String, dynamic> json) => RegisterSuccess(
    message: json["message"],
    userMsg: json["user_msg"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "user_msg": userMsg,
  };
}

///Register Error Model
class RegisterError {
  RegisterError({
    this.data,
    this.message,
    this.userMsg,
  });

  Data data;
  String message;
  String userMsg;

  factory RegisterError.fromJson(Map<String, dynamic> json) => RegisterError(
    data: Data.fromJson(json["data"]),
    message: json["message"],
    userMsg: json["user_msg"],
  );

  Map<String, dynamic> toJson() => {
    "data": data.toJson(),
    "message": message,
    "user_msg": userMsg,
  };
}

class Data {
  Data({
    this.firstName,
    this.lastName,
    this.email,
    this.gender,
    this.phoneNo,
  });

  String firstName;
  String lastName;
  String email;
  String gender;
  int phoneNo;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    firstName: json[" first_name"],
    lastName: json[" last_name"],
    email: json["email"],
    gender: json["gender"],
    phoneNo: json[" phone_no"],
  );

  Map<String, dynamic> toJson() => {
    " first_name": firstName,
    " last_name": lastName,
    "email": email,
    "gender": gender,
    " phone_no": phoneNo,
  };
}




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

///Login Success Model
class SuccessModel {
  SuccessModel({
    this.message,
    this.userMsg,
  });

  String message;
  String userMsg;

  factory SuccessModel.fromJson(Map<String, dynamic> json) => SuccessModel(
    message: json["message"],
    userMsg: json["user_msg"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "user_msg": userMsg,
  };
}


///Forget Success Model
class ForgetSuccess {
  ForgetSuccess({
    this.message,
    this.userMsg,
  });

  String message;
  String userMsg;

  factory ForgetSuccess.fromJson(Map<String, dynamic> json) => ForgetSuccess(
    message: json["message"],
    userMsg: json["user_msg"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "user_msg": userMsg,
  };
}


///Forget Error Model
class ForgetError {
  ForgetError({
    this.message,
    this.userMsg,
  });

  String message;
  String userMsg;

  factory ForgetError.fromJson(Map<String, dynamic> json) => ForgetError(
    message: json["message"],
    userMsg: json["user_msg"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "user_msg": userMsg,
  };
}