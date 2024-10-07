import 'package:polynomist/term.dart';

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
    } else {
      // variable is not present in the term, so derivative is 0
      result.add(Term(0, '', 0));
    }
  }

  return result;
}
