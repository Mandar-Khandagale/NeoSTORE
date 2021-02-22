import 'dart:convert';

///Registration Model
Register registerFromJson(String str) => Register.fromJson(json.decode(str));
String registerToJson(Register data) => json.encode(data.toJson());

class Register {
  Register({
    this.firstName,
    this.lastName,
    this.email,
    this.password,
    this.confirmPassword,
    this.gender,
    this.phoneNo,
  });

  String firstName;
  String lastName;
  String email;
  String password;
  String confirmPassword;
  String gender;
  String phoneNo;

  factory Register.fromJson(Map<String, dynamic> json) => Register(
    firstName: json["first_name"],
    lastName: json["last_name"],
    email: json["email"],
    password: json["password"],
    confirmPassword: json["confirm_password"],
    gender: json["gender"],
    phoneNo: json["phone_no"],
  );

  Map<String, dynamic> toJson() => {
    "first_name": firstName,
    "last_name": lastName,
    "email": email,
    "password": password,
    "confirm_password": confirmPassword,
    "gender": gender,
    "phone_no": phoneNo,
  };
}

///Login Model:-
Login loginFromJson(String str) => Login.fromJson(json.decode(str));
String loginToJson(Login data) => json.encode(data.toJson());

class Login {
  Login({
    this.email,
    this.password,
  });

  String email;
  String password;

  factory Login.fromJson(Map<String, dynamic> json) => Login(
    email: json["email"],
    password: json["password"],
  );

  Map<String, dynamic> toJson() => {
    "email": email,
    "password": password,
  };
}

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
