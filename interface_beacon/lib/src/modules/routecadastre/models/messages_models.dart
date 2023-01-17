import 'package:flutter/cupertino.dart';

class MessagesModels extends ChangeNotifier {
  final String messageStartPageTitle =
      """BEM VINDO A INTERFACE DO SEU DISPOSITIVO""";

  final String messageStartPageText =
      """SIGA OS PASSO PARA REALIZA  O CADASTRO DO BEACON""";

  final String messagePageScanTitle = """
    Clique no botao a baixo para escanerar as informações 
    do seus beacon
""";

  final String messagePageIdTitle = """Agora precisamos do que crie um nome
  que represente o local onde o dispositivo se encontra.
  exemplo nome do comercio.
""";

  final String messagePageIdText = """
  Digite abaixo e aperte abaixo para continuar 
""";

  final String messagePageFinalTitle = """
  Precisamos dos dados de  localizacao do dipositivo.
  Ative o gps do seu celular. Encoste o celular no 
  dispositivo e aperte o botao abaixo 
""";

  final String messagePageFinalText = """
  ATENCAO PARA MELHOR FUNCIONAMENTO DO APARELHO,
 APERTER O BOTAO NO LOCAL ONDE O DISPOSITIVO SERA INSTALADO 
""";
}
