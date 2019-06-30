import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gas Calculator',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Gas Calculator'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool gasChecker = false;
  bool alcChecker = false;
  double _result = 0;
  String gasPrice;
  String alcPrice;

  void _calculateBestPrice() {
      alcPrice = alcPrice.replaceAll(',', '.');
      gasPrice = gasPrice.replaceAll(',', '.');

      _result = double.parse(alcPrice) / double.parse(gasPrice);
      var cheaper = 'Alcohol';
      if (_result > 0.7) {
        cheaper = 'Gasoline';
      }
      _showingResolt('The cheaper is:', cheaper);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Insert the Price of Gas:',
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50.0, vertical:20.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: "R\$",
                ),
                keyboardType: TextInputType.numberWithOptions(signed: false, decimal: true),
                onChanged: (value){
                  this.gasPrice = value;
                  setState(() {
                     gasChecker = _isValid(value);
                  });
                },
              ),
            ),
            Text(
              'Insert the Price of Alcohol:',
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50.0, vertical:20.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: "R\$",
                ),
                keyboardType: TextInputType.numberWithOptions(signed: false, decimal: true),
                onChanged: (value){
                  this.alcPrice = value;
                  setState(() {
                    alcChecker = _isValid(value);
                  });
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: gasChecker && alcChecker ? Colors.blue : Colors.grey,
        onPressed: gasChecker && alcChecker ? _calculateBestPrice : null,
        tooltip: 'Calculate',
        child: Icon(Icons.local_gas_station),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  bool _isValid(String value){
    return value != null && value.isNotEmpty;
  }

  Future<void> _showingResolt(String title, String description) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(description),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

}
