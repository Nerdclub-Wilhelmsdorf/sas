


  import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:sas/main.dart';

class Balance extends StatefulWidget {
    const Balance({Key? key}) : super(key: key);

  @override
  State<Balance> createState() => _BalanceState();
}

class _BalanceState extends State<Balance> {
    var balance = "";
    var controllerAcc = TextEditingController();
    var controllerPin = TextEditingController();
    @override
    Widget build(BuildContext context) {
      return Scaffold(
        body: Center(
          child: Column(

            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.6,
                height: 70,
                child: Positioned(
                        left: 0,
                        right: 75,
                        child: TextFormField(
                          onChanged: (value) {
                            setState(() {});
                          },
                          controller: controllerAcc,
                          decoration: const InputDecoration(
                            labelText: 'Konto',
                            border: OutlineInputBorder(),
                            suffixIcon: Icon(
                            Icons.account_balance,
                            ),
                          ),
                        ),
                      ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.2,
                height: 70,
                child: Positioned(
                        left: 0,
                        right: 75,
                        child: TextFormField(
                          onChanged: (value) {
                            setState(() {});
                          },
                          controller: controllerPin,
                          decoration: const InputDecoration(
                            labelText: 'PIN',
                            border: OutlineInputBorder(),
                            suffixIcon: Icon(
                            Icons.pin,
                            ),
                          ),
                        ),
                      ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center, 
                children: [
                  Text(
                    "Kontostand",
                    textScaleFactor: 2.4,
                  ),
                  IconButton(onPressed: () {
                    balanceCheck(controllerAcc.text, controllerPin.text);
                    setState(() {
                      
                    });
                  }, icon: Icon(Icons.balance),
                  
                  color: Colors.blue,),
                ],
              ),
              Text(
                balance,
                textScaleFactor: 2.4,
              ),
            ],
          ),
        ),
      );
    }
    balanceCheck(String acc, String pin) async {
      Dio dio = Dio();
      if (acc.isEmpty|| pin.isEmpty) {
        return;
      }
        dio.get(URL + "/balanceCheck", data: {"acc1": acc, "pin": pin}).then((value) {
        print(value.data);
        if (value.statusCode == 200) {
          balance = value.data;
        }
        if (value.statusCode == 401) {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("Fehler!"),
              );
            },
          );
        }
      }).catchError((error) {
        print(error);
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Fehler!"),
            );
          },
        );
        return;
      });
  }

}


