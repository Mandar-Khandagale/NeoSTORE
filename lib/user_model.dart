import 'dart:convert';

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
