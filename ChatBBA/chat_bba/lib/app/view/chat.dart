// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:chat_bba/app/controllers/app_controller.dart';
import 'package:chat_bba/app/controllers/login_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controllers/language_controller.dart';
import 'drawer.dart';

class Chat extends StatefulWidget {
  const Chat({super.key});

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  @override
  Widget build(BuildContext context) {
    final AppController appController = Provider.of(context, listen: true);
    final ScrollController listScrollController = ScrollController();

    return Scaffold(
        endDrawer: MyDrawer(),
        appBar: AppBar(
          title: Image.asset("assets/logo2.png", width: 35, height: 35),
          backgroundColor: Color.fromARGB(255, 248, 209, 23),
        ),
        body: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
                //color: Colors.red,
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 30.0, bottom: 30.0),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(
                          width: 1.2,
                          color: Color.fromARGB(255, 100, 101, 102)),
                    ),
                    color: Color.fromARGB(255, 222, 222, 231),
                    //color: Colors.green,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Expanded(
                      child: ListView.builder(
                        controller: listScrollController,
                        itemCount: appController.messages.length,
                        itemBuilder: (context, index) =>
                            appController.messages[index],
                      ),
                    ),
                  ),
                ),
              ),
            )));
  }
}

class ChatMessage extends StatelessWidget {
  final String message;
  final bool option;
  const ChatMessage({super.key, required this.message, required this.option});

  @override
  Widget build(BuildContext context) {
    final AppController appController = Provider.of(context, listen: false);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      //mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          "assets/logo2.png",
          width: 40,
          height: 40,
        ),
        SizedBox(
          width: 10,
        ),
        FittedBox(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 280,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                  color: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text(message),
                ),
              ),
              option
                  ? Row(
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  Color.fromARGB(255, 13, 82, 148)),
                          onPressed: () {
                            appController.firstOptions(
                                context, 'Debit Card Activation');
                          },
                          child: Text('Debit Card Activation'),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  Color.fromARGB(255, 13, 82, 148)),
                          onPressed: () {
                            appController.firstOptions(context, 'PIN Reset');
                          },
                          child: Text('PIN Reset'),
                        ),
                      ],
                    )
                  : TimeMessage(),
              SizedBox(
                height: 5,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class ClientMessage extends StatelessWidget {
  final String message;
  const ClientMessage({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        FittedBox(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 280,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                  ),
                  color: Color.fromARGB(255, 13, 82, 148),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text(message,
                      style: const TextStyle(color: Colors.white)),
                ),
              ),
              TimeMessage(),
              SizedBox(
                height: 5,
              ),
            ],
          ),
        ),
        SizedBox(
          width: 10,
        ),
        Image.asset(
          "assets/user_pic.png",
          width: 40,
          height: 40,
        ),
      ],
    );
  }
}

class TimeMessage extends StatelessWidget {
  const TimeMessage({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.access_time_outlined,
          color: Color.fromARGB(255, 170, 183, 184),
          size: 20,
        ),
        Text(
          "01:00",
          style: TextStyle(
              color: Color.fromARGB(255, 170, 183, 184), fontSize: 15),
        ),
      ],
    );
  }
}

class LoadingIcon extends StatelessWidget {
  const LoadingIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      //mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          "assets/logo2.png",
          width: 40,
          height: 40,
        ),
        SizedBox(
          width: 10,
        ),
        FittedBox(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                "assets/loading2.gif",
                width: 40,
                height: 40,
              ),
              SizedBox(
                height: 5,
              ),
            ],
          ),
        ),
      ],
    );
  }
}


// actions: [
//             Image.asset("assets/us_flag.png"),
//             Image.asset("assets/br_flag.png"),
//           ],
