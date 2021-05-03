//
// Create temporary files to save mutants then run the tests
//

import 'dart:io';

import 'package:dart_mutator/mutators/mutator.dart';

class Sandbox {
  List<File> _sourceCode;
  Mutator _mutator;
  late final Directory sandboxDir;

  Sandbox(this._sourceCode, this._mutator) {
    sandboxDir = Directory(getMutatorSandboxPath());
  }

  void create() async {
    // Create sandbox temporary file
    if(!await sandboxDir.exists()) {
      sandboxDir.createTemp();
    }
  }

  String getMutatorSandboxPath() {
    final now = DateTime.now();
    return "${Directory.systemTemp}/${_mutator.name}_${now.toIso8601String()}";
  }
}