String? validateInput(String? value) {
  if (value == null || value.isEmpty) {
    return 'This field is required';
  }
  return null;
}

String? validateUserName(String? value) {
  if (value == null || value.isEmpty) {
    return '姓名為必填欄位';
  }
  if (!RegExp('[\\u4e00-\\u9fa5]+').hasMatch(value)) {
    return '請填寫中文';
  }
  return null;
}

String? validateEmail(String? value) {
  if (value == null || value.isEmpty) {
    return 'E-mail 信箱為必填欄位';
  }
  if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
    return '請填寫正確的 E-mail 信箱地址';
  }
  return null;
}

String? validatePassword(String? value) {
  if (value == null || value.isEmpty) {
    return '密碼是必填欄位';
  } else {
    if (!RegExp(r'(?=.*[a-z])(?=.*[A-Z])(?=.*?[0-9])\w+').hasMatch(value) || value.length < 8) {
      return '請填寫至少8個字，同時需要包含大小寫和數字';
    }
  }
  return null;
}

String? validatePhoneNumber(String? value) {
  if (value == null || value.isEmpty) {
    return '電話號碼為必填欄位';
  }

  //全為數字,09開頭
  if (!RegExp(r'^[09]{2}\d{8}$').hasMatch(value)) {
    return '請填寫正確的行動電話，10個數字';
  }
  return null;
}

String? validateDate(String? value) {
  if (value == null || value.isEmpty) {
    return '日期為必填欄位';
  }
  try {
    DateTime.parse(value);
  } catch (e) {
    return 'Invalid date format';
  }
  return null;
}

String? validateAddress(String? value) {
  if (value == null || value.isEmpty) {
    return '地址為必填欄位';
  }
  // if () {
  //   return '請填寫正確的地址格式';
  // }
  return null;
}

String? validateTaiwanId(String? id) {
  if (id == null || id.isEmpty) {
    return '身分證字號為必填欄位';
  }

  RegExp idRegExp = RegExp(r"^[A-Z][1-2]\d{8}$");
  //如果符合第一層格式
  if (idRegExp.hasMatch(id)) {
    //宣告一個陣列放入A~Z相對應數字的順序
    List<String> country = [
      "A",
      "B",
      "C",
      "D",
      "E",
      "F",
      "G",
      "H",
      "J",
      "K",
      "L",
      "M",
      "N",
      "P",
      "Q",
      "R",
      "S",
      "T",
      "U",
      "V",
      "X",
      "Y",
      "W",
      "Z",
      "I",
      "O"
    ];

    int eSum = 0, nSum = 0, count = 0;
    for (int index = 0; index < country.length; index++) {
      if (id.substring(0, 1) == country[index]) {
        index += 10; //A是從10開始編碼,每個英文的碼都跟index差異10,先加回來
        eSum = (((index % 10) * 9) + (index / 10)).toInt();
        //英文轉成的數字, 個位數(把數字/10取餘數)乘９再加上十位數
        //加上十位數(數字/10,因為是int,後面會直接捨去)
        break;
      }
    }

    for (int i = 1; i < 9; i++) { //從第二個數字開始跑,每個數字*相對應權重
      nSum += (int.parse(id[i])) * (9 - i);
    }
    count = 10 - ((eSum + nSum) % 10);//把上述的總和加起來,取餘數後,10-該餘數為檢查碼,要等於最後一個數字

    //判斷計算總和是不是等於檢查碼
    if (count != int.parse(id[9])) {
      return "身分證字號不存在，請正確填寫";
    }
  } else {
    return '請填寫正確的身分證字號，大寫英文和9個數字';
  }
}
