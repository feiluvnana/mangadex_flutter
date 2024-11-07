import 'package:drift/drift.dart';
import 'package:mangadex_flutter/core/services/local/drift/type_converter.dart';

class LibraryMangaTable extends Table {
  TextColumn get mangaId => text().withLength()();
  TextColumn get mangaTitle => text().map(LocalizedStringConverter()).withLength()();
  TextColumn get coverUrl => text().withLength()();

  @override
  Set<Column<Object>>? get primaryKey => {mangaId};
}
