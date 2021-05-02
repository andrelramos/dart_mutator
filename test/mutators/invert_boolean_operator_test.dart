import 'dart:io';

import 'package:dart_mutator/dart_mutator.dart';
import 'package:file/memory.dart';
import 'package:test/test.dart';
import 'package:dart_mutator/mutators/invert_boolean_operator.dart';

const source = '''
void main() {
  // checking reality
  if (3 < 4) print('ok');
  if (3 < 4) print('ok');
  if (5 == 5) print('ok');
}
''';

final File sourceMemoryFile = MemoryFileSystem().file('test.dart')..writeAsString(source);

void main() {
  test('invert boolean operations', () async {
    final creator = MutantCreator(sourceMemoryFile, [InvertBooleanOperations()]);
    final result = await creator.mutate();
    expect(result, "void main() {if (!(3 < 4)) print('ok'); if (!(3 < 4)) print('ok'); if (!(5 == 5)) print('ok');}");
  });
}