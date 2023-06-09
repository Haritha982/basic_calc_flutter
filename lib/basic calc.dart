import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class SimpleCalc extends StatefulWidget {
  const SimpleCalc({Key? key}) : super(key: key);

  @override
  State<SimpleCalc> createState() => _SimpleCalcState();
}

class _SimpleCalcState extends State<SimpleCalc> {
  TextEditingController num1=TextEditingController();
  TextEditingController op=TextEditingController();
  TextEditingController num2=TextEditingController();
  String ans = '';
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    double txt = MediaQuery.of(context).textScaleFactor;
    return SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            backgroundColor: Colors.teal,
            title: Text('Simple Calculator',
            style: TextStyle(
              color: Colors.white,
            ),),
            centerTitle: true,
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.all(10*txt),
                    width: w*0.35,
                    child: TextFormField(
                      cursorColor: Colors.teal,
                      controller: num1,
                      onChanged: (val){
                        setState(() {
                          num1.text=val;
                          num1.selection=TextSelection.fromPosition(TextPosition(offset: num1.text.length),);
                        });
                      },
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: 'First number',
                        hintStyle: TextStyle(
                          color: Colors.grey.shade400,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(10*txt),
                    width: w*0.25,
                    child: TextFormField(
                      cursorColor: Colors.teal,
                      controller: op,
                      onChanged: (val){
                        setState(() {
                          op.text=val;
                          op.selection=TextSelection.fromPosition(TextPosition(offset: op.text.length),);
                        });
                      },
                      decoration: InputDecoration(
                        hintText: '(+,-,etc)',
                        hintStyle: TextStyle(
                          color: Colors.grey.shade400,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(10*txt),
                    width: w*0.35,
                    child: TextFormField(
                      cursorColor: Colors.teal,
                      controller: num2,
                      onChanged: (val){
                        setState(() {
                          num2.text=val;
                          num2.selection=TextSelection.fromPosition(TextPosition(offset: num2.text.length),);
                        });
                      },
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: 'Second number',
                        hintStyle: TextStyle(
                          color: Colors.grey.shade400,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                width: double.infinity,
                height: h*0.4,
                child: Center(child: Text(
                  ans==''?'Your answer will be displyed here':ans,
                  style: TextStyle(
                    fontSize: ans==''?16*txt:25*txt,
                    color: ans==''?Colors.grey.shade400:Colors.teal,
                  ),
                ),),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: w*0.4,
                    height: h*0.08,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.teal,
                      ),
                      onPressed: (){
                        ans = calc();
                        setState(() {

                        });
                      },
                      child: Text('CALCULATE'),
                    ),
                  ),
                  Container(
                    width: w*0.4,
                    height: h*0.08,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.teal,
                      ),
                      onPressed: (){
                        ans = '';
                        num1.clear();
                        op.clear();
                        num2.clear();
                        setState(() {

                        });
                      },
                      child: Text('CLEAR'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    num1.dispose();
    num2.dispose();
    op.dispose();
    super.dispose();
  }

  String calc(){
    Parser p = Parser();
    Expression e = p.parse('${num1.text+op.text+num2.text}');
    ContextModel cm = ContextModel();
    num ans = e.evaluate(EvaluationType.REAL, cm);
    return ans.toString().length>10?ans.toStringAsPrecision(3):ans.toString();
  }
}
