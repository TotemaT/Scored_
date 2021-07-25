// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a fr locale. All the
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
  String get localeName => 'fr';

  static String m0(date, time) => "${date} ${time}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "cancel": MessageLookupByLibrary.simpleMessage("Annuler"),
        "continueParty": MessageLookupByLibrary.simpleMessage("Reprendre"),
        "createParty": MessageLookupByLibrary.simpleMessage("Créer la partie"),
        "darkMode": MessageLookupByLibrary.simpleMessage("Thème Sombre"),
        "delete": MessageLookupByLibrary.simpleMessage("Supprimer"),
        "historyDate": m0,
        "language": MessageLookupByLibrary.simpleMessage("Langue"),
        "noHistoryBody1":
            MessageLookupByLibrary.simpleMessage("Clique sur le bouton"),
        "noHistoryBody2": MessageLookupByLibrary.simpleMessage(
            "et commence une nouvelle partie maintenant"),
        "noHistoryTitle":
            MessageLookupByLibrary.simpleMessage("Aucun historique trouvé :("),
        "noNameError": MessageLookupByLibrary.simpleMessage("Nom requis"),
        "notFoundBody": MessageLookupByLibrary.simpleMessage(
            "Cette page n\'existe pas.. Peut être veux-tu"),
        "notFoundButton":
            MessageLookupByLibrary.simpleMessage("Retourner à l\'accueil"),
        "partyName": MessageLookupByLibrary.simpleMessage("Nom de la partie"),
        "playerCount":
            MessageLookupByLibrary.simpleMessage("Nombre de joueurs"),
        "playerName": MessageLookupByLibrary.simpleMessage("Nom du joueur"),
        "restart": MessageLookupByLibrary.simpleMessage(" Redémarrer"),
        "selectColor":
            MessageLookupByLibrary.simpleMessage("Sélectionne une couleur"),
        "selectColorShade":
            MessageLookupByLibrary.simpleMessage("Sélectionne une nuance"),
        "start": MessageLookupByLibrary.simpleMessage("Démarrer"),
        "today": MessageLookupByLibrary.simpleMessage("Aujourd\'hui"),
        "yesterday": MessageLookupByLibrary.simpleMessage("Hier")
      };
}
