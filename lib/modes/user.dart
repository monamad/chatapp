class Users {
  String name;
  String email;
  Users({required this.email, required this.name});

  Map<String, dynamic> usertomap() {
    return {
      'name': name,
      'email': email,
    };
  }

  factory Users.get(data) {
    return Users(email: data['email'], name: data['name']);
  }
}
