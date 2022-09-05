import 'package:calculadora/version2/bloc/calcu_bloc.dart';
import 'package:calculadora/version2/widgets/main_colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class ResultsLabel extends StatelessWidget {
  const ResultsLabel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CalcuBloc, CalcuState>(
        builder: (context, state){
          return Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                lista_info(),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    state.mathResult,
                    style: TextStyle(
                        fontSize: 55,
                        fontWeight: FontWeight.bold,
                        color: state.darker ? Colors.white : Colors.red),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '=',
                      style: TextStyle(
                          fontSize: 35,
                          color: state.darker? Colors.white:Colors.redAccent),
                    ),
                    Text(
                      state.stringOfNumbers,
                      style: TextStyle(
                          fontSize: 20,
                          color: state.darker? Colors.white:Colors.redAccent),
                    )
                  ],
                ),

              ],
            ),
          );
        }
    );
  }

  Widget lista_info(){

    return BlocBuilder<CalcuBloc, CalcuState>(
        builder: (context, state) {
          return SizedBox(
            height: 150,
            child: ListView.builder(
              itemCount: state.history.length,
              padding: EdgeInsets.all(8),
              reverse: true,

              itemBuilder: (BuildContext context, int index){
                return Container(
                  height: 25,
                  color: state.darker? colorDark: colorLight,
                  child:Align(
                      alignment: Alignment.topRight,
                      child: Text(state.history[index],style: TextStyle(color: state.darker? Colors.white:Colors.redAccent,))),

                );
              },
            ),
          );
        }
    );
  }
}
