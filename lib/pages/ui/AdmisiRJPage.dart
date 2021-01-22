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

  void _onItemTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  color: Colors.white,
                ),
                padding: const EdgeInsets.only(left: 16, right: 16, top: 48),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            InkWell(
                              child: Icon(Icons.menu, color: Colors.blueGrey),
                              onTap: widget.onMenuTap,
                            ),
                            Text("Pendaftaran",
                                style: TextStyle(
                                    fontSize: 24, color: Colors.blueGrey)),
                          ]),
                      _widgetOptions.elementAt(_selectedIndex)
                    ]))),
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
