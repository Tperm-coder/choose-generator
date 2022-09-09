// Jenkins hash functions
int _combine(int hash, int value) {
  hash = 0x1fffffff & (hash + value);
  hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
  return hash ^ (hash >> 6);
}

int _finish(int hash) {
  hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
  hash = hash ^ (hash >> 11);
  return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
}

int hash2(a, b) => _finish(_combine(_combine(0, a.hashCode), b.hashCode));

class Pair<T1, T2> {
  final T1 first;

  final T2 second;

  const Pair(this.first, this.second);

  Pair<T1, T2> setFirst(T1 v) => Pair<T1, T2>(v, second);
  Pair<T1, T2> setSecond(T2 v) => Pair<T1, T2>(first, v);

  @override
  String toString() => '[$first, $second]';

  @override
  bool operator ==(Object other) =>
      other is Pair && other.first == first && other.second == second;

  @override
  int get hashCode => hash2(first.hashCode, second.hashCode);
}
