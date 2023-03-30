bool isEmail(String em) {
  String p =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regExp = RegExp(p);

  return regExp.hasMatch(em);
}

isPassword(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter your password';
  }
  if (value.length < 8) {
    return 'Password must be atleast 8 characters';
  }
  RegExp regex =
      RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');

  if (!regex.hasMatch(value)) {
    return 'Enter valid password';
  }
  return null;
}

isPhoneNumber(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter your phone number';
  }
  if (value.length != 10) {
    return 'Phone number must be 10 digits';
  }
  // RegExp regex = RegExp(r'^[6-9]\d{9}$');

  // if (!regex.hasMatch(value)) {
  //   return 'Enter valid phone number';
  // }
  return null;
}

isTitle(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter a title';
  }
  return null;
}

isDescription(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter a description';
  }
  return null;
}

isRoom(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter a room number';
  }
  // regex such that room number is of the form A/B-1-1-1
  // RegExp regex = RegExp(r'^[A-Z]/[A-Z]-\d-\d-\d$');

  // if (!regex.hasMatch(value)) {
  //   return 'Enter valid room number';
  // }
  return null;
}
