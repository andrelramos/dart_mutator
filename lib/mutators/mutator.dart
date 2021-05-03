import 'package:analyzer/dart/ast/ast.dart';

abstract class Mutator {
  String name;
  AstVisitor visitor; // AstVisitor is the responsible for change the code AST and generate the mutant

  Mutator(this.name, this.visitor);
}