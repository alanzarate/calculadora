import 'package:calculadora/version2/bloc/calcu_bloc.dart';
import 'package:calculadora/version2/widgets/labels_widget.dart';
import 'package:flutter/material.dart';
import 'package:calculadora/version2/widgets/main_colors.dart';
import 'package:calculadora/version2/widgets/container_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Calculator extends StatefulWidget {
  const Calculator({Key? key}) : super(key: key);

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String result = "123123";
  List<String> testList = ['1 ','2','3','asdasd','asdasd','asdasd','asdasd','asdasd','asdasd','asdasd','asdasd','asdasd','asdasd','asdasd','asdasd'];

  String str = "asdasd";
  bool darkMode = true;


  @override
  Widget build(BuildContext context) {
    final calcuBloc = BlocProvider.of<CalcuBloc>(context);

    return Scaffold(
      backgroundColor: darkMode ? colorDark : colorLight,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                  onTap: () {
                    setState(() {
                      darkMode ? darkMode = false : darkMode = true;

                    });
                    calcuBloc.add(ChangeDark(darkMode));

                  },
                  child: _switchMode()),
              ResultsLabel(),
              Container(
                child: Column(children: [
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     _buttonOval(title: 'op1'),
                  //     _buttonOval(title: 'op2'),
                  //     _buttonOval(title: 'op3'),
                  //     _buttonOval(title: 'op4')
                  //   ],
                  // ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buttonRounded(
                          title: 'C',
                          textColor:
                          darkMode ? Colors.green : Colors.redAccent,
                          onPressed: ()=> calcuBloc.add( DeleteCurrent() )),
                      _buttonRounded(title: '(',
                          onPressed: ()=> {} ),
                      _buttonRounded(title: ')',onPressed: ()=> {}),
                      _buttonRounded(
                          title: '/',
                          textColor: darkMode ? Colors.green : Colors.redAccent,
                          onPressed: ()=> calcuBloc.add( AddNumber('/')))
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buttonRounded(title: '7',onPressed: ()=>calcuBloc.add(AddNumber('7'))),
                      _buttonRounded(title: '8',onPressed: ()=>calcuBloc.add(AddNumber('8'))),
                      _buttonRounded(title: '9',onPressed: ()=>calcuBloc.add(AddNumber('9'))),
                      _buttonRounded(
                          title: 'x',
                          textColor: darkMode ? Colors.green : Colors.redAccent
                          ,onPressed: ()=>calcuBloc.add(AddNumber('x')))
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buttonRounded(title: '4',onPressed: ()=>calcuBloc.add(AddNumber('4')) ),
                      _buttonRounded(title: '5',onPressed: ()=>calcuBloc.add(AddNumber('5'))),
                      _buttonRounded(title: '6',onPressed: ()=>calcuBloc.add(AddNumber('6'))),
                      _buttonRounded(
                          title: '-',
                          textColor: darkMode ? Colors.green : Colors.redAccent
                          ,onPressed: ()=>calcuBloc.add(AddNumber('-')))
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buttonRounded(title: '1',onPressed: ()=>calcuBloc.add(AddNumber('1'))),
                      _buttonRounded(title: '2',onPressed: ()=>calcuBloc.add(AddNumber('2'))),
                      _buttonRounded(title: '3',onPressed: ()=>calcuBloc.add(AddNumber('3'))),
                      _buttonRounded(
                          title: '+',
                          textColor: darkMode ? Colors.green : Colors.redAccent
                          ,onPressed: ()=>calcuBloc.add(AddNumber('+')))
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buttonRounded(title: '0',onPressed: ()=>calcuBloc.add(AddNumber('0'))),
                      _buttonRounded(title: '.',onPressed: ()=>calcuBloc.add(AddNumber('.'))),
                      _buttonRounded(
                          icon: Icons.backspace_outlined,
                          iconColor:
                          darkMode ? Colors.green : Colors.redAccent
                          ,onPressed: ()=>calcuBloc.add(DeleteLast())),
                      _buttonRounded(
                          title: '=',
                          textColor: darkMode ? Colors.green : Colors.redAccent,
                          onPressed: ()=>calcuBloc.add(UpResult()))
                    ],
                  )
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }



  Widget _buttonRounded(
      {String? title,
        double padding = 5,
        IconData? icon,
        Color? iconColor,
        Color? textColor,
        required Function onPressed}) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: NeuContainer(

        darkMode: darkMode,
        borderRadius: BorderRadius.circular(40),
        padding: EdgeInsets.all(padding),
        child: TextButton(
          onPressed: ()=> onPressed(),
          child: Container(
            width: padding * 5,
            height: padding * 9,
            child: Center(
                child: title != null
                    ? Text(
                  '$title',
                  style: TextStyle(
                      color: textColor != null
                          ? textColor
                          : darkMode
                          ? Colors.white
                          : Colors.black,
                      fontSize: 30),
                )
                    : Icon(
                  icon,
                  color: iconColor,
                  size: 20,
                )),
          ),
        ),
      ),
    );
  }

  Widget _buttonOval({String? title, double padding = 17}) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: NeuContainer(
        darkMode: darkMode,
        borderRadius: BorderRadius.circular(50),

        padding:
        EdgeInsets.symmetric(horizontal: padding, vertical: padding / 2),
        child: Container(
          width: padding * 2,
          child: Center(
            child: Text(
              '$title',
              style: TextStyle(
                  color: darkMode ? Colors.white : Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }

  Widget _switchMode() {
    return NeuContainer(
      darkMode: darkMode,
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      borderRadius: BorderRadius.circular(40),
      child: Container(
        width: 70,
        child:
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Icon(
            Icons.wb_sunny,
            color: darkMode ? Colors.grey : Colors.redAccent,
          ),
          Icon(
            Icons.nightlight_round,
            color: darkMode ? Colors.green : Colors.grey,
          ),
        ]),
      ),
    );
  }



}
