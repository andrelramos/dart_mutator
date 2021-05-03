import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/token.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:dart_mutator/mutators/mutator.dart';
import 'package:dart_mutator/singleton.dart';


class ArithmeticOperatorVisitor extends RecursiveAstVisitor<void> {
  final List<TokenType> _operators = [
    TokenType.PLUS,
    TokenType.MINUS,
    TokenType.SLASH,
    TokenType.STAR,
    TokenType.PERCENT
  ];

  final Map<TokenType, TokenType> _inverseOperators = {
    TokenType.PLUS: TokenType.MINUS,
    TokenType.MINUS: TokenType.PLUS,
    TokenType.SLASH: TokenType.STAR,
    TokenType.STAR: TokenType.SLASH,
    TokenType.PERCENT: TokenType.STAR
  };

  @override
  void visitBinaryExpression(BinaryExpression node) {
    if(_operators.contains(node.operator.type)) {
      final newOperator = Token(_inverseOperators[node.operator.type] ?? TokenType.PLUS, node.operator.offset);
      LogHandlerSingleton().d('Change arithmetic operation from: ${node.leftOperand} ${node.operator} ${node.rightOperand} to ${node.leftOperand} $newOperator ${node.rightOperand}');
      // ignore: deprecated_member_use
      node.operator = newOperator;
    } else {
      // If the operation is in another token, visit the children and execute this visitor again.
      LogHandlerSingleton().d('Visiting children of operation ${node.leftOperand} ${node.operator} ${node.rightOperand}');
      node.visitChildren(this);
    }
  }

  // TODO implement mutations for atribution arithmetic operations:
  // a+=1;
  // a-=1;
  // a*=2;
  // a%=2;
}

class ArithmeticOperatorMutator extends Mutator {
  ArithmeticOperatorMutator() : super('ArithmeticOperatorMutator', ArithmeticOperatorVisitor());
}