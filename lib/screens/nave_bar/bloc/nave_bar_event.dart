abstract class NaveBarEvent {}

class NaveBarIndexEvent extends NaveBarEvent {
  int index;
  NaveBarIndexEvent({required this.index});
}

class NaveBarLogoutEvent extends NaveBarEvent {}
