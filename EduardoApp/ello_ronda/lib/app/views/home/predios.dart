import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class Predios extends StatefulWidget {
  const Predios({super.key});

  @override
  State<Predios> createState() => _PrediosState();
}

class _PrediosState extends State<Predios> {
  final ScrollController listScrollController = ScrollController();

  List<String> itens = [
    "Vila Alpina",
    "Pinheiros",
    "Tatuapé",
    "Guararema",
    "Guarulhos",
    "São Caetano",
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: ListView.builder(
        controller: listScrollController,
        itemCount: itens.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(5.0),
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color.fromARGB(255, 255, 255, 255),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 7,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: Image.network(
                            "https://s2.glbimg.com/m4sELSI7M4B_xmLbBsfEz9ESS-c=/smart/e.glbimg.com/og/ed/f/original/2020/09/08/10-predios-mais-altos-brasil-orion-goiania.jpg",
                            width: 100,
                            height: 100,
                          ),
                        ),
                        const SizedBox(width: 20),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              itens[index],
                              style: TextStyle(
                                color: Colors.black.withOpacity(0.6),
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              "Some Text here",
                              style: TextStyle(
                                color: Colors.black.withOpacity(0.6),
                                fontSize: 15,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Color.fromARGB(255, 248, 209, 23),
                              ),
                              height: 3,
                              width: 100,
                            ),
                            Container(
                              child: Row(
                                children: const [
                                  Icon(Icons.lock_clock),
                                  Text("asdasd"),
                                  SizedBox(width: 30),
                                  Icon(Icons.label_important),
                                  Text("asdasd"),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 5),
              ],
            ),
          );
        },
      ),
    );
  }
}
