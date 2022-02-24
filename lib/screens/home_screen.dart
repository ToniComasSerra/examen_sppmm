import 'package:examen_sppmm/providers/list_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'screens.dart';

class HomeScreen extends StatelessWidget {
  static Route<dynamic> route(String mensaje) {
    return MaterialPageRoute(
      builder: (context) => HomeScreen(mensaje: mensaje),
    );
  }
  final String mensaje;
  const HomeScreen({Key? key, required this.mensaje}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final listProvider = Provider.of<ListProvider>(context, listen: false);
    final despeses = listProvider.despeses;

    return Scaffold(
      appBar: AppBar(
        title: Text('Inici'),
        actions: [
          IconButton(
            icon: Icon(Icons.delete_forever),
            onPressed: () {
              print('Boton De Eliminar Todo Pulsado');
              final listProvider = Provider.of<ListProvider>(context, listen: false);
              listProvider.esborraTotes();
            },
          )
        ],
      ),
      body: ListView.builder(
        itemCount: despeses.length,
        itemBuilder: (_,index) => ListTile(
          leading: Icon(Icons.star_border_outlined),
          title: Text(despeses[index].titol),
          subtitle: Text(despeses[index].quantitat),
          trailing: Icon(
            Icons.keyboard_arrow_right_outlined,
            color: Colors.grey  
          ),
          onTap: (){

          },
        ),
      ),
      /*body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                mensaje,
                style: TextStyle(
                  fontSize: 32.0,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          )
        ],
      ),*/
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print('Boton De Añadir Pulsado');
          final listProvider = Provider.of<ListProvider>(context, listen: false);
          listProvider.afegeixDespesa('ELDER RING', '78.00');
          print(despeses);
        },
        backgroundColor: Colors.green,
        child: const Icon(Icons.add),
      ),
    );
  }
}