import 'package:examen_sppmm/models/models.dart';
import 'package:examen_sppmm/providers/db_provider.dart';
import 'package:flutter/cupertino.dart';

class ListProvider extends ChangeNotifier {
  List<Despesa> despeses = [];

  Future<Despesa> afegeixDespesa(String titol, String quantitat) async {
    final nova = Despesa(titol: titol, quantitat: quantitat);
    final id = await DBProvider.db.insert(nova);
    nova.id = id;

    this.despeses.add(nova);
    notifyListeners();
    return nova;
  }

  seleccionaTotes() async {
    final llistar = await DBProvider.db.getAll();
    this.despeses = [...despeses];
    notifyListeners();
  }

  esborraTotes() async {
    final esborrar = await DBProvider.db.deleteAll();
    this.despeses = [...despeses];
    notifyListeners();
  }

  esborraDespesa(int id) async {
    final esborrarPerId = await DBProvider.db.delete(id);
    this.despeses = [...despeses];
    notifyListeners();
  }
}