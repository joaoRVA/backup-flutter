import 'package:flutter/material.dart';
import 'package:flutter_application_1/estoquescreen.dart';
import 'package:flutter_application_1/loginscreen.dart'; // Importa a tela de login
import 'package:http/http.dart' as http;
import 'dart:convert';

class CadastroScreen extends StatefulWidget {
  const CadastroScreen({super.key});

  @override
  State<CadastroScreen> createState() => _CadastroScreenState();
}

class _CadastroScreenState extends State<CadastroScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  final _cpfController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordController2 = TextEditingController();
  final _enderecoController = TextEditingController();

  Future<bool> cadastro() async {
    if (_formKey.currentState?.validate() ?? false) {
      final response = await http.post(
        Uri.parse('https://backup-flutter.onrender.com/register'), // URL da sua API
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'nome': _nomeController.text,
          'cpf': _cpfController.text,
          'email': _emailController.text,
          'senha': _passwordController.text,
          'endereco': _enderecoController.text,
        }),
      );

      if (response.statusCode == 201) {
        return true; // Cadastro bem-sucedido
      } else {
        return false; // Erro no cadastro
      }
    }
    return false; // Validação falhou
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Image.asset('assets/imgs/agricultura.jpg', fit: BoxFit.cover),
          ),
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: Colors.black.withOpacity(0.40),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(
                        height: 100,
                        width: 100,
                        child: Image.asset('assets/imgs/tech.png'),
                      ),
                      SizedBox(height: 30),

                      // Campo de nome
                      TextFormField(
                        controller: _nomeController,
                        validator: (nome) {
                          if (nome == null || nome.isEmpty) {
                            return 'Por favor, digite seu nome.';
                          }
                          return null;
                        },
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          labelText: 'Nome',
                          prefixIcon: Icon(Icons.person, color: Colors.white),
                          labelStyle: TextStyle(color: Colors.white),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: const Color.fromARGB(255, 246, 242, 30),
                              width: 2.0,
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),

                      // Campo de CPF
                      TextFormField(
                        controller: _cpfController,
                        keyboardType: TextInputType.number,
                        validator: (cpf) {
                          if (cpf == null || cpf.isEmpty) {
                            return 'Por favor, digite seu CPF.';
                          } else if (cpf.length != 11) {
                            return 'O CPF deve ter 11 dígitos.';
                          }
                          return null;
                        },
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          labelText: 'CPF',
                          prefixIcon: Icon(Icons.article, color: Colors.white),
                          labelStyle: TextStyle(color: Colors.white),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: const Color.fromARGB(255, 246, 242, 30),
                              width: 2.0,
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),

                      // Campo de e-mail
                      TextFormField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        validator: (email) {
                          if (email == null || email.isEmpty) {
                            return 'Por favor, digite seu e-mail.';
                          } else if (!RegExp(
                                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(email)) {
                            return 'Por favor, digite um e-mail correto';
                          }
                          return null;
                        },
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          labelText: 'Cadastrar E-mail',
                          prefixIcon: Icon(Icons.email, color: Colors.white),
                          labelStyle: TextStyle(color: Colors.white),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: const Color.fromARGB(255, 246, 242, 30),
                              width: 2.0,
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),

                      // Campo de senha
                      TextFormField(
                        controller: _passwordController,
                        validator: (senha) {
                          if (senha == null || senha.isEmpty) {
                            return "Por favor, digite uma senha.";
                          } else if (senha.length <= 6) {
                            return "Por favor, digite uma senha maior que 6 caracteres.";
                          }
                          return null;
                        },
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          labelText: 'Nova Senha',
                          prefixIcon: Icon(Icons.lock, color: Colors.white),
                          labelStyle: TextStyle(color: Colors.white),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: const Color.fromARGB(255, 246, 242, 30),
                              width: 2.0,
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        obscureText: true,
                      ),
                      SizedBox(height: 20),

                      // Campo de confirmar senha
                      TextFormField(
                        controller: _passwordController2,
                        validator: (senha) {
                          if (senha == null || senha.isEmpty) {
                            return "Por favor, digite uma senha.";
                          } else if (senha != _passwordController.text) {
                            return "Por favor, digite senhas iguais.";
                          }
                          return null;
                        },
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          labelText: 'Confirmar Senha',
                          prefixIcon: Icon(Icons.lock, color: Colors.white),
                          labelStyle: TextStyle(color: Colors.white),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: const Color.fromARGB(255, 246, 242, 30),
                              width: 2.0,
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        obscureText: true,
                      ),
                      SizedBox(height: 20),

                      // Campo de Endereço
                      TextFormField(
                        controller: _enderecoController,
                        validator: (endereco) {
                          if (endereco == null || endereco.isEmpty) {
                            return 'Por favor, digite seu endereço.';
                          }
                          return null;
                        },
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          labelText: 'Endereço',
                          prefixIcon: Icon(Icons.home, color: Colors.white),
                          labelStyle: TextStyle(color: Colors.white),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: const Color.fromARGB(255, 246, 242, 30),
                              width: 2.0,
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                      SizedBox(height: 30),

                      // Botão de cadastrar
                      ElevatedButton(
                        onPressed: () async {
                          if (await cadastro()) {
                            // Navegando para a tela de Login após cadastro bem-sucedido
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginScreen()),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Erro ao cadastrar.')),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                            side: BorderSide(
                              color: const Color.fromARGB(255, 111, 65, 0),
                              width: 1,
                            ),
                          ),
                          backgroundColor: Color.fromARGB(235, 255, 255, 255),
                          foregroundColor: const Color.fromARGB(255, 0, 0, 0),
                        ),
                        child: Text('Cadastrar'),
                      ),
                      SizedBox(height: 20),

                      // Botão de já tem uma conta?
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text('Já tem uma conta? Faça login'),
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "Fazenda Tech 2024 ©",
                    style: TextStyle(
                        color: const Color.fromARGB(255, 255, 255, 255)),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
