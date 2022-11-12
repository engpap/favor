extension EmailValidator on String {
  bool isValidEmail() {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }

  bool isWhitespace() => this.trim().isEmpty;

  bool isValidDouble() => double.tryParse(this) != null;

  bool isValidInt() => int.tryParse(this) != null;

  //TODO creare criteri per cui la password non è valida (tipo lunghezza, caratteri, ecc)
  bool isValidPassword() => this.isWhitespace();
}
