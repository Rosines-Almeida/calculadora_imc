import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TextEditingController heightControler = TextEditingController();
  final TextEditingController weightControler = TextEditingController();
  static const VALUE_MIM_IMC = 18.6;

dynamic _formKey = GlobalKey<FormState>();

  String _infoText = 'Informe seus dados';

  void resetFields() {
    setState(() {
      heightControler.clear();
      weightControler.clear();
      _infoText = '';
      _formKey = GlobalKey<FormState>(); 
    });
  }

  //format values
  //pegar valor da cailcu
  //condição de acordo com resultado
  //passar para o infoTect
  void calculate() {
    double weightFormat = double.parse(weightControler.text);
    double heightFormat = double.parse(heightControler.text) / 100;
    double imcValue = weightFormat / (heightFormat * heightFormat);
    print(imcValue);
    setInfoText(imcValue);
  }

  void setInfoText(double imcValue) {
    setState(() {
      if (imcValue < VALUE_MIM_IMC) {
        _infoText =
            "Abaixo do peso , seu valor de IMC : ${imcValue.toStringAsPrecision(3)}";
      } else if (imcValue >= 18.6 && imcValue < 24.9) {
        _infoText = "Peso Ideal (${imcValue.toStringAsPrecision(4)})";
      } else if (imcValue >= 24.9 && imcValue < 29.9) {
        _infoText =
            "Levemente Acima do Peso (${imcValue.toStringAsPrecision(4)})";
      } else if (imcValue >= 29.9 && imcValue < 34.9) {
        _infoText = "Obesidade Grau I (${imcValue.toStringAsPrecision(4)})";
      } else if (imcValue >= 34.9 && imcValue < 39.9) {
        _infoText = "Obesidade Grau II (${imcValue.toStringAsPrecision(4)})";
      } else if (imcValue >= 40) {
        _infoText = "Obesidade Grau III (${imcValue.toStringAsPrecision(4)})";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculado de IMC'),
        backgroundColor: Colors.green,
        actions: [
          IconButton(onPressed: resetFields, icon: Icon(Icons.refresh))
        ],
      ),
      backgroundColor: Color(0xFFf1f7f6),
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(10, 0, 10, 0.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Icon(
                Icons.person_outline,
                size: 120.0,
                color: Colors.green,
              ),
              TextFormField(
                validator:(value) {
                  if(value!.isEmpty){
                    return 'Insira seu peso!'; 
                  }else{
                    return null;
                  }
                },
                controller: weightControler,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: 'Peso (Kg)',
                    labelStyle: TextStyle(color: Colors.green, fontSize: 25)),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.green, fontSize: 25),
              ),
              TextFormField(
                validator: (value) {
                  if(value!.isEmpty){
                    return 'Insira sua altura!';
                  }else{
                    null;
                  }
                },
                controller: heightControler,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: 'Altura (cm)',
                    labelStyle: TextStyle(
                      color: Colors.green,
                    )),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.green, fontSize: 25),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Container(
                  height: 50.0,
                  child: RaisedButton(
                    onPressed: (){
                      if(_formKey.currentState!.validate()){
                        calculate();
                      };
                    },
                    child: Text(
                      ' Calcular',
                      style: TextStyle(color: Colors.white, fontSize: 25.0),
                    ),
                    color: Colors.green,
                  ),
                ),
              ),
              Text(
                _infoText,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.green, fontSize: 25),
              )
            ],
          ),
        ),
      ),
    );
  }
}
