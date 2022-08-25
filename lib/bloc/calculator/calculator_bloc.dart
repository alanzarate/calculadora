import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'calculator_event.dart';
part 'calculator_state.dart';

class CalculatorBloc extends Bloc<CalculatorEvent, CalculatorState> {

  CalculatorBloc() : super(CalculatorState());

  final specialChars = {'x':2,'/':3, '+':5, '-':4};

  @override
  Stream<CalculatorState> mapEventToState(
    CalculatorEvent event,
  ) async* {


      if ( event is ResetAC ) {
        yield* this._resetAC();

      // Agregar números
      } else if ( event is AddNumber ) {
        yield* _addNewNumber(event.number);
        /*
        yield state.copyWith(
          mathResult: (state.mathResult == '0')
                        ? event.number
                        : state.mathResult + event.number,
        );

         */


      } else if ( event is ChangeNegativePositive ) {
        yield state.copyWith(
          mathResult:  state.mathResult.contains('-') 
                        ? state.mathResult.replaceFirst('-', '')
                        : '-' + state.mathResult
        );


      } else if ( event is DeleteLastEntry ) {

        yield state.copyWith(
          secondNumber: state.secondNumber.length > 1
                      ? state.secondNumber.substring(0, state.secondNumber.length - 1)
                      : '0',
          mathResult: state.secondNumber.length > 1 ?
                      _preResult(state.secondNumber.substring(0, state.secondNumber.length - 1), specialChars)
                    : '0',
        );


      } else if ( event is OperationEntry ) {

      } else if ( event is UpResult ) {
        print(state.mathResult + "-----"+ state.secondNumber);
        yield state.copyWith(

          mathResult: state.mathResult,
          secondNumber: (state.mathResult.endsWith('.0'))? state.mathResult.substring(0, state.mathResult.length - 2)
              : state.mathResult
        );
      }
  }


  Stream<CalculatorState> _resetAC() async* {
    yield CalculatorState(

          mathResult: '0',
          secondNumber: '0',

        );
  }

  Stream<CalculatorState> _calculateResult() async* {

    /*

    final double num1 = double.parse( state.firstNumber );
    final double num2 = double.parse( state.mathResult );

    switch( state.operation ) {

      case '+':
        yield state.copyWith(
          secondNumber: state.mathResult,
          mathResult: '${num1 + num2}'
        );
      break;


      default:
        yield state;
    }

     */
  }
  Stream<CalculatorState> _addNewNumber(String newChar) async*{
    String str = state.secondNumber;
    print(str);
    final specialChars = {'x':2,'/':3, '+':5, '-':4};
    String nStr = await _processingNewCharacter(str, newChar, specialChars);
    print(nStr);
    String pStr = await _preResult(nStr, specialChars);
    print('Aqui llego arriba$nStr abajo $pStr');
    yield CalculatorState(mathResult: pStr, secondNumber: nStr );
  }
  String _preResult(String str, Map<String, int>specialChars){
    List<double> numbers = [];
    List<int> signs = [];
    _refillList(str, numbers, signs,  specialChars);
    print('numbers $numbers , signs $signs');

    String ret = _toReturnResult(numbers,signs);
    return ret;
  }
  String _toReturnResult(List<double> numbers, List<int> signs){
    String res1 = "";

    if(numbers.length == 1){
      res1 = numbers[0].toString();

    }
    while(numbers.length >1){
      int min = signs.reduce( (current, next) => current < next ? current : next);

      for(int pos =0; pos < signs.length ; pos++){
        if(min == signs[pos]){
          String res2 = _operateResult(min, numbers[pos], numbers[pos+1]);
          print('To return result $res2');
          if(res2!= 'Error0'){
            numbers.removeAt(pos);
            numbers.removeAt(pos);
            numbers.insert(pos, double.parse(res2));
            signs.removeAt(pos);
            pos = signs.length + 1;

          }else{
            if(res2 == 'Error0'){
              res1 = "Division entre cero";
              numbers.clear();

              pos = signs.length + 1;
            }
          }
        }
      }
    }

    if(numbers.length>0){
      res1 = numbers[0].toString();

    }


    return res1;

  }
  String _operateResult(int ope, double num1, double num2){
    String res ="";
    switch(ope){
      case 2:{
        res = '${num1*num2}';
      }
      break;

      case 3:{
        if(num2 == 0){
          res = "Error0";
        }else{
          res = '${num1/num2}';
        }
      }
      break;

      case 4:{
        res = '${num1-num2}';

      }
      break;

      case 5:{
        res = '${num1+num2}';
      }
      break;
    }
    return res;
  }
  void _refillList(String str, List<double> numbers, List<int> signs, Map<String, int> specialChars){
    String aux = "";
    for(int x= 0 ; x<str.length; x++){
      if(specialChars[str[x]] ==  null){
        aux = aux + str[x];
      }else{
        signs.add(specialChars[str[x]]!);
        if(aux.length != 0){
          numbers.add(double.parse(aux));
          aux = "";
        }
      }
    }
    if(aux.length != 0){
      numbers.add(double.parse(aux));
    }
    if(str[0] == '-'){
      numbers.insert(0, 0);
    }
    if(numbers.length == signs.length  ){
      signs.removeLast();
    }
  }
  String _processingNewCharacter(String str, String newStr, Map<String,int> mapa){
    String lastChar = str[str.length-1];
    print('last char $lastChar');
    if(mapa[newStr] != null || newStr == "."){
      // es un signo
      print('es un signo');

      if(newStr == "."){
        // es un punto
        int position = str.length - 1;
        for(int x=str.length - 1; x >= 0 ; x--){
          if(mapa[str[x]] != null){
            position = x;
            x = -1;
          }
        }


        if(position == str.length-1){
          str = str +newStr;
        }else{
          String numberFounded = str.substring(position);

          if(!numberFounded.contains(".")){
            str = str + newStr;
          }
        }



      }else{
        if(mapa[lastChar] != null){

          // es un simbolo
          print('lenght str ${str.length}  and lastChar $lastChar');
          if(str.length == 1 && lastChar == '0'){
              str = '0';
          }else{
            if (str != null && str.length > 1) {
              str = str.substring(0, str.length - 1);

            }
            str = str + newStr;
          }

        } else{
          // el ultimo en un numero
          print('lenght str ${str.length}  and lastChar $lastChar str $str');
          if(str.length == 1 && str == '0'){
             if(newStr == "-"){
               str = newStr;
             }
          }else{
            str = str + newStr;
          }

        }
      }


    }else{
      // es un numero
      if(newStr == "0"){
        // caso que el nuevo sea cero
        if(lastChar !="0"){
          str = str + newStr;
        }else{
          if(str.length > 1){
            str = str + newStr;
          }
        }
      }else{
        if(lastChar == '0'){
          if(str.length > 1){
            str = str + newStr;
          }else{
            str = newStr;
          }

        }else{
          str = str + newStr;
        }

      }
    }
    return str;
  }
}
