import 'package:hive/hive.dart';

part 'profile.g.dart';
@HiveType(typeId: 0)
class Chats{
  @HiveField(0)
  String ava_photo;
  @HiveField(1)
  String nickName;
  @HiveField(2)
  List <String> message = [];
  @HiveField(3)
  bool isSelected = false;

  Chats({required this.ava_photo,required this.nickName,required this.message, this.isSelected = false});
}