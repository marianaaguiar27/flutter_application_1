import 'package:flutter/material.dart';
import '../models/pessoa.dart';
import '../widgets/pessoa_item.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/cores.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static const int capacidadeMaxima =50;

  final List<Pessoa> pessoas = [];
  final TextEditingController nomeController = TextEditingController();
  final TextEditingController idController = TextEditingController();

  @override
  void dispose() {
    nomeController.dispose();
    idController.dispose();
    super.dispose();
  }

  int get pessoasNoAmbiente => pessoas.where((p) => p.estaNoAmbiente).length;

  bool get isEmpty => pessoasNoAmbiente == 0;
  bool get isFull => pessoasNoAmbiente >= capacidadeMaxima;
  bool get isAlmostFull => pessoasNoAmbiente >= 45 && !isFull;
  Color get corStatus => isFull
      ? Cores.vermelho
      : isAlmostFull
          ? Cores.amarelo
          : Cores.verde;

    void cadastrar() {
    final nome = nomeController.text.trim();
    final id = idController.text.trim();

    if (nome.isEmpty || id.isEmpty) {
      mostrarMensagem("Preencha o nome e a identificação.", erro: true);
      return;
    }

    if (isFull) {
      mostrarMensagem(
        "Não é possível realizar a entrada. Ambiente lotado!",
        erro: true,
      );
      return;
    }

    final idJaNoAmbiente = pessoas.any(
      (p) => p.identificacao == id && p.estaNoAmbiente,
    );
    if (idJaNoAmbiente) {
      mostrarMensagem(
        "Já existe uma pessoa no ambiente com essa identificação.",
        erro: true,
      );
      return;
    }

    setState(() {
      pessoas.add(Pessoa(
        nome: nome,
        identificacao: id,
        dataEntrada: DateTime.now(),
      ));
    });

    nomeController.clear();
    idController.clear();
    mostrarMensagem("Pessoa cadastrada com sucesso!");
  }

  void registrarSaida(Pessoa pessoa) {
    if (!pessoa.estaNoAmbiente) {
      mostrarMensagem("Essa pessoa já saiu.", erro: true);
      return;
    }

    setState(() {
      pessoa.dataSaida = DateTime.now();
    });
    mostrarMensagem("Saída registrada com sucesso!");
  }
  
  void mostrarMensagem(String texto, {bool erro = false}) {
    final messenger = ScaffoldMessenger.of(context);
    messenger.hideCurrentSnackBar(); 
    messenger.showSnackBar(
      SnackBar(
        content: Text(texto),
        backgroundColor: erro ? Colors.red[800] : Colors.green[700],
      ),
    );
  }

  Future<bool> confirmar({
    required String titulo,
    required String mensagem,
  }) async {
    final resultado = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(titulo),
        content: Text(mensagem),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text("CANCELAR"),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text("CONFIRMAR"),
          ),
        ],
      ),
    );
    return resultado ?? false;
  }

    Future<void> confirmarSaida(Pessoa pessoa) async {
    if (!pessoa.estaNoAmbiente) {
      mostrarMensagem("Essa pessoa já saiu.", erro: true);
      return;
    }

    final confirmou = await confirmar(
      titulo: "Registrar saída?",
      mensagem: "Deseja realmente registrar a saída de ${pessoa.nome}?",
    );

    if (!mounted) return;
    if (confirmou) registrarSaida(pessoa);
  }

  Future<void> confirmarExclusao(Pessoa pessoa) async {
    final confirmou = await confirmar(
      titulo: "Excluir registro?",
      mensagem: "Deseja realmente excluir o registro de ${pessoa.nome}?",
    );

    if (!mounted) return;
    if (confirmou) {
      setState(() {
        pessoas.remove(pessoa);
      });
      mostrarMensagem("Registro excluído com sucesso!");
    }
  }

   @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Cores.fundo,
      appBar: AppBar(
        backgroundColor: Cores.vinho,
        centerTitle: true,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.theaters, color: Cores.dourado),
            const SizedBox(width: 8),
            Text(
              "CINE CONTROLE",
              style: GoogleFonts.bebasNeue(
                fontSize: 28,
                letterSpacing: 2,
                color: Cores.dourado,
              ),
            ),
          ],
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: const AssetImage("assets/images/fundocinema.jpg"),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.black.withAlpha(170),
              BlendMode.darken,
            ),
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.circle, size: 14, color: corStatus),
                        const SizedBox(width: 8),
                        Text(
                          isFull
                              ? "Sessão lotada"
                              : isAlmostFull
                                  ? "Sessão quase cheia!"
                                  : "Pode entrar",
                          style: GoogleFonts.poppins(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "$pessoasNoAmbiente / $capacidadeMaxima",
                      style: GoogleFonts.bebasNeue(
                        fontSize: 64,
                        color: Cores.dourado,
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: nomeController,
                      decoration: const InputDecoration(
                        labelText: "Nome",
                        prefixIcon: Icon(Icons.person),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: idController,
                      decoration: const InputDecoration(
                        labelText: "Ingresso / matrícula",
                        prefixIcon: Icon(Icons.confirmation_number),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: ElevatedButton.icon(
                        onPressed: cadastrar,
                        icon: const Icon(Icons.add),
                        label: Text(
                          "REGISTRAR ENTRADA",
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              isFull ? Colors.grey : Cores.dourado,
                          foregroundColor: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: pessoas.isEmpty
                    ? Center(
                        child: Text(
                          "Nenhum espectador cadastrado",
                          style: GoogleFonts.poppins(
                            color: Colors.white70,
                            fontSize: 16,
                          ),
                        ),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        itemCount: pessoas.length,
                        itemBuilder: (context, index) {
                          final pessoa = pessoas[index];
                          return PessoaItem(
                            pessoa: pessoa,
                            onSaida: () => confirmarSaida(pessoa),
                            onExcluir: () => confirmarExclusao(pessoa),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}