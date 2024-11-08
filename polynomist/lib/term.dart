class Term {
  final int coefficient;
  final String variable;
  final int exponent;

  Term(this.coefficient, this.variable, this.exponent);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Term &&
          runtimeType == other.runtimeType &&
          coefficient == other.coefficient &&
          variable == other.variable &&
          exponent == other.exponent;

  @override
  int get hashCode =>
      coefficient.hashCode ^ variable.hashCode ^ exponent.hashCode;

  @override
  String toString() {
    if (coefficient == 0) return '0';
    String term = '';

    if (coefficient == -1)
      term += '-';
    else if (coefficient != 1) term += coefficient.toString();

    if (variable.isNotEmpty) {
      if (coefficient != 1) term += '*';
      term += variable;
      if (exponent != 1) {
        term += '^$exponent';
      }
    } else
      term += '1';

    return term;
  }
}

String presentAnswer(List<Term> lt) {
  String res = '';
  for (Term t in lt) if (t.toString() != '0') res += t.toString();
  if (res == '') res = '0';
  return res;
}
