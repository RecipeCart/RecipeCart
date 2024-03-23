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


/** This is an auto generated class representing the IngredientType type in your schema. */
class IngredientType extends amplify_core.Model {
  static const classType = const _IngredientTypeModelType();
  final String id;
  final String? _ingredientName;
  final List<String>? _barcodes;
  final amplify_core.TemporalDateTime? _createdAt;
  final amplify_core.TemporalDateTime? _updatedAt;
  final String? _settingsAvoidancesId;

  @override
  getInstanceType() => classType;
  
  @Deprecated('[getId] is being deprecated in favor of custom primary key feature. Use getter [modelIdentifier] to get model identifier.')
  @override
  String getId() => id;
  
  IngredientTypeModelIdentifier get modelIdentifier {
      return IngredientTypeModelIdentifier(
        id: id
      );
  }
  
  String get ingredientName {
    try {
      return _ingredientName!;
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
  
  const IngredientType._internal({required this.id, required ingredientName, barcodes, createdAt, updatedAt, settingsAvoidancesId}): _ingredientName = ingredientName, _barcodes = barcodes, _createdAt = createdAt, _updatedAt = updatedAt, _settingsAvoidancesId = settingsAvoidancesId;
  
  factory IngredientType({String? id, required String ingredientName, List<String>? barcodes, String? settingsAvoidancesId}) {
    return IngredientType._internal(
      id: id == null ? amplify_core.UUID.getUUID() : id,
      ingredientName: ingredientName,
      barcodes: barcodes != null ? List<String>.unmodifiable(barcodes) : barcodes,
      settingsAvoidancesId: settingsAvoidancesId);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is IngredientType &&
      id == other.id &&
      _ingredientName == other._ingredientName &&
      DeepCollectionEquality().equals(_barcodes, other._barcodes) &&
      _settingsAvoidancesId == other._settingsAvoidancesId;
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("IngredientType {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("ingredientName=" + "$_ingredientName" + ", ");
    buffer.write("barcodes=" + (_barcodes != null ? _barcodes!.toString() : "null") + ", ");
    buffer.write("createdAt=" + (_createdAt != null ? _createdAt!.format() : "null") + ", ");
    buffer.write("updatedAt=" + (_updatedAt != null ? _updatedAt!.format() : "null") + ", ");
    buffer.write("settingsAvoidancesId=" + "$_settingsAvoidancesId");
    buffer.write("}");
    
    return buffer.toString();
  }
  
  IngredientType copyWith({String? ingredientName, List<String>? barcodes, String? settingsAvoidancesId}) {
    return IngredientType._internal(
      id: id,
      ingredientName: ingredientName ?? this.ingredientName,
      barcodes: barcodes ?? this.barcodes,
      settingsAvoidancesId: settingsAvoidancesId ?? this.settingsAvoidancesId);
  }
  
  IngredientType copyWithModelFieldValues({
    ModelFieldValue<String>? ingredientName,
    ModelFieldValue<List<String>?>? barcodes,
    ModelFieldValue<String?>? settingsAvoidancesId
  }) {
    return IngredientType._internal(
      id: id,
      ingredientName: ingredientName == null ? this.ingredientName : ingredientName.value,
      barcodes: barcodes == null ? this.barcodes : barcodes.value,
      settingsAvoidancesId: settingsAvoidancesId == null ? this.settingsAvoidancesId : settingsAvoidancesId.value
    );
  }
  
  IngredientType.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _ingredientName = json['ingredientName'],
      _barcodes = json['barcodes']?.cast<String>(),
      _createdAt = json['createdAt'] != null ? amplify_core.TemporalDateTime.fromString(json['createdAt']) : null,
      _updatedAt = json['updatedAt'] != null ? amplify_core.TemporalDateTime.fromString(json['updatedAt']) : null,
      _settingsAvoidancesId = json['settingsAvoidancesId'];
  
  Map<String, dynamic> toJson() => {
    'id': id, 'ingredientName': _ingredientName, 'barcodes': _barcodes, 'createdAt': _createdAt?.format(), 'updatedAt': _updatedAt?.format(), 'settingsAvoidancesId': _settingsAvoidancesId
  };
  
  Map<String, Object?> toMap() => {
    'id': id,
    'ingredientName': _ingredientName,
    'barcodes': _barcodes,
    'createdAt': _createdAt,
    'updatedAt': _updatedAt,
    'settingsAvoidancesId': _settingsAvoidancesId
  };

  static final amplify_core.QueryModelIdentifier<IngredientTypeModelIdentifier> MODEL_IDENTIFIER = amplify_core.QueryModelIdentifier<IngredientTypeModelIdentifier>();
  static final ID = amplify_core.QueryField(fieldName: "id");
  static final INGREDIENTNAME = amplify_core.QueryField(fieldName: "ingredientName");
  static final BARCODES = amplify_core.QueryField(fieldName: "barcodes");
  static final SETTINGSAVOIDANCESID = amplify_core.QueryField(fieldName: "settingsAvoidancesId");
  static var schema = amplify_core.Model.defineSchema(define: (amplify_core.ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "IngredientType";
    modelSchemaDefinition.pluralName = "IngredientTypes";
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.id());
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: IngredientType.INGREDIENTNAME,
      isRequired: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: IngredientType.BARCODES,
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
      key: IngredientType.SETTINGSAVOIDANCESID,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
  });
}

class _IngredientTypeModelType extends amplify_core.ModelType<IngredientType> {
  const _IngredientTypeModelType();
  
  @override
  IngredientType fromJson(Map<String, dynamic> jsonData) {
    return IngredientType.fromJson(jsonData);
  }
  
  @override
  String modelName() {
    return 'IngredientType';
  }
}

/**
 * This is an auto generated class representing the model identifier
 * of [IngredientType] in your schema.
 */
class IngredientTypeModelIdentifier implements amplify_core.ModelIdentifier<IngredientType> {
  final String id;

  /** Create an instance of IngredientTypeModelIdentifier using [id] the primary key. */
  const IngredientTypeModelIdentifier({
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
  String toString() => 'IngredientTypeModelIdentifier(id: $id)';
  
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    
    return other is IngredientTypeModelIdentifier &&
      id == other.id;
  }
  
  @override
  int get hashCode =>
    id.hashCode;
}