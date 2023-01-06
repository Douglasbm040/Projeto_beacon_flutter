import 'package:flutter/material.dart';
import 'package:interface_beacon/src/components/home_form_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: Theme.of(context).primaryColorDark,
          appBar: AppBar(
            actions: [
              IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    semanticLabel: "botao para a ligar gps",
                    Icons.gps_fixed_rounded,
                    size: 45,
                  )),
              SizedBox(width: 20),
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.volume_up,
                  size: 45,
                  semanticLabel: "botao para a ligar som",
                ),
              )
            ],
            bottom: const TabBar(
              tabs: [
                Text("Cadastrar"),
                Text("Atualizar"),
                //    Text("visualizacao")
              ],
            ),
            title: const Text('homepage'),
          ),
          body: const TabBarView(children: [
            SingleChildScrollView(
                child: HomeFormWidget(
              title: "Cadastre o seu beacon",
              titlebuttom: "enviar dados",
            )),
            SingleChildScrollView(
                child: HomeFormWidget(
              title: "Atualize o seu beacom",
              titlebuttom: "transmitir os dados",
            )),
            // SingleChildScrollView(child: HomeFormWidget()),
          ]),
        ),
      ),
    );
  }
}
