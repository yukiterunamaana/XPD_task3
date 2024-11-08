import 'package:polynomist/term.dart';
// import 'package:characters/characters.dart';

// List<Term> parse(String expression) {
//   List<Term> terms = [];
//   List<String> parts = expression.split(RegExp('[+-]'));

//   for (String part in parts) {
//     if (part.isEmpty) continue; // skip empty strings

//     int coefficient = 1;
//     String variable = '';
//     int exponent = 0;

//     if (part.contains('x')) {
//       List<String> variableParts = part.split(RegExp('[x\\^]'));

//       if (variableParts[0].isNotEmpty) {
//         coefficient = int.parse(variableParts[0]);
//       }

//       variable = 'x';

//       if (variableParts.length > 1 && variableParts[1].isNotEmpty) {
//         exponent = int.parse(variableParts[1]);
//       } else {
//         exponent = 1;
//       }
//     } else {
//       coefficient = int.parse(part);
//     }

//     terms.add(Term(coefficient, variable, exponent));
//   }

//   return terms;
// }

// List<Term> diff(List<Term> terms, String variable) {
//   List<Term> derivativeTerms = [];
//   for (Term term in terms) {
//     if (term.variable == variable) {
//       if (term.exponent > 0) {
//         int newCoefficient = term.coefficient * term.exponent;
//         int newExponent = term.exponent - 1;
//         derivativeTerms.add(Term(newCoefficient, term.variable, newExponent));
//       }
//     } else {
//       derivativeTerms.add(Term(0, '', 0));
//     }
//   }

//   return derivativeTerms;
// }

List<Term> diff(List<Term> terms, String variable) {
  List<Term> result = [];

  for (Term term in terms) {
    if (term.variable == variable) {
      // differentiate with respect to the variable
      int newCoefficient = term.coefficient * term.exponent;
      int newExponent = term.exponent - 1;
      if (newExponent > 0) {
        result.add(Term(newCoefficient, variable, newExponent));
      } else if (newExponent == 0) {
        result.add(Term(newCoefficient, '', 0)); // constant term
      }
    } else if (result.length == 0) {
      // variable is not present in the term, so derivative is 0
      result.add(Term(0, '', 0));
    }
  }

  return result;
}

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
