import 'package:flutter/material.dart';
import 'package:torch_light/torch_light.dart';
import 'dart:io';

void main() {
  runApp(const MyApp());
}

Map mapper = {
  ' ': '     ',
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
  '1': '.----',
  '2': '..---',
  '3': '...--',
  '4': '....-',
  '5': '.....',
  '6': '-....',
  '7': '--...',
  '8': '---..',
  '9': '----.',
  '0': '-----',
  '?': '..--..',
  '!': '-.-.--',
  '.': '.-.-.-',
  ',': '--..--',
  ';': '-.-.-.',
  ':': '---...',
  '+': '.-.-.',
  '-': '-....-',
  '/': '-..-.',
  '=': '-...-',
};

Map timing = {'-': 300, '.': 100, ' ': 0};

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'App Title',

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

  String morsecode = '';

  void text2morse() {
    setState(() {
      String temp = text1.text.toLowerCase();
      morsecode = '';
      for (int i = 0; i < temp.length; i++) {
        morsecode += mapper[temp[i]] + ' ';
        }
      }
    );
  }

  void flash() {
    for (int i = 0; i < morsecode.length - 1; i++) {
      int time = timing[morsecode[i]];
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
        title: const Text(
            'Morse code flasher',
          //style: TextStyle(
            //fontStyle: FontStyle.italic,
          //),
        ),
      ),
      body: Column(children: <Widget>[
        TextField(
          controller: text1,
          decoration: const InputDecoration(
            border: OutlineInputBorder(
            )
          ),
        ),
        OutlinedButton(
            onPressed: text2morse,
            child: const Text(
              "Convert",
            )
        ),
        Text(
          morsecode,
          style: const TextStyle(
            fontSize: 30,
            ),
          ),
        OutlinedButton(
            onPressed: flash,
            child: const Text(
               "Flash",
            ),
          ),
        ],
      ),
    );
  }
}