import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void main() {
  runApp(const MaterialApp(
    home: Home(),
    debugShowCheckedModeBanner: false,
  ));
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _infoText = "Informe seus dados";

  void _resetFields() {
    weightController.text = "";
    heightController.text = "";
    setState(() {
      _infoText = "Informe seus dados";
      _formKey = GlobalKey<FormState>();
    });
  }

  void _calculate(){
    setState(() {
      double weight = double.parse(weightController.text);
      double height = double.parse(heightController.text) / 100;
      double imc = weight / (height * height);

      if(imc < 18.6){
        _infoText = "Abaixo do peso (${imc.toStringAsPrecision(3)})";
      } else if(imc >= 18.6 && imc < 24.9){
        _infoText = "Peso ideal (${imc.toStringAsPrecision(3)})";
      } else if(imc >= 24.9 && imc < 29.9){
        _infoText = "Levemente acima do peso (${imc.toStringAsPrecision(3)})";
      } else if(imc >= 29.9 && imc < 34.9){
        _infoText = "Obesidade Grau I (${imc.toStringAsPrecision(3)})";
      } else if(imc >= 34.9 && imc < 39.9){
        _infoText = "Obesidade Grau II (${imc.toStringAsPrecision(3)})";
      } else if(imc >= 40){
        _infoText = "Obesidade Grau III (${imc.toStringAsPrecision(3)})";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('IMC Calc'),
          centerTitle: true,
          backgroundColor: Colors.greenAccent,
          actions: [
            IconButton(onPressed: _resetFields, icon: const Icon(Icons.refresh)),
          ],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Icon(
                  Icons.person_outline,
                  size: 120,
                  color: Colors.greenAccent,
                ),
                TextFormField(
                  controller: weightController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                      labelText: 'Peso (kg)',
                      labelStyle: TextStyle(color: Colors.green)),
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 20),
                  validator: (value){
                    if(value!.isEmpty){
                      return "Insira seu peso!";
                    }
                  },
                ),
                TextFormField(
                  controller: heightController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                      labelText: 'Altura',
                      labelStyle: TextStyle(color: Colors.green)),
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 20),
                  validator: (value){
                    if(value!.isEmpty){
                      return "Insira sua altura!";
                    }
                  },
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Container(
                    height: 60,
                    child: FilledButton(
                        style: FilledButton.styleFrom(
                            backgroundColor: Colors.deepPurpleAccent),
                        onPressed: (){
                          if(_formKey.currentState!.validate()){
                            _calculate();
                          }
                        },
                        child: const Text('Calcular')),
                  ),
                ),
                Text(
                  _infoText,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 24),
                )
              ],
            ),
          ),
        ));
  }
}
