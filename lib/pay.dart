import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:qr_bar_code_scanner_dialog/qr_bar_code_scanner_dialog.dart';
import 'package:sas/dialogs.dart';
import 'package:sas/main.dart';

class SAS extends StatefulWidget {
  const SAS({Key? key}) : super(key: key);

  @override
  State<SAS> createState() => _SASState();
}

class _SASState extends State<SAS> {
  final _qrBarCodeScannerDialogPlugin = QrBarCodeScannerDialog();
  final _controllerAcc1 = TextEditingController();
  final _controllerAcc2 = TextEditingController();
  final _controllerAmount = TextEditingController();
  final _controllerPin = TextEditingController();
  bool acc1Checked = false;
  bool acc2Checked = false;
  bool amountChecked = false;
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
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Bezahlen",
              textScaleFactor: 2.4,
            ),
            SizedBox(
  width: MediaQuery.of(context).size.width * 0.8,
  height: 70,
  child: Stack(
    children: [
      Positioned(
        left: 0,
        right: 75,
        child: TextFormField(
          onChanged: (value) {
            setState(() {});
          },
          enabled: !acc1Checked,
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
      Positioned(
        right: 0,
        top: 0,
        bottom: 15,
        child: Center(
          child: Row(
            children: [
              Checkbox(
                value: acc1Checked,
                onChanged: (value) {
                  setState(() {
                    acc1Checked = value!;
                  });
                },
              ),
                IconButton(
                onPressed: () {
                    _qrBarCodeScannerDialogPlugin.getScannedQrBarCode(
                        context: context,
                        onCode: (code) {
                          if(code == null){
                            return;
                          }
                          var codeShort = code.substring(15,code.length);

                          if(codeShort.substring(0,2) == "m:"){
                            setState(() {
                            _controllerAcc2.text = codeShort.substring(2, codeShort.length);
                          });
                          }
                         
                        });
                  }, icon: Icon(Icons.qr_code))

            ],
          ),
        ),
      ),
    ],
  ),
),
SizedBox(
  width: MediaQuery.of(context).size.width * 0.8,
  height: 70,
  child: Stack(
    children: [
      Positioned(
        left: 0,
        right: 75,
        child: TextFormField(
          onChanged: (value) {
            setState(() {});
          },
          enabled: !acc2Checked,
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
      Positioned(
        right: 0,
        top: 0,
        bottom: 15,
        child: Center(
          child: Row(
            children: [
              Checkbox(
                value: acc2Checked,
                onChanged: (value) {
                  setState(() {
                    acc2Checked = value!;
                  });
                },
              ),
              IconButton(
                onPressed: () {
                    _qrBarCodeScannerDialogPlugin.getScannedQrBarCode(
                        context: context,
                        onCode: (code) {
                          if(code == null){
                            return;
                          }
                          var codeShort = code.substring(15,code.length);

                          if(codeShort.substring(0,2) == "m:"){
                            setState(() {
                            _controllerAcc2.text = codeShort.substring(2, codeShort.length);
                          });
                          }
                         
                        });
                  }, icon: Icon(Icons.qr_code))

            ],
          ),
        ),
      ),

    ],
  ),
),
SizedBox(
  width: MediaQuery.of(context).size.width * 0.8,
  height: 70,
  child: Stack(
    children: [
      Positioned(
        left: 0,
        right: 75,
        child: TextFormField(
          enabled: !amountChecked,
          onChanged: (value) {
            setState(() {});
          },
          controller: _controllerAmount,
          decoration: const InputDecoration(
            labelText: 'Betrag',
            border: OutlineInputBorder(),
            suffixIcon: Icon(
              Icons.monetization_on,
            ),
          ),
        ),
      ),
      Positioned(
        right: 40,
        top: 0,
        bottom: 15,
        child: Center(
          child: Checkbox(
            value: amountChecked,
            onChanged: (value) {
              setState(() {
                amountChecked = value!;
              });
            },
          ),
        ),
      ),
    ],
  ),
),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.56,
              height: 70,
              child: TextFormField(
                onChanged: (value) {
                  setState(() {});
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
            Row(
              children: [
                ElevatedButton(
                    child: Text("Bezahlen"),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Color.fromARGB(255, 0, 148, 145),
                      elevation: 0,
                    ),
                    onPressed: !inputsValid(
                            _controllerAcc1.text,
                            _controllerAcc2.text,
                            _controllerAmount.text,
                            _controllerPin.text)
                        ? null
                        : () async {
                            var res = await pay(
                                _controllerAcc1.text,
                                _controllerAcc2.text,
                                _controllerAmount.text,
                                _controllerPin.text);
                          }),
                Visibility(child: double.tryParse(_controllerAmount.text) != null ? Text((double.parse(_controllerAmount.text)*1.1).toStringAsFixed(3).replaceAll(".", ",") + "D", textScaleFactor: 1.72): Text("")
                , visible: inputsValid(
                            _controllerAcc1.text,
                            _controllerAcc2.text,
                            _controllerAmount.text,
                            _controllerPin.text))
              ],
            )
          ],
        ),
      ),
    );
  }

  void clearInputs() {
    _controllerPin.clear();
    if(!amountChecked){
      _controllerAmount.clear();
    }
    if(!acc2Checked){
      _controllerAcc2.clear();
    }
    if(!acc1Checked){
      _controllerAcc1.clear();
    }
 
 }
Future<int> pay(String acc1, String acc2, String amount, String pin) async {
    //print("Bezahle " + amount + " von " + acc1 + " nach " + acc2 + " mit PIN " + pin);
    final dio = Dio();
    try {
      await dio.get(URL,
          options: Options(
            headers: {
            "Authorization": "Bearer " + token,
            },)
      );
    } on DioException catch (e) {
      // The request was made and the serve
      
      //r responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null) {
        return 4;
      }
    }
    try {
      var res = await dio.get(URL,
          options: Options(
            headers: {
            "Authorization": "Bearer " + token,
            
            })
      
      );
      if (res.data != "0") {
        return 4;
      }
    } catch (e) {
      print(e);
      return 4;
    }
    showLoadingDialog(context);
    var response = await dio.post(URL + "/pay",
        data: {"acc1": acc1, "acc2": acc2, "amount": amount, "pin": pin},
        options: Options(
          headers: {
            "Authorization": "Bearer " + token,
}
        ));
    Navigator.pop(context);
    print(response.data);
    if (response.data == "success") {
      showSuccessDialog(context, amount);
      clearInputs();
    return 5;

    }
    if(response.data == "suspended"){
      showErrorDialog(context, "Konto gesperrt, versuchen Sie es später nocheinmal!");
      return 5;
    }
    if (response.data == "Not enough money") {
      showErrorDialog(context, "Nicht genug Geld!");
      return 2;
    }
    if (response.data == "wrong pin") {
      showErrorDialog(context, "Falsche PIN!");
      return 4;
    }
    showErrorDialog(context, "Fehler! Bitte überprüfen Sie Ihre Eingaben und Internetverbindung");
    return 4;


  }
}

bool inputsValid(String acc1, String acc2, String amount, String pin) {
  if (acc1.trim() == "" ||
      acc2.trim() == "" ||
      amount.trim() == "" ||
      pin.trim() == "") {
    return false;
  }
  if (double.tryParse(amount) == null) {
    print(false);
    return false;
  }
  if (int.tryParse(pin) == null) {
    print(false);
    return false;
  }
  print(true);
  return true;
}