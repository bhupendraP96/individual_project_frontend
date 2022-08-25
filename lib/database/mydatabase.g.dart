// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mydatabase.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$AppDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  Userdao? _userDaoInstance;

  Future<sqflite.Database> open(String path, List<Migration> migrations,
      [Callback? callback]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `FUser` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `username` TEXT, `fullName` TEXT, `eMail` TEXT, `phoneNo` TEXT, `password` TEXT)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  Userdao get userDao {
    return _userDaoInstance ??= _$Userdao(database, changeListener);
  }
}

class _$Userdao extends Userdao {
  _$Userdao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _fUserInsertionAdapter = InsertionAdapter(
            database,
            'FUser',
            (FUser item) => <String, Object?>{
                  'id': item.id,
                  'username': item.username,
                  'fullName': item.fullName,
                  'eMail': item.eMail,
                  'phoneNo': item.phoneNo,
                  'password': item.password
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<FUser> _fUserInsertionAdapter;

  @override
  Future<List<FUser>> findAllUsers() async {
    return _queryAdapter.queryList('Select * from FUser',
        mapper: (Map<String, Object?> row) => FUser(
            id: row['id'] as int?,
            username: row['username'] as String?,
            fullName: row['fullName'] as String?,
            eMail: row['eMail'] as String?,
            phoneNo: row['phoneNo'] as String?,
            password: row['password'] as String?));
  }

  @override
  Future<FUser?> findUserById(int id) async {
    return _queryAdapter.query('Select * from FUser where id= ?1',
        mapper: (Map<String, Object?> row) => FUser(
            id: row['id'] as int?,
            username: row['username'] as String?,
            fullName: row['fullName'] as String?,
            eMail: row['eMail'] as String?,
            phoneNo: row['phoneNo'] as String?,
            password: row['password'] as String?),
        arguments: [id]);
  }

  @override
  Future<int> insertUser(FUser user) {
    return _fUserInsertionAdapter.insertAndReturnId(
        user, OnConflictStrategy.abort);
  }
}
