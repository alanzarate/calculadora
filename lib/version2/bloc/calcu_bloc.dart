import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:calculadora/version2/model/numbers.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'calcu_event.dart';
part 'calcu_state.dart';

class CalcuBloc extends Bloc<CalcuEvent, CalcuState> {
  final Number _number;
  final Historial _historial;

  CalcuBloc(this._number, this._historial) : super(CalcuState(history: []));

  @override
  Stream<CalcuState> mapEventToState(
      CalcuEvent event,
      ) async* {
    if(event is AddNumber){
      yield* _addNum(event.character);
    }else if(event is DeleteLast){
      _number.deleteLastChar();
      await _number.stringGetIn(_number.strPart);
      await _number.operateAll();
      //yield state.copyWith(stringOfNumbers: _number.strPart, mathResult: _number.resultado, history: _historial.historyOpe, darker: state.darker) ;
      yield CalcuState(stringOfNumbers: _number.strPart, mathResult: _number.resultado, history: _historial.historyOpe, darker: state.darker);
    }else if(event is UpResult){
      _historial.historyOpe.insert(0,_number.strPart);
      _historial.historyOpe.insert(0,_number.resultado);
      _number.resultado = "0";
      _number.strPart = "0";
      _historial.result = _number.resultado;
      //yield state.copyWith(mathResult: "0", stringOfNumbers: "0", history: _historial.historyOpe, darker: state.darker);
      yield CalcuState(mathResult: "0", stringOfNumbers: "0", history: _historial.historyOpe, darker: state.darker);
    }else if(event is DeleteCurrent){
      _number.resultado = "0";
      _number.strPart = "0";
      yield CalcuState(stringOfNumbers: _number.strPart, mathResult: _number.resultado, history: _historial.historyOpe, darker: state.darker);
      //yield state.copyWith(stringOfNumbers: _number.strPart, mathResult: _number.resultado, history: _historial.historyOpe, darker: state.darker);
    }else if(event is ChangeDark){
      yield CalcuState(history: _historial.historyOpe, stringOfNumbers: _number.strPart, mathResult: _number.resultado, darker: event.dark);
      //yield state.copyWith(history: _historial.historyOpe, stringOfNumbers: _number.strPart, mathResult: _number.resultado, darker: event.dark);
    }
  }

  Stream<CalcuState> _addNum(String char) async*{
    await _number.verifyingStr(char);
    await _number.stringGetIn(_number.strPart);
    await _number.operateAll();

    //print('Calcu_bloc number: ${_number.resultado} ____ ${_number.strPart} ____${_number.numbers} ____' );

    //yield CalcuState(stringOfNumbers: _number.strPart, mathResult: _number.resultado, history: _historial.historyOpe);
    yield CalcuState(stringOfNumbers: _number.strPart, mathResult: _number.resultado, history: _historial.historyOpe, darker: state.darker);
  }
}
