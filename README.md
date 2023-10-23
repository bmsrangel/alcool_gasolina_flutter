# Etanol ou Gasolina?

Esta aplicação indica qual tipo de combustível utilizar comparando o valor do etanol e da gasolina.

A aplicação também é capaz de fazer os cálculos levando em consideração o consumo do automóvel.

Além disto, ela mantém salvo na aplicação os últimos valores informados de consumo, de forma a evitar que o usuário informe os mesmos dados a cada uso.

Dentre as tecnologias utilizadas no projeto, pode-se destacar:

- O uso de Streams do pacote `rxdart` para reatividade;
- O uso de máscaras de campos de text com o pacote `flutter_masked_text`;
- O uso de fontes externas sem a necessidade de instalação com o pacote `google_fonts`;

Todos os pacotes podem ser encontrados no site [Dart Packages](https://pub.dev/)

<img src=".github/demo.gif" width="300" />

## Executando o Projeto

Primeiramente, é necessário ter o Flutter instalado. A seguir, na raiz do projeto, executar os seguintes comandos:

```bash
flutter pub get
```

```bash
flutter run
```
