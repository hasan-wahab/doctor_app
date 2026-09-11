abstract class HomeEvent {}

class HomeLoadEvent extends HomeEvent {
  HomeLoadEvent({this.forceRefresh = false});

  final bool forceRefresh;
}
