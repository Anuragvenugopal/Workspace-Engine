import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

import '../features/analytics/domain/usecases/log_profile_swapped_usecase.dart';
import '../features/profiles/domain/entities/profile.dart';
import '../features/profiles/domain/usecases/profile_usecases.dart';

// ─── State ───────────────────────────────────────────────────────────────────

class ProfileState extends Equatable {
  final List<Profile> profiles;
  final Profile? activeProfile;
  final bool isLoading;

  const ProfileState({
    this.profiles = const [],
    this.activeProfile,
    this.isLoading = false,
  });

  ProfileState copyWith({
    List<Profile>? profiles,
    Profile? activeProfile,
    bool? isLoading,
  }) {
    return ProfileState(
      profiles: profiles ?? this.profiles,
      activeProfile: activeProfile ?? this.activeProfile,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object?> get props => [profiles, activeProfile, isLoading];
}

// ─── Provider ────────────────────────────────────────────────────────────────

@injectable
class ProfileProvider extends ChangeNotifier {
  final GetProfilesUseCase _getProfiles;
  final SeedDefaultProfilesUseCase _seedDefaults;
  final LogProfileSwappedUseCase _logProfileSwapped;

  ProfileState _state = const ProfileState();
  ProfileState get state => _state;

  ProfileProvider(
    this._getProfiles,
    this._seedDefaults,
    this._logProfileSwapped,
  );

  void _emit(ProfileState newState) {
    if (_state != newState) {
      _state = newState;
      notifyListeners();
    }
  }

  Future<void> initialize() async {
    _emit(state.copyWith(isLoading: true));
    await _seedDefaults();
    final profiles = _getProfiles();
    final active = profiles.isNotEmpty ? profiles.first : null;
    _emit(state.copyWith(
      profiles: profiles,
      activeProfile: active,
      isLoading: false,
    ));
  }

  Future<void> switchProfile(Profile profile) async {
    if (state.activeProfile?.id == profile.id) return;
    _emit(state.copyWith(activeProfile: profile));
    await _logProfileSwapped(profile.name);
  }

  void refresh() {
    final profiles = _getProfiles();
    final active = profiles.firstWhere(
      (p) => p.id == state.activeProfile?.id,
      orElse: () => profiles.isNotEmpty ? profiles.first : state.activeProfile!,
    );
    _emit(state.copyWith(profiles: profiles, activeProfile: active));
  }
}
