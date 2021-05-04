//
// Create temporary files to save mutants then run the tests
//

import 'dart:io';
import 'package:dart_mutator/singleton.dart';
import 'package:path/path.dart' as pathUtils;
import 'package:dart_mutator/mutators/mutator.dart';

class Sandbox {
  Directory projectRoot;
  Mutator mutator;
  late final Directory sandboxDir;

  Sandbox(this.projectRoot, this.mutator) {
    sandboxDir = Directory(getMutatorSandboxPath());
  }

  Future<void> create() async {
    // Create sandbox temporary file
    if(!await sandboxDir.exists()) {
      await sandboxDir.create(recursive: true);
    }

    // Copy project files to sandbox directory
    await _copyFiles(projectRoot, sandboxDir);
  }

  Future<void> _copyFiles(Directory from, Directory to) async {
    var files = await from.list().toList();

    for (var path in files) {
      // Get the path relative from sandbox directory
      var relativePath = pathUtils.join(
        to.path, pathUtils.relative(path.path, from: path.parent.path)
      );

      if(path is File) {
        LogHandlerSingleton().d('Copying file from ${path.path} to $relativePath');
        await path.copy(relativePath);
      } else if(path is Directory) {
        var sandboxRelativeDir = Directory(relativePath);

        // Create relative subfolder on sandbox directory
        if(!await sandboxRelativeDir.exists()) {
          LogHandlerSingleton().d('Creating subfolder ${sandboxRelativeDir.path}');
          await sandboxRelativeDir.create(recursive: true);
        }

        // Recursive call for copy files on subfolder
        await _copyFiles(path, sandboxRelativeDir);
      }
    }
  }

  String getMutatorSandboxPath() {
    final now = DateTime.now();
    return pathUtils.joinAll([Directory.systemTemp.path, now.toIso8601String(), mutator.name]);
  }
}