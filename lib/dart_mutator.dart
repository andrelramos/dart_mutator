import 'dart:io';

import 'package:analyzer/dart/analysis/features.dart';
import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/analysis/utilities.dart';
import 'package:analyzer/dart/ast/ast.dart';

class MutantCreator {
  List<AstVisitor> mutators;
  File sourceCode;

  MutantCreator(this.sourceCode, this.mutators);

  Future<String> mutate() async {
    // Read the source code file
    final parsedSource = parseDartCode(await sourceCode.readAsString());

    // Add mutators on source code to generate the mutation code
    mutators.forEach((mutator) => parsedSource.unit.accept(mutator));

    // Return mutated
    return parsedSource.unit.toString();
  }

  ParseStringResult parseDartCode(String source) {
    // Parse String as a Dart code
    return parseString(
      content: source,
      featureSet: FeatureSet.latestLanguageVersion(),  // TODO get project dart sdk version
    );
  }

}