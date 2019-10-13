// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$TodoStore on _TodoStore, Store {
  final _$todosAtom = Atom(name: '_TodoStore.todos');

  @override
  List<Todo> get todos {
    _$todosAtom.context.enforceReadPolicy(_$todosAtom);
    _$todosAtom.reportObserved();
    return super.todos;
  }

  @override
  set todos(List<Todo> value) {
    _$todosAtom.context.conditionallyRunInAction(() {
      super.todos = value;
      _$todosAtom.reportChanged();
    }, _$todosAtom, name: '${_$todosAtom.name}_set');
  }

  final _$remindersAtom = Atom(name: '_TodoStore.reminders');

  @override
  List<Reminder> get reminders {
    _$remindersAtom.context.enforceReadPolicy(_$remindersAtom);
    _$remindersAtom.reportObserved();
    return super.reminders;
  }

  @override
  set reminders(List<Reminder> value) {
    _$remindersAtom.context.conditionallyRunInAction(() {
      super.reminders = value;
      _$remindersAtom.reportChanged();
    }, _$remindersAtom, name: '${_$remindersAtom.name}_set');
  }

  final _$getTodosAsyncAction = AsyncAction('getTodos');

  @override
  Future<void> getTodos() {
    return _$getTodosAsyncAction.run(() => super.getTodos());
  }
}
