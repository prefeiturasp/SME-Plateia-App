
[![GPLv3 License](https://img.shields.io/badge/License-GPL%20v3-yellow.svg)](https://opensource.org/licenses/) 
![Flutter](https://img.shields.io/badge/Flutter-%2302569B.svg?style=for-the-badge&logo=Flutter&logoColor=white)


# App Plateia

O App Plateia é um aplicativo criado para facilitar a visualização das inscrições do site do [Plateia](https://plateia.sme.prefeitura.sp.gov.br/).



## Funcionalidades

* Acessar os eventos incritos
* Visualizar detalhes do eventos
* Visualizar e salvar o voucher do evento


## Variáveis de Ambiente

Para rodar esse projeto, você vai precisar adicionar as seguintes variáveis de ambiente no seu .env

`URL_API` - URL da API de acesso

`URL_RECUPERAR_SENHA` - URL de recuperação de senha do Plateia


## Instalação

Instale App Plateia com Flutter

```shell
  flutter pub get
  flutter packages pub run build_runner build --delete-conflicting-outputs
```
    
## Configure o Firebase

```shell
# Development
./firebase.sh app-plateia-dev development br.gov.sp.prefeitura.sme.plateia.dev br.gov.sp.prefeitura.sme.plateia.dev

# Staging                                              
./firebase.sh app-plateia-hom staging br.gov.sp.prefeitura.sme.plateia.stg br.gov.sp.prefeitura.sme.plateia.stg

# Production
./firebase.sh app-plateia-prd production br.gov.sp.prefeitura.sme.plateia br.gov.sp.prefeitura.sme.plateia
```
## Execução

Este projeto possui 3 flavors:

- development
- staging
- production

Para executar o tipo desejado, use a configuração de inicialização no VSCode/Android Studio ou use os seguintes comandos:

```sh
# Development
$ flutter run --flavor development --target lib/main_development.dart

# Staging
$ flutter run --flavor staging --target lib/main_staging.dart

# Production
$ flutter run --flavor production --target lib/main_production.dart
```

## Makefile Command

Este projeto está equipado com o comando Makefile para encurtar a escrita do comando, para ver o comando disponível, consulte [Makefile](https://github.com/prefeiturasp/SME-Plateia-App/blob/master/Makefile).

Para executar o tipo desejado, use a configuração de inicialização no VSCode/Android Studio ou use os seguintes comandos:

```sh
# run build_runner once
$ make build
# watch file change
$ make watch
# generate dev apk
$ make apk-dev
# generate staging apk
$ make apk-stg
# generate production apk
$ make apk-prod
# generate dev ipa
$ make ipa-dev
# generate staging ipa
$ make ipa-stg
# generate production ipa
$ make ipa-prod
# fix code
$ make fix
# check fix
$ make check-fix
```
## Referência

 - [Site Plateia](https://plateia.sme.prefeitura.sp.gov.br/)
 - [Flutter](https://flutter.dev/)

