class EditCartModel {
  int status;
  bool data;
  int totalCarts;
  String message;
  String userMsg;

  EditCartModel(
      {this.status, this.data, this.totalCarts, this.message, this.userMsg});

  EditCartModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'];
    totalCarts = json['total_carts'];
    message = json['message'];
    userMsg = json['user_msg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['data'] = this.data;
    data['total_carts'] = this.totalCarts;
    data['message'] = this.message;
    data['user_msg'] = this.userMsg;
    return data;
  }
}