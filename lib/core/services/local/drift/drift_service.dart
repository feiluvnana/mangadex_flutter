import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:mangadex_flutter/core/services/local/drift/tables/library_manga_table.dart';
import 'package:mangadex_flutter/core/services/local/drift/type_converter.dart';
import 'package:path_provider/path_provider.dart';

part 'drift_service.g.dart';

@DriftDatabase(tables: [LibraryMangaTable])
class DriftService extends _$DriftService {
  DriftService() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(beforeOpen: (details) async {
        await getApplicationDocumentsDirectory()
            .then((dir) => dir.listSync().forEach((file) => file.deleteSync()));
      });

  static QueryExecutor _openConnection() {
    return driftDatabase(
        name: "fln_mangadex",
        web: DriftWebOptions(
            sqlite3Wasm: Uri.parse("sqlite3.wasm"),
            driftWorker: Uri.parse("drift_worker.js")));
  }
}
