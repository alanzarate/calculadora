part of 'calculator_bloc.dart';

class CalculatorState {
  
  final String mathResult;

  final String secondNumber;


  CalculatorState({
    this.mathResult = '0',

    this.secondNumber = '0',

  });

  CalculatorState copyWith({
    String? mathResult,

    String? secondNumber,

  }) => CalculatorState(
    mathResult  : mathResult ?? this.mathResult,

    secondNumber: secondNumber ?? this.secondNumber, 

  );


}

