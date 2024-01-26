class Memory {
  static const operations = ['%', '/', 'X', '-', '+', '='];
  final buffer = [0.0, 0.0];
  int bufferIndex = 0;
  String operation = "";
  String displayValue = '0';
  bool clickedOp = false;

  void applyCommand(String command) {
    if (command == "AC") {
      resetValues();
    } else if (operations.contains(command)) {
      _setOperation(command);
    } else {
      _addDigit(command); //só entra nos numerais e no ponto
    }
  }

  _setOperation(String newOp) {
    clickedOp = true;
    final isEqual = newOp == "=";

    if (bufferIndex == 0) {
      bufferIndex = 1;
      operation = newOp;
    } else {
      buffer[0] = calculate();
      buffer[1] = 0;
      operation = newOp;

      display(buffer[0]);
      
    }
    print(buffer);
  }

  calculate() {
    switch (operation) {
      case "%":
        return buffer[0] % buffer[1];
      case "/":
        return buffer[0] / buffer[1];
      case "X":
        return buffer[0] * buffer[1];
      case "-":
        return buffer[0] - buffer[1];
      case "+":
        return buffer[0] + buffer[1];
      default:
        return buffer[0];
    }
  }

  display(value){
    displayValue = value.toString();
      displayValue = displayValue.endsWith(".0")
          ? displayValue.split(".")[0]
          : displayValue;
  }

  _addDigit(String digit) {
    final isDot = digit == '.';
    final limpar = clickedOp || (displayValue == '0' && !isDot);

    if (isDot && displayValue.contains(".") && !limpar) {
      return;
    }

    final emptyValue = isDot ? '0' : '';
    final currentValue = limpar ? emptyValue : displayValue;
    displayValue = currentValue + digit;
    clickedOp = false;

    buffer[bufferIndex] = double.tryParse(displayValue) ?? 0;

    print(buffer);
  }

  void resetValues() {
    displayValue = "0";
    buffer.setAll(0, [0.0, 0.0]);
    bufferIndex = 0;
    clickedOp = false;
  }

  void getResult() {
    //value = eval();
  }
}
