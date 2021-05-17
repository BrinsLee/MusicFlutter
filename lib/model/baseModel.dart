import 'package:flutter/material.dart';
import 'package:music_flutter/common/api/api.dart';
import 'package:music_flutter/common/utils/utils.dart';

class BaseModel<T extends Api> extends ChangeNotifier {
  T api;
  bool disposed = false;

  BaseModel(this.api);

  ViewState _state = ViewState.initializedState;

  ViewState get state => _state;

  void setState(ViewState value) {
    _state = value;
    notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();
    disposed = true;
  }

  @override
  void notifyListeners() {
    if (!disposed) {
      super.notifyListeners();
    }
  }
}
