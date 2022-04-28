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
  bool xTurn = true;
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
    setState(() {
      if (xTurn && !selected[index]) {
        symbols[index] = "X";
        xTurn = false;
        selected[index] = true;
      } else if (!xTurn && !selected[index]) {
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
    }
    if (_checkWinner() == "O") {
      print(_checkWinner());
      score[1] += 1;
      print(score);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Wyniki\n" + score[0].toString() + " : " + score[1].toString(),
              style: TextStyle(
                fontSize: 40,
              ),
              textAlign: TextAlign.center,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    GestureDetector(
                        child: CustomCard(symbol: symbols[0]),
                        onTap: () {
                          _selectedField(0);
                          print("tap 1");
                        }),
                    GestureDetector(
                        child: CustomCard(symbol: symbols[1]),
                        onTap: () {
                          _selectedField(1);
                          print("tap 2");
                        }),
                    GestureDetector(
                        child: CustomCard(symbol: symbols[2]),
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
                        child: CustomCard(symbol: symbols[3]),
                        onTap: () {
                          _selectedField(3);
                          print("tap 4");
                        }),
                    GestureDetector(
                        child: CustomCard(symbol: symbols[4]),
                        onTap: () {
                          _selectedField(4);
                          print("tap 5");
                        }),
                    GestureDetector(
                        child: CustomCard(symbol: symbols[5]),
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
                        child: CustomCard(symbol: symbols[6]),
                        onTap: () {
                          _selectedField(6);
                          print("tap 7");
                        }),
                    GestureDetector(
                        child: CustomCard(symbol: symbols[7]),
                        onTap: () {
                          _selectedField(7);
                          print("tap 8");
                        }),
                    GestureDetector(
                        child: CustomCard(symbol: symbols[8]),
                        onTap: () {
                          _selectedField(8);
                          print("tap 9");
                        }),
                  ],
                ),
              ],
            ),
            SizedBox(height: 20),
            if(_checkWinner() != "")
            MaterialButton(
              onPressed: () {
                _clearBoard();
              },
              child: Text("Jeszcze Raa"),
              color: Colors.lightGreenAccent,
            )
          ],
        ),
      ),
    );
  }
}
