# imc_flutter

Aplicativo desenvolvido seguindo desafios propostos por [web.dio.me](https://web.dio.me) de criar uma calculadora de IMC (índice de massa corporal) em flutter.

## Checklist do primeiro desafio

- [x] Criar classe IMC (Peso / Altura)
- [x] Ler dados no app
- [x] Calcular IMC
- [x] Exibir em uma lista

## Checklist do segundo desafio

- [x] Criar classe IMC (Peso / Altura)
- [ ] Altura ler em tela de Configurações
- [x] Ler dados no app
- [x] Calcular IMC
- [ ] Gravar dados no Hive ou SQLite
- [x] Exibir em uma lista

## Rodando a aplicação

```
flutter pub get
flutter run
```

## Tabela de IMC

|     IMC     | Classificação                |
|:-----------:|:-----------------------------|
|    < 16     | Magreza grave                |
|  16 a < 17  | Magreza moderada             |
| 17 a < 18,5 | Magreza leve                 |
| 18,5 a < 25 | Saudável                     |
|  25 a < 30  | Sobrepeso                    |
|  30 a < 35  | Obesidade Grau I             |
|  35 a < 40  | Obesidade Grau II (severa)   |
|    >= 40    | Obesidade Grau III (mórbida) |
