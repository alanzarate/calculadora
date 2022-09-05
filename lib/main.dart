// FROM VERSION 1

// import 'package:calculadora/bloc/calculator/calculator_bloc.dart';
// import 'package:calculadora/screens/calculator_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
//
// void main() => runApp(AppState());
//
// class AppState extends StatelessWidget {
//
//   @override
//   Widget build(BuildContext context) {
//     return MultiBlocProvider(
//       providers: [
//         BlocProvider<CalculatorBloc>(create: ( _ ) => CalculatorBloc() )
//       ],
//       child: MyApp()
//     );
//   }
// }
//
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Material App',
//       home: CalculatorScreen(),
//       theme: ThemeData.dark().copyWith(
//         scaffoldBackgroundColor: Color(0xFF374352)
//       ),
//     );
//   }
// }


// FROM VERSION 2

import 'package:calculadora/version2/bloc/calcu_bloc.dart';
import 'package:calculadora/version2/model/numbers.dart';

import 'package:flutter/material.dart';
import 'package:calculadora/version2/pages/calculator_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CalcuBloc>(create: ( _ ) => CalcuBloc(Number(), Historial()),)
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Calculadora',
        home:  Calculator(),
      ),
    );
  }
}



