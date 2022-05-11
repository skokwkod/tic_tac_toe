import 'package:flutter/material.dart';

class ShowCustomDialog extends StatelessWidget {
  ShowCustomDialog({Key? key, required this.clearBoard, required this.text})
      : super(key: key);
  Function clearBoard;
  String text;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape:
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      backgroundColor: Colors.transparent,
      elevation: 40,
      child: Stack(
        children: [
          SizedBox(
            width: 400,
            height: 500,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Opacity(
                  opacity: 0.8,
                  child: Container(
                    height: 300,
                    width: 300,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 150,
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(40),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(18.0),
                            child: Center(
                              child: CircleAvatar(
                                child: Text(text == "Kółko" ? "0" : "X",
                                    style: const TextStyle(
                                      fontSize: 30,
                                    )),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Text("Punkt dla " + text + "!",
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              )),
                        ),
                        MaterialButton(
                          onPressed: () {
                            clearBoard();
                            Navigator.of(context).pop();
                          },
                          color: Colors.lightGreen,
                          child: const Text(
                            "Zagraj jeszcze raz",
                            style: TextStyle(

                              fontSize: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}