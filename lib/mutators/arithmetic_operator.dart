import 'dart:math';

import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/standard_ast_factory.dart';
import 'package:analyzer/dart/ast/token.dart';
import 'package:analyzer/dart/ast/visitor.dart';


class ArithmeticOperatorMutator extends RecursiveAstVisitor<void> {
  final List<TokenType> _operators = [
    TokenType.PLUS,
    TokenType.MINUS,
    TokenType.SLASH,
    TokenType.STAR,
    TokenType.PERCENT
  ];

  T _getRandomElement<T>(List<T> list) {
      final random = Random();
      var i = random.nextInt(list.length);
      return list[i];
  }

  TokenType _chooseDifferentOperator(TokenType currentOperator) {
      var newOperator = _getRandomElement(_operators);

      if(newOperator == currentOperator) {
        return _chooseDifferentOperator(currentOperator);
      }

      return newOperator;
  }

  @override
  void visitBinaryExpression(BinaryExpression node) {
    print("Original Operation: ${node.leftOperand} ${node.operator} ${node.rightOperand}");
    if(_operators.contains(node.operator.type)) {
      final newOperator = Token(_chooseDifferentOperator(node.operator.type), node.operator.offset);
      node.operator = newOperator;
      print("New Operation: ${node.leftOperand} ${node.operator} ${node.rightOperand}");
    }
  }
}