import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

const request = "https://api.hgbrasil.com/finance?format=json&key=1b48135e";

void main() async {
  print(await getData());

  runApp(MaterialApp(
    home: ConversorHome(),
  ));
}

class ConversorHome extends StatefulWidget {
  @override
  _ConversorHomeState createState() => _ConversorHomeState();
}

class _ConversorHomeState extends State<ConversorHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("\$ Conversor \$"),
        backgroundColor: Colors.amber,
        centerTitle: true,
      ),
      body: FutureBuilder<Map>(
          future: getData(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.waiting:
                return Center(
                    child: Text(
                  "Carregando dados... ",
                  style: TextStyle(color: Colors.amber, fontSize: 25.0),
                  textAlign: TextAlign.center,
                ));
              default:
                if (snapshot.hasError) {
                  return Center(
                      child: Text(
                    "Erro ao carregar dados :( ",
                    style: TextStyle(color: Colors.amber, fontSize: 25.0),
                    textAlign: TextAlign.center,
                  ));
                } else {
                  return Container(
                    color: Colors.green,
                  );
                }
            }
          }),
    );
  }
}

Future<Map> getData() async {
  http.Response response = await http.get(request);
  return (json.decode(response.body));
}
