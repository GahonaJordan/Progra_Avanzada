import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/contact.dart';

class ContactNotifier extends StateNotifier<List<Contact>> {
  ContactNotifier() : super([]);

  void addContact(Contact contact) {
    // Genera un nuevo id si es necesario
    final newId = state.isEmpty ? 1 : (state.map((c) => c.id).reduce((a, b) => a > b ? a : b) + 1);
    state = [...state, contact.copyWith(id: newId)];
  }

  void updateContact(Contact contact) {
    state = [
      for (final c in state)
        if (c.id == contact.id) contact else c
    ];
  }

  void deleteContact(String id) {
    state = state.where((c) => c.id.toString() != id).toList();
  }
}

extension on Contact {
  Contact copyWith({
    int? id,
    String? nombre,
    String? empresa,
    String? numero,
    String? foto,
  }) {
    return Contact(
      id: id ?? this.id,
      nombre: nombre ?? this.nombre,
      empresa: empresa ?? this.empresa,
      numero: numero ?? this.numero,
      foto: foto ?? this.foto,
    );
  }
}

final contactProvider = StateNotifierProvider<ContactNotifier, List<Contact>>(
      (ref) => ContactNotifier(),
);