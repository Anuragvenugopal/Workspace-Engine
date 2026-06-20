import 'package:json_annotation/json_annotation.dart';

part 'photo_response_model.g.dart';

@JsonSerializable()
class PhotoResponseModel {
  final int albumId;
  final int id;
  final String title;
  final String url;
  final String thumbnailUrl;

  const PhotoResponseModel({
    required this.albumId,
    required this.id,
    required this.title,
    required this.url,
    required this.thumbnailUrl,
  });

  factory PhotoResponseModel.fromJson(Map<String, dynamic> json) =>
      _$PhotoResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$PhotoResponseModelToJson(this);
}
