class User {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String password;
  final String confirmPassword;

  User(this.id, this.email, this.password, this.confirmPassword, this.firstName,
      this.lastName);

  ///The following code has the purpose of JSON stringify the user object.
  User.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        email = json['email'],
        password = json['password'],
        confirmPassword = json['confirmPassword'],
        firstName = json['firstName'],
        lastName = json['lastName'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'email': email,
        'password': password,
        'confirmPassword': confirmPassword,
        'firstName': firstName,
        'lastName': lastName
      };
}