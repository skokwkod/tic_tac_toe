import 'package:flutter/material.dart';

class CustomCard extends StatefulWidget {
  CustomCard({Key? key, required this.symbol}) : super(key: key);

  String symbol;
  @override
  State<CustomCard> createState() => _CustomCardState();
}

class _CustomCardState extends State<CustomCard> {


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: MediaQuery.of(context).size.height/7,
        width: MediaQuery.of(context).size.width/5,
        child: Card(
          elevation: 15,
          shadowColor: Colors.black,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Center(
            child: Text(
              widget.symbol,
              style: TextStyle(
                fontSize: 70,
                    color: (widget.symbol=="O" ? Colors.amber:Colors.red),
              ),),
          ),
        ),
      ),
    );
  }
}
