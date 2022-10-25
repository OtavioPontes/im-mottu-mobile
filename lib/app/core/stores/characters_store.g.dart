// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'characters_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$CharactersStore on CharactersStoreBase, Store {
  final _$charactersAtom = Atom(name: 'CharactersStoreBase.characters');

  @override
  List<Char> get characters {
    _$charactersAtom.reportRead();
    return super.characters;
  }

  @override
  set characters(List<Char> value) {
    _$charactersAtom.reportWrite(value, super.characters, () {
      super.characters = value;
    });
  }

  final _$setCharactersAsyncAction =
      AsyncAction('CharactersStoreBase.setCharacters');

  @override
  Future<void> setCharacters(List<Char> heroes) {
    return _$setCharactersAsyncAction.run(() => super.setCharacters(heroes));
  }

  @override
  String toString() {
    return '''
characters: ${characters}
    ''';
  }
}
