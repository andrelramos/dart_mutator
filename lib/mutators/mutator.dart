import 'package:analyzer/dart/ast/ast.dart';

abstract class Mutator {
  String name;
  AstVisitor visitor;

  Mutator(this.name, this.visitor);
}