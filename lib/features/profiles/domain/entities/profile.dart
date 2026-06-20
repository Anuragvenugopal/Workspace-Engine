import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/theme/app_theme.dart';

part 'profile.freezed.dart';

@freezed
abstract class Profile with _$Profile {
  const factory Profile({
    required String id,
    required String name,
    required ProfileType type,
    required int colorValue,
    required DateTime createdAt,
  }) = _Profile;
}
