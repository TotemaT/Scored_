# Scored!

## Stack

-   Flutter
-   Hive
-   Provider

## How to build

### In the terminal

-   Install the dependencies `flutter pub get`
-   Web : `flutter build web`
-   Android : `flutter build appbundle`
-   MacOS (only on a mac) : `flutter build macos`
-   Windows (only on windows) : `flutter build macos`
-   Linux (only on linux) : `flutter build linux`

## How to add an entity

-   Create the domain class (eg. game.dart)
-   Add the 'part' (eg. `game.g.dart`) which will be the name of the generated TypeAdapter
-   Annotate the class with `@HiveType(id)` (where id is the biggest index so far +1)
-   Annotate every fields with `@HiveField(id)` (with every id being unique in the class)
-   Run `flutter packages pub run build_runner build` to generate the TypeAdapter
