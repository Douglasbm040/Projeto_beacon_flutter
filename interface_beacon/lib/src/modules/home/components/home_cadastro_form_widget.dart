import 'package:flutter/material.dart';
import '../../custom/components/custom_textfield_widget.dart';

class HomeCadastroFormWidget extends StatelessWidget {
  const HomeCadastroFormWidget(
      {super.key, required String title, required String titlebuttom})
      : _title = title,
        _titlebutton = titlebuttom;
  final String _title;
  final String _titlebutton;
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(30),
      child: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Form(
            child: ListView(
          children: [
            const Text("Cadastrar seu beacon :"),
            const SizedBox(height: 30),
            const ListTile(
              leading: Text("1 PASSO"),
              title: Text("Preencha os campos abaixo :"),
            ),
            const CustomTextFieldWidget(label: 'ID'),
            const SizedBox(height: 20),
            const CustomTextFieldWidget(label: 'usuario'),
            const SizedBox(height: 20),
            const ListTile(
              leading: Text("PASSO 2"),
              title: Text(
                  textAlign: TextAlign.justify,
                  "Necessitamos dos dados de localizacao para o aparelho funcionar. Ligue os gps do seu celular, encoste seu celular ao aparelho e aperte o botao abaixo para capturar os dados de localicação, lembre de fazer isso no local onde o aparelho ira ficar."),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {},
              child: const SizedBox(
                  height: 50,
                  child: Center(child: Text("compartilhar localização"))),
            ),
            const SizedBox(height: 40),
          ],
        )),
      ),
    );
  }
}
