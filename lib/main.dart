import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _textInfo = "Informe os Dados! ";

  void _resetField() {
    setState(() {
      weightController.text = "";
      heightController.text = "";
      _textInfo = "Informe os Dados! ";
    });
  }

  void _calcula() {
    setState(() {
      double weight = double.parse(weightController.text);
      double height = double.parse(heightController.text) / 100;
      double imc = weight / (height * height);

      if (imc < 18.6) {
        _textInfo = "Abaixo do peso (${imc.toStringAsPrecision(4)})";
      } else if (imc >= 18.6 && imc < 24.9) {
        _textInfo = "Peso ideal (${imc.toStringAsPrecision(4)})";
      } else if (imc >= 24.9 && imc < 29.9) {
        _textInfo = "Levemente acima do peso (${imc.toStringAsPrecision(4)})";
      } else if (imc >= 29.9 && imc < 34.9) {
        _textInfo = "Obesidade grau I (${imc.toStringAsPrecision(4)})";
      } else {
        _textInfo = "Obesidade grau II (${imc.toStringAsPrecision(4)})";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Calculadora de IMC"),
          centerTitle: true,
          backgroundColor: Colors.orange,
          //Actions para colocar o botão de reload
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.refresh),
              onPressed: () {
                _resetField();
              },
            )
          ],
        ),
        //Parte da tela
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(26.0, 0.0, 26.0, 0.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Icon(
                  Icons.person_outline,
                  size: 120.0,
                  color: Colors.orange,
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "Peso (Kg)",
                    labelStyle: TextStyle(color: Colors.orange),
                  ),
                  style: TextStyle(color: Colors.orange, fontSize: 25.0),
                  textAlign: TextAlign.center,
                  controller: weightController,
                  validator: (value){
                    if (value.isEmpty) {
                      return "Insira teu peso!";
                    }
                  },
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "Altura (cm)",
                    labelStyle: TextStyle(color: Colors.orange),
                  ),
                  style: TextStyle(color: Colors.orange, fontSize: 25.0),
                  textAlign: TextAlign.center,
                  controller: heightController,
                  validator: (value){
                    if (value.isEmpty) {
                      return "Insira tua altura!";
                    }
                  },
                ),
                //Para definir a altura do botao precisa ter o Container
                Padding(
                  padding: EdgeInsets.only(
                      right: 40.0, left: 40.0, top: 30.0, bottom: 10.0),
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0),
                        side: BorderSide(color: Colors.transparent)),
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        _calcula();
                      }
                    },
                    child: Text(
                      "Calcular",
                      style: TextStyle(color: Colors.white, fontSize: 30.0),
                    ),
                    color: Colors.orange,
                  ),
                ),
                Text(
                  _textInfo,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.orange, fontSize: 30.0),
                ),
              ],
            ),
          ),
        ));
  }
}
