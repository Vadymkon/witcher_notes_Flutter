import '../db/subnotes_database.dart';

final String tableNotes = 'notes';

class SubNoteField {
  static final List<String> subvalues = [
    /// Add all fields
    idParent, idSub, title, isActive,
  ];

  static final String idSub            = '_idSub';
  static final String idParent         = 'idParent';
  static final String title            = 'title';
  static final String isActive         = 'isActive';

}

class SubNote {
  final int?       idSub             ;
  final int        idParent          ;
  final bool       isActive          ;
  final String     title             ;

  const SubNote (
      {
        this.idSub,
        required this.idParent ,
        required this.isActive ,
        required this.title    ,
      });

  SubNote copy ({
    int?        idSub         ,
    int?        idParent       ,
    bool?       isActive       ,
    String?     title          ,

  }) => SubNote(
    idSub     :   idSub    ?? this.idSub     ,
    idParent  :   idParent ?? this.idParent  ,
    isActive  :   isActive ?? this.isActive  ,
    title     :   title    ?? this.title     ,
  );

  static SubNote fromJson(Map<String,Object?> json) =>
      SubNote(
        idSub     :   json[SubNoteField.idSub    ] as int?     ,
        idParent  :   json[SubNoteField.idParent ] as int      ,
        isActive  : json[SubNoteField.isActive] == 1           ,
        title     :   json[SubNoteField.title    ] as String   ,
      );

  Map<String, Object?> toJson () => {
    SubNoteField.idSub     : idSub    ,
    SubNoteField.idParent  : idParent ,
    SubNoteField.isActive  : isActive ? 1: 0 ,
    SubNoteField.title     : title    ,
  };


}