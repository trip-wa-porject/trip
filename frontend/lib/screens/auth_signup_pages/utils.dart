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

String? validateTaiwanId(String? id) {
  if (id == null || id.isEmpty) {
    return 'id is required';
  }
  RegExp idRegExp = RegExp(r"^[A-Z][1-2]\d{8}$");

  if (!idRegExp.hasMatch(id)) {
    return '需要有效的身分證';
  }

  int sum = 0;
  Map<String, int> idMap = {
    'A': 1,
    'B': 10,
    'C': 19,
    'D': 28,
    'E': 37,
    'F': 46,
    'G': 55,
    'H': 64,
    'I': 39,
    'J': 73,
    'K': 82,
    'L': 2,
    'M': 11,
    'N': 20,
    'O': 48,
    'P': 29,
    'Q': 38,
    'R': 47,
    'S': 56,
    'T': 65,
    'U': 74,
    'V': 83,
    'W': 21,
    'X': 3,
    'Y': 12,
    'Z': 30
  };

  int firstNumber = idMap[id.substring(0, 1)]!;
  sum += firstNumber ~/ 10 + (firstNumber % 10) * 9;

  for (int i = 1; i < id.length - 1; i++) {
    sum += int.parse(id[i]) * (9 - i);
  }

  int checkDigit = int.parse(id[id.length - 1]);
  sum += checkDigit;

  bool isTaiwanId = sum % 5 == 0;
  if (!isTaiwanId) return '需要有效身分證';
}
