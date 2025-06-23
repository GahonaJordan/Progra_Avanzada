import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/contact.dart';
import '../provider/contact_provider.dart';
import '../widgets/contact_title.dart';

class ContactListPage extends ConsumerWidget {
  const ContactListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(contactProvider);
    final agrupados = agruparPorInicial(state);

    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      appBar: AppBar(
        title: const Text("Contacts"),
        backgroundColor: Colors.blue.shade700,
        elevation: 2,
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
        ],
      ),
      body: agrupados.isEmpty
          ? const Center(child: Text("No hay contactos"))
          : ListView.builder(
        itemCount: agrupados.length,
        itemBuilder: (context, index) {
          final letra = agrupados.keys.elementAt(index);
          final lista = agrupados[letra]!;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                color: Colors.grey.shade200,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                child: Text(letra, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black54)),
              ),
              ...lista.map((c) => ContactTile(contact: c)),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.lightBlue.shade400,
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.pushNamed(context, '/form');
        },
      ),
    );
  }

  Map<String, List<Contact>> agruparPorInicial(List<Contact> contactos) {
    final Map<String, List<Contact>> grouped = {};
    for (var c in contactos) {
      final letra = c.nombre[0].toUpperCase();
      grouped.putIfAbsent(letra, () => []).add(c);
    }
    final sorted = Map.fromEntries(grouped.entries.toList()
      ..sort((a, b) => a.key.compareTo(b.key)));
    return sorted;
  }
}