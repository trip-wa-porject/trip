String? validateInput(String? value) {
  if (value == null || value.isEmpty) {
    return 'This field is required';
  }
  return null;
}

String? validateEmail(String? value) {
  if (value == null || value.isEmpty) {
    return 'Email is required';
  }
  if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
    return 'Invalid email address';
  }
  return null;
}

String? validatePassword(String? value) {
  if (value == null || value.isEmpty) {
    return 'Password is required';
  }
  if (value.length < 8) {
    return 'Password must be at least 8 characters long';
  }
  return null;
}

String? validatePhoneNumber(String? value) {
  if (value == null || value.isEmpty) {
    return 'Phone number is required';
  }
  if (!RegExp(r'^\+?\d{9,15}$').hasMatch(value)) {
    return 'Invalid phone number';
  }
  return null;
}

String? validateDate(String? value) {
  if (value == null || value.isEmpty) {
    return 'Date is required';
  }
  try {
    DateTime.parse(value);
  } catch (e) {
    return 'Invalid date format';
  }
  return null;
}
