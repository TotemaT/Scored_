<div align="center">
	<img src="./web/apple-touch-icon.png"/>
</div>


# Scored!

Scored! is a simple Flutter app that allows you to keep track of all countable things.
Use it to keep track of your board games scores, the number of yellow cars you passed, how many times your least favourite politician lied during their speech,...

Unlike the v1 of Scored!, your parties are now saved and can be either restarted from 0 with the same setup, or continued from where it stopped 👍

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

## How to deploy

-   To internal testing : `bundle exec fastlane internal`
-   To production : `bundle exec fastlane production`

## How to add an entity

-   Create the domain class (eg. game.dart)
-   Add the 'part' (eg. `game.g.dart`) which will be the name of the generated TypeAdapter
-   Annotate the class with `@HiveType(id)` (where id is the biggest index so far +1)
-   Annotate every fields with `@HiveField(id)` (with every id being unique in the class)
-   Run `flutter packages pub run build_runner build` to generate the TypeAdapter
