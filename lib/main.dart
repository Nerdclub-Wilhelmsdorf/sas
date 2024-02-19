import 'package:flutter/material.dart';
import 'package:sas/balance.dart';
import 'package:sas/pay.dart';

const URL = "http://localhost:1323";
void main() {
  runApp(MaterialApp(home: const Overview()));
}

//create a stateless widget named overview
class Overview extends StatefulWidget {
  const Overview({Key? key}) : super(key: key);

  @override
  State<Overview> createState() => _OverviewState();
}

class _OverviewState extends State<Overview> {
  int currentPageIndex = 0;
  @override
  Widget build(BuildContext context) {

    return  Scaffold(
      bottomNavigationBar: NavigationBar(
        selectedIndex: currentPageIndex,
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        destinations: const [
            NavigationDestination(
            icon: Icon(Icons.payment),
            label: 'Bezahlen',
          ),
           NavigationDestination(
            icon: Icon(Icons.account_balance),
            label: 'Kontostand',
          ),
          ],
      ),
      body: Center(

        child: currentPageIndex == 0 ? const SAS() : const Balance(),
      ),

    );
  }
}




