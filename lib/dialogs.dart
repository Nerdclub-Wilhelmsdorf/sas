
import 'package:flutter/material.dart';

void showDialogs(context, res) {
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
                        if (res == 4){
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text("Fehler! Überprüfen Sie Ihre Internetverbindung! Sollte diese bestehen, kontaktieren Sie bitte die Zentralbank!"),
                  );     
          },

        );
            }
            }
            if (res == 5){
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text("QR Code ungültig!"),
                  );     
          },
        );
            }
}

showSuccessDialog(context, amount) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(

        title: Text("Bezahlen:"),
        content: Column(
          children: [
            Text("Betrag:"+ amount),
            Text("Steuer:"+ (double.parse(amount) * 0.1).toString()),
            Text("Gesamt:"+ (double.parse(amount) * 1.1).toString()),
          ],
        ),

      );
    },
  );
}