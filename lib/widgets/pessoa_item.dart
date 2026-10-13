import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import '../models/pessoa.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/cores.dart';

class PessoaItem extends StatelessWidget {
  final Pessoa pessoa;
  final VoidCallback onSaida;
  final VoidCallback onExcluir; 

  const PessoaItem({
    super.key,
    required this.pessoa,
    required this.onSaida,
    required this.onExcluir,
  });

  @override
  Widget build(BuildContext context) {
    final entrada = DateFormat("dd/MM/yyyy 'às' HH:mm").format(pessoa.dataEntrada);
    
    return Slidable(
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: (context) => onSaida(),
            backgroundColor: Colors.orange[800]!,
            foregroundColor: Colors.white,
            icon: Icons.logout,
            label: "SAÍDA",
          ),
          SlidableAction(
            onPressed: (context) => onExcluir(),
            backgroundColor: Colors.red[800]!,
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: "EXCLUIR",
          ),
        ],
      ),
            child: Card(
        color: Cores.cardFundo,
        child: ListTile(
          leading: Icon(
            pessoa.estaNoAmbiente ? Icons.event_seat : Icons.exit_to_app,
            color: pessoa.estaNoAmbiente ? Cores.dourado : Colors.grey,
          ),
          title: Text(
            pessoa.nome,
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
          subtitle: Text(
            "ID: ${pessoa.identificacao}\n"
            "Entrada: $entrada\n"
            "Situação: ${pessoa.situacao}",
            style: GoogleFonts.poppins(color: Colors.white70, fontSize: 12),
          ),
          isThreeLine: true,
          trailing: IconButton(
            icon: const Icon(Icons.logout),
            color: Cores.dourado,
            disabledColor: Colors.grey,
            onPressed: pessoa.estaNoAmbiente ? onSaida : null,
          ),
        ),
      ),
    );
  }
}