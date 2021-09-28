// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a de locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'de';

  static String m0(count) => "gelöschte ${count} Gruppen";

  static String m1(name) => "gelöscht ${name}";

  static String m2(date, time) => "${date} ${time}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "cancel": MessageLookupByLibrary.simpleMessage("Abbrechen"),
        "continueParty": MessageLookupByLibrary.simpleMessage("Weiter"),
        "createParty":
            MessageLookupByLibrary.simpleMessage("Erstelle eine Gruppe"),
        "darkMode": MessageLookupByLibrary.simpleMessage("Dark Mode"),
        "delete": MessageLookupByLibrary.simpleMessage("Löschen"),
        "deletedParties": m0,
        "deletedParty": m1,
        "historyDate": m2,
        "language": MessageLookupByLibrary.simpleMessage("Sprache"),
        "noHistoryBody1":
            MessageLookupByLibrary.simpleMessage("Drücke den Button"),
        "noHistoryBody2": MessageLookupByLibrary.simpleMessage(
            "Und started jetzt eine neue Gruppe!"),
        "noHistoryTitle":
            MessageLookupByLibrary.simpleMessage("Keine Historie gefunden :("),
        "noNameError":
            MessageLookupByLibrary.simpleMessage("Name ist notwendig"),
        "notFoundBody": MessageLookupByLibrary.simpleMessage(
            "Diese Seite existiert nicht vielleicht möchtest du"),
        "notFoundButton":
            MessageLookupByLibrary.simpleMessage("Zurück zum Hauptbildschirm"),
        "partyName": MessageLookupByLibrary.simpleMessage("Gruppenname"),
        "playerCount":
            MessageLookupByLibrary.simpleMessage("Anzahl der Spieler"),
        "playerName": MessageLookupByLibrary.simpleMessage("Name"),
        "playerScore": MessageLookupByLibrary.simpleMessage("Spielstände"),
        "restart": MessageLookupByLibrary.simpleMessage(" Neustart"),
        "selectColor":
            MessageLookupByLibrary.simpleMessage("Wähle eine Hauptfarbe"),
        "selectColorShade":
            MessageLookupByLibrary.simpleMessage("Wähle einen Farbton"),
        "start": MessageLookupByLibrary.simpleMessage("Start"),
        "today": MessageLookupByLibrary.simpleMessage("Heute"),
        "viewScores":
            MessageLookupByLibrary.simpleMessage("Spielstände ansehen"),
        "yesterday": MessageLookupByLibrary.simpleMessage("Morgen")
      };
}
