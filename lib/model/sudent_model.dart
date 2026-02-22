class StudentModel {
  String? name;
  String? email;
  String? phone;
  String? password;
  String? sex;
  StudentModel({this.name, this.email, this.phone, this.password, this.sex});

  StudentModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['password'] = this.password;
    data['sex'] = this.sex;
    return data;
  }
}
