// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'drift_service.dart';

// ignore_for_file: type=lint
class $LibraryMangaTableTable extends LibraryMangaTable
    with TableInfo<$LibraryMangaTableTable, LibraryMangaTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LibraryMangaTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _mangaIdMeta =
      const VerificationMeta('mangaId');
  @override
  late final GeneratedColumn<String> mangaId = GeneratedColumn<String>(
      'manga_id', aliasedName, false,
      additionalChecks: GeneratedColumn.checkTextLength(),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _mangaTitleMeta =
      const VerificationMeta('mangaTitle');
  @override
  late final GeneratedColumnWithTypeConverter<Map<String, String>, String>
      mangaTitle = GeneratedColumn<String>('manga_title', aliasedName, false,
              additionalChecks: GeneratedColumn.checkTextLength(),
              type: DriftSqlType.string,
              requiredDuringInsert: true)
          .withConverter<Map<String, String>>(
              $LibraryMangaTableTable.$convertermangaTitle);
  static const VerificationMeta _coverUrlMeta =
      const VerificationMeta('coverUrl');
  @override
  late final GeneratedColumn<String> coverUrl = GeneratedColumn<String>(
      'cover_url', aliasedName, false,
      additionalChecks: GeneratedColumn.checkTextLength(),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [mangaId, mangaTitle, coverUrl];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'library_manga_table';
  @override
  VerificationContext validateIntegrity(
      Insertable<LibraryMangaTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('manga_id')) {
      context.handle(_mangaIdMeta,
          mangaId.isAcceptableOrUnknown(data['manga_id']!, _mangaIdMeta));
    } else if (isInserting) {
      context.missing(_mangaIdMeta);
    }
    context.handle(_mangaTitleMeta, const VerificationResult.success());
    if (data.containsKey('cover_url')) {
      context.handle(_coverUrlMeta,
          coverUrl.isAcceptableOrUnknown(data['cover_url']!, _coverUrlMeta));
    } else if (isInserting) {
      context.missing(_coverUrlMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {mangaId};
  @override
  LibraryMangaTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LibraryMangaTableData(
      mangaId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}manga_id'])!,
      mangaTitle: $LibraryMangaTableTable.$convertermangaTitle.fromSql(
          attachedDatabase.typeMapping.read(
              DriftSqlType.string, data['${effectivePrefix}manga_title'])!),
      coverUrl: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}cover_url'])!,
    );
  }

  @override
  $LibraryMangaTableTable createAlias(String alias) {
    return $LibraryMangaTableTable(attachedDatabase, alias);
  }

  static TypeConverter<Map<String, String>, String> $convertermangaTitle =
      LocalizedStringConverter();
}

class LibraryMangaTableData extends DataClass
    implements Insertable<LibraryMangaTableData> {
  final String mangaId;
  final Map<String, String> mangaTitle;
  final String coverUrl;
  const LibraryMangaTableData(
      {required this.mangaId,
      required this.mangaTitle,
      required this.coverUrl});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['manga_id'] = Variable<String>(mangaId);
    {
      map['manga_title'] = Variable<String>(
          $LibraryMangaTableTable.$convertermangaTitle.toSql(mangaTitle));
    }
    map['cover_url'] = Variable<String>(coverUrl);
    return map;
  }

  LibraryMangaTableCompanion toCompanion(bool nullToAbsent) {
    return LibraryMangaTableCompanion(
      mangaId: Value(mangaId),
      mangaTitle: Value(mangaTitle),
      coverUrl: Value(coverUrl),
    );
  }

  factory LibraryMangaTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LibraryMangaTableData(
      mangaId: serializer.fromJson<String>(json['mangaId']),
      mangaTitle: serializer.fromJson<Map<String, String>>(json['mangaTitle']),
      coverUrl: serializer.fromJson<String>(json['coverUrl']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'mangaId': serializer.toJson<String>(mangaId),
      'mangaTitle': serializer.toJson<Map<String, String>>(mangaTitle),
      'coverUrl': serializer.toJson<String>(coverUrl),
    };
  }

  LibraryMangaTableData copyWith(
          {String? mangaId,
          Map<String, String>? mangaTitle,
          String? coverUrl}) =>
      LibraryMangaTableData(
        mangaId: mangaId ?? this.mangaId,
        mangaTitle: mangaTitle ?? this.mangaTitle,
        coverUrl: coverUrl ?? this.coverUrl,
      );
  LibraryMangaTableData copyWithCompanion(LibraryMangaTableCompanion data) {
    return LibraryMangaTableData(
      mangaId: data.mangaId.present ? data.mangaId.value : this.mangaId,
      mangaTitle:
          data.mangaTitle.present ? data.mangaTitle.value : this.mangaTitle,
      coverUrl: data.coverUrl.present ? data.coverUrl.value : this.coverUrl,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LibraryMangaTableData(')
          ..write('mangaId: $mangaId, ')
          ..write('mangaTitle: $mangaTitle, ')
          ..write('coverUrl: $coverUrl')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(mangaId, mangaTitle, coverUrl);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LibraryMangaTableData &&
          other.mangaId == this.mangaId &&
          other.mangaTitle == this.mangaTitle &&
          other.coverUrl == this.coverUrl);
}

class LibraryMangaTableCompanion
    extends UpdateCompanion<LibraryMangaTableData> {
  final Value<String> mangaId;
  final Value<Map<String, String>> mangaTitle;
  final Value<String> coverUrl;
  final Value<int> rowid;
  const LibraryMangaTableCompanion({
    this.mangaId = const Value.absent(),
    this.mangaTitle = const Value.absent(),
    this.coverUrl = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  LibraryMangaTableCompanion.insert({
    required String mangaId,
    required Map<String, String> mangaTitle,
    required String coverUrl,
    this.rowid = const Value.absent(),
  })  : mangaId = Value(mangaId),
        mangaTitle = Value(mangaTitle),
        coverUrl = Value(coverUrl);
  static Insertable<LibraryMangaTableData> custom({
    Expression<String>? mangaId,
    Expression<String>? mangaTitle,
    Expression<String>? coverUrl,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (mangaId != null) 'manga_id': mangaId,
      if (mangaTitle != null) 'manga_title': mangaTitle,
      if (coverUrl != null) 'cover_url': coverUrl,
      if (rowid != null) 'rowid': rowid,
    });
  }

  LibraryMangaTableCompanion copyWith(
      {Value<String>? mangaId,
      Value<Map<String, String>>? mangaTitle,
      Value<String>? coverUrl,
      Value<int>? rowid}) {
    return LibraryMangaTableCompanion(
      mangaId: mangaId ?? this.mangaId,
      mangaTitle: mangaTitle ?? this.mangaTitle,
      coverUrl: coverUrl ?? this.coverUrl,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (mangaId.present) {
      map['manga_id'] = Variable<String>(mangaId.value);
    }
    if (mangaTitle.present) {
      map['manga_title'] = Variable<String>(
          $LibraryMangaTableTable.$convertermangaTitle.toSql(mangaTitle.value));
    }
    if (coverUrl.present) {
      map['cover_url'] = Variable<String>(coverUrl.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LibraryMangaTableCompanion(')
          ..write('mangaId: $mangaId, ')
          ..write('mangaTitle: $mangaTitle, ')
          ..write('coverUrl: $coverUrl, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$DriftService extends GeneratedDatabase {
  _$DriftService(QueryExecutor e) : super(e);
  $DriftServiceManager get managers => $DriftServiceManager(this);
  late final $LibraryMangaTableTable libraryMangaTable =
      $LibraryMangaTableTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [libraryMangaTable];
}

typedef $$LibraryMangaTableTableCreateCompanionBuilder
    = LibraryMangaTableCompanion Function({
  required String mangaId,
  required Map<String, String> mangaTitle,
  required String coverUrl,
  Value<int> rowid,
});
typedef $$LibraryMangaTableTableUpdateCompanionBuilder
    = LibraryMangaTableCompanion Function({
  Value<String> mangaId,
  Value<Map<String, String>> mangaTitle,
  Value<String> coverUrl,
  Value<int> rowid,
});

class $$LibraryMangaTableTableFilterComposer
    extends Composer<_$DriftService, $LibraryMangaTableTable> {
  $$LibraryMangaTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get mangaId => $composableBuilder(
      column: $table.mangaId, builder: (column) => ColumnFilters(column));

  ColumnWithTypeConverterFilters<Map<String, String>, Map<String, String>,
          String>
      get mangaTitle => $composableBuilder(
          column: $table.mangaTitle,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnFilters<String> get coverUrl => $composableBuilder(
      column: $table.coverUrl, builder: (column) => ColumnFilters(column));
}

class $$LibraryMangaTableTableOrderingComposer
    extends Composer<_$DriftService, $LibraryMangaTableTable> {
  $$LibraryMangaTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get mangaId => $composableBuilder(
      column: $table.mangaId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get mangaTitle => $composableBuilder(
      column: $table.mangaTitle, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get coverUrl => $composableBuilder(
      column: $table.coverUrl, builder: (column) => ColumnOrderings(column));
}

class $$LibraryMangaTableTableAnnotationComposer
    extends Composer<_$DriftService, $LibraryMangaTableTable> {
  $$LibraryMangaTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get mangaId =>
      $composableBuilder(column: $table.mangaId, builder: (column) => column);

  GeneratedColumnWithTypeConverter<Map<String, String>, String>
      get mangaTitle => $composableBuilder(
          column: $table.mangaTitle, builder: (column) => column);

  GeneratedColumn<String> get coverUrl =>
      $composableBuilder(column: $table.coverUrl, builder: (column) => column);
}

class $$LibraryMangaTableTableTableManager extends RootTableManager<
    _$DriftService,
    $LibraryMangaTableTable,
    LibraryMangaTableData,
    $$LibraryMangaTableTableFilterComposer,
    $$LibraryMangaTableTableOrderingComposer,
    $$LibraryMangaTableTableAnnotationComposer,
    $$LibraryMangaTableTableCreateCompanionBuilder,
    $$LibraryMangaTableTableUpdateCompanionBuilder,
    (
      LibraryMangaTableData,
      BaseReferences<_$DriftService, $LibraryMangaTableTable,
          LibraryMangaTableData>
    ),
    LibraryMangaTableData,
    PrefetchHooks Function()> {
  $$LibraryMangaTableTableTableManager(
      _$DriftService db, $LibraryMangaTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LibraryMangaTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LibraryMangaTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LibraryMangaTableTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> mangaId = const Value.absent(),
            Value<Map<String, String>> mangaTitle = const Value.absent(),
            Value<String> coverUrl = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              LibraryMangaTableCompanion(
            mangaId: mangaId,
            mangaTitle: mangaTitle,
            coverUrl: coverUrl,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String mangaId,
            required Map<String, String> mangaTitle,
            required String coverUrl,
            Value<int> rowid = const Value.absent(),
          }) =>
              LibraryMangaTableCompanion.insert(
            mangaId: mangaId,
            mangaTitle: mangaTitle,
            coverUrl: coverUrl,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$LibraryMangaTableTableProcessedTableManager = ProcessedTableManager<
    _$DriftService,
    $LibraryMangaTableTable,
    LibraryMangaTableData,
    $$LibraryMangaTableTableFilterComposer,
    $$LibraryMangaTableTableOrderingComposer,
    $$LibraryMangaTableTableAnnotationComposer,
    $$LibraryMangaTableTableCreateCompanionBuilder,
    $$LibraryMangaTableTableUpdateCompanionBuilder,
    (
      LibraryMangaTableData,
      BaseReferences<_$DriftService, $LibraryMangaTableTable,
          LibraryMangaTableData>
    ),
    LibraryMangaTableData,
    PrefetchHooks Function()>;

class $DriftServiceManager {
  final _$DriftService _db;
  $DriftServiceManager(this._db);
  $$LibraryMangaTableTableTableManager get libraryMangaTable =>
      $$LibraryMangaTableTableTableManager(_db, _db.libraryMangaTable);
}
