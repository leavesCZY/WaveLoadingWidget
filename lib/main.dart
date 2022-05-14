import 'package:flutter/material.dart';

import 'wave_loading.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  final _title = "WaveLoadingWidget";

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: _title),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final String title;

  const MyHomePage({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: SingleChildScrollView(
        child: Align(
          alignment: Alignment.center,
          child: Column(
            children: <Widget>[
              SizedBox(
                width: 300,
                height: 300,
                child: WaveLoading(
                  text: "開",
                  fontSize: 210,
                  backgroundColor: Colors.lightBlue,
                  foregroundColor: Colors.white,
                  waveColor: Colors.lightBlue,
                ),
              ),
              SizedBox(
                width: 300,
                height: 300,
                child: WaveLoading(
                  text: "心",
                  fontSize: 210,
                  backgroundColor: Colors.indigoAccent,
                  foregroundColor: Colors.white,
                  waveColor: Colors.indigoAccent,
                ),
              ),
              SizedBox(
                width: 300,
                height: 300,
                child: WaveLoading(
                  text: "最",
                  fontSize: 210,
                  backgroundColor: Colors.teal,
                  foregroundColor: Colors.white,
                  waveColor: Colors.teal,
                ),
              ),
              SizedBox(
                width: 300,
                height: 300,
                child: WaveLoading(
                  text: "重",
                  fontSize: 210,
                  backgroundColor: Colors.redAccent,
                  foregroundColor: Colors.white,
                  waveColor: Colors.redAccent,
                ),
              ),
              SizedBox(
                width: 300,
                height: 300,
                child: WaveLoading(
                  text: "要",
                  fontSize: 210,
                  backgroundColor: Colors.amber,
                  foregroundColor: Colors.white,
                  waveColor: Colors.amber,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
