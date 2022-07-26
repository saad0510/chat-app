String? validateName(String? value) {
  if (value == null || value.isEmpty) return "This field is required";
  return null;
}

String? validateEmail(String? value) {
  if (value == null || value.isEmpty) return "This field is required";
  if (value.isValidEmail() == false) return "Enter a valid email";
  return null;
}

String? validatePass(String? value) {
  if (value == null || value.isEmpty) return "This field is required";
  if (value.length < 6) return "Enter atleast 6 characters";
  return null;
}

extension EmailValidator on String {
  bool isValidEmail() {
    return RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$',
    ).hasMatch(this);
  }
}
