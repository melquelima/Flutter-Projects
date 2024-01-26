import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void modal_error(context, String message) {
  showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          height: MediaQuery.of(context).size.height * .25,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.vertical(top: Radius.circular(10.0)),
            color: Colors.white,
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 100,
                    height: 4,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: const Color.fromARGB(255, 168, 168, 168),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const Center(
                  child: Icon(
                    CupertinoIcons.xmark_octagon_fill,
                    color: Color.fromARGB(255, 189, 32, 21),
                    size: 40,
                  ),
                ),
                Text("Ops! -  ${message}"),
                const SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(40),
                    backgroundColor: Color.fromRGBO(0, 10, 118, 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10), // <-- Radius
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text('OK'),
                  ),
                )
              ],
            ),
          ),
        );
      });
}
