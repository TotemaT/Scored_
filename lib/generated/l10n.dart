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

  /// `Cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `Continue`
  String get continueParty {
    return Intl.message(
      'Continue',
      name: 'continueParty',
      desc: '',
      args: [],
    );
  }

  /// `Create the party`
  String get createParty {
    return Intl.message(
      'Create the party',
      name: 'createParty',
      desc: '',
      args: [],
    );
  }

  /// `Dark Mode`
  String get darkMode {
    return Intl.message(
      'Dark Mode',
      name: 'darkMode',
      desc: '',
      args: [],
    );
  }

  /// `Delete`
  String get delete {
    return Intl.message(
      'Delete',
      name: 'delete',
      desc: '',
      args: [],
    );
  }

  /// `{date} {time}`
  String historyDate(Object date, Object time) {
    return Intl.message(
      '$date $time',
      name: 'historyDate',
      desc: '',
      args: [date, time],
    );
  }

  /// `Click on the button`
  String get noHistoryBody1 {
    return Intl.message(
      'Click on the button',
      name: 'noHistoryBody1',
      desc: '',
      args: [],
    );
  }

  /// `and start a new party now!`
  String get noHistoryBody2 {
    return Intl.message(
      'and start a new party now!',
      name: 'noHistoryBody2',
      desc: '',
      args: [],
    );
  }

  /// `No history found :(`
  String get noHistoryTitle {
    return Intl.message(
      'No history found :(',
      name: 'noHistoryTitle',
      desc: '',
      args: [],
    );
  }

  /// `Name is required`
  String get noNameError {
    return Intl.message(
      'Name is required',
      name: 'noNameError',
      desc: '',
      args: [],
    );
  }

  /// `This page doesn't exist maybe you want to`
  String get notFoundBody {
    return Intl.message(
      'This page doesn\'t exist maybe you want to',
      name: 'notFoundBody',
      desc: '',
      args: [],
    );
  }

  /// `Go back home`
  String get notFoundButton {
    return Intl.message(
      'Go back home',
      name: 'notFoundButton',
      desc: '',
      args: [],
    );
  }

  /// `Party Name`
  String get partyName {
    return Intl.message(
      'Party Name',
      name: 'partyName',
      desc: '',
      args: [],
    );
  }

  /// `Number of players`
  String get playerCount {
    return Intl.message(
      'Number of players',
      name: 'playerCount',
      desc: '',
      args: [],
    );
  }

  /// `Player Name`
  String get playerName {
    return Intl.message(
      'Player Name',
      name: 'playerName',
      desc: '',
      args: [],
    );
  }

  /// ` Restart`
  String get restart {
    return Intl.message(
      ' Restart',
      name: 'restart',
      desc: '',
      args: [],
    );
  }

  /// `Select a main color`
  String get selectColor {
    return Intl.message(
      'Select a main color',
      name: 'selectColor',
      desc: '',
      args: [],
    );
  }

  /// `Select a color shade`
  String get selectColorShade {
    return Intl.message(
      'Select a color shade',
      name: 'selectColorShade',
      desc: '',
      args: [],
    );
  }

  /// `Start`
  String get start {
    return Intl.message(
      'Start',
      name: 'start',
      desc: '',
      args: [],
    );
  }

  /// `Today`
  String get today {
    return Intl.message(
      'Today',
      name: 'today',
      desc: '',
      args: [],
    );
  }

  /// `Yesterday`
  String get yesterday {
    return Intl.message(
      'Yesterday',
      name: 'yesterday',
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
      Locale.fromSubtags(languageCode: 'de'),
      Locale.fromSubtags(languageCode: 'fr'),
      Locale.fromSubtags(languageCode: 'nl'),
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