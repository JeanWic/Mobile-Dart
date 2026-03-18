import 'package:flutter/material.dart';

void main() {
  runApp(const CalculadoraApp());
}

class CalculadoraApp extends StatelessWidget {
  const CalculadoraApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculadora Mobile',
      theme: ThemeData.dark(),
      home: const CalculadoraHome(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class CalculadoraHome extends StatefulWidget {
  const CalculadoraHome({super.key});

  @override
  State<CalculadoraHome> createState() => _CalculadoraHomeState();
}

class _CalculadoraHomeState extends State<CalculadoraHome> {
  String _expressao = "";
  String _resultado = "0";
  String _operador = "";
  double _primeiroNumero = 0;
  double _segundoNumero = 0;

  void _calcular(String botaoTexto) {
    setState(() {
      if (botaoTexto == "C") {
        _expressao = "";
        _resultado = "0";
        _operador = "";
        _primeiroNumero = 0;
        _segundoNumero = 0;
      } else if (botaoTexto == "+" ||
          botaoTexto == "-" ||
          botaoTexto == "x" ||
          botaoTexto == "/") {
        _primeiroNumero = double.tryParse(_resultado) ?? 0;
        _operador = botaoTexto;
        _expressao = "";
      } else if (botaoTexto == "=") {
        _segundoNumero = double.tryParse(_expressao) ?? 0;
        switch (_operador) {
          case "+":
            _resultado = (_primeiroNumero + _segundoNumero).toString();
            break;
          case "-":
            _resultado = (_primeiroNumero - _segundoNumero).toString();
            break;
          case "x":
            _resultado = (_primeiroNumero * _segundoNumero).toString();
            break;
          case "/":
            _resultado = _segundoNumero != 0
                ? (_primeiroNumero / _segundoNumero).toString()
                : "Erro";
            break;
        }

        if (_resultado.endsWith(".0")) {
          _resultado = _resultado.replaceAll(".0", "");
        }

        _expressao = _resultado;
        _operador = "";
      } else {
        _expressao += botaoTexto;
        _resultado = _expressao;
      }
    });
  }

  Widget _construirBotao(String texto, {Color cor = Colors.grey}) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: cor,
            padding: const EdgeInsets.symmetric(vertical: 24),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          onPressed: () => _calcular(texto),
          child: Text(
            texto,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Calculadora'), centerTitle: true),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            alignment: Alignment.bottomRight,
            child: Text(
              _resultado,
              style: const TextStyle(fontSize: 60, fontWeight: FontWeight.bold),
            ),
          ),
          const Divider(thickness: 2),
          Row(
            children: [
              _construirBotao("7", cor: Colors.blueGrey[800]!),
              _construirBotao("8", cor: Colors.blueGrey[800]!),
              _construirBotao("9", cor: Colors.blueGrey[800]!),
              _construirBotao("/", cor: Colors.orange),
            ],
          ),
          Row(
            children: [
              _construirBotao("4", cor: Colors.blueGrey[800]!),
              _construirBotao("5", cor: Colors.blueGrey[800]!),
              _construirBotao("6", cor: Colors.blueGrey[800]!),
              _construirBotao("x", cor: Colors.orange),
            ],
          ),
          Row(
            children: [
              _construirBotao("1", cor: Colors.blueGrey[800]!),
              _construirBotao("2", cor: Colors.blueGrey[800]!),
              _construirBotao("3", cor: Colors.blueGrey[800]!),
              _construirBotao("-", cor: Colors.orange),
            ],
          ),
          Row(
            children: [
              _construirBotao("C", cor: Colors.redAccent),
              _construirBotao("0", cor: Colors.blueGrey[800]!),
              _construirBotao("=", cor: Colors.green),
              _construirBotao("+", cor: Colors.orange),
            ],
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
