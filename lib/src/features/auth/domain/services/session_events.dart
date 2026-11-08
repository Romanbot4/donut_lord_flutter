abstract interface class ISessionEvents {
  Stream<void> get onExpired;

  void expire();
}
