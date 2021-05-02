import 'dart:io';

import 'package:dart_mutator/mutators/arithmetic_operator.dart';
import 'package:dart_mutator/mutators/invert_boolean_operator.dart';


void main(List<String> arguments) {
  var file = File("/home/andrebrenda/dev/dart_mutator/bin/example.dart");

  var mutators = [
    InvertBooleanOperations(),
    //ArithmeticOperatorMutator()
  ];

}