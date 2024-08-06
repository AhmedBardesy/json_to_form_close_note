// // GENERATED CODE - DO NOT MODIFY BY HAND

// part of 'tag_model.dart';

// // **************************************************************************
// // TypeAdapterGenerator
// // **************************************************************************

// class tagmodelAdapter extends TypeAdapter<tag_model> {
//   @override
//   final int typeId = 2;

//   @override
//   tag_model read(BinaryReader reader) {
//     final numOfFields = reader.readByte();
//     final fields = <int, dynamic>{
//       for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
//     };
//     return tag_model(
//       tagid: fields[0] as int,
//       type: fields[1] as String,
//       name: fields[2] as String,
//       relatedtag: (fields[3] as List).cast<String>(),
//     );
//   }

//   @override
//   void write(BinaryWriter writer, tag_model obj) {
//     writer
//       ..writeByte(4)
//       ..writeByte(0)
//       ..write(obj.tagid)
//       ..writeByte(1)
//       ..write(obj.type)
//       ..writeByte(2)
//       ..write(obj.name)
//       ..writeByte(3)
//       ..write(obj.relatedtag);
//   }

//   @override
//   int get hashCode => typeId.hashCode;

//   @override
//   bool operator ==(Object other) =>
//       identical(this, other) ||
//       other is tagmodelAdapter &&
//           runtimeType == other.runtimeType &&
//           typeId == other.typeId;
// }
