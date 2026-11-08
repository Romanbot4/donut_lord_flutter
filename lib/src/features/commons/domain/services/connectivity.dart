abstract interface class IConnectivity {
  Stream<bool> get onlineChanges;

  Future<bool> isOnline();
}
