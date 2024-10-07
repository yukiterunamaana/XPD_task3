import 'package:polynomist/term.dart';

List<Term> parse(String input) {
  List<Term> terms = [];
  List<String> parts = input.split(RegExp('[+-]'));
  print(parts);
  for (String part in parts) {
    part = part.trim();
    if (part.isEmpty) continue; // skip empty strings

    int coefficient = 1;
    if (input.startsWith('-') && parts.first == part) {
      coefficient = -1;
    } else if (part.startsWith('-')) {
      coefficient = -1;
      part = part.substring(1);
    }
    print(coefficient);

    String variable;
    int exponent;
    List<String> subparts = part.split('*');
    if (subparts.length == 1) {
      // no variable, just a coefficient
      coefficient *= int.parse(part);
      variable = '';
      exponent = 0;
    } else {
      coefficient *= int.parse(subparts[0]);
      int index = subparts[1].indexOf('^');
      if (index == -1) {
        variable = subparts[1];
        exponent = 1;
      } else {
        variable = subparts[1].substring(0, index);
        exponent = int.parse(subparts[1].substring(index + 1));
      }
    }
    Term t = Term(coefficient, variable, exponent);
    terms.add(t);
  }

  return terms;
}
