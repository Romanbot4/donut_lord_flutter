Future<T> withMinimumDuration<T>(Future<T> call, Duration minimum) async {
  final results = await Future.wait<Object?>([call, Future.delayed(minimum)]);
  return results.first as T;
}
