import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:jdonuts/src/features/commons/domain/domain.dart';
import 'package:jdonuts/src/features/cart/data/data.dart';

abstract interface class ICartLocalStorage {
  Future<List<CartLineModel>> getLines();
  Future<void> saveLines(List<CartLineModel> lines);
  Future<void> clear();
}

@Injectable(as: ICartLocalStorage)
class CartLocalStorage implements ICartLocalStorage {
  final ILocalStorage _localStorage;
  const CartLocalStorage(this._localStorage);

  static const _cartKey = "CART_LINES";

  @override
  Future<List<CartLineModel>> getLines() async {
    final source = await _localStorage.getString(_cartKey);
    if (source == null) return [];
    try {
      final list = json.decode(source) as List<dynamic>;
      return list
          .map((e) => CartLineModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } on FormatException {
      await clear();
      return [];
    }
  }

  @override
  Future<void> saveLines(List<CartLineModel> lines) => _localStorage.setString(
    _cartKey,
    json.encode(lines.map((l) => l.toJson()).toList()),
  );

  @override
  Future<void> clear() => _localStorage.remove(_cartKey);
}
