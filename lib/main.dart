

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:dio/dio.dart';
import 'package:sas/dialogs.dart';
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
  bool acc1Checked = false;
  bool acc2Checked = false;
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
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,

                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.7,
                      height: MediaQuery.of(context).size.height * 0.1,
                      child: TextFormField(
                          onChanged: (value) {
                          setState(() {
                            
                          });
                        },
                      
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
                      width: 50,
                      height: 20,

                      child: Checkbox(value: acc1Checked, onChanged: (value) {
                        setState(() {
                          acc1Checked = value!;
                        });
                      }),
                    )
                  ],
                ),
              ),
             SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                height: MediaQuery.of(context).size.height * 0.1,
                child: TextFormField(
                          onChanged: (value) {
                    setState(() {
                      
                    });
                  },
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
                          onChanged: (value) {
                    setState(() {
                      
                    });
                  },
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
                  onChanged: (value) {
                    setState(() {
                      
                    });
                  },
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
          onPressed: !inputsValid(_controllerAcc1.text, _controllerAcc2.text, _controllerAmount.text, _controllerPin.text) ? null : () async {
            var res = await pay(_controllerAcc1.text, _controllerAcc2.text, _controllerAmount.text, _controllerPin.text);
            showDialogs(context, res);
          }
              )
      

            ],  
          ),
        ),
      );
  }

Future<int> pay(String acc1, String acc2, String amount, String pin) async {
  //print("Bezahle " + amount + " von " + acc1 + " nach " + acc2 + " mit PIN " + pin);
  final dio = Dio();
  try {
  await dio.get('http://localhost:1323/');
} on DioException catch (e) {
  // The request was made and the serve
  //r responded with a status code
  // that falls out of the range of 2xx and is also not 304.
  if (e.response != null) {
  return 4;
  }

  }
  try {
    var res = await dio.get('http://localhost:1323/');
    if (res.data != "0"){
      return 4;
    }
  } catch (e) {
    print(e);
    return 4;
  }
  var response = await dio.post('http://localhost:1323/pay', data: {"acc1": acc1, "acc2": acc2, "amount": amount, "pin": pin});
  print(response.data);
  if (response.data == "success"){
    clearInputs();
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

void clearInputs(){
  _controllerAcc1.clear();
  _controllerAcc2.clear();
  _controllerAmount.clear();
  _controllerPin.clear();
}
}

bool inputsValid(String acc1,String acc2,String amount,String pin){
  if (acc1.trim() == "" || acc2.trim() == "" || amount.trim() == "" || pin.trim() == ""){

    return false;
  }
      if(double.tryParse(amount) == null){
      print(false);
      return false;
    }
    if(int.tryParse(pin) == null){
      print(false);
      return false;
    }    
  print(true);
  return true;
}



