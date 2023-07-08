/// [onf] conditionally returns the result of the function [fn] if [condition] is
/// `true`, otherwise returns `null` or [els] if provided.
T? onf<T>(bool condition, T Function() fn, {T? els}) {
  return condition ? fn() : els;
}

/// [on] conditionally returns [obj] if [condition] is `true`, otherwise returns
/// `null` or [els] if provided.
T? on<T>(bool condition, T obj, {T? els}) {
  return condition ? obj : els;
}
