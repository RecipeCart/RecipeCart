// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ingredient_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$ingredientListControllerHash() =>
    r'aa6bec1713a4fc585f7fef67d632b71496c67be8';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

abstract class _$IngredientListController
    extends BuildlessAutoDisposeAsyncNotifier<List<Ingredient?>> {
  late final String searchEntry;

  FutureOr<List<Ingredient?>> build({
    required String searchEntry,
  });
}

/// See also [IngredientListController].
@ProviderFor(IngredientListController)
const ingredientListControllerProvider = IngredientListControllerFamily();

/// See also [IngredientListController].
class IngredientListControllerFamily
    extends Family<AsyncValue<List<Ingredient?>>> {
  /// See also [IngredientListController].
  const IngredientListControllerFamily();

  /// See also [IngredientListController].
  IngredientListControllerProvider call({
    required String searchEntry,
  }) {
    return IngredientListControllerProvider(
      searchEntry: searchEntry,
    );
  }

  @override
  IngredientListControllerProvider getProviderOverride(
    covariant IngredientListControllerProvider provider,
  ) {
    return call(
      searchEntry: provider.searchEntry,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'ingredientListControllerProvider';
}

/// See also [IngredientListController].
class IngredientListControllerProvider
    extends AutoDisposeAsyncNotifierProviderImpl<IngredientListController,
        List<Ingredient?>> {
  /// See also [IngredientListController].
  IngredientListControllerProvider({
    required String searchEntry,
  }) : this._internal(
          () => IngredientListController()..searchEntry = searchEntry,
          from: ingredientListControllerProvider,
          name: r'ingredientListControllerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$ingredientListControllerHash,
          dependencies: IngredientListControllerFamily._dependencies,
          allTransitiveDependencies:
              IngredientListControllerFamily._allTransitiveDependencies,
          searchEntry: searchEntry,
        );

  IngredientListControllerProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.searchEntry,
  }) : super.internal();

  final String searchEntry;

  @override
  FutureOr<List<Ingredient?>> runNotifierBuild(
    covariant IngredientListController notifier,
  ) {
    return notifier.build(
      searchEntry: searchEntry,
    );
  }

  @override
  Override overrideWith(IngredientListController Function() create) {
    return ProviderOverride(
      origin: this,
      override: IngredientListControllerProvider._internal(
        () => create()..searchEntry = searchEntry,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        searchEntry: searchEntry,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<IngredientListController,
      List<Ingredient?>> createElement() {
    return _IngredientListControllerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is IngredientListControllerProvider &&
        other.searchEntry == searchEntry;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, searchEntry.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin IngredientListControllerRef
    on AutoDisposeAsyncNotifierProviderRef<List<Ingredient?>> {
  /// The parameter `searchEntry` of this provider.
  String get searchEntry;
}

class _IngredientListControllerProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<IngredientListController,
        List<Ingredient?>> with IngredientListControllerRef {
  _IngredientListControllerProviderElement(super.provider);

  @override
  String get searchEntry =>
      (origin as IngredientListControllerProvider).searchEntry;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
