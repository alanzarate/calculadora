import 'dart:math';
const specialChars = {'x':2,'/':3, '+':5, '-':4};
const hierarchy = {'x':2,'/':2, '+':5, '-':5};

class Historial{
  List<String> historyOpe = [];
  String result = '';


}

class Number{
  List<double> numbers=[0];
  String resultado = "0";
  List<int> operations = [];
  List<int> hierarchyOper = [];
  String strPart = "0";



  Future<void> stringGetIn(String str) async{
    strPart = str;
    List<double> listNumbers = [];
    List<int> signs = [];
    List<int> signsHierarchy = [];

    bool firstIsNumber = true;

    String aux = "";
    for(int x= 0 ; x<str.length; x++){
      if(specialChars[str[x]] ==  null){
        aux = aux + str[x];
      }else{
        signs.add(specialChars[str[x]]!);
        signsHierarchy.add(hierarchy[str[x]]!);
        if(x == 0){
          firstIsNumber = false;
        }
        if(aux.isNotEmpty){
          if(aux == "."){
            aux = "0";
          }
          listNumbers.add(double.parse(aux));
          aux = "";
        }


      }
    }
    if(aux.isNotEmpty){
      if(aux == "."){
        aux = "0";
      }
      listNumbers.add(double.parse(aux));
    }

    if(firstIsNumber){
      signs.insert(0, specialChars['+']!);
      signsHierarchy.insert(0, hierarchy['+']!);
    }
    if(signs.length > listNumbers.length){
      signs.removeLast();
      signsHierarchy.removeLast();
    }

    // ya se tiene las listas con los signos

    numbers = List.from(numbers)..addAll(listNumbers);
    operations = signs;
    hierarchyOper = signsHierarchy;


    //print('Numbers.dart StrSingIn: $operations _____ $numbers _____ $hierarchyOper');

  }

  Future<void> operateAll()async {
    String res1 = '';
    String res2 = '';
    while(numbers.length > 1){
      if(hierarchyOper.isNotEmpty){
        int min  = hierarchyOper.reduce( (current, next) => current < next ? current : next);
        for(int i = 0; i < operations.length; i++){
          if(min == hierarchyOper[i]){

            String res1 = _operateTwoNumbers(operations[i], numbers[i], numbers[i+1]);
            if(res1 != 'Error0'){
              numbers.removeAt(i);
              numbers.removeAt(i);
              numbers.insert(i, double.parse(res1));
              operations.removeAt(i);
              hierarchyOper.removeAt(i);
              i = operations.length+1;
            }else if(res1 == 'Error0'){
              res2 = "Infinito";
              i = operations.length + 3;
              numbers.clear();
            }
          }
        }
      }
      //print('Numbers.dart OperateAll>> $operations _____ $numbers _____ $hierarchyOper');
    }
    if(res2.isEmpty){
      res1 = '${numbers[0]}';
      resultado= res1;

    }else{
      resultado= res2;

    }
    _clearInformation();


  }

  void _clearInformation(){
    numbers=[0];
    operations = [];
    hierarchyOper = [];
  }


  String _operateTwoNumbers(int ope, double num1, double num2){
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



  // para mostrar en la pantalla, reglas de doble signo etc
  Future<void> verifyingStr( String newStr)async {
    if(strPart.isNotEmpty){

      if(specialChars[newStr]== null && newStr !='.' ){
        // newStr es un numero

        if(newStr == "0"){

          String  aux = _lastnumbercomplete();
          if(aux.isNotEmpty){
            if(aux == "."){

            }else{
              if(double.parse(_lastnumbercomplete()) == 0){
                if(!_lastnumbercomplete().contains(".")){
                  newStr = "";
                }
              }
            }

          }

        }else{
          String aux1 = _lastnumbercomplete();
          if(aux1.isNotEmpty){
            if(strPart[0] == "0" && strPart.length==1){
              strPart = newStr;
              newStr = "";
            }else{
              if(double.parse(aux1) == 0){
                //newStr = "";
              }
            }

          }



        }


      }else{
        // newStr es un caracter o punto

        if(specialChars[strPart[strPart.length-1]] != null || strPart[strPart.length-1] == "." ){
          // lo ultimo es un punto o caracter

          if(specialChars[strPart[strPart.length-1]] != null ){
            // lo ultimo es un signo
            //print('aaa');

            if(newStr == "."){
              //print('es punto');
              newStr = ".";
            }else{

              if (strPart != null && strPart.isNotEmpty) {
                strPart = strPart.substring(0, strPart.length - 1);
              }

            }

          }else{
            // lo utlimo es un punto

            if(newStr =="."){
              newStr = "";
            }

          }




        }else{
          // la ultima cosa es un numero
          if(_lastnumbercomplete().contains('.')){
            if(newStr == "."){

              newStr = "";
            }
          }
        }



      }
    }else{
      if(specialChars[newStr]!= null){
        if(newStr!='-'){
          newStr = "";
        }
      }
    }

    strPart = strPart + newStr;

  }

  String _lastnumbercomplete(){
    int pos = 0;

    for(int x=  strPart.length-1; x >= 0; x--){
      if(specialChars[strPart[x]] != null){
        pos = x;
        x = -2;
      }
    }



    String  a = strPart.substring(pos+1, strPart.length);
    if(pos == 0){
      a = strPart.substring(pos, strPart.length);
    }


    //print('double $a');
    return a;
  }
  int _positionOfLastNumber(){
    int pos = 0;

    for(int x=  strPart.length-1; x >= 0; x--){
      if(specialChars[strPart[x]] != null){
        pos = x;
        x = -2;
      }
    }


    return pos;
  }

  void deleteLastChar(){
    if (strPart != null && strPart.length > 0) {
      strPart = strPart.substring(0, strPart.length - 1);
    }
  }


}