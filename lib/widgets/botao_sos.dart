import 'package:flutter/material.dart';
import 'package:segura_app/services/sos_service.dart';
import 'package:segura_app/theme/app_colors.dart';

class BotaoSosWidget extends StatefulWidget {
  const BotaoSosWidget({super.key});

  @override
  State<BotaoSosWidget> createState() => _BotaoSosWidgetState();
}

class _BotaoSosWidgetState extends State<BotaoSosWidget> {
  final SOSService _sosService = SOSService();
  bool _isLoading = false;

  void _acionarOuEscolher() async {
    final contatos = await _sosService.obterContatos();

    if (contatos.isEmpty) {
      _mostrarDialogGerenciamento();
      return;
    }

    if (contatos.length == 1) {
      _dispararSOS(contatos.first['numero']!);
      return;
    }

    _mostrarBottomSheetEscolha(contatos);
  }

  void _dispararSOS(String numero) async {
    if (mounted) setState(() => _isLoading = true);
    final sucesso = await _sosService.acionarSOS(numero);

    if (mounted) {
      setState(() => _isLoading = false);
      if (!sucesso) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Falha ao abrir WhatsApp. Verifique sua conexão o; se o app está instalado.',
            ),
          ),
        );
      }
    }
  }

  void _mostrarBottomSheetEscolha(List<Map<String, String>> contatos) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'Enviar SOS para:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              const Divider(height: 1),
              ...contatos.map(
                (c) => ListTile(
                  leading: const CircleAvatar(
                    backgroundColor: AppColors.alertaVermelho,
                    child: Icon(Icons.warning, color: Colors.white, size: 20),
                  ),
                  title: Text(
                    c['nome'] ?? 'Anjo',
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  subtitle: Text(c['numero'] ?? ''),
                  onTap: () {
                    Navigator.pop(context);
                    _dispararSOS(c['numero']!);
                  },
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        );
      },
    );
  }

  void _mostrarDialogGerenciamento() {
    showDialog(
      context: context,
      builder: (context) => _PainelGerenciamento(sosService: _sosService),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: _mostrarDialogGerenciamento,
      child: FloatingActionButton.extended(
        onPressed: _isLoading ? null : _acionarOuEscolher,
        backgroundColor: AppColors.alertaVermelho,
        icon: _isLoading
            ? const SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2,
                ),
              )
            : const Icon(
                Icons.warning_amber_rounded,
                color: Colors.white,
                size: 28,
              ),
        label: const Text(
          'SOS',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}

class _PainelGerenciamento extends StatefulWidget {
  final SOSService sosService;
  const _PainelGerenciamento({required this.sosService});

  @override
  State<_PainelGerenciamento> createState() => _PainelGerenciamentoState();
}

class _PainelGerenciamentoState extends State<_PainelGerenciamento> {
  List<Map<String, String>> _contatos = [];

  @override
  void initState() {
    super.initState();
    _carregarContatos();
  }

  Future<void> _carregarContatos() async {
    final lista = await widget.sosService.obterContatos();
    if (mounted) {
      setState(() => _contatos = lista);
    }
  }

  void _excluirContato(String numero) async {
    await widget.sosService.removerContato(numero);
    _carregarContatos();
  }

  void _adicionarNovoContato() {
    final nomeController = TextEditingController();
    final numeroController = TextEditingController();

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Novo Anjo'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nomeController,
              decoration: const InputDecoration(
                hintText: 'Nome (ex: Mãe)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: numeroController,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                hintText: 'Número c/ DDD',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () async {
              if (nomeController.text.isNotEmpty &&
                  numeroController.text.isNotEmpty) {
                await widget.sosService.adicionarContato(
                  nomeController.text.trim(),
                  numeroController.text.trim(),
                );
                if (ctx.mounted) {
                  Navigator.pop(ctx);
                }
                if (mounted) {
                  _carregarContatos();
                }
              }
            },
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary),
            child: const Text('Salvar', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        'Anjos da Guarda',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      content: SizedBox(
        width: double.maxFinite,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Cadastre as pessoas que irão te socorrer. Segure o botão SOS no app sempre que quiser abrir esta tela.',
              style: TextStyle(fontSize: 13),
            ),
            const SizedBox(height: 15),
            if (_contatos.isEmpty)
              const Padding(
                padding: EdgeInsets.all(20.0),
                child: Text(
                  'Nenhum cadastrado ainda.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey),
                ),
              )
            else
              ConstrainedBox(
                constraints: const BoxConstraints(maxHeight: 250),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: _contatos.length,
                  itemBuilder: (context, index) {
                    final c = _contatos[index];
                    return Card(
                      elevation: 1,
                      child: ListTile(
                        title: Text(
                          c['nome']!,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(c['numero']!),
                        trailing: IconButton(
                          icon: const Icon(
                            Icons.delete_outline,
                            color: Colors.grey,
                          ),
                          onPressed: () => _excluirContato(c['numero']!),
                        ),
                      ),
                    );
                  },
                ),
              ),
            const SizedBox(height: 15),
            ElevatedButton.icon(
              onPressed: _adicionarNovoContato,
              icon: const Icon(Icons.add, color: Colors.white),
              label: const Text(
                'Adicionar Novo',
                style: TextStyle(color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(backgroundColor: AppColors.ajuda),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Fechar'),
        ),
      ],
    );
  }
}
