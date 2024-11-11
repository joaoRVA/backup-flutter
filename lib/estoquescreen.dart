import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class EstoqueScreen extends StatefulWidget {
  @override
  _EstoqueScreenState createState() => _EstoqueScreenState();
}

class _EstoqueScreenState extends State<EstoqueScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<dynamic> _searchResults = [];

  Future<void> _searchProduct() async {
    final query = _searchController.text;

    if (query.isEmpty) {
      // Não faz nada se o campo de pesquisa estiver vazio
      return;
    }

    final response = await http.get(Uri.parse('https://backup-flutter.onrender.com/search?query=$query'));

    if (response.statusCode == 200) {
      setState(() {
        // Decodifica a resposta JSON
        _searchResults = json.decode(response.body);
      });
    } else {
      // Em caso de erro, você pode exibir uma mensagem de erro
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao buscar o produto.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: const Color.fromARGB(255, 67, 40, 1),
        shadowColor: Colors.black,
        elevation: 4.0,
        title: Text('Estoque da Fazenda', style: TextStyle(color: Colors.white)),
      ),
      body: Stack(children: [
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 20),
              TextField(
                controller: _searchController,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: 'Pesquisar Produto',
                  labelStyle: TextStyle(color: Colors.white),
                  prefixIcon: Icon(
                    Icons.search_rounded,
                    color: Colors.white,
                  ),
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
              ElevatedButton(
                onPressed: _searchProduct,
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 18),
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
                child: Text('Buscar', style: TextStyle(fontSize: 18)),
              ),
              SizedBox(height: 20),
              Expanded(
                child: ListView.builder(
                  itemCount: _searchResults.length,
                  itemBuilder: (context, index) {
                    final product = _searchResults[index];
                    return ListTile(
                      leading: product['imagem'] != null
                          ? Image.network(
                              product['imagem'],
                              width: 50,
                              height: 50,
                              fit: BoxFit.cover,
                            )
                          : Icon(Icons.image, size: 50), // Placeholder if no image
                      title: Text(product['nome'] ?? 'Produto'),
                      subtitle: Text('Quantidade: ${product['qtd_disponivel']} - ${product['descricao']}'),
                      textColor: Colors.white,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
