import 'package:flutter/material.dart';
import 'package:tic_tac_toe/widgets/card_widget.dart';
import 'package:tic_tac_toe/widgets/custom_dialog.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
  int selectedCount = 0;

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
      selectedCount = 0;
    });
  }

  String _checkWinner() {
    String Function(int, int, int) checkPossibilities;
    checkPossibilities = (a, b, c) {
      if (symbols[a] != " ") {
        if ((symbols[a] == symbols[b]) && (symbols[b] == symbols[c])) {
          return symbols[a];
        }
      }
      return "";
    };

    String winner = "";

    final possibilities = [
      checkPossibilities(0, 1, 2),
      checkPossibilities(3, 4, 5),
      checkPossibilities(6, 7, 8),
      checkPossibilities(0, 3, 6),
      checkPossibilities(1, 4, 7),
      checkPossibilities(2, 5, 8),
      checkPossibilities(0, 4, 8),
      checkPossibilities(2, 4, 6)
    ];

    for (int i = 0; i < possibilities.length; i++) {
      if (possibilities[i] != "") {
        winner = possibilities[i];
        break;
      }
    }
    return winner;
  }

  void _selectedField(int index) {
    selectedCount++;
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
        score[0] += 1;
        enabled = false;
        showDialog(
            context: context,
            builder: (context) {
             return ShowCustomDialog(clearBoard: _clearBoard, text: "Krzyżyk");
            });
      }
      if (_checkWinner() == "O") {
        score[1] += 1;
        enabled = false;
        showDialog(
            context: context,
            builder: (context) {
              return ShowCustomDialog(clearBoard: _clearBoard, text: "Kółko");
            });
      }
      }
    }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 20),
            Expanded(
              flex: 1,
              child: Text(
                "Wyniki\n" +
                    score[0].toString() +
                    " : " +
                    score[1].toString(),
                style: const TextStyle(
                  fontSize: 40,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Expanded(
              flex: 6,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      GestureDetector(
                          child: CustomCard(
                              symbol: symbols[0]),
                          onTap: () {
                            animated = !animated;
                            _selectedField(0);
                          }),
                      GestureDetector(
                          child: CustomCard(
                              symbol: symbols[1]),
                          onTap: () {
                            _selectedField(1);
                          }),
                      GestureDetector(
                          child: CustomCard(
                              symbol: symbols[2]),
                          onTap: () {
                            _selectedField(2);
                          }),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      GestureDetector(
                          child: CustomCard(
                              symbol: symbols[3]),
                          onTap: () {
                            _selectedField(3);
                          }),
                      GestureDetector(
                          child: CustomCard(
                              symbol: symbols[4]),
                          onTap: () {
                            _selectedField(4);
                          }),
                      GestureDetector(
                          child: CustomCard(
                              symbol: symbols[5]),
                          onTap: () {
                            _selectedField(5);
                          }),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      GestureDetector(
                          child: CustomCard(
                              symbol: symbols[6]),
                          onTap: () {
                            _selectedField(6);
                          }),
                      GestureDetector(
                          child: CustomCard(
                              symbol: symbols[7]),
                          onTap: () {
                            _selectedField(7);
                          }),
                      GestureDetector(
                          child: CustomCard(
                              symbol: symbols[8]),
                          onTap: () {
                            _selectedField(8);
                          }),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            if (_checkWinner() != "" || selectedCount == 9)
              Expanded(
                flex: 1,
                child: MaterialButton(
                  elevation: 15,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  color: Colors.lightGreenAccent,
                  minWidth: MediaQuery.of(context).size.width / 2,
                  onPressed: () {
                    _clearBoard();
                  },
                  child: const Text(
                    "Zagraj Jeszcze Raz",
                    style: TextStyle(
                      fontSize: 30,
                    ),
                  ),
                ),
              )
            else
              const Expanded(flex: 1, child: SizedBox(height: 10)),
            const SizedBox(height: 50)
          ],
        ),
      ),
    );
  }
}
