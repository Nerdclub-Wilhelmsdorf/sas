
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
}