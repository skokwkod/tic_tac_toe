import 'package:flutter/material.dart';
import 'package:tic_tac_toe/widgets/card_widget.dart';

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
      home: const TicTacToe(),
    );
  }
}

class TicTacToe extends StatefulWidget {
  const TicTacToe({Key? key}) : super(key: key);

  @override
  State<TicTacToe> createState() => _TicTacToeState();
}

class _TicTacToeState extends State<TicTacToe> {
  List<String> symbols = [" ", " ", " ", " ", " ", " ", " ", " ", " "];
  List<bool> selected = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false
  ];
  bool animated = true;
  bool xTurn = true;
  bool enabled = true;
  String errorMessage = "Pole już zostało użyte!";
  List<int> score = [0, 0];

  void _clearBoard() {
    setState(() {
      selected = [
        false,
        false,
        false,
        false,
        false,
        false,
        false,
        false,
        false
      ];
      symbols = [" ", " ", " ", " ", " ", " ", " ", " ", " "];
      xTurn = true;
      enabled = true;
    });
  }

  String _checkWinner() {
    String winner = "";
    String Function(int, int, int) checkPossibilities = (a, b, c) {
      if (symbols[a] != " ") {
        if ((symbols[a] == symbols[b]) && (symbols[b] == symbols[c])) {
          return symbols[a];
        }
      }
      return "";
    };

    final posibilities = [
      checkPossibilities(0, 1, 2),
      checkPossibilities(3, 4, 5),
      checkPossibilities(6, 7, 8),
      checkPossibilities(0, 3, 6),
      checkPossibilities(1, 4, 7),
      checkPossibilities(2, 5, 8),
      checkPossibilities(0, 4, 8),
      checkPossibilities(2, 4, 6)
    ];

    for (int i = 0; i < posibilities.length; i++) {
      if (posibilities[i] != "") {
        winner = posibilities[i];
        break;
      }
    }
    return winner;
  }

  void _selectedField(int index) {
    if (enabled == true) {
      setState(() {
        if (xTurn && !selected[index] && enabled) {
          symbols[index] = "X";
          xTurn = false;
          selected[index] = true;
        } else if (!xTurn && !selected[index] && enabled) {
          symbols[index] = "O";
          xTurn = true;
          selected[index] = true;
        } else {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(errorMessage)));
        }
      });


      if (_checkWinner() == "X") {
        print(_checkWinner());
        score[0] += 1;
        print(score);
        enabled = false;
      }
      if (_checkWinner() == "O") {
        print(_checkWinner());
        score[1] += 1;
        print(score);
        enabled = false;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Expanded(
                flex:1,
                child: SizedBox(height: 10)),
            Expanded(
              flex:1,
              child: Container(
                child: Text(
                  "Wyniki\n" + score[0].toString() + " : " + score[1].toString(),
                  style: TextStyle(
                    fontSize: 40,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Expanded(
              flex: 6,
              child: Container(

                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        GestureDetector(
                            child: CustomCard(symbol: symbols[0], animation: animated),
                            onTap: () {
                              animated = !animated;
                              _selectedField(0);
                              print("tap 1");
                            }),
                        GestureDetector(
                            child: CustomCard(symbol: symbols[1], animation: animated),
                            onTap: () {
                              _selectedField(1);
                              print("tap 2");
                            }),
                        GestureDetector(
                            child: CustomCard(symbol: symbols[2], animation: animated),
                            onTap: () {
                              _selectedField(2);
                              print("tap 3");
                            }),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        GestureDetector(
                            child: CustomCard(symbol: symbols[3], animation: animated),
                            onTap: () {
                              _selectedField(3);
                              print("tap 4");
                            }),
                        GestureDetector(
                            child: CustomCard(symbol: symbols[4], animation: animated),
                            onTap: () {
                              _selectedField(4);
                              print("tap 5");
                            }),
                        GestureDetector(
                            child: CustomCard(symbol: symbols[5], animation: animated),
                            onTap: () {
                              _selectedField(5);
                              print("tap 6");
                            }),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        GestureDetector(
                            child: CustomCard(symbol: symbols[6], animation: animated),
                            onTap: () {
                              _selectedField(6);
                              print("tap 7");
                            }),
                        GestureDetector(
                            child: CustomCard(symbol: symbols[7], animation: animated),
                            onTap: () {
                              _selectedField(7);
                              print("tap 8");
                            }),
                        GestureDetector(
                            child: CustomCard(symbol: symbols[8], animation: animated),
                            onTap: () {
                              _selectedField(8);
                              print("tap 9");
                            }),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            if(_checkWinner() != "")
            Expanded(
              flex: 1,
              child: MaterialButton(
                elevation: 15,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                color: Colors.lightGreenAccent,
                minWidth: MediaQuery.of(context).size.width/2,
                onPressed: () {
                  _clearBoard();
                },
                child: Text("Zagraj Jeszcze Raz",
                style: TextStyle(
                  fontSize: 30,
                ),),

              ),
            )
            else
              Expanded(
                  flex: 1,
                  child: SizedBox(height: 10)),
            SizedBox(height: 50)
          ],
        ),
      ),
    );
  }
}
