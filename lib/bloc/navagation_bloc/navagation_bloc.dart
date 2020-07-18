import 'package:bloc/bloc.dart';
import 'package:sidebar_animation/pages/account.dart';
import 'package:sidebar_animation/pages/home.dart';
import 'package:sidebar_animation/pages/notifications.dart';
import 'package:sidebar_animation/pages/profile.dart';
import 'package:sidebar_animation/pages/settings.dart';
import 'package:sidebar_animation/pages/support.dart';
import 'package:sidebar_animation/pages/terms.dart';

enum NavigationEvents {
  NotificationsClickedEvent,
  ProfileClickedEvent,
  SettingsClickedEvent,
  AccountClickedEvent,
  SupportClickedEvent,
  TermsClickedEvent,

}

abstract class NavigationStates{}

class NavigationBloc extends Bloc<NavigationEvents, NavigationStates> {
  @override
  // TODO: implement initialState
  NavigationStates get initialState => Notifications();

  @override
  Stream<NavigationStates> mapEventToState(NavigationEvents event) async* {
    switch(event){

      case NavigationEvents.NotificationsClickedEvent:
        yield Notifications();
        break;
      case NavigationEvents.ProfileClickedEvent:
        yield ProfilePage();
        break;
      case NavigationEvents.SettingsClickedEvent:
        yield SettingsPage();
        break;
      case NavigationEvents.AccountClickedEvent:
        yield AccountPage();
        break;
      case NavigationEvents.SupportClickedEvent:
        yield SupportPage();
        break;
      case NavigationEvents.TermsClickedEvent:
        yield TermsPage();
        break;
    }
    // TODO: implement mapEventToState
    throw UnimplementedError();
  }
  
}