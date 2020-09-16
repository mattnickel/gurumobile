

class LoggedInUser {
  int id;
  String email;
  String created_at;
  String updated_at;
  String first_name;
  String last_name;
  String roll;
  String authentication_token;

  LoggedInUser(
      {this.id,
        this.email,
        this.created_at,
        this.updated_at,
        this.first_name,
        this.last_name,
        this.roll,
        this.authentication_token});

  LoggedInUser.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    created_at = json['created_at'];
    updated_at = json['updated_at'];
    last_name = json['last_name'];
    roll = json['roll '];
    authentication_token = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['email'] = this.email;
    data['created_at'] = this.created_at;
    data['updated_at'] = this.updated_at;
    data['first_name'] = this.first_name;
    data['last_name'] = this.last_name;
    data['roll'] = this.roll;
    data['authentication_token'] = this.authentication_token;
    return data;
  }
}