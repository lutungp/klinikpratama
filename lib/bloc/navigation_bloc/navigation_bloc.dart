import 'package:bloc/bloc.dart';
import 'package:klinikpratama/pages/ui/AdmisiRJPage.dart';
import 'package:klinikpratama/pages/ui/Dashboard.dart';
import 'package:klinikpratama/pages/ui/utility_bills_page.dart';

enum NavigationEvents {
  DashboardClickEvent,
  AdmisiRJClickEvent,
  UtilityClickEvent
}

abstract class NavigationStates {}

class NavigationBloc extends Bloc<NavigationEvents, NavigationStates> {
  final Function onMenuTap;

  NavigationBloc({this.onMenuTap});

  @override
  NavigationStates get initialState => MyDashboardPage(
        onMenuTap: onMenuTap,
      );

  @override
  Stream<NavigationStates> mapEventToState(NavigationEvents event) async* {
    switch (event) {
      case NavigationEvents.DashboardClickEvent:
        yield MyDashboardPage(
          onMenuTap: onMenuTap,
        );
        break;
      case NavigationEvents.AdmisiRJClickEvent:
        yield AdmisiRJPage(
          onMenuTap: onMenuTap,
        );
        break;
      case NavigationEvents.UtilityClickEvent:
        yield UtilityBills(
          onMenuTap: onMenuTap,
        );
        break;
    }
  }
}
