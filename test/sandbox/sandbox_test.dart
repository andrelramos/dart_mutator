import 'dart:io';
import 'package:dart_mutator/mutators/arithmetic_operator.dart';
import 'package:dart_mutator/sandbox/sandbox.dart';
import 'package:test/test.dart';
import 'package:path/path.dart';

const mainSource = '''
  void main() {
    // checking reality
    if (3 < 4) print('ok');
    if (3 < 4) print('ok');
    if (5 == 5) print('ok');
  }
  ''';

const mainTestSource = '''
  import 'package:test/test.dart';

  void main() {
    test('generic test', () async {
      expect(true, true);
    });
  }
  ''';

void main() async {

  // Create a fake project directory
  final rootPath = Directory('${Directory.systemTemp.path}').createTempSync('sandbox_test');
  final srcPath = Directory('${rootPath.path}/src')..createSync();
  final testPath = Directory('${rootPath.path}/test')..createSync();

  final mainFile = File('${srcPath.path}/main.dart')
    ..createSync()
    ..writeAsStringSync(mainSource);

  final mainTestFile = File('${testPath.path}/main_test.dart')
    ..createSync()
    ..writeAsStringSync(mainTestSource);
  
  // Run tests
  test('creating sandbox environment', () async {
    var testSandbox = Sandbox(rootPath, ArithmeticOperatorMutator());
    await testSandbox.create();

    for(var sandboxPath in await testSandbox.sandboxDir.list().toList()) {
      var relativeSandboxPath = relative(sandboxPath.path, from: sandboxPath.parent.path);

      var projectPath = Directory(join(
        testSandbox.projectRoot.path, 
        relativeSandboxPath
      ));

      expect(true, await projectPath.exists());
      expect(true, await sandboxPath.exists());
    }
  });

  tearDownAll(() {
    // Delete root directory after tests run
    rootPath.deleteSync(recursive: true);
  });
}