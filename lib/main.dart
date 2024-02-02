

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:dio/dio.dart';
void main() {
  runApp(MaterialApp(home: const SAS()));
}

class SAS extends StatefulWidget {
  const SAS({Key? key}) : super(key: key);

  @override
  State<SAS> createState() => _SASState();
}

class _SASState extends State<SAS> {
  final _controllerAcc1 = TextEditingController();
  final _controllerAcc2 = TextEditingController();
  final _controllerAmount = TextEditingController();
  final _controllerPin = TextEditingController();

  @override
  void dispose() {

    _controllerAcc1.dispose();
    _controllerAcc2.dispose();
    _controllerAmount.dispose();
    _controllerPin.dispose();

    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Bezahlen", textScaleFactor: 2.4,),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                height: MediaQuery.of(context).size.height * 0.1,
                child: TextFormField(
                  controller: _controllerAcc1,
                  decoration: const InputDecoration(
                    labelText: 'Konto 1 (Zahler)',
                    border: OutlineInputBorder(),
                    suffixIcon: Icon(
                Icons.account_balance,
                    ),
                  ),
                ),
              ),
             SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                height: MediaQuery.of(context).size.height * 0.1,
                child: TextFormField(
                  controller: _controllerAcc2,
                  decoration: const InputDecoration(
                    labelText: 'Konto 2 (Empfänger)',
                    border: OutlineInputBorder(),
                    suffixIcon: Icon(
                Icons.account_balance,
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                height: MediaQuery.of(context).size.height * 0.1,
                child: TextFormField(
                  controller: _controllerAmount,
                  decoration: const InputDecoration(
                    labelText: 'Betrag',
                    border: OutlineInputBorder(),
                    suffixIcon: Icon(
                Icons.euro,
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.56,
                height: MediaQuery.of(context).size.height * 0.07,
                child: TextFormField(
                  obscureText: true,
                  controller: _controllerPin,
                  decoration: const InputDecoration(
                    labelText: 'PIN',
                    border: OutlineInputBorder(),
                    suffixIcon: Icon(
                Icons.pin,
                    ),
                  ),
                ),
              ),
              ElevatedButton(
          child: Text("Bezahlen"),
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: Color.fromARGB(255, 0, 148, 145),
            elevation: 0,
          ),
          onPressed: () async {
            var res = await pay(_controllerAcc1.text, _controllerAcc2.text, _controllerAmount.text, _controllerPin.text);
            if (res == 0){
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text("Erfolgreich"),
                  );     
          },
        );
            }
             if (res == 1){
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text("Nicht genügend Geld!"),
                  );     
          },
        );
            }
               if (res == 2){
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text("Falsche PIN!"),
                  );     
          },
        );
            }
  
            if (res == 3){
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text("Fehler! Bitte überprüfen Sie Ihre Eingaben und Internetverbindung"),
                  );     
          },
        );
            }
          }
              )
      

            ],  
          ),
        ),
      );
  }
}


Future<int> pay(String acc1, String acc2, String amount, String pin) async {
  //print("Bezahle " + amount + " von " + acc1 + " nach " + acc2 + " mit PIN " + pin);
  final dio = Dio();
  var response = await dio.post('http://localhost:1323/pay', data: {"acc1": acc1, "acc2": acc2, "amount": amount, "pin": pin});
  print(response.data);
  if (response.data == "success"){
    return 0;
  }
  if (response.data == "Not enough money"){
    return 1;
  }
  if (response.data == "wrong pin"){
    return 2;
  }
   return 3;
}