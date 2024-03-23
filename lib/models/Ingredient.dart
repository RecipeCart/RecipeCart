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


/** This is an auto generated class representing the Ingredient type in your schema. */
class Ingredient extends amplify_core.Model {
  static const classType = const _IngredientModelType();
  final String id;
  final double? _quantity;
  final IngredientType? _ingredientType;
  final amplify_core.TemporalDateTime? _createdAt;
  final amplify_core.TemporalDateTime? _updatedAt;
  final String? _ingredientIngredientTypeId;
  final String? _recipeIngredientsId;
  final String? _userInventoryId;

  @override
  getInstanceType() => classType;
  
  @Deprecated('[getId] is being deprecated in favor of custom primary key feature. Use getter [modelIdentifier] to get model identifier.')
  @override
  String getId() => id;
  
  IngredientModelIdentifier get modelIdentifier {
      return IngredientModelIdentifier(
        id: id
      );
  }
  
  double get quantity {
    try {
      return _quantity!;
    } catch(e) {
      throw amplify_core.AmplifyCodeGenModelException(
          amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  IngredientType get ingredientType {
    try {
      return _ingredientType!;
    } catch(e) {
      throw amplify_core.AmplifyCodeGenModelException(
          amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  amplify_core.TemporalDateTime? get createdAt {
    return _createdAt;
  }
  
  amplify_core.TemporalDateTime? get updatedAt {
    return _updatedAt;
  }
  
  String get ingredientIngredientTypeId {
    try {
      return _ingredientIngredientTypeId!;
    } catch(e) {
      throw amplify_core.AmplifyCodeGenModelException(
          amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  String? get recipeIngredientsId {
    return _recipeIngredientsId;
  }
  
  String? get userInventoryId {
    return _userInventoryId;
  }
  
  const Ingredient._internal({required this.id, required quantity, required ingredientType, createdAt, updatedAt, required ingredientIngredientTypeId, recipeIngredientsId, userInventoryId}): _quantity = quantity, _ingredientType = ingredientType, _createdAt = createdAt, _updatedAt = updatedAt, _ingredientIngredientTypeId = ingredientIngredientTypeId, _recipeIngredientsId = recipeIngredientsId, _userInventoryId = userInventoryId;
  
  factory Ingredient({String? id, required double quantity, required IngredientType ingredientType, required String ingredientIngredientTypeId, String? recipeIngredientsId, String? userInventoryId}) {
    return Ingredient._internal(
      id: id == null ? amplify_core.UUID.getUUID() : id,
      quantity: quantity,
      ingredientType: ingredientType,
      ingredientIngredientTypeId: ingredientIngredientTypeId,
      recipeIngredientsId: recipeIngredientsId,
      userInventoryId: userInventoryId);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Ingredient &&
      id == other.id &&
      _quantity == other._quantity &&
      _ingredientType == other._ingredientType &&
      _ingredientIngredientTypeId == other._ingredientIngredientTypeId &&
      _recipeIngredientsId == other._recipeIngredientsId &&
      _userInventoryId == other._userInventoryId;
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("Ingredient {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("quantity=" + (_quantity != null ? _quantity!.toString() : "null") + ", ");
    buffer.write("createdAt=" + (_createdAt != null ? _createdAt!.format() : "null") + ", ");
    buffer.write("updatedAt=" + (_updatedAt != null ? _updatedAt!.format() : "null") + ", ");
    buffer.write("ingredientIngredientTypeId=" + "$_ingredientIngredientTypeId" + ", ");
    buffer.write("recipeIngredientsId=" + "$_recipeIngredientsId" + ", ");
    buffer.write("userInventoryId=" + "$_userInventoryId");
    buffer.write("}");
    
    return buffer.toString();
  }
  
  Ingredient copyWith({double? quantity, IngredientType? ingredientType, String? ingredientIngredientTypeId, String? recipeIngredientsId, String? userInventoryId}) {
    return Ingredient._internal(
      id: id,
      quantity: quantity ?? this.quantity,
      ingredientType: ingredientType ?? this.ingredientType,
      ingredientIngredientTypeId: ingredientIngredientTypeId ?? this.ingredientIngredientTypeId,
      recipeIngredientsId: recipeIngredientsId ?? this.recipeIngredientsId,
      userInventoryId: userInventoryId ?? this.userInventoryId);
  }
  
  Ingredient copyWithModelFieldValues({
    ModelFieldValue<double>? quantity,
    ModelFieldValue<IngredientType>? ingredientType,
    ModelFieldValue<String>? ingredientIngredientTypeId,
    ModelFieldValue<String?>? recipeIngredientsId,
    ModelFieldValue<String?>? userInventoryId
  }) {
    return Ingredient._internal(
      id: id,
      quantity: quantity == null ? this.quantity : quantity.value,
      ingredientType: ingredientType == null ? this.ingredientType : ingredientType.value,
      ingredientIngredientTypeId: ingredientIngredientTypeId == null ? this.ingredientIngredientTypeId : ingredientIngredientTypeId.value,
      recipeIngredientsId: recipeIngredientsId == null ? this.recipeIngredientsId : recipeIngredientsId.value,
      userInventoryId: userInventoryId == null ? this.userInventoryId : userInventoryId.value
    );
  }
  
  Ingredient.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _quantity = (json['quantity'] as num?)?.toDouble(),
      _ingredientType = json['ingredientType']?['serializedData'] != null
        ? IngredientType.fromJson(new Map<String, dynamic>.from(json['ingredientType']['serializedData']))
        : null,
      _createdAt = json['createdAt'] != null ? amplify_core.TemporalDateTime.fromString(json['createdAt']) : null,
      _updatedAt = json['updatedAt'] != null ? amplify_core.TemporalDateTime.fromString(json['updatedAt']) : null,
      _ingredientIngredientTypeId = json['ingredientIngredientTypeId'],
      _recipeIngredientsId = json['recipeIngredientsId'],
      _userInventoryId = json['userInventoryId'];
  
  Map<String, dynamic> toJson() => {
    'id': id, 'quantity': _quantity, 'ingredientType': _ingredientType?.toJson(), 'createdAt': _createdAt?.format(), 'updatedAt': _updatedAt?.format(), 'ingredientIngredientTypeId': _ingredientIngredientTypeId, 'recipeIngredientsId': _recipeIngredientsId, 'userInventoryId': _userInventoryId
  };
  
  Map<String, Object?> toMap() => {
    'id': id,
    'quantity': _quantity,
    'ingredientType': _ingredientType,
    'createdAt': _createdAt,
    'updatedAt': _updatedAt,
    'ingredientIngredientTypeId': _ingredientIngredientTypeId,
    'recipeIngredientsId': _recipeIngredientsId,
    'userInventoryId': _userInventoryId
  };

  static final amplify_core.QueryModelIdentifier<IngredientModelIdentifier> MODEL_IDENTIFIER = amplify_core.QueryModelIdentifier<IngredientModelIdentifier>();
  static final ID = amplify_core.QueryField(fieldName: "id");
  static final QUANTITY = amplify_core.QueryField(fieldName: "quantity");
  static final INGREDIENTTYPE = amplify_core.QueryField(
    fieldName: "ingredientType",
    fieldType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.model, ofModelName: 'IngredientType'));
  static final INGREDIENTINGREDIENTTYPEID = amplify_core.QueryField(fieldName: "ingredientIngredientTypeId");
  static final RECIPEINGREDIENTSID = amplify_core.QueryField(fieldName: "recipeIngredientsId");
  static final USERINVENTORYID = amplify_core.QueryField(fieldName: "userInventoryId");
  static var schema = amplify_core.Model.defineSchema(define: (amplify_core.ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "Ingredient";
    modelSchemaDefinition.pluralName = "Ingredients";
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.id());
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: Ingredient.QUANTITY,
      isRequired: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.double)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.hasOne(
      key: Ingredient.INGREDIENTTYPE,
      isRequired: true,
      ofModelName: 'IngredientType',
      associatedKey: IngredientType.ID
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
      key: Ingredient.INGREDIENTINGREDIENTTYPEID,
      isRequired: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: Ingredient.RECIPEINGREDIENTSID,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: Ingredient.USERINVENTORYID,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
  });
}

class _IngredientModelType extends amplify_core.ModelType<Ingredient> {
  const _IngredientModelType();
  
  @override
  Ingredient fromJson(Map<String, dynamic> jsonData) {
    return Ingredient.fromJson(jsonData);
  }
  
  @override
  String modelName() {
    return 'Ingredient';
  }
}

/**
 * This is an auto generated class representing the model identifier
 * of [Ingredient] in your schema.
 */
class IngredientModelIdentifier implements amplify_core.ModelIdentifier<Ingredient> {
  final String id;

  /** Create an instance of IngredientModelIdentifier using [id] the primary key. */
  const IngredientModelIdentifier({
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
  String toString() => 'IngredientModelIdentifier(id: $id)';
  
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    
    return other is IngredientModelIdentifier &&
      id == other.id;
  }
  
  @override
  int get hashCode =>
    id.hashCode;
}