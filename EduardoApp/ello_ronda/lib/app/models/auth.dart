class UserApp {
  int? id;
  String? isAdmin;
  String? userName;

  UserApp({required this.id, required this.isAdmin, this.userName});

  UserApp.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    isAdmin = json['isAdmin'];
    userName = json['userName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = {
      'id': id,
      'isAdmin': isAdmin,
      'userName': userName
    };

    return json;
  }
}

class AuthApp {
  UserApp? user;
  String? token;

  AuthApp({required this.user, required this.token});

  AuthApp.fromJson(Map<String, dynamic> json) {
    user = UserApp.fromJson(json['user']);
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = {'user': user?.toJson(), 'token': token};

    return json;
  }
}
