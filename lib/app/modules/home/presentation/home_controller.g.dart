// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$HomeController on HomeControllerBase, Store {
  Computed<List<Char>>? _$heroesComputed;

  @override
  List<Char> get heroes =>
      (_$heroesComputed ??= Computed<List<Char>>(() => super.heroes,
              name: 'HomeControllerBase.heroes'))
          .value;

  final _$isAscendingAtom = Atom(name: 'HomeControllerBase.isAscending');

  @override
  bool get isAscending {
    _$isAscendingAtom.reportRead();
    return super.isAscending;
  }

  @override
  set isAscending(bool value) {
    _$isAscendingAtom.reportWrite(value, super.isAscending, () {
      super.isAscending = value;
    });
  }

  final _$stateAtom = Atom(name: 'HomeControllerBase.state');

  @override
  ControlState get state {
    _$stateAtom.reportRead();
    return super.state;
  }

  @override
  set state(ControlState value) {
    _$stateAtom.reportWrite(value, super.state, () {
      super.state = value;
    });
  }

  final _$fetchHeroesAsyncAction =
      AsyncAction('HomeControllerBase.fetchHeroes');

  @override
  Future<void> fetchHeroes({String? startsWith, int? offset}) {
    return _$fetchHeroesAsyncAction
        .run(() => super.fetchHeroes(startsWith: startsWith, offset: offset));
  }

  final _$HomeControllerBaseActionController =
      ActionController(name: 'HomeControllerBase');

  @override
  void setIsAscending(bool isDescending) {
    final _$actionInfo = _$HomeControllerBaseActionController.startAction(
        name: 'HomeControllerBase.setIsAscending');
    try {
      return super.setIsAscending(isDescending);
    } finally {
      _$HomeControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setState(ControlState nextState) {
    final _$actionInfo = _$HomeControllerBaseActionController.startAction(
        name: 'HomeControllerBase.setState');
    try {
      return super.setState(nextState);
    } finally {
      _$HomeControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isAscending: ${isAscending},
state: ${state},
heroes: ${heroes}
    ''';
  }
}
