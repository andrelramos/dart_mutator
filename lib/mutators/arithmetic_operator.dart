import 'dart:math';

import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/token.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:dart_mutator/singleton.dart';


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
    if(_operators.contains(node.operator.type)) {
      final newOperator = Token(_chooseDifferentOperator(node.operator.type), node.operator.offset);
      LogHandlerSingleton().d('Change arithmetic operation from: ${node.leftOperand} ${node.operator} ${node.rightOperand} to ${node.leftOperand} $newOperator ${node.rightOperand}');
      // ignore: deprecated_member_use
      node.operator = newOperator;
    } else {
      // If the operation is in another token, visit the children and execute this visitor again.
      LogHandlerSingleton().d('Visiting children of operation ${node.leftOperand} ${node.operator} ${node.rightOperand}');
      node.visitChildren(this);
    }
  }
}