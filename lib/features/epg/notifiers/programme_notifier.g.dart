// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'programme_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$programmeNotifierHash() => r'ff131e4cad0d6254000e54b3519b64d25d7bfbe8';

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

abstract class _$ProgrammeNotifier
    extends BuildlessAutoDisposeStreamNotifier<ProgrammeCache?> {
  late final String channelId;
  late final DateTime day;

  Stream<ProgrammeCache?> build({
    required String channelId,
    required DateTime day,
  });
}

/// See also [ProgrammeNotifier].
@ProviderFor(ProgrammeNotifier)
const programmeNotifierProvider = ProgrammeNotifierFamily();

/// See also [ProgrammeNotifier].
class ProgrammeNotifierFamily extends Family<AsyncValue<ProgrammeCache?>> {
  /// See also [ProgrammeNotifier].
  const ProgrammeNotifierFamily();

  /// See also [ProgrammeNotifier].
  ProgrammeNotifierProvider call({
    required String channelId,
    required DateTime day,
  }) {
    return ProgrammeNotifierProvider(channelId: channelId, day: day);
  }

  @override
  ProgrammeNotifierProvider getProviderOverride(
    covariant ProgrammeNotifierProvider provider,
  ) {
    return call(channelId: provider.channelId, day: provider.day);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'programmeNotifierProvider';
}

/// See also [ProgrammeNotifier].
class ProgrammeNotifierProvider
    extends
        AutoDisposeStreamNotifierProviderImpl<
          ProgrammeNotifier,
          ProgrammeCache?
        > {
  /// See also [ProgrammeNotifier].
  ProgrammeNotifierProvider({required String channelId, required DateTime day})
    : this._internal(
        () =>
            ProgrammeNotifier()
              ..channelId = channelId
              ..day = day,
        from: programmeNotifierProvider,
        name: r'programmeNotifierProvider',
        debugGetCreateSourceHash:
            const bool.fromEnvironment('dart.vm.product')
                ? null
                : _$programmeNotifierHash,
        dependencies: ProgrammeNotifierFamily._dependencies,
        allTransitiveDependencies:
            ProgrammeNotifierFamily._allTransitiveDependencies,
        channelId: channelId,
        day: day,
      );

  ProgrammeNotifierProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.channelId,
    required this.day,
  }) : super.internal();

  final String channelId;
  final DateTime day;

  @override
  Stream<ProgrammeCache?> runNotifierBuild(
    covariant ProgrammeNotifier notifier,
  ) {
    return notifier.build(channelId: channelId, day: day);
  }

  @override
  Override overrideWith(ProgrammeNotifier Function() create) {
    return ProviderOverride(
      origin: this,
      override: ProgrammeNotifierProvider._internal(
        () =>
            create()
              ..channelId = channelId
              ..day = day,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        channelId: channelId,
        day: day,
      ),
    );
  }

  @override
  AutoDisposeStreamNotifierProviderElement<ProgrammeNotifier, ProgrammeCache?>
  createElement() {
    return _ProgrammeNotifierProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ProgrammeNotifierProvider &&
        other.channelId == channelId &&
        other.day == day;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, channelId.hashCode);
    hash = _SystemHash.combine(hash, day.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin ProgrammeNotifierRef
    on AutoDisposeStreamNotifierProviderRef<ProgrammeCache?> {
  /// The parameter `channelId` of this provider.
  String get channelId;

  /// The parameter `day` of this provider.
  DateTime get day;
}

class _ProgrammeNotifierProviderElement
    extends
        AutoDisposeStreamNotifierProviderElement<
          ProgrammeNotifier,
          ProgrammeCache?
        >
    with ProgrammeNotifierRef {
  _ProgrammeNotifierProviderElement(super.provider);

  @override
  String get channelId => (origin as ProgrammeNotifierProvider).channelId;
  @override
  DateTime get day => (origin as ProgrammeNotifierProvider).day;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
