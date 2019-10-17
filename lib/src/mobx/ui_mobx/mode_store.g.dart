// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mode_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$LightOrDark on _LightOrDark, Store {
  final _$modeAtom = Atom(name: '_LightOrDark.mode');

  @override
  ThemeData get mode {
    _$modeAtom.context.enforceReadPolicy(_$modeAtom);
    _$modeAtom.reportObserved();
    return super.mode;
  }

  @override
  set mode(ThemeData value) {
    _$modeAtom.context.conditionallyRunInAction(() {
      super.mode = value;
      _$modeAtom.reportChanged();
    }, _$modeAtom, name: '${_$modeAtom.name}_set');
  }

  final _$_LightOrDarkActionController = ActionController(name: '_LightOrDark');

  @override
  void normalMode() {
    final _$actionInfo = _$_LightOrDarkActionController.startAction();
    try {
      return super.normalMode();
    } finally {
      _$_LightOrDarkActionController.endAction(_$actionInfo);
    }
  }

  @override
  void darkMode() {
    final _$actionInfo = _$_LightOrDarkActionController.startAction();
    try {
      return super.darkMode();
    } finally {
      _$_LightOrDarkActionController.endAction(_$actionInfo);
    }
  }
}
