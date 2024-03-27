/*
* Copyright 2021 Amazon.com, Inc. or its affiliates. All Rights Reserved.
*
* Licensed under the Apache License, Version 2.0 (the "License").
* You may not use this file except in compliance with the License.
* A copy of the License is located at
*
*  http://aws.amazon.com/apache2.0
*
* or in the "license" file accompanying this file. This file is distributed
* on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either
* express or implied. See the License for the specific language governing
* permissions and limitations under the License.
*/

// NOTE: This file is generated and may not follow lint rules defined in your app
// Generated files can be excluded from analysis in analysis_options.yaml
// For more info, see: https://dart.dev/guides/language/analysis-options#excluding-code-from-analysis

// ignore_for_file: public_member_api_docs, annotate_overrides, dead_code, dead_codepublic_member_api_docs, depend_on_referenced_packages, file_names, library_private_types_in_public_api, no_leading_underscores_for_library_prefixes, no_leading_underscores_for_local_identifiers, non_constant_identifier_names, null_check_on_nullable_type_parameter, prefer_adjacent_string_concatenation, prefer_const_constructors, prefer_if_null_operators, prefer_interpolation_to_compose_strings, slash_for_doc_comments, sort_child_properties_last, unnecessary_const, unnecessary_constructor_name, unnecessary_late, unnecessary_new, unnecessary_null_aware_assignments, unnecessary_nullable_for_final_variable_declarations, unnecessary_string_interpolations, use_build_context_synchronously

import 'ModelProvider.dart';
import 'package:amplify_core/amplify_core.dart' as amplify_core;
import 'package:collection/collection.dart';


/** This is an auto generated class representing the Settings type in your schema. */
class Settings extends amplify_core.Model {
  static const classType = const _SettingsModelType();
  final String id;
  final int? _dietType;
  final List<Ingredient>? _avoidances;
  final List<int>? _cuisineTypes;
  final int? _language;
  final bool? _notifications;
  final List<String>? _linkedDevices;
  final amplify_core.TemporalDateTime? _createdAt;
  final amplify_core.TemporalDateTime? _updatedAt;

  @override
  getInstanceType() => classType;
  
  @Deprecated('[getId] is being deprecated in favor of custom primary key feature. Use getter [modelIdentifier] to get model identifier.')
  @override
  String getId() => id;
  
  SettingsModelIdentifier get modelIdentifier {
      return SettingsModelIdentifier(
        id: id
      );
  }
  
  int get dietType {
    try {
      return _dietType!;
    } catch(e) {
      throw amplify_core.AmplifyCodeGenModelException(
          amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  List<Ingredient>? get avoidances {
    return _avoidances;
  }
  
  List<int>? get cuisineTypes {
    return _cuisineTypes;
  }
  
  int get language {
    try {
      return _language!;
    } catch(e) {
      throw amplify_core.AmplifyCodeGenModelException(
          amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  bool get notifications {
    try {
      return _notifications!;
    } catch(e) {
      throw amplify_core.AmplifyCodeGenModelException(
          amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  List<String>? get linkedDevices {
    return _linkedDevices;
  }
  
  amplify_core.TemporalDateTime? get createdAt {
    return _createdAt;
  }
  
  amplify_core.TemporalDateTime? get updatedAt {
    return _updatedAt;
  }
  
  const Settings._internal({required this.id, required dietType, avoidances, cuisineTypes, required language, required notifications, linkedDevices, createdAt, updatedAt}): _dietType = dietType, _avoidances = avoidances, _cuisineTypes = cuisineTypes, _language = language, _notifications = notifications, _linkedDevices = linkedDevices, _createdAt = createdAt, _updatedAt = updatedAt;
  
  factory Settings({String? id, required int dietType, List<Ingredient>? avoidances, List<int>? cuisineTypes, required int language, required bool notifications, List<String>? linkedDevices}) {
    return Settings._internal(
      id: id == null ? amplify_core.UUID.getUUID() : id,
      dietType: dietType,
      avoidances: avoidances != null ? List<Ingredient>.unmodifiable(avoidances) : avoidances,
      cuisineTypes: cuisineTypes != null ? List<int>.unmodifiable(cuisineTypes) : cuisineTypes,
      language: language,
      notifications: notifications,
      linkedDevices: linkedDevices != null ? List<String>.unmodifiable(linkedDevices) : linkedDevices);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Settings &&
      id == other.id &&
      _dietType == other._dietType &&
      DeepCollectionEquality().equals(_avoidances, other._avoidances) &&
      DeepCollectionEquality().equals(_cuisineTypes, other._cuisineTypes) &&
      _language == other._language &&
      _notifications == other._notifications &&
      DeepCollectionEquality().equals(_linkedDevices, other._linkedDevices);
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("Settings {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("dietType=" + (_dietType != null ? _dietType!.toString() : "null") + ", ");
    buffer.write("cuisineTypes=" + (_cuisineTypes != null ? _cuisineTypes!.toString() : "null") + ", ");
    buffer.write("language=" + (_language != null ? _language!.toString() : "null") + ", ");
    buffer.write("notifications=" + (_notifications != null ? _notifications!.toString() : "null") + ", ");
    buffer.write("linkedDevices=" + (_linkedDevices != null ? _linkedDevices!.toString() : "null") + ", ");
    buffer.write("createdAt=" + (_createdAt != null ? _createdAt!.format() : "null") + ", ");
    buffer.write("updatedAt=" + (_updatedAt != null ? _updatedAt!.format() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  Settings copyWith({int? dietType, List<Ingredient>? avoidances, List<int>? cuisineTypes, int? language, bool? notifications, List<String>? linkedDevices}) {
    return Settings._internal(
      id: id,
      dietType: dietType ?? this.dietType,
      avoidances: avoidances ?? this.avoidances,
      cuisineTypes: cuisineTypes ?? this.cuisineTypes,
      language: language ?? this.language,
      notifications: notifications ?? this.notifications,
      linkedDevices: linkedDevices ?? this.linkedDevices);
  }
  
  Settings copyWithModelFieldValues({
    ModelFieldValue<int>? dietType,
    ModelFieldValue<List<Ingredient>?>? avoidances,
    ModelFieldValue<List<int>?>? cuisineTypes,
    ModelFieldValue<int>? language,
    ModelFieldValue<bool>? notifications,
    ModelFieldValue<List<String>?>? linkedDevices
  }) {
    return Settings._internal(
      id: id,
      dietType: dietType == null ? this.dietType : dietType.value,
      avoidances: avoidances == null ? this.avoidances : avoidances.value,
      cuisineTypes: cuisineTypes == null ? this.cuisineTypes : cuisineTypes.value,
      language: language == null ? this.language : language.value,
      notifications: notifications == null ? this.notifications : notifications.value,
      linkedDevices: linkedDevices == null ? this.linkedDevices : linkedDevices.value
    );
  }
  
  Settings.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _dietType = (json['dietType'] as num?)?.toInt(),
      _avoidances = json['avoidances'] is List
        ? (json['avoidances'] as List)
          .where((e) => e?['serializedData'] != null)
          .map((e) => Ingredient.fromJson(new Map<String, dynamic>.from(e['serializedData'])))
          .toList()
        : null,
      _cuisineTypes = (json['cuisineTypes'] as List?)?.map((e) => (e as num).toInt()).toList(),
      _language = (json['language'] as num?)?.toInt(),
      _notifications = json['notifications'],
      _linkedDevices = json['linkedDevices']?.cast<String>(),
      _createdAt = json['createdAt'] != null ? amplify_core.TemporalDateTime.fromString(json['createdAt']) : null,
      _updatedAt = json['updatedAt'] != null ? amplify_core.TemporalDateTime.fromString(json['updatedAt']) : null;
  
  Map<String, dynamic> toJson() => {
    'id': id, 'dietType': _dietType, 'avoidances': _avoidances?.map((Ingredient? e) => e?.toJson()).toList(), 'cuisineTypes': _cuisineTypes, 'language': _language, 'notifications': _notifications, 'linkedDevices': _linkedDevices, 'createdAt': _createdAt?.format(), 'updatedAt': _updatedAt?.format()
  };
  
  Map<String, Object?> toMap() => {
    'id': id,
    'dietType': _dietType,
    'avoidances': _avoidances,
    'cuisineTypes': _cuisineTypes,
    'language': _language,
    'notifications': _notifications,
    'linkedDevices': _linkedDevices,
    'createdAt': _createdAt,
    'updatedAt': _updatedAt
  };

  static final amplify_core.QueryModelIdentifier<SettingsModelIdentifier> MODEL_IDENTIFIER = amplify_core.QueryModelIdentifier<SettingsModelIdentifier>();
  static final ID = amplify_core.QueryField(fieldName: "id");
  static final DIETTYPE = amplify_core.QueryField(fieldName: "dietType");
  static final AVOIDANCES = amplify_core.QueryField(
    fieldName: "avoidances",
    fieldType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.model, ofModelName: 'Ingredient'));
  static final CUISINETYPES = amplify_core.QueryField(fieldName: "cuisineTypes");
  static final LANGUAGE = amplify_core.QueryField(fieldName: "language");
  static final NOTIFICATIONS = amplify_core.QueryField(fieldName: "notifications");
  static final LINKEDDEVICES = amplify_core.QueryField(fieldName: "linkedDevices");
  static var schema = amplify_core.Model.defineSchema(define: (amplify_core.ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "Settings";
    modelSchemaDefinition.pluralName = "Settings";
    
    modelSchemaDefinition.authRules = [
      amplify_core.AuthRule(
        authStrategy: amplify_core.AuthStrategy.OWNER,
        ownerField: "owner",
        identityClaim: "cognito:username",
        provider: amplify_core.AuthRuleProvider.USERPOOLS,
        operations: const [
          amplify_core.ModelOperation.READ,
          amplify_core.ModelOperation.UPDATE,
          amplify_core.ModelOperation.DELETE
        ]),
      amplify_core.AuthRule(
        authStrategy: amplify_core.AuthStrategy.PUBLIC,
        provider: amplify_core.AuthRuleProvider.APIKEY,
        operations: const [
          amplify_core.ModelOperation.CREATE,
          amplify_core.ModelOperation.UPDATE,
          amplify_core.ModelOperation.DELETE,
          amplify_core.ModelOperation.READ
        ])
    ];
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.id());
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: Settings.DIETTYPE,
      isRequired: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.int)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.hasMany(
      key: Settings.AVOIDANCES,
      isRequired: false,
      ofModelName: 'Ingredient',
      associatedKey: Ingredient.SETTINGS
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: Settings.CUISINETYPES,
      isRequired: false,
      isArray: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.collection, ofModelName: amplify_core.ModelFieldTypeEnum.int.name)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: Settings.LANGUAGE,
      isRequired: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.int)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: Settings.NOTIFICATIONS,
      isRequired: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.bool)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: Settings.LINKEDDEVICES,
      isRequired: false,
      isArray: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.collection, ofModelName: amplify_core.ModelFieldTypeEnum.string.name)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.nonQueryField(
      fieldName: 'createdAt',
      isRequired: false,
      isReadOnly: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.dateTime)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.nonQueryField(
      fieldName: 'updatedAt',
      isRequired: false,
      isReadOnly: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.dateTime)
    ));
  });
}

class _SettingsModelType extends amplify_core.ModelType<Settings> {
  const _SettingsModelType();
  
  @override
  Settings fromJson(Map<String, dynamic> jsonData) {
    return Settings.fromJson(jsonData);
  }
  
  @override
  String modelName() {
    return 'Settings';
  }
}

/**
 * This is an auto generated class representing the model identifier
 * of [Settings] in your schema.
 */
class SettingsModelIdentifier implements amplify_core.ModelIdentifier<Settings> {
  final String id;

  /** Create an instance of SettingsModelIdentifier using [id] the primary key. */
  const SettingsModelIdentifier({
    required this.id});
  
  @override
  Map<String, dynamic> serializeAsMap() => (<String, dynamic>{
    'id': id
  });
  
  @override
  List<Map<String, dynamic>> serializeAsList() => serializeAsMap()
    .entries
    .map((entry) => (<String, dynamic>{ entry.key: entry.value }))
    .toList();
  
  @override
  String serializeAsString() => serializeAsMap().values.join('#');
  
  @override
  String toString() => 'SettingsModelIdentifier(id: $id)';
  
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    
    return other is SettingsModelIdentifier &&
      id == other.id;
  }
  
  @override
  int get hashCode =>
    id.hashCode;
}