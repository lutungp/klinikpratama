import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:klinikpratama/bloc/navigation_bloc/navigation_bloc.dart';
import 'package:klinikpratama/services/authService.dart';

class Menu extends StatelessWidget {
  final Animation<double> menuAnimation;
  final Animation<Offset> slideAnimation;
  final int selectedIndex;
  final Function onItemPageTap;

  const Menu(
      {Key key,
      this.slideAnimation,
      this.menuAnimation,
      this.selectedIndex,
      @required this.onItemPageTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: slideAnimation,
      child: ScaleTransition(
        scale: menuAnimation,
        child: Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    BlocProvider.of<NavigationBloc>(context)
                        .add(NavigationEvents.DashboardClickEvent);
                    onItemPageTap();
                  },
                  child: Text(
                    "Dashboard",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: selectedIndex == 0
                            ? FontWeight.w900
                            : FontWeight.normal),
                  ),
                ),
                SizedBox(height: 30),
                GestureDetector(
                  onTap: () {
                    BlocProvider.of<NavigationBloc>(context)
                        .add(NavigationEvents.AdmisiRJClickEvent);
                    onItemPageTap();
                  },
                  child: Text(
                    "Daftar",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: selectedIndex == 1
                            ? FontWeight.w900
                            : FontWeight.normal),
                  ),
                ),
                SizedBox(height: 200),
                GestureDetector(
                  onTap: () {
                    Navigator.popAndPushNamed(context, '/login');
                    AuthService.removeToken();
                  },
                  child: Text(
                    "Logout",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: selectedIndex == 2
                            ? FontWeight.w900
                            : FontWeight.normal),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
