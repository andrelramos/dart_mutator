import 'dart:io';

import 'package:dart_mutator/dart_mutator.dart';
import 'package:dart_mutator/mutators/arithmetic_operator.dart';
import 'package:file/memory.dart';
import 'package:test/test.dart';

const source = '''
void main() {
  print(1+2);
  var a=10;
  print(a/2);
  if ((10*2) == 20) print('ok');
  if ((a%2) == (10*0)) print('ok');
}
''';

final File sourceMemoryFile = MemoryFileSystem().file('test.dart')..writeAsString(source);

void main() {
  test('changing arithmetic operations', () async {
    final creator = MutantCreator(sourceMemoryFile, [ArithmeticOperatorMutator()]);
    final result = await creator.mutate();
    expect(result, "void main() {print(1 - 2); var a = 10; print(a * 2); if ((10 / 2) == 20) print(\'ok\'); if ((a * 2) == (10 / 0)) print(\'ok\');}");
  });
}