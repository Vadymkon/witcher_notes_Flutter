// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `en`
  String get local {
    return Intl.message(
      'en',
      name: 'local',
      desc: '',
      args: [],
    );
  }

  /// `MEOW`
  String get meow_message {
    return Intl.message(
      'MEOW',
      name: 'meow_message',
      desc: '',
      args: [],
    );
  }

  /// `Menu`
  String get menu {
    return Intl.message(
      'Menu',
      name: 'menu',
      desc: '',
      args: [],
    );
  }

  /// `TAP`
  String get tap {
    return Intl.message(
      'TAP',
      name: 'tap',
      desc: '',
      args: [],
    );
  }

  /// `Close`
  String get close {
    return Intl.message(
      'Close',
      name: 'close',
      desc: '',
      args: [],
    );
  }

  /// `Ok`
  String get ok {
    return Intl.message(
      'Ok',
      name: 'ok',
      desc: '',
      args: [],
    );
  }

  /// `Settings:`
  String get settings {
    return Intl.message(
      'Settings:',
      name: 'settings',
      desc: '',
      args: [],
    );
  }

  /// `Pro (without ads)`
  String get pro {
    return Intl.message(
      'Pro (without ads)',
      name: 'pro',
      desc: '',
      args: [],
    );
  }

  /// `DONAT!`
  String get donat {
    return Intl.message(
      'DONAT!',
      name: 'donat',
      desc: '',
      args: [],
    );
  }

  /// `Hunting is now easier!`
  String get discr {
    return Intl.message(
      'Hunting is now easier!',
      name: 'discr',
      desc: '',
      args: [],
    );
  }

  /// `Failed`
  String get failed {
    return Intl.message(
      'Failed',
      name: 'failed',
      desc: '',
      args: [],
    );
  }

  /// `Done`
  String get done {
    return Intl.message(
      'Done',
      name: 'done',
      desc: '',
      args: [],
    );
  }

  /// `Task`
  String get task {
    return Intl.message(
      'Task',
      name: 'task',
      desc: '',
      args: [],
    );
  }

  /// `Quests`
  String get quests {
    return Intl.message(
      'Quests',
      name: 'quests',
      desc: '',
      args: [],
    );
  }

  /// `DateStart: `
  String get dateStart {
    return Intl.message(
      'DateStart: ',
      name: 'dateStart',
      desc: '',
      args: [],
    );
  }

  /// `Deadline: `
  String get deadline {
    return Intl.message(
      'Deadline: ',
      name: 'deadline',
      desc: '',
      args: [],
    );
  }

  /// `Make Note`
  String get makenote {
    return Intl.message(
      'Make Note',
      name: 'makenote',
      desc: '',
      args: [],
    );
  }

  /// `Title: `
  String get title {
    return Intl.message(
      'Title: ',
      name: 'title',
      desc: '',
      args: [],
    );
  }

  /// `Description: `
  String get description {
    return Intl.message(
      'Description: ',
      name: 'description',
      desc: '',
      args: [],
    );
  }

  /// `\n(optionally): `
  String get optionally {
    return Intl.message(
      '\n(optionally): ',
      name: 'optionally',
      desc: '',
      args: [],
    );
  }

  /// `Is Important?`
  String get is_important {
    return Intl.message(
      'Is Important?',
      name: 'is_important',
      desc: '',
      args: [],
    );
  }

  /// `Directory:`
  String get directory {
    return Intl.message(
      'Directory:',
      name: 'directory',
      desc: '',
      args: [],
    );
  }

  /// `Place:`
  String get place {
    return Intl.message(
      'Place:',
      name: 'place',
      desc: '',
      args: [],
    );
  }

  /// `AI`
  String get ai {
    return Intl.message(
      'AI',
      name: 'ai',
      desc: '',
      args: [],
    );
  }

  /// `New Note`
  String get newnote {
    return Intl.message(
      'New Note',
      name: 'newnote',
      desc: '',
      args: [],
    );
  }

  /// `QUEST FAILED!`
  String get q2 {
    return Intl.message(
      'QUEST FAILED!',
      name: 'q2',
      desc: '',
      args: [],
    );
  }

  /// `QUEST COMPLETED!`
  String get q3 {
    return Intl.message(
      'QUEST COMPLETED!',
      name: 'q3',
      desc: '',
      args: [],
    );
  }

  /// `NEW QUEST!`
  String get q4 {
    return Intl.message(
      'NEW QUEST!',
      name: 'q4',
      desc: '',
      args: [],
    );
  }

  /// `QUEST UPDATED!`
  String get q1 {
    return Intl.message(
      'QUEST UPDATED!',
      name: 'q1',
      desc: '',
      args: [],
    );
  }

  /// `Thanks for using!`
  String get thanks {
    return Intl.message(
      'Thanks for using!',
      name: 'thanks',
      desc: '',
      args: [],
    );
  }

  /// `Vadym HEKAHOH!`
  String get vk {
    return Intl.message(
      'Vadym HEKAHOH!',
      name: 'vk',
      desc: '',
      args: [],
    );
  }

  /// `Plus Buttons`
  String get plusB {
    return Intl.message(
      'Plus Buttons',
      name: 'plusB',
      desc: '',
      args: [],
    );
  }

  /// `(You still can add your notes using long-press on directory-menu)`
  String get tip1 {
    return Intl.message(
      '(You still can add your notes using long-press on directory-menu)',
      name: 'tip1',
      desc: '',
      args: [],
    );
  }

  /// `Lorem ipsum dolor sit amet, et vel meis dicat, vituperata disputationi eu vis, congue ignota no sed. Mel ex erroribus maluisset, id altera officiis consectetuer vis, an qui utinam theophrastus. Ne minim legendos sed, ea has meliore interesset. Et bonorum luptatum mel, his tation tamquam volutpat an. Quo ei debet integre, ei melius copiosae ius, nec nostro blandit ei.`
  String get template {
    return Intl.message(
      'Lorem ipsum dolor sit amet, et vel meis dicat, vituperata disputationi eu vis, congue ignota no sed. Mel ex erroribus maluisset, id altera officiis consectetuer vis, an qui utinam theophrastus. Ne minim legendos sed, ea has meliore interesset. Et bonorum luptatum mel, his tation tamquam volutpat an. Quo ei debet integre, ei melius copiosae ius, nec nostro blandit ei.',
      name: 'template',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ru'),
      Locale.fromSubtags(languageCode: 'ua'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
