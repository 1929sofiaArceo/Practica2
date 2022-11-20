import 'package:flutter/foundation.dart';

class FavProvider with ChangeNotifier {
  bool _listening = false;
  bool get listening => _listening;
  int _prueba = 0;
  int get prueba => _prueba;

  void startlisten(){
    _listening = true;
    notifyListeners();
  }
  void stoplisten(){
    _listening = false;
    notifyListeners();
  }
}