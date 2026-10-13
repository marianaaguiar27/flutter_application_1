# Cine Controle

## Descrição
Aplicativo Flutter para controlar a lotação e o gerenciamento de acessos
de uma sala de cinema. Permite cadastrar espectadores, registrar entradas
e saídas e respeitar a capacidade máxima da sala (50 pessoas).

## Ambiente escolhido
Sala de cinema

## Integrantes
- Mariana de Paula Aguiar - RM566850
- Gustavo Miguel Martins de Oliveira - RM566666 

## Vídeo de demonstração
[Assistir ao vídeo no YouTube](https://youtu.be/6TBexwU87rw)

## Como executar
1. Instale o Flutter e configure um emulador ou dispositivo.
2. Clone o repositório:
   `git clone [https://github.com/marianaaguiar27/flutter_application_1.git]`
3. Entre na pasta e instale as dependências:
   `flutter pub get`
4. Execute:
   `flutter run`

## Tecnologias e pacotes
- Flutter / Dart
- intl (formatação de data e hora)
- google_fonts (tipografia)
- flutter_slidable (ações ao deslizar)
- flutter_launcher_icons (ícone do app)

## Funcionalidades
- Cadastro de pessoas (nome, identificação e data/hora)
- Lista de pessoas com situação (No ambiente / Saiu)
- Registro de saída com confirmação (AlertDialog)
- Exclusão de registros
- Controle de capacidade máxima
- Bloqueio de identificação duplicada
- Feedback ao usuário com SnackBar
