import 'package:freezed_annotation/freezed_annotation.dart';

part 'api_envelope.freezed.dart';
part 'api_envelope.g.dart';

@Freezed(genericArgumentFactories: true)
sealed class ApiEnvelope<T> with _$ApiEnvelope<T> {
  const factory ApiEnvelope({T? data, ApiErrorModel? error}) = _ApiEnvelope<T>;

  factory ApiEnvelope.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) => _$ApiEnvelopeFromJson(json, fromJsonT);
}

@freezed
sealed class ApiErrorModel with _$ApiErrorModel {
  const factory ApiErrorModel({required String code, required String message}) =
      _ApiErrorModel;

  factory ApiErrorModel.fromJson(Map<String, dynamic> json) =>
      _$ApiErrorModelFromJson(json);
}
