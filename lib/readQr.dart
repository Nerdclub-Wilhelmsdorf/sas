import 'package:flutter/material.dart';
import 'package:qr_bar_code_scanner_dialog/qr_bar_code_scanner_dialog.dart';

final _qrBarCodeScannerDialogPlugin = QrBarCodeScannerDialog();

Future<String> readQr(BuildContext context) async{
_qrBarCodeScannerDialogPlugin.getScannedQrBarCode(
context: context,
onCode: (code) {
  if(code == null){
    return "invalid";
  }
  if(code.substring(0,2) != "m:"){
    return "invalid";
  }
  return code.substring(2, code.length);
}
);
return "invalid";
}
