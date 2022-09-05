part of 'calcu_bloc.dart';

@immutable
abstract class CalcuEvent {}

class AddNumber extends CalcuEvent{
  final String character;
  AddNumber(this.character);
}

class DeleteLast extends CalcuEvent{}

class UpResult extends CalcuEvent{}

class ChangeBackground extends CalcuEvent{}

class DeleteCurrent extends CalcuEvent{}

class ChangeDark extends CalcuEvent{
  final bool dark;
  ChangeDark(this.dark);
}