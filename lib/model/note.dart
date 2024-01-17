final String tableNotes = 'notes';

class NoteField {
  static final List<String> values = [
    /// Add all fields
    id, directory, nameOfShield, isImportant, level, title, place, dateStart, deadline, completedID, done, description,
  ];

  static final String id                = '_id';
  static final String directory         = 'Directory';
  static final String nameOfShield      = 'nameOfShield';
  static final String isImportant       = 'isImportant';
  static final String ai                = 'ai';
  static final String level             = 'level';
  static final String title             = 'title';
  static final String place             = 'place';
  static final String dateStart         = 'dateStart';
  static final String deadline          = 'deadline';
  static final String completedID       = 'completedID';
  static final String done              = 'done';
  static final String description       = 'description';

}

class Note {
  final int?       id             ;
  final String     directory      ;
  final String     nameOfShield   ;
  final bool       isImportant    ;
  final bool       ai             ;
  final int        level          ;
  final String     title          ;
  final String     place          ;
  final DateTime   dateStart      ;
  final DateTime   deadline       ;
  final int        completedID    ;
  final bool       done           ;
  final String     description    ;

  const Note (
  {
   this.id,
   required this.isImportant,
   required this.ai,
   required this.title,
   required this.description,
   required this.directory,
   required this.nameOfShield,
   required this.level,
   required this.place,
   required this.dateStart,
   required this.deadline,
   required this.completedID,
   required this.done,
  });

  Note copy ({
    int?        id            ,
    String?     directory     ,
    String?     nameOfShield  ,
    bool?       isImportant   ,
    bool?       ai            ,
    int?        level         ,
    String?     title         ,
    String?     place         ,
    DateTime?   dateStart     ,
    DateTime?   deadline      ,
    int?        completedID   ,
    bool?       done          ,
    String?     description   ,

    }) => Note(
      id            :   id           ?? this.id            ,
      directory     :   directory    ?? this.directory     ,
      nameOfShield  :   nameOfShield ?? this.nameOfShield  ,
      isImportant   :   isImportant  ?? this.isImportant   ,
      ai            :   ai           ?? this.isImportant   ,
      level         :   level        ?? this.level         ,
      title         :   title        ?? this.title         ,
      place         :   place        ?? this.place         ,
      dateStart     :   dateStart    ?? this.dateStart     ,
      deadline      :   deadline     ?? this.deadline      ,
      completedID   :   completedID  ?? this.completedID   ,
      done          :   done         ?? this.done          ,
      description   :   description  ?? this.description   ,
  );

  static Note fromJson(Map<String,Object?> json) =>
  Note(
      // id: json[NoteField.id] as int?,
      // number: json[NoteField.number] as int,
      // title: json[NoteField.title] as String,
      // description: json[NoteField.description] as String,
      // createdTime: DateTime.parse(json[NoteField.time] as String),
      // isImportant: json[NoteField.isImportant] == 1,

      id            :   json[NoteField.id           ] as int?     ,
      directory     :   json[NoteField.directory    ] as String   ,
      nameOfShield  :   json[NoteField.nameOfShield ] as String   ,
      isImportant   :   json[NoteField.isImportant] == 1          ,
      ai            :   json[NoteField.ai] == 1                   ,
      level         :   json[NoteField.level        ] as int      ,
      title         :   json[NoteField.title        ] as String   ,
      place         :   json[NoteField.place        ] as String   ,
      dateStart     :   DateTime.parse (json[NoteField.dateStart    ] as String) ,
      deadline      :   DateTime.parse (json[NoteField.deadline     ] as String) ,
      completedID   :   json[NoteField.completedID  ] as int      ,
      done          :   json[NoteField.done] == 1                 ,
      description   :   json[NoteField.description  ] as String   ,

  );

  Map<String, Object?> toJson () => {
    // NoteField.id : id,
    // NoteField.title : title,
    // NoteField.description : description,
    // NoteField.number : number,
    // NoteField.isImportant : isImportant ? 1: 0,
    // NoteField.time: createdTime.toIso8601String(),

  NoteField.id            : id           ,
  NoteField.directory     : directory    ,
  NoteField.nameOfShield  : nameOfShield ,
  NoteField.isImportant   : isImportant ? 1: 0 ,
  NoteField.ai            : ai ? 1: 0 ,
  NoteField.level         : level        ,
  NoteField.title         : title        ,
  NoteField.place         : place        ,
  NoteField.dateStart     : dateStart.toIso8601String()    ,
  NoteField.deadline      : deadline.toIso8601String()    ,
  NoteField.completedID   : completedID  ,
  NoteField.done          : done  ? 1: 0 ,
  NoteField.description   : description  ,


};
}