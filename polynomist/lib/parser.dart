import 'package:polynomist/term.dart';

List<Term> parse(String input) {
  String i = input.replaceAll('-', '+-');
  List<Term> terms = [];
  List<String> parts = i.split('+');
  print(parts);
  for (String part in parts) {
    part = part.trim();
    if (part.isEmpty) continue; // skip empty strings
    int coefficient = 0;
    String variable = part.replaceAll(RegExp(r'[0-9-^*]'), '');
    int power = 0;

    //print("var=${variable}");

    if (variable == '') {
      coefficient = int.parse(part);
      //print('coeff=${coefficient}');
    } //no variable, covers 0 ±C
    else {
      if (part.contains('*')) {
        coefficient = int.parse(part.split('*')[0]);
      } else if (part[0] == '-') {
        coefficient = -1;
      } else {
        coefficient = 1;
      }
      //print('coeff=${coefficient}');
      //variable and coeff, covers ±x ±C*x

      if (part.contains('^')) {
        power = int.parse(part.split('^')[1]);
      } else {
        power = 1;
      }
      //print('pwr=${power}');
      //variable and power, covers x^±C and by proxy ±x^±C ±C*x^±C
    }
    Term t = Term(coefficient, variable, power);
    terms.add(t);
  }
  return terms;
}
