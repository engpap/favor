extension StringValidator on String {
  bool isValidEmail() {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }

  bool isWhitespace() => this.trim().isEmpty;

  bool isValidDouble() => double.tryParse(this) != null;

  bool isValidInt() => int.tryParse(this) != null;

  /// Check if the password is at least 8 characters long and contains
  /// at least one uppercase letter, one lowercase letter, and one digit.
  bool isValidPassword() =>
      (new RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d).{8,}$')).hasMatch(this);

  // true: if letters A-z, numbers 0-9, dot . or comma ,
  bool isValidName() {
    return RegExp(r'^[A-z.,\s0-9]+$').hasMatch(this);
  }

  // TODO: TO REMOVE, THERE IS SERVER DATA!
  // true: any number between 0 and 99
  bool isValidAge() {
    return RegExp(r'^([0-9]{1,2})$').hasMatch(this);
  }

  // TODO: TO REMOVE, THERE IS SERVER DATA!
  // true: if 'M', 'm', 'F' or 'f'
  bool isValidGender() {
    return RegExp(r'^[MmFf]$').hasMatch(this);
  }

  // TODO: TO REMOVE, THERE IS SERVER DATA!
  // true: if letters A-z, numbers 0-9, dot . or comma ,
  bool isValidResidence() {
    return RegExp(r'^[A-z.,\s0-9]+$').hasMatch(this);
  }

  // TODO: TO REMOVE, THERE IS SERVER DATA!
  // true: if string contains just letters
  bool isValidJob() {
    return RegExp(r'^[A-z]+$').hasMatch(this);
  }
}
