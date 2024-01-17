import 'dart:async';
//import 'dart:js_interop';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:witcher_notes/model/note.dart';

class NotesDatabase {
  static final NotesDatabase instance = NotesDatabase._init();

  static Database? _database;

  NotesDatabase._init();


  Future<bool> databaseExists(String path) =>
      databaseFactory.databaseExists(path);

  Future<Database> get database async {
    if (_database!=null) return _database!;

    _database = await _initDB('notes.db');
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

    // await db.execute('''
    // CREATE TABLE $tableNotes (
    // ${NoteField.id} $idType,
    // ${NoteField.isImportant} $boolType,
    // ${NoteField.number} $integerType,
    // ${NoteField.title} $textType,
    // ${NoteField.description} $textType,
    // ${NoteField.time} $textType
    // )
    // ''');

    await db.execute('''
    CREATE TABLE $tableNotes (
    ${NoteField.id           } $idType      ,
    ${NoteField.directory    } $textType    ,
    ${NoteField.nameOfShield } $textType    ,
    ${NoteField.isImportant  } $boolType    ,
    ${NoteField.ai           } $boolType    ,
    ${NoteField.level        } $integerType ,
    ${NoteField.title        } $textType    ,
    ${NoteField.place        } $textType    ,
    ${NoteField.dateStart    } $textType    ,
    ${NoteField.deadline     } $textType    ,
    ${NoteField.completedID  } $integerType ,
    ${NoteField.done         } $boolType    ,
    ${NoteField.description  } $textType    
    )
    ''');
  }



  Future<Note> create (Note note) async {
    final db = await instance.database;

/*    final json = note.toJson();
    final columns =
        '${NoteField.title}, ${NoteField.description}, ${NoteField.time}';
    final values =
        '${json[NoteField.title]}, ${json[NoteField.description]}, ${json[NoteField.time]}';
    final id = await db
        .rawInsert('INSERT INTO table_name ($columns) VALUES ($values)');*/

    final id = await db.insert(tableNotes, note.toJson());
    return note.copy(id: id);
  }

  Future<Note> readNote(int id) async {
    final db = await instance.database;
    final maps = await db.query(
      tableNotes,
      columns: NoteField.values,
      where: '${NoteField.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Note.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future readAllNotes() async {
    if(!await databaseExists(join( await getDatabasesPath(),'notes.db')))  return [];///ЕСЛИ ФАЙЛА НЕ СУЩЕСТВУЕТ

    final db = await instance.database;

    final orderBy = '${NoteField.deadline} ASC';

   //final result = db.rawQuery('SELECT * FROM $tableNotes ORDER BY $orderBy');

    final result = await db.query(tableNotes, orderBy: orderBy);

    return result.map((json) => Note.fromJson(json)).toList();

  }

  Future<int> update(Note note) async {
    final db = await instance.database;  

    return db.update(
      tableNotes,
      note.toJson(),
      where: '${NoteField.id} = ?',
      whereArgs: [note.id],
    );
  }

  Future<int> delete(int id) async {
    final db = await instance.database;

    return await db.delete(tableNotes,where: '${NoteField.id} = ?',whereArgs: [id],);
  }
  Future close() async {
    final db = await instance.database;

    db.close();
  }
}
