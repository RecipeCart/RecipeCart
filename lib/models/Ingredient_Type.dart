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


/** This is an auto generated class representing the Ingredient_Type type in your schema. */
class Ingredient_Type extends amplify_core.Model {
  static const classType = const _Ingredient_TypeModelType();
  final String id;
  final String? _ingredient_name;
  final List<String>? _barcodes;
  final amplify_core.TemporalDateTime? _createdAt;
  final amplify_core.TemporalDateTime? _updatedAt;
  final String? _settingsAvoidancesId;

  @override
  getInstanceType() => classType;
  
  @Deprecated('[getId] is being deprecated in favor of custom primary key feature. Use getter [modelIdentifier] to get model identifier.')
  @override
  String getId() => id;
  
  Ingredient_TypeModelIdentifier get modelIdentifier {
      return Ingredient_TypeModelIdentifier(
        id: id
      );
  }
  
  String get ingredient_name {
    try {
      return _ingredient_name!;
    } catch(e) {
      throw amplify_core.AmplifyCodeGenModelException(
          amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  List<String>? get barcodes {
    return _barcodes;
  }
  
  amplify_core.TemporalDateTime? get createdAt {
    return _createdAt;
  }
  
  amplify_core.TemporalDateTime? get updatedAt {
    return _updatedAt;
  }
  
  String? get settingsAvoidancesId {
    return _settingsAvoidancesId;
  }
  
  const Ingredient_Type._internal({required this.id, required ingredient_name, barcodes, createdAt, updatedAt, settingsAvoidancesId}): _ingredient_name = ingredient_name, _barcodes = barcodes, _createdAt = createdAt, _updatedAt = updatedAt, _settingsAvoidancesId = settingsAvoidancesId;
  
  factory Ingredient_Type({String? id, required String ingredient_name, List<String>? barcodes, String? settingsAvoidancesId}) {
    return Ingredient_Type._internal(
      id: id == null ? amplify_core.UUID.getUUID() : id,
      ingredient_name: ingredient_name,
      barcodes: barcodes != null ? List<String>.unmodifiable(barcodes) : barcodes,
      settingsAvoidancesId: settingsAvoidancesId);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Ingredient_Type &&
      id == other.id &&
      _ingredient_name == other._ingredient_name &&
      DeepCollectionEquality().equals(_barcodes, other._barcodes) &&
      _settingsAvoidancesId == other._settingsAvoidancesId;
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("Ingredient_Type {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("ingredient_name=" + "$_ingredient_name" + ", ");
    buffer.write("barcodes=" + (_barcodes != null ? _barcodes!.toString() : "null") + ", ");
    buffer.write("createdAt=" + (_createdAt != null ? _createdAt!.format() : "null") + ", ");
    buffer.write("updatedAt=" + (_updatedAt != null ? _updatedAt!.format() : "null") + ", ");
    buffer.write("settingsAvoidancesId=" + "$_settingsAvoidancesId");
    buffer.write("}");
    
    return buffer.toString();
  }
  
  Ingredient_Type copyWith({String? ingredient_name, List<String>? barcodes, String? settingsAvoidancesId}) {
    return Ingredient_Type._internal(
      id: id,
      ingredient_name: ingredient_name ?? this.ingredient_name,
      barcodes: barcodes ?? this.barcodes,
      settingsAvoidancesId: settingsAvoidancesId ?? this.settingsAvoidancesId);
  }
  
  Ingredient_Type copyWithModelFieldValues({
    ModelFieldValue<String>? ingredient_name,
    ModelFieldValue<List<String>?>? barcodes,
    ModelFieldValue<String?>? settingsAvoidancesId
  }) {
    return Ingredient_Type._internal(
      id: id,
      ingredient_name: ingredient_name == null ? this.ingredient_name : ingredient_name.value,
      barcodes: barcodes == null ? this.barcodes : barcodes.value,
      settingsAvoidancesId: settingsAvoidancesId == null ? this.settingsAvoidancesId : settingsAvoidancesId.value
    );
  }
  
  Ingredient_Type.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _ingredient_name = json['ingredient_name'],
      _barcodes = json['barcodes']?.cast<String>(),
      _createdAt = json['createdAt'] != null ? amplify_core.TemporalDateTime.fromString(json['createdAt']) : null,
      _updatedAt = json['updatedAt'] != null ? amplify_core.TemporalDateTime.fromString(json['updatedAt']) : null,
      _settingsAvoidancesId = json['settingsAvoidancesId'];
  
  Map<String, dynamic> toJson() => {
    'id': id, 'ingredient_name': _ingredient_name, 'barcodes': _barcodes, 'createdAt': _createdAt?.format(), 'updatedAt': _updatedAt?.format(), 'settingsAvoidancesId': _settingsAvoidancesId
  };
  
  Map<String, Object?> toMap() => {
    'id': id,
    'ingredient_name': _ingredient_name,
    'barcodes': _barcodes,
    'createdAt': _createdAt,
    'updatedAt': _updatedAt,
    'settingsAvoidancesId': _settingsAvoidancesId
  };

  static final amplify_core.QueryModelIdentifier<Ingredient_TypeModelIdentifier> MODEL_IDENTIFIER = amplify_core.QueryModelIdentifier<Ingredient_TypeModelIdentifier>();
  static final ID = amplify_core.QueryField(fieldName: "id");
  static final INGREDIENT_NAME = amplify_core.QueryField(fieldName: "ingredient_name");
  static final BARCODES = amplify_core.QueryField(fieldName: "barcodes");
  static final SETTINGSAVOIDANCESID = amplify_core.QueryField(fieldName: "settingsAvoidancesId");
  static var schema = amplify_core.Model.defineSchema(define: (amplify_core.ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "Ingredient_Type";
    modelSchemaDefinition.pluralName = "Ingredient_Types";
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.id());
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: Ingredient_Type.INGREDIENT_NAME,
      isRequired: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: Ingredient_Type.BARCODES,
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
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: Ingredient_Type.SETTINGSAVOIDANCESID,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
  });
}

class _Ingredient_TypeModelType extends amplify_core.ModelType<Ingredient_Type> {
  const _Ingredient_TypeModelType();
  
  @override
  Ingredient_Type fromJson(Map<String, dynamic> jsonData) {
    return Ingredient_Type.fromJson(jsonData);
  }
  
  @override
  String modelName() {
    return 'Ingredient_Type';
  }
}

/**
 * This is an auto generated class representing the model identifier
 * of [Ingredient_Type] in your schema.
 */
class Ingredient_TypeModelIdentifier implements amplify_core.ModelIdentifier<Ingredient_Type> {
  final String id;

  /** Create an instance of Ingredient_TypeModelIdentifier using [id] the primary key. */
  const Ingredient_TypeModelIdentifier({
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
  String toString() => 'Ingredient_TypeModelIdentifier(id: $id)';
  
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    
    return other is Ingredient_TypeModelIdentifier &&
      id == other.id;
  }
  
  @override
  int get hashCode =>
    id.hashCode;
}