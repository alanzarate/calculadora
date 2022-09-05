part of 'calcu_bloc.dart';


class CalcuState{
  final String mathResult;
  final String stringOfNumbers;
  List<String> history;
  final bool darker;

  CalcuState({this.mathResult = '0', this.stringOfNumbers = '0', required this.history, this.darker = true});

  CalcuState copyWith({String? mathResult, String? stringOfNumbers, List<String>? history, bool? darker}) =>
      CalcuState(mathResult: mathResult?? this.mathResult,
          stringOfNumbers: stringOfNumbers ?? this.stringOfNumbers,
          history: history ?? this.history,
          darker: darker ?? this.darker
      );

}