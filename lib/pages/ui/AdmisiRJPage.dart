import 'package:flutter/material.dart';
import 'package:klinikpratama/bloc/navigation_bloc/navigation_bloc.dart';
import 'AddPasien.dart';
import 'AddAdmisiRj.dart';

String norm;

class AdmisiRJPage extends StatefulWidget with NavigationStates {
  final Function onMenuTap;
  const AdmisiRJPage({Key key, this.onMenuTap}) : super(key: key);
  AdmisiRJState createState() => AdmisiRJState();
}

class AdmisiRJState extends State<AdmisiRJPage> {
  int _selectedIndex = 0;

  List<Widget> _widgetOptions = <Widget>[
    AddAdmisiRjPage(onMenuTap: () {}),
    AddPasienPage(onFlatButtonPressed: (value) {
      norm = value;
    })
  ];

  @override
  void _onItemTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(child: _widgetOptions.elementAt(_selectedIndex)),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.list, color: Colors.blueGrey), label: ''),
            BottomNavigationBarItem(
              icon: Icon(Icons.person, color: Colors.blueGrey),
              label: '',
            ),
          ],
          onTap: _onItemTap,
        ));
  }
}
