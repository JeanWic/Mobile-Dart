import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() => runApp(const CalculadoraMobile());

class CalculadoraMobile extends StatelessWidget {
  const CalculadoraMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blueGrey, useMaterial3: true),
      home: const CalculadoraHome(),
    );
  }
}

class CalculadoraHome extends StatefulWidget {
  const CalculadoraHome({super.key});

  @override
  State<CalculadoraHome> createState() => _CalculadoraHomeState();
}

class _CalculadoraHomeState extends State<CalculadoraHome> {
  String _expressao = '';
  String _resultado = '0';

  void _botaoPressionado(String texto) {
    setState(() {
      if (texto == 'C') {
        _expressao = '';
        _resultado = '0';
      } else if (texto == 'DEL') {
        if (_expressao.isNotEmpty) {
          _expressao = _expressao.substring(0, _expressao.length - 1);
        }
      } else if (texto == '=') {
        _executarCalculo();
      } else {
        _expressao += texto;
      }
    });
  }

  void _executarCalculo() {
    if (_expressao.isEmpty) return;

    try {
      String preparada = _expressao
          .replaceAll(',', '.')
          .replaceAll('x', '*')
          .replaceAll('÷', '/')
          .replaceAll('[', '(')
          .replaceAll(']', ')')
          .replaceAll('{', '(')
          .replaceAll('}', ')');

      Parser p = Parser();
      Expression exp = p.parse(preparada);
      ContextModel cm = ContextModel();
      double valor = exp.evaluate(EvaluationType.REAL, cm);

      setState(() {
        _resultado = (valor == valor.toInt())
            ? valor.toInt().toString()
            : valor.toString().replaceAll('.', ',');
      });
    } catch (e) {
      setState(() => _resultado = 'Erro');
    }
  }

  Widget _buildBotao(String texto, {Color? cor, Color? textoCor}) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: cor ?? Colors.grey[200],
            foregroundColor: textoCor ?? Colors.black87,
            padding: const EdgeInsets.symmetric(vertical: 20),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
          onPressed: () => _botaoPressionado(texto),
          child: Text(texto,
              style:
                  const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar:
          AppBar(title: const Text('Calculadora Mobile'), centerTitle: true),
      body: Column(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(24),
              alignment: Alignment.bottomRight,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(_expressao,
                      style:
                          const TextStyle(fontSize: 28, color: Colors.black54)),
                  const SizedBox(height: 10),
                  Text(_resultado,
                      style: const TextStyle(
                          fontSize: 48, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            color: Colors.grey[100],
            child: Column(
              children: [
                Row(children: [
                  _buildBotao('{'),
                  _buildBotao('}'),
                  _buildBotao('['),
                  _buildBotao(']')
                ]),
                Row(children: [
                  _buildBotao('('),
                  _buildBotao(')'),
                  _buildBotao('DEL', cor: Colors.orange[100]),
                  _buildBotao('C', cor: Colors.red[100])
                ]),
                Row(children: [
                  _buildBotao('7'),
                  _buildBotao('8'),
                  _buildBotao('9'),
                  _buildBotao('÷', cor: Colors.blue[100])
                ]),
                Row(children: [
                  _buildBotao('4'),
                  _buildBotao('5'),
                  _buildBotao('6'),
                  _buildBotao('x', cor: Colors.blue[100])
                ]),
                Row(children: [
                  _buildBotao('1'),
                  _buildBotao('2'),
                  _buildBotao('3'),
                  _buildBotao('-', cor: Colors.blue[100])
                ]),
                Row(children: [
                  _buildBotao(','),
                  _buildBotao('0'),
                  _buildBotao('=', cor: Colors.green[200]),
                  _buildBotao('+', cor: Colors.blue[100])
                ]),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
