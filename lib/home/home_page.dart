import 'package:conversor_moedas/home/home_repository.dart';
import 'package:conversor_moedas/home/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final realController = TextEditingController();
  final dolarController = TextEditingController();
  final euroController = TextEditingController();

  double? dolar;
  double? euro;

  final repository = HomeRepository();

  void realChanged(String text) {
    if (text.isEmpty) return;

    double real = double.parse(text);
    dolarController.text = (real / dolar!).toStringAsFixed(2);
    euroController.text = (real / euro!).toStringAsFixed(2);
  }

  void dolarChanged(String text) {
    if (text.isEmpty) return;

    double dolar = double.parse(text);
    realController.text = (dolar * this.dolar!).toStringAsFixed(2);
    euroController.text = (dolar * this.dolar! / euro!).toStringAsFixed(2);
  }

  void euroChanged(String text) {
    if (text.isEmpty) return;

    double euro = double.parse(text);
    realController.text = (euro * this.euro!).toStringAsFixed(2);
    dolarController.text = (euro * this.euro! / dolar!).toStringAsFixed(2);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("Conversor de Moedas"),
        backgroundColor: Colors.amber,
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: repository.getData(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return Center(
                child: Text(
                  "Carregando dados",
                  style: TextStyle(
                    color: Colors.amber,
                  ),
                  textAlign: TextAlign.center,
                ),
              );
            default:
              if (snapshot.hasError) {
                return Center(
                  child: Text(
                    "Erro ao carregar os dados",
                    style: TextStyle(
                      color: Colors.amber,
                    ),
                    textAlign: TextAlign.center,
                  ),
                );
              } else {
                dolar = snapshot.data!["results"]["currencies"]["USD"]["buy"];
                euro = snapshot.data!["results"]["currencies"]["EUR"]["buy"];

                return SingleChildScrollView(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Icon(
                        Icons.monetization_on,
                        size: 150,
                        color: Colors.amber,
                      ),
                      CustomTextField(
                        controller: realController,
                        label: "Reais",
                        prefix: "R\$",
                        function: realChanged,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      CustomTextField(
                        controller: dolarController,
                        label: "Dólares",
                        prefix: "US\$",
                        function: dolarChanged,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      CustomTextField(
                        controller: euroController,
                        label: "Euros",
                        prefix: "€",
                        function: euroChanged,
                      ),
                    ],
                  ),
                );
              }
          }
        },
      ),
    );
  }
}
