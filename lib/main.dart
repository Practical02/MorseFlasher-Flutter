import 'package:flutter/material.dart';
import 'package:torch_light/torch_light.dart';
import 'dart:io';

void main() {
  runApp(const MyApp());
}

Map timing = {'-': 200, '.': 50, ' ': 0};
Map mapper = {
  'a': '.-',
  'b': '-...',
  'c': '-.-.',
  'd': '-..',
  'e': '.',
  'f': '..-.',
  'g': '--.',
  'h': '....',
  'i': '..',
  'j': '.---',
  'k': '-.-',
  'l': '.-..',
  'm': '--',
  'n': '-.',
  'o': '---',
  'p': '.--.',
  'q': '--.-',
  'r': '.-.',
  's': '...',
  't': '-',
  'u': '..-',
  'v': '...-',
  'w': '.--',
  'x': '-..-',
  'y': '-.--',
  'z': '--..',
  ' ': '     '
};

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController text1 = TextEditingController();

  String code = '';

  void encoder() {
    setState(() {
      String temp = text1.text.toLowerCase();
      code = '';
      for (int i = 0; i < temp.length; i++) {
        code += mapper[temp[i]] + ' ';
      }
    });
  }

  void lit() {
    for (int i = 0; i < code.length - 1; i++) {
      int time = timing[code[i]];
      time > 0 ? TorchLight.enableTorch() : 1;
      sleep(Duration(milliseconds: time));
      TorchLight.disableTorch();
      sleep(const Duration(milliseconds: 100));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Text > Morse'),
      ),
      body: Column(children: <Widget>[
        TextField(
          controller: text1,
        ),
        ElevatedButton(
            onPressed: encoder,
            child: const Text(
              "Convert To Morse Code",
            )),
        Text(
          code,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
                onPressed: lit,
                child: const Text(
                  "Flash",
                ))
          ],
        )
      ]),
    );
  }
}