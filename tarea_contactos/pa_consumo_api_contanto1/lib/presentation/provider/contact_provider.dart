import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pa_consumo_api_contanto1/data/repositories/contact_repository_impl.dart';
import '../../domain/entities/contact.dart';
import '../../data/repositories/contact_repository_impl.dart';
import '../../data/datasources/contact_api.dart';

class ContactNotifier extends StateNotifier<List<Contact>> {

  final ContactRepositoryImpl repository;

  ContactNotifier(this.repository) : super([]) {
    // Cargar contactos al iniciar el Notifier
    loadContacts();
  }


  //obtener todos los contactos
  Future<void> loadContacts() async {
    try {
      final contacts = await repository.getContacts();
      state = contacts;
    } catch (e) {
      // Manejo de errores, por ejemplo, mostrar un mensaje al usuario
      print('Error al cargar contactos: $e');
    }
  }

  // Crear un nuevo contacto
  Future<void> createContact(Contact contact) async {
    try {
      final newContact = await repository.create(contact);
      state = [...state, newContact];
    } catch (e) {
      // Manejo de errores, por ejemplo, mostrar un mensaje al usuario
      print('Error al crear contacto: $e');
    }
  }

  // Actualizar un contacto existente
  Future<void> updateContact(Contact contact) async {
    try {
      final updatedContact = await repository.update(contact);
      state = state
          .map((c) => c.id == updatedContact.id ? updatedContact : c)
          .toList();
    } catch (e) {
      // Manejo de errores, por ejemplo, mostrar un mensaje al usuario
      print('Error al actualizar contacto: $e');
    }
  }

  // Eliminar un contacto
  Future<void> deleteContact(int id) async {
    try {
      await repository.delete(id);
      state = state.where((c) => c.id != id).toList();
    } catch (e) {
      // Manejo de errores, por ejemplo, mostrar un mensaje al usuario
      print('Error al eliminar contacto: $e');
    }
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

final contactProvider = StateNotifierProvider<ContactNotifier, List<Contact>>((ref) {
  final contactAPI = ContactAPI();
  final repository = ContactRepositoryImpl(contactAPI);
  return ContactNotifier(repository);
});