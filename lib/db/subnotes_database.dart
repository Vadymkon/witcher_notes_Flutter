import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:witcher_notes/model/subnote.dart';

class SubNotesDatabase {
  static final SubNotesDatabase instance = SubNotesDatabase._init();

  static Database? _database;

  SubNotesDatabase._init();

  Future<Database> get database async {
    if (_database!=null) return _database!;

    _database = await _initDB('subnotes.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath,filePath);

    return await openDatabase(path,version: 1, onCreate: _createDB);
  }


  Future _createDB(Database db, int version) async {

    final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    final boolType = 'BOOLEAN NOT NULL';
    final integerType = 'INTEGER NOT NULL';
    final textType = 'TEXT NOT NULL';

    await db.execute('''
    CREATE TABLE $tableNotes (
    ${SubNoteField.idSub     } $idType      ,
    ${SubNoteField.idParent  } $integerType    ,
    ${SubNoteField.isActive  } $boolType    ,
    ${SubNoteField.title     } $textType    
    )
    ''');
  }



  Future<SubNote> create (SubNote note) async {
    final db = await instance.database;

    final id = await db.insert(tableNotes, note.toJson());
    return note.copy(idSub: id);
  }

  Future<SubNote> readNote(int id) async {
    final db = await instance.database;
    final maps = await db.query(
      tableNotes,
      columns: SubNoteField.subvalues,
      where: '${SubNoteField.idSub} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return SubNote.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future readAllNotes() async {
    final db = await instance.database;

    final orderBy = '${SubNoteField.idParent} ASC';

    //final result = db.rawQuery('SELECT * FROM $tableNotes ORDER BY $orderBy');

    final result = await db.query(tableNotes, orderBy: orderBy);

    return result.map((json) => SubNote.fromJson(json)).toList();
  }

  Future<int> update(SubNote note) async {
    final db = await instance.database;

    return db.update(
      tableNotes,
      note.toJson(),
      where: '${SubNoteField.idSub} = ?',
      whereArgs: [note.idSub],
    );
  }

  Future<int> delete(int id) async {
    final db = await instance.database;

    return await db.delete(tableNotes,where: '${SubNoteField.idSub} = ?',whereArgs: [id],);
  }
  Future close() async {
    final db = await instance.database;

    db.close();
  }

  static Future<void> updateOrAddSubNote(SubNote subNote) async {
    if (subNote.idSub == null) {
      await SubNotesDatabase.instance.create(subNote);
    } else {
      await SubNotesDatabase.instance.update(subNote);
    }
  }
}
