# Workspace Engine

A Flutter application that demonstrates offline-first profile management, profile-specific todo lists, remote API integration, dynamic theming, secure networking, and Clean Architecture using modern Flutter development practices.
---

## Architecture Overview

```
lib/
├── core/
│   ├── analytics/          # Abstract AnalyticsService + Stub implementation
│   ├── di/                 # get_it + injectable setup & generated config
│   ├── env/                # envied strongly-typed environment variables
│   ├── error/              # Domain Failure types
│   ├── network/            # Dio singleton (NetworkModule) + AuthInterceptor
│   ├── router/             # go_router configuration (5 routes)
│   ├── storage/            # flutter_secure_storage wrapper
│   └── theme/              # ProfileType-aware ThemeData factory
├── features/
│   ├── profiles/           # Profiles & Todos (Hive offline-first)
│   │   ├── data/
│   │   │   ├── datasources/   # ProfileLocalDatasource (Hive boxes)
│   │   │   ├── models/        # ProfileModel, TodoModel (HiveType adapters)
│   │   │   └── repositories/  # ProfileRepositoryImpl
│   │   ├── domain/
│   │   │   ├── entities/      # Profile, Todo (freezed, immutable)
│   │   │   ├── repositories/  # ProfileRepository (abstract)
│   │   │   └── usecases/      # GetProfiles, AddTodo, ToggleTodo, DeleteTodo, Seed
│   │   └── presentation/
│   │       ├── cubit/         # ProfileCubit (global), TodoCubit (page-scoped)
│   │       ├── pages/         # DashboardPage, TodoManagerPage
│   │       └── widgets/       # ProfileSelector, StatsCard
│   ├── events/             # Global Events (Dio API service)
│   │   ├── data/
│   │   │   ├── datasources/   # EventsApiService (Dio, Retrofit-style)
│   │   │   ├── models/        # PhotoResponseModel (json_serializable)
│   │   │   └── repositories/  # EventRepositoryImpl (maps DTO → entity)
│   │   ├── domain/
│   │   │   ├── entities/      # GlobalEvent (freezed)
│   │   │   ├── repositories/  # EventRepository (abstract)
│   │   │   └── usecases/      # GetEventsUseCase, GetEventByIdUseCase
│   │   └── presentation/
│   │       ├── cubit/         # EventsCubit (page-scoped)
│   │       └── pages/         # EventsFeedPage, EventDetailsPage
│   └── calendar/           # Calendar with profile-adaptive styling
│       └── presentation/
│           ├── cubit/         # CalendarCubit (page-scoped)
│           └── pages/         # CalendarPage
├── app.dart                # Root widget — MultiBlocProvider (global cubits)
└── main.dart               # Entry: Hive init → DI → runApp
```

### Layer Responsibilities

| Layer | Responsibility |
|-------|---------------|
| **Data** | DTOs, Hive models, API services, repository implementations |
| **Domain** | Entities (freezed), abstract repositories, use-cases |
| **Presentation** | Cubits (state), Pages (UI), Widgets (pure/dumb) |
| **Core** | DI, routing, theme, networking, analytics, storage, env |

---

## Provider / BLoC Usage Rules

| Rule | Implementation |
|---|---|
| Global cubits live at root | `ProfileCubit` in `MultiBlocProvider` in `app.dart` |
| Page-scoped cubits live in router | `TodoCubit`, `EventsCubit`, `CalendarCubit` in `pageBuilder` |
| `context.read<T>()` | Event handlers, initState, BlocListener callbacks only |
| `context.select<T, R>()` | Efficient partial rebuilds (e.g., profileType only) |
| `BlocBuilder<T, S>` | All reactive UI — never in creation callbacks |
| Pure widgets | `ProfileSelector`, `StatsCard`, `_NavTile` — zero cubit access |

---

## Data Models

### Profile (domain entity)
```dart
@freezed class Profile {
  String id, name;
  ProfileType type;   // personal | work | corporate | creative
  int colorValue;
  DateTime createdAt;
}
```

### Todo (domain entity)
```dart
@freezed class Todo {
  String id, title, profileId;
  bool isCompleted;
  DateTime createdAt;
}
```

### GlobalEvent (domain entity)
```dart
@freezed class GlobalEvent {
  int id;
  String title, description, imageUrl, thumbnailUrl;
  DateTime eventDate;   // programmatically generated
}
```

---

## Local Storage Strategy

- **Technology**: `hive_flutter` with custom `TypeAdapter`s
- **Box structure**: One box per model type (`profiles`, `todos`)
- **Profile isolation**: Todos are scoped by `profileId` foreign key
- **Cascade delete**: Deleting a profile removes all its todos
- **Seeding**: 4 default profiles (Personal, Work, Corporate, Creative) created on first launch
- **Adapters**: Hand-written `TypeAdapter`s in `*.g.dart` files (equivalent to `hive_generator` output)

---

## Networking Setup

```
Request Flow:
  App → Dio → AuthInterceptor → API
               ↓
     Reads token from flutter_secure_storage
     Falls back to AppEnv.authToken (envied)
     Injects: Authorization: Bearer <token>
```

- **Client**: `Dio` singleton provided via `@module` in `NetworkModule`
- **Interceptor**: `AuthInterceptor` — reads from `SecureStorageService`, falls back to env token
- **Logging**: `PrettyDioLogger` for development debugging
- **API service**: `EventsApiService` using Dio directly (Retrofit-style interface)
- **Timeouts**: 30s connect / receive / send

---

## Environment Configuration

1. Copy `.env.example` to `.env`:
   ```bash
   cp .env.example .env
   ```

2. Set your values:
   ```
   API_BASE_URL=https://jsonplaceholder.typicode.com
   AUTH_TOKEN=your_token_here
   ```

3. The `envied` package reads `.env` at **build time** via `build_runner` and generates
   `lib/core/env/app_env.g.dart` with obfuscated values. The `.env` file is included
   as a Flutter asset so it's accessible during codegen.

> **Note**: `.env` should be in `.gitignore` in production. The included file uses a
> placeholder token safe for the assessment.

---

## Build Instructions

### Prerequisites
- Flutter 3.44+
- Dart SDK 3.8+

### Setup

```bash
# Install dependencies
flutter pub get

# Generate code (freezed, json_serializable, injectable, envied)
dart run build_runner build --delete-conflicting-outputs
```

### Run

```bash
flutter run
```

### Test

```bash
flutter test
```

### Analyze

```bash
flutter analyze
```

---

## Dependency Injection Registry

All registrations are in the generated `lib/core/di/injection.config.dart`:

| Service | Scope |
|---------|-------|
| `Dio` | Singleton (via `@module`) |
| `AuthInterceptor` | Singleton |
| `SecureStorageService` | Singleton |
| `EventsApiService` | Singleton |
| `ProfileLocalDatasource` | Singleton |
| `AnalyticsService` (stub) | Lazy Singleton |
| `ProfileRepository` | Lazy Singleton |
| `EventRepository` | Lazy Singleton |
| All UseCases | Factory |
| All Cubits | Factory |

---

## Dynamic Branding

| Profile | Corners | Colors | Calendar Cells |
|---------|---------|--------|----------------|
| Corporate | Sharp (0px) | Monochrome (navy) | Rectangle, no margin |
| Creative | Rounded (20px) | Vibrant (purple/pink) | Circle, glow shadow |
| Personal | Rounded (12px) | Sky blue / cyan | Circle |
| Work | Rounded (8px) | Emerald green | Circle |

---

## Analytics

- Custom event `profile_swapped` logged on every profile switch via `ProfileCubit.switchProfile()`
- Firebase: add `google-services.json` (Android) and `GoogleService-Info.plist` (iOS) and swap `StubAnalyticsService` for `FirebaseAnalyticsService` in `@LazySingleton` annotation
- All analytics calls go through the abstract `AnalyticsService` interface — the concrete implementation is swappable without changing any feature code
