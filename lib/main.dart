import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ByteBank',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: FormTransferenciaScreen(),
      //home: const HomeScreen(title: 'Transferências'),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListaTransferencias(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => '',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class ListaTransferencias extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(2.0),
        child: ListView(
          children: [
            ItemTransferencia(Transferencia(100.0, 1000)),
            ItemTransferencia(Transferencia(200.0, 2000)),
            ItemTransferencia(Transferencia(300.0, 3000)),
          ],
        ));
  }
}

class ItemTransferencia extends StatelessWidget {
  Transferencia _transferencia;

  ItemTransferencia(this._transferencia);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Card(
        child: ListTile(
      leading: Icon(Icons.monetization_on),
      title: Text(_transferencia.value.toString()),
      subtitle: Text(_transferencia.accountNum.toString()),
    ));
  }
}

class Transferencia {
  final double value;
  final int accountNum;

  Transferencia(this.value, this.accountNum);

  @override
  String toString() {
    return 'Transferencia{value: $value, accountNum: $accountNum}';
  }
}

class FormTransferenciaScreen extends StatelessWidget {
  final TextEditingController _controladorCampoNumConta =
      TextEditingController();
  final TextEditingController _controladorCampoValor = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.arrow_back),
        title: Text('Formulário Transferência'),
      ),
      body: Column(
        children: [
          Editor(
            controller: _controladorCampoNumConta,
            label: 'Número da Conta',
            hint: '0000',
          ),
          Editor(
            controller: _controladorCampoValor,
            label: 'Valor',
            hint: '0.00',
            icon: Icons.monetization_on,
          ),
          ElevatedButton(
            onPressed: () => _createTransferencia(),
            child: Text('Confirmar'),
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.blue)),
          )
        ],
      ),
    );
  }

  void _createTransferencia() {
    final int? numConta = int.tryParse(_controladorCampoNumConta.text);
    final double? valor = double.tryParse(_controladorCampoValor.text);

    if (numConta != null && valor != null) {
      final newTransferencia = Transferencia(valor, numConta);
      debugPrint('$newTransferencia');
    }
  }
}

class Editor extends StatelessWidget {
  final TextEditingController? controller;
  final String? label;
  final String? hint;
  final IconData? icon;

  Editor({this.controller, this.label, this.hint, this.icon});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextField(
        controller: controller,
        style: TextStyle(fontSize: 20.0),
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          icon: icon != null ? Icon(Icons.monetization_on) : null,
        ),
      ),
    );
  }
}
