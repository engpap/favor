extension StringValidator on String {
  bool isValidEmail() {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }

  bool isWhitespace() => this.trim().isEmpty;

  bool isValidDouble() => double.tryParse(this) != null;

  bool isValidInt() => int.tryParse(this) != null;

  //TODO: creare criteri per cui la password non è valida (tipo lunghezza, caratteri, ecc)
  bool isValidPassword() => this.isWhitespace();

  // true: any number between 0 and 99
  bool isValidAge() {
    return RegExp(r'^([0-9]{1,2})$').hasMatch(this);
  }

  // true: if 'M', 'm', 'F' or 'f'
  bool isValidGender() {
    return RegExp(r'^[MmFf]$').hasMatch(this);
  }

  // true: if letters A-z, numbers 0-9, dot . or comma ,
  bool isValidResidence() {
    return RegExp(r'^[A-z.,\s0-9]+$').hasMatch(this);
  }

  // true: if string contains just letters
  bool isValidJob() {
    return RegExp(r'^[A-z]+$').hasMatch(this);
  }
}
