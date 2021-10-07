import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:scored/generated/l10n.dart';
import 'package:scored/setup/setup_page.dart';
import 'package:scored/utils/extensions.dart';

import '../domain/game.dart';
import '../partials/layout.dart';
import 'history_item.dart';
import 'no_history.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State {
  final _selectedGames = <Game>{};
  bool _selecting = false;

  void _deleteSelected() {
    final s = S.of(context);
    final deletedGames = Set.from(_selectedGames);

    deleteGame(game) => game.delete();
    reAddGame(game) => Hive.box<Game>('games').add(game);

    _selectedGames.forEach(deleteGame);
    setState(() {
      _selecting = false;
      _selectedGames.clear();
    });
    context.showSnackbar(s.deletedParties(deletedGames.length), s.undo, () {
      deletedGames.forEach(reAddGame);
    });
  }

  void _toggleSelected(Game game) {
    setState(() {
      _selectedGames.contains(game)
          ? _selectedGames.remove(game)
          : _selectedGames.add(game);

      if (!_selecting && _selectedGames.isNotEmpty) {
        _selecting = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Layout(
        appBar: _selecting
            ? AppBar(
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    setState(() {
                      _selecting = false;
                      _selectedGames.clear();
                    });
                  },
                ),
                title:
                    Text(S.of(context).selectedParties(_selectedGames.length)),
                actions: <Widget>[
                  Padding(
                      padding: const EdgeInsets.only(right: 20.0),
                      child: GestureDetector(
                        onTap: _deleteSelected,
                        child: const Icon(
                          Icons.delete,
                          size: 26.0,
                        ),
                      ))
                ],
              )
            : null,
        scaffoldKey: 'HistoryScaffold',
        fabIcon: const Icon(Icons.add),
        fabAction: () => Navigator.of(context)
            .pushNamed(SetupPage.route, arguments: SetupPageArgs()),
        child: ValueListenableBuilder(
          valueListenable: Hive.box<Game>('games').listenable(),
          builder: (BuildContext context, Box<Game> box, Widget? widget) {
            if (box.isEmpty) {
              return const NoHistory();
            }

            final list = box.values.toList();
            list.sort((game1, game2) => game2.date.compareTo(game1.date));

            return ListView.separated(
              itemBuilder: (context, listIndex) {
                final game = list[listIndex];
                return HistoryItem(game, _selectedGames.contains(game),
                    _selecting, () => _toggleSelected(game));
              },
              itemCount: box.length,
              separatorBuilder: (_, __) => const Divider(),
            );
          },
        ));
  }
}
