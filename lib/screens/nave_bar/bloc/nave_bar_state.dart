class NaveBarStates {
  final int index;

  NaveBarStates({this.index = 0});

  NaveBarStates copyWith(int? index) {
    return NaveBarStates(index: index ?? this.index);
  }
}
