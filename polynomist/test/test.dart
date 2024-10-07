import 'package:polynomist/diff.dart';
import 'package:polynomist/parser.dart';
import 'package:polynomist/term.dart';
import 'package:test/test.dart';

void main() {
  test('diff x, x => 1', () {
    List<Term> terms = parse('x');
    List<Term> result = diff(terms, 'x');
    expect(result, [Term(1, '', 1)]);
  });

  test('diff x^2, x => 2x', () {
    List<Term> terms = parse('x^2');
    List<Term> result = diff(terms, 'x');
    expect(result, [Term(1, 'x', 2)]);
  });

  test('diff 2*x, x => 2', () {
    List<Term> terms = parse('2*x');
    List<Term> result = diff(terms, 'x');
    expect(result, [Term(2, '', 0)]);
  });

  test('diff x-2, x => 1', () {
    List<Term> terms = parse('x-2');
    List<Term> result = diff(terms, 'x');
    expect(result, [Term(1, '', 0)]);
  });

  test('diff 4*x-2, x => 4', () {
    List<Term> terms = parse('4*x-2');
    List<Term> result = diff(terms, 'x');
    expect(result, [Term(4, '', 0)]);
  });

  test('diff 4*x^3, x => 12*x^2', () {
    List<Term> terms = parse('4*x^3');
    List<Term> result = diff(terms, 'x');
    expect(result, [Term(12, 'x', 2)]);
  });

  test('diff 4*x^3, y => 0', () {
    List<Term> terms = parse('4*x^3');
    List<Term> result = diff(terms, 'y');
    expect(result, [Term(0, '', 0)]);
  });

  test('diff 4*x^3-x^2, x => 12*x^2 - 2*x', () {
    List<Term> terms = parse('4*x^3-x^2');
    List<Term> result = diff(terms, 'x');
    expect(result, [Term(12, 'x', 2), Term(-2, 'x', 1)]);
  });
}
