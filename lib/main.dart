import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator',
      home: MyCalculator(title: 'Calculator'),
      debugShowCheckedModeBanner: false,
      // debugShowMaterialGrid: true,
    );
  }
}

class MyCalculator extends StatefulWidget {
  MyCalculator({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyCalculatorState createState() => _MyCalculatorState();
}

class _MyCalculatorState extends State<MyCalculator> {
  String finalOutput = "0";
  String currentValue = "0";
  double num1 = 0.0;
  double num2 = 0.0;
  String operand = "";

  void buttonPressed(String buttonText) {
    if (buttonText == "AC") {
      finalOutput = "0";
      currentValue = "0";
      num1 = 0.0;
      num2 = 0.0;
      operand = "";
    } else if(buttonText == "CLR") {
      if(currentValue.length > 1 && currentValue != "0")
        currentValue = currentValue.substring(0, currentValue.length - 1);
      else if(currentValue.length == 1)
        currentValue = "0";
    } else if(buttonText == "DIV" || buttonText == "MUL" || buttonText == "ADD" || buttonText == "SUB" || buttonText == "MOD") {
      num1 = double.parse(currentValue);
      operand = buttonText;
      currentValue = "0";
    } else if(buttonText == "."){
      if(currentValue.contains(".")) {
        print("Already contains dot(.)");
        return;
      } else {
        print("WTF");
        currentValue = currentValue + buttonText;
      }
    } else if(buttonText == "EQ") {
      num2 = double.parse(currentValue);
      if(operand == "ADD") {
        finalOutput = (num1 + num2).toString();
      } else if(operand == "SUB") {
        finalOutput = (num1 - num2).toString();
      } else if(operand == "MUL") {
        finalOutput = (num1 * num2).toString();
      } else if(operand == "DIV") {
        finalOutput = (num1 / num2).toString();
      } else if(operand == "MOD") {
        finalOutput = (num1 % num2).toString();
      }
      num1 = 0;
      num2 = 0;
      operand = "";
    } else {
      print(buttonText);
      setState(() {
        if(currentValue != "0")
          currentValue = currentValue + buttonText;
        else
          currentValue = buttonText;
      });
    }

    setState(() {
      finalOutput = finalOutput;
      currentValue = currentValue;
    });
  }

  Widget calButton(Widget _widget, {int flex = 1, String key}) {
    return Expanded(
      flex: flex,
      child: OutlineButton(
        key: Key(key),
        padding: EdgeInsets.all(28),
        onPressed: () {
          buttonPressed(key);
        },
        child: Container(
          height: 24,
          alignment: AlignmentDirectional.center,
          child: _widget,
        ),
      ),
    );
  }

  TextStyle _textStyle = TextStyle(fontSize: 24);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SafeArea(
        child: Container(
          child: Column(
            children: <Widget>[
              Container(
                alignment: Alignment.centerRight,
                padding: EdgeInsets.symmetric(vertical: 24, horizontal: 12),
                child: Text(
                  currentValue,
                  style: TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Expanded(
                child: Divider(),
              ),
              Expanded(
                child: 
                Container(
                  alignment: Alignment.centerRight,
                  padding: EdgeInsets.symmetric(vertical: 24, horizontal: 12),
                  child: Text(
                    finalOutput,
                    style: TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      calButton(Text("AC", style: _textStyle), key: "AC"),
                      calButton(Icon(Icons.backspace), key: "CLR"),
                      calButton(Text("%", style: _textStyle), key: "MOD"),
                      calButton(Text("/", style: _textStyle), key: "DIV"),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      calButton(Text("7", style: _textStyle), key: "7"),
                      calButton(Text("8", style: _textStyle), key: "8"),
                      calButton(Text("9", style: _textStyle), key: "9"),
                      calButton(Text("x", style: _textStyle), key: "MUL"),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      calButton(Text("4", style: _textStyle), key: "4"),
                      calButton(Text("5", style: _textStyle), key: "5"),
                      calButton(Text("6", style: _textStyle), key: "6"),
                      calButton(Text("-", style: _textStyle), key: "SUB"),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      calButton(Text("1", style: _textStyle), key: "1"),
                      calButton(Text("2", style: _textStyle), key: "2"),
                      calButton(Text("3", style: _textStyle), key: "3"),
                      calButton(Text("+", style: _textStyle), key: "ADD"),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      calButton(Text(".", style: _textStyle), key: "."),
                      calButton(Text("0", style: _textStyle), key: "0"),
                      calButton(Text("=", style: _textStyle), key: "EQ", flex: 2),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
