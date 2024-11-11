import 'package:flutter/material.dart';
import 'package:flutter_application_1/estoquescreen.dart';
import 'package:flutter_application_1/loginscreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BoasVindas extends StatefulWidget {
  const BoasVindas({super.key});

  @override
  State<BoasVindas> createState() => _BoasVindasState();
}

class _BoasVindasState extends State<BoasVindas> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    verificarToken().then((onValue) {
      if (onValue) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => EstoqueScreen()));
      }else{
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => LoginScreen()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }

  Future<bool> verificarToken() async {
    SharedPreferences sharedpreferences = await SharedPreferences.getInstance();
    if (sharedpreferences.getString('token') != null) {
      return true;
    } else {
      return false;
    }
  }
}
