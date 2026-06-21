# Workspace Engine

Multi-Profile Workspace Engine — an offline-first, multi-tenant Flutter application designed with modern architectural patterns and industry-standard tooling.

## Architecture Overview

This application follows **Clean Architecture** principles combined with a **Feature-based Folder Structure**. The codebase is modular, highly testable, and strictly separates concerns into three distinct layers:
- **Presentation**: UI screens, widgets, and state management (`Provider`).
- **Domain**: Immutable entities (using `freezed`), abstract repository interfaces, and business logic encapsulated within UseCases.
- **Data**: Data source implementations (Local & Remote), DTOs, and Repository Implementations.

Compile-time **Dependency Injection** is handled using `get_it` and `injectable`.

## Data Models

The app relies heavily on **Immutable Domain Models** generated via the `freezed` and `json_serializable` packages.
- **Profile**: Represents a local workspace tenant (e.g., Personal, Work, Corporate, Creative) containing a unique theme and color scheme.
- **Todo**: Tasks specifically tied to a `Profile`.
- **GlobalEvent**: A domain entity representing events fetched from a remote API.
- **PhotoResponseModel**: The DTO layer mapping the JSON API response to the Dart class.

## Local Storage Strategy

The app utilizes **Hive** as its local, offline-first database. 
- **TypeAdapters**: Configured via `hive_generator` for both `ProfileModel` and `TodoModel`.
- **Data Isolation**: Todos are strictly bound to a specific Profile ID, ensuring complete multi-tenant isolation.
- **Performance**: Hive provides instant read/write capabilities, allowing for instant UI refresh when swapping profiles.

## Networking Setup

Networking is powered by **Dio** and **Retrofit**.
- **Retrofit**: The `EventsApiService` uses Retrofit annotations (`@RestApi`, `@GET`) to generate a type-safe HTTP client for the remote JSONPlaceholder API.
- **Interceptors**: A custom `AuthInterceptor` is injected into the `Dio` instance to automatically attach Authorization headers to outgoing requests.
- **Image Caching**: Images fetched from the API are cached locally using `cached_network_image` to minimize bandwidth and improve load times.

## Environment Configuration

Environment variables are managed using the **envied** package.
- Variables such as `API_BASE_URL` and `AUTH_TOKEN` are defined in a `.env` file.
- `envied` obfuscates these variables and compiles them directly into `app_env.g.dart` to prevent plain-text extraction from the compiled binary.
- This provides compile-time type safety for all environment configurations.

## Build Instructions

### Prerequisites
- Flutter SDK 3.19+ (or as specified in `pubspec.yaml`)
- A `.env` file placed at the root of the project with the following keys:
  ```env
  API_BASE_URL=https://jsonplaceholder.typicode.com
  AUTH_TOKEN=your_secure_token_here
  ```

### Code Generation
Because this project relies on generated code (`freezed`, `json_serializable`, `injectable`, `retrofit`, `hive_generator`, `envied`), you must run the build runner before launching the app for the first time, or after making changes to models/services.

```bash
# Get dependencies
flutter pub get

# Generate boilerplate code
dart run build_runner build --delete-conflicting-outputs
```

### Run the App
```bash
flutter run
```

### Build for Production
To build the Android APK:
```bash
flutter build apk --release
```
To build the iOS IPA:
```bash
flutter build ipa --release
```
