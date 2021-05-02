import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/standard_ast_factory.dart';
import 'package:analyzer/dart/ast/token.dart';
import 'package:analyzer/dart/ast/visitor.dart';


class InvertBooleanOperations extends RecursiveAstVisitor<void> {
  @override
  void visitIfStatement(IfStatement node) {
    final op = Token(TokenType.BANG, node.condition.offset);
    // ignore: deprecated_member_use
    node.condition = astFactory.prefixExpression(op, node.condition);
  }
}
