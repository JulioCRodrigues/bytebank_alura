import 'package:flutter/material.dart';
//construção do app
void main() => runApp(ByteBankApp());

class ByteBankApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: FormularioTransferencia(),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}


class FormularioTransferencia extends StatelessWidget {

  //criando controller para o botão confirmar
  final TextEditingController _controladorCampoNumeroConta = TextEditingController();
  final TextEditingController _controladorCampoValor = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Criando transferência'),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _controladorCampoNumeroConta,
              decoration: InputDecoration(
                labelText: 'Número da conta',
                hintText: '0000'
              ),
              style: TextStyle(
                fontSize: 20.0
              ),
              keyboardType: TextInputType.number,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _controladorCampoValor,
              decoration: InputDecoration(
                labelText: 'Valor',
                hintText: '0.00',
                icon: Icon(Icons.monetization_on)
              ),
              style: TextStyle(
                fontSize: 20.0
              ),
              keyboardType: TextInputType.number,
            ),
          ),
          //Pegar os dados do input e converter para criar transferencia
          RaisedButton(
            child: Text('Confirmar'),
            onPressed: (){
                print('Clicou no confirmar');
                final int numeroConta = int.tryParse(_controladorCampoNumeroConta.text);
                final double valor = double.tryParse(_controladorCampoValor.text);

                if(numeroConta != null && valor != null){
                  final TransferenciaCriada = Transferencia(valor, numeroConta);
                  Scaffold.of(context).showSnackBar(SnackBar(
                    content: Text('$TransferenciaCriada'),
                  ));
                }
            },
          ),
        ],
      ),
    );
  }
}

// cria lista de transferencia na tela principal de visualização
class ListaTransferencia extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Transferencias'),),
      body: Column(
        children: <Widget>[
          ItemTransferencia(Transferencia(300, 125698)),
          ItemTransferencia(Transferencia(400, 159635)),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
      ),
    );
  }
 

}
//Insere valor da transferencia na tela usando argumentos referenciados
class ItemTransferencia extends StatelessWidget{

  final Transferencia _transferencia;

  ItemTransferencia(this._transferencia);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(Icons.monetization_on),
        title: Text(_transferencia.valor.toString()),
        subtitle: Text(_transferencia.numeroConta.toString()),
      ),
    );
  }

}

class Transferencia{
  final double valor;
  final int numeroConta;

  Transferencia(this.valor, this.numeroConta);

  @override
  String toString() {
    return 'Transferencia{valor: $valor, numeroConta: $numeroConta}';
  }
}