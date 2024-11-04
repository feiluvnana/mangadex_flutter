extension IterableExt<T> on Iterable<T> {
  Iterable<V> mapIndexed<V>(V Function(T, int) transformer) sync* {
    for (int i = 0; i < length; i++) {
      yield transformer(elementAt(i), i);
    }
  }
}
