import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _infoText = "Informe seus dados!";

  void _resetFields() {
    weightController.clear();
    heightController.clear();

    setState(() {
      _infoText = "Informe seus dados!";
      _formKey = GlobalKey<FormState>();
    });
  }

  void _calculate() {
    double weight = double.parse(weightController.text);
    double height = double.parse(heightController.text) / 100;
    double imc = weight / (height * height);

    setState(() {
      if (imc < 18.6) {
        _infoText = "Abaixo do peso \nIMC = ${imc.toStringAsPrecision(4)}";
      } else if (imc >= 18.6 && imc <= 24.9) {
        _infoText = "Peso normal \nIMC = ${imc.toStringAsPrecision(4)}";
      } else if (imc >= 25 && imc <= 29.9) {
        _infoText = "Sobrepeso \nIMC = ${imc.toStringAsPrecision(4)}";
      } else if (imc >= 30 && imc <= 34.9) {
        _infoText = "Obesidade grau I \nIMC = ${imc.toStringAsPrecision(4)}";
      } else if (imc >= 35 && imc <= 39.9) {
        _infoText = "Obesidade grau II \nIMC = ${imc.toStringAsPrecision(4)}";
      } else if (imc > 40) {
        _infoText = "Obesidade grau III \nIMC = ${imc.toStringAsPrecision(4)}";
      }
    });
  }

  String? _weightValidation(String? value) {
    if (value == null) {
      return "Insira um valor";
    } else if (value.isEmpty) {
      return "Insira um valor";
    } else if (value.isNotEmpty) {
      String patttern = r'(^["-9"-9]*$)';
      RegExp regExp = RegExp(patttern);

      if (!regExp.hasMatch(value)) {
        return "Esse campo só pode conter números";
      }

      double weight = double.parse(weightController.text);

      if (weight > 499) {
        return "Insira um peso válido";
      } else if (weight <= 0) {
        return "Insira um peso válido";
      }
    }
    return null;
  }

  String? _heightValidation(String? value) {
    if (value == null) {
      return "Insira um valor";
    } else if (value.isEmpty) {
      return "Insira um valor";
    } else if (value.isNotEmpty) {
      String patttern = r'(^["-9"-9]*$)';
      RegExp regExp = RegExp(patttern);

      if (!regExp.hasMatch(value)) {
        return "Esse campo só pode conter números";
      }

      double height = double.parse(heightController.text);
      if (height > 299) {
        return "Insira uma altura válida";
      } else if (height <= 0) {
        return "Insira uma altura válida";
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calculadora de IMC"),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: _resetFields,
            icon: Icon(
              Icons.refresh,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(10),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Icon(
                Icons.person,
                size: 150,
                color: Colors.blue,
              ),
              TextFormField(
                controller: weightController,
                keyboardType: TextInputType.number,
                validator: _weightValidation,
                decoration: InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: "Peso (kg)",
                ),
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: 25,
                ),
              ),
              TextFormField(
                controller: heightController,
                keyboardType: TextInputType.number,
                validator: _heightValidation,
                decoration: InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: "Altura (cm)",
                ),
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: 25,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: SizedBox(
                  height: 60,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _calculate();
                      }
                    },
                    child: Text(
                      "Calcular",
                      style: TextStyle(fontSize: 25),
                    ),
                  ),
                ),
              ),
              Text(
                _infoText,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 25),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
