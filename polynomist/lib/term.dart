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
}
