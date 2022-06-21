import 'dart:math';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:make_money_calculator/calculate_symbol.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late SharedPreferences sharedPreferences;
  CalculateSymbol? calculateSymbol;
  String showNumber = '0';
  double eachObjectSize = 0;
  List<double> numbers = [];
  bool needClear =false;
  String savedKey = "coin";
  String showCoin = 'tw';
  String lastButton = '';
  @override
  void initState() {
    super.initState();
    initSharePreferences();
  }

  Future initSharePreferences() async {
    sharedPreferences = await SharedPreferences.getInstance();
    var value = sharedPreferences.getString(savedKey);
    if(value != null) showCoin = value;
    setState((){
    });
  }
  Widget loadCoinImage(double size){
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: SizedBox(height:size*1.5,width:size*1.5,child: Image(image: AssetImage('images/$showCoin.png'))),
    );
  }
  @override
  Widget build(BuildContext context) {
    var topShowingViewHeight = MediaQuery.of(context).size.height / 3;
    var bottomShowingViewHeight =
        MediaQuery.of(context).size.height - topShowingViewHeight;
    eachObjectSize = bottomShowingViewHeight / 5;
    return Scaffold(
      body: DecoratedBox(
        decoration: const BoxDecoration(color: Colors.black),
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: topShowingViewHeight,
                width: MediaQuery.of(context).size.width,
                child: Stack(
                  children: [
                    Container(
                        alignment: Alignment.bottomRight,
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Text(
                            showNumber,
                            style:
                                const TextStyle(color: Colors.white, fontSize: 90),
                          ),
                        )),
                    loadCoinImage(eachObjectSize)
                  ],
                ),
              ),
              firstRowCalculate(),
              secondRowCalculate(),
              thirdRowCalculate(),
              fourthRowCalculate(),
              fifthRowCalculate()
            ],
          ),
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: _incrementCounter,
      //   tooltip: 'Increment',
      //   child: const Icon(Icons.add),
      // ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Widget firstRowCalculate() {
    return SizedBox(
      height: eachObjectSize,
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          eachButton(
              CalculateSymbol.AllClear.getName(), Colors.grey, Colors.black),
          eachButton(
              CalculateSymbol.Clear.getName(), Colors.grey, Colors.black),
          eachButton(
              CalculateSymbol.Setting.getName(), Colors.grey, Colors.black),
          eachButton(
              CalculateSymbol.Div.getName(), Colors.orange, Colors.white),
        ],
      ),
    );
  }

  Widget secondRowCalculate() {
    return SizedBox(
      height: eachObjectSize,
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          eachButton('7', Colors.grey, Colors.black),
          eachButton('8', Colors.grey, Colors.black),
          eachButton('9', Colors.grey, Colors.black),
          eachButton(CalculateSymbol.Multiplied.getName(), Colors.orange,
              Colors.white),
        ],
      ),
    );
  }

  Widget thirdRowCalculate() {
    return SizedBox(
      height: eachObjectSize,
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          eachButton('4', Colors.grey, Colors.black),
          eachButton('5', Colors.grey, Colors.black),
          eachButton('6', Colors.grey, Colors.black),
          eachButton(
              CalculateSymbol.Sub.getName(), Colors.orange, Colors.white),
        ],
      ),
    );
  }

  Widget fourthRowCalculate() {
    return SizedBox(
      height: eachObjectSize,
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          eachButton('1', Colors.grey, Colors.black),
          eachButton('2', Colors.grey, Colors.black),
          eachButton('3', Colors.grey, Colors.black),
          eachButton(
              CalculateSymbol.Add.getName(), Colors.orange, Colors.white),
        ],
      ),
    );
  }

  Widget fifthRowCalculate() {
    return SizedBox(
      height: eachObjectSize,
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          zeroButton('0', Colors.grey, Colors.black),
          eachButton('.', Colors.grey, Colors.black),
          eachButton(
              CalculateSymbol.Equal.getName(), Colors.orange, Colors.white),
        ],
      ),
    );
  }

  Widget zeroButton(String text, Color background, Color textColor) {
    return SizedBox(
      height: eachObjectSize - 20,
      width: eachObjectSize * 2 - 5,
      child: ElevatedButton(
        onPressed: () {
          buttonClicked(text);
        },
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(background),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
              side: BorderSide(color: background),
            ))),
        child: Text(
          text,
          style: TextStyle(color: textColor, fontSize: 40),
        ),
      ),
    );
  }

  Widget eachButton(String text, Color background, Color textColor) {
    var symbolPressed = text == calculateSymbol?.getName();
    return SizedBox(
      height: eachObjectSize - 20,
      width: eachObjectSize - 20,
      child: ElevatedButton(
        onPressed: () {
          buttonClicked(text);
        },
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(symbolPressed ? Colors.amberAccent :background),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
              side: BorderSide(color: symbolPressed ? Colors.amberAccent :background),
            ))),
        child: Text(
          text,
          style: TextStyle(color: textColor, fontSize: 40),
        ),
      ),
    );
  }

  bool isZero(String text) {
    return text == "0";
  }

  void updateShowNumber(String text) {
    setState(() {
      showNumber = text;
    });
  }
  void updateSymbol(CalculateSymbol? currentUpdateSymbol){
    logE("updateSymbol $currentUpdateSymbol");
    if(currentUpdateSymbol!=null && !currentUpdateSymbol.isCalculate()) {
      return;
    }
    setState(() {
      calculateSymbol = currentUpdateSymbol;
      if(showNumber != "0") numbers.add(double.parse(showNumber));
      needClear = true;
    });
  }
  bool isDot(String text) {
    return text == '.';
  }

  bool isNumber(String text) {
    try {
      int.parse(text);
      return true;
    } catch (e) {
      return false;
    }
  }
  void calculate(){
    if(numbers.isNotEmpty && calculateSymbol != null) {
      double firstNumber = numbers[0];
      double currentNumber = double.parse(showNumber);
      switch(calculateSymbol) {
        case CalculateSymbol.Add:
          double value = firstNumber + currentNumber;
          int intValue = value.toInt();
          if(intValue.toDouble() == value) {
            updateShowNumber('$intValue');
          } else {
            updateShowNumber('$value');
          }
          break;
        case CalculateSymbol.Sub:
          double value = firstNumber - currentNumber;
          int intValue = value.toInt();
          if(intValue.toDouble() == value) {
            updateShowNumber('$intValue');
          } else {
            updateShowNumber('$value');
          }
          break;
        case CalculateSymbol.Div:
          double value = firstNumber / currentNumber;
          int intValue = value.toInt();
          if(intValue.toDouble() == value) {
            updateShowNumber('$intValue');
          } else {
            updateShowNumber('$value');
          }
          break;
        case CalculateSymbol.Multiplied:
          double value = firstNumber * currentNumber;
          int intValue = value.toInt();
          if(intValue.toDouble() == value) {
            updateShowNumber('$intValue');
          } else {
            updateShowNumber('$value');
          }
          break;
        default:
          break;
      }
    }
    numbers.clear();
    updateSymbol(null);
  }
  bool isSymbol(String text){
    bool isSymbol = false;
    for (var element in CalculateSymbol.values) {
      if (element.getName() == text) isSymbol = true;
    }
    return isSymbol;
  }
  void changeShowCoin(String coinName){
    setState((){
      showCoin = coinName;
      sharedPreferences.setString(savedKey, coinName);
    });
  }
  void clickedOnSetting(){
    showDialog(context: context, builder: (context) {
      return AlertDialog(
        title: const Text("提示"),
        actions: <Widget>[
          TextButton(
            child: const Text("us"),
            onPressed: () {
              changeShowCoin('us');
              Navigator.of(context).pop();
            } ,
          ),
          TextButton(
            child: const Text("tw"),
            onPressed: (){
              changeShowCoin('tw');
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    });
  }
  void clearClicked(CalculateSymbol currentSymbol){
    switch(currentSymbol) {
      case CalculateSymbol.Clear:
        updateShowNumber('0');
        break;
      case CalculateSymbol.AllClear:
        numbers.clear();
        updateShowNumber('0');
        updateSymbol(null);
        break;
      default:
        break;
    }
  }
  void buttonClicked(String text) {
    logE('lastButton:$lastButton numbers:$numbers text:$text calculateSymbol:$calculateSymbol');
    if(needClear && !isSymbol(text)){
      showNumber = "0";
    }
    if (isSymbol(text)) {
      late CalculateSymbol currentSymbol;
      for (var element in CalculateSymbol.values) {
        if (element.getName() == text) {
          currentSymbol = element;
        }
      }
      if(currentSymbol == CalculateSymbol.Setting){
        clickedOnSetting();
        return;
      }
      if(calculateSymbol == null) {
        if(currentSymbol.isCalculate()) {
          updateSymbol(currentSymbol);
        } else {
          clearClicked(currentSymbol);
        }
      } else if(numbers.isNotEmpty) {
        //we have a number inside
        if(isSymbol(lastButton)) {
          if(currentSymbol == CalculateSymbol.AllClear || currentSymbol == CalculateSymbol.Clear){
            clearClicked(currentSymbol);
          } else{
            if(currentSymbol.isCalculate()) updateSymbol(currentSymbol);
          }
        } else {
          if(currentSymbol.isCalculate()) {
            calculate();
            if(currentSymbol != CalculateSymbol.Equal){
              updateSymbol(currentSymbol);
            }
          } else {
            clearClicked(currentSymbol);
          }
        }
      }
    } else {
      needClear = false;
      if (isDot(text)) {
        if (!showNumber.contains('.') && isZero(showNumber)) {
          //if contains remain the same string , nothing will happen
          updateShowNumber('$showNumber$text');
        }
      }
      if (isNumber(text)) {
        if (isZero(showNumber)) {
          updateShowNumber(text);
        } else {
          updateShowNumber('$showNumber$text');
        }
      }
    }
    lastButton = text;
  }

  void logE(String message){
    var logger = Logger();
    logger.e(message);
  }
}
