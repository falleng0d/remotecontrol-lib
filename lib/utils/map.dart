/// Inverts a map, where the keys become values and the values become keys.
/// If the original map contains duplicate values, the first key-value pair is
/// used.
extension MapExtensions<X, Y> on Map<X, Y> {
  Map<Y, X> invertNoOverrideDuplicate() {
    final processedKeys = <Y>{};
    final newMap = <Y, X>{};

    for (final entry in entries) {
      if (processedKeys.contains(entry.value)) {
        continue;
      }

      newMap[entry.value] = entry.key;
      processedKeys.add(entry.value);
    }

    return newMap;
  }
}
