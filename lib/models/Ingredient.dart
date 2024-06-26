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


/** This is an auto generated class representing the Ingredient type in your schema. */
class Ingredient extends amplify_core.Model {
  static const classType = const _IngredientModelType();
  final String id;
  final String? _ingredientName;
  final String? _userID;
  final String? _barcode;
  final List<String>? _relatedNames;
  final bool? _removed;
  final double? _quantity;
  final String? _unit;
  final double? _standardQuantity;
  final amplify_core.TemporalDateTime? _createdAt;
  final amplify_core.TemporalDateTime? _updatedAt;

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
  
  String? get userID {
    return _userID;
  }
  
  String? get barcode {
    return _barcode;
  }
  
  List<String> get relatedNames {
    try {
      return _relatedNames!;
    } catch(e) {
      throw amplify_core.AmplifyCodeGenModelException(
          amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  bool get removed {
    try {
      return _removed!;
    } catch(e) {
      throw amplify_core.AmplifyCodeGenModelException(
          amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  double? get quantity {
    return _quantity;
  }
  
  String? get unit {
    return _unit;
  }
  
  double? get standardQuantity {
    return _standardQuantity;
  }
  
  amplify_core.TemporalDateTime? get createdAt {
    return _createdAt;
  }
  
  amplify_core.TemporalDateTime? get updatedAt {
    return _updatedAt;
  }
  
  const Ingredient._internal({required this.id, required ingredientName, userID, barcode, required relatedNames, required removed, quantity, unit, standardQuantity, createdAt, updatedAt}): _ingredientName = ingredientName, _userID = userID, _barcode = barcode, _relatedNames = relatedNames, _removed = removed, _quantity = quantity, _unit = unit, _standardQuantity = standardQuantity, _createdAt = createdAt, _updatedAt = updatedAt;
  
  factory Ingredient({String? id, required String ingredientName, String? userID, String? barcode, required List<String> relatedNames, required bool removed, double? quantity, String? unit, double? standardQuantity}) {
    return Ingredient._internal(
      id: id == null ? amplify_core.UUID.getUUID() : id,
      ingredientName: ingredientName,
      userID: userID,
      barcode: barcode,
      relatedNames: relatedNames != null ? List<String>.unmodifiable(relatedNames) : relatedNames,
      removed: removed,
      quantity: quantity,
      unit: unit,
      standardQuantity: standardQuantity);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Ingredient &&
      id == other.id &&
      _ingredientName == other._ingredientName &&
      _userID == other._userID &&
      _barcode == other._barcode &&
      DeepCollectionEquality().equals(_relatedNames, other._relatedNames) &&
      _removed == other._removed &&
      _quantity == other._quantity &&
      _unit == other._unit &&
      _standardQuantity == other._standardQuantity;
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("Ingredient {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("ingredientName=" + "$_ingredientName" + ", ");
    buffer.write("userID=" + "$_userID" + ", ");
    buffer.write("barcode=" + "$_barcode" + ", ");
    buffer.write("relatedNames=" + (_relatedNames != null ? _relatedNames!.toString() : "null") + ", ");
    buffer.write("removed=" + (_removed != null ? _removed!.toString() : "null") + ", ");
    buffer.write("quantity=" + (_quantity != null ? _quantity!.toString() : "null") + ", ");
    buffer.write("unit=" + "$_unit" + ", ");
    buffer.write("standardQuantity=" + (_standardQuantity != null ? _standardQuantity!.toString() : "null") + ", ");
    buffer.write("createdAt=" + (_createdAt != null ? _createdAt!.format() : "null") + ", ");
    buffer.write("updatedAt=" + (_updatedAt != null ? _updatedAt!.format() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  Ingredient copyWith({String? ingredientName, String? userID, String? barcode, List<String>? relatedNames, bool? removed, double? quantity, String? unit, double? standardQuantity}) {
    return Ingredient._internal(
      id: id,
      ingredientName: ingredientName ?? this.ingredientName,
      userID: userID ?? this.userID,
      barcode: barcode ?? this.barcode,
      relatedNames: relatedNames ?? this.relatedNames,
      removed: removed ?? this.removed,
      quantity: quantity ?? this.quantity,
      unit: unit ?? this.unit,
      standardQuantity: standardQuantity ?? this.standardQuantity);
  }
  
  Ingredient copyWithModelFieldValues({
    ModelFieldValue<String>? ingredientName,
    ModelFieldValue<String?>? userID,
    ModelFieldValue<String?>? barcode,
    ModelFieldValue<List<String>>? relatedNames,
    ModelFieldValue<bool>? removed,
    ModelFieldValue<double?>? quantity,
    ModelFieldValue<String?>? unit,
    ModelFieldValue<double?>? standardQuantity
  }) {
    return Ingredient._internal(
      id: id,
      ingredientName: ingredientName == null ? this.ingredientName : ingredientName.value,
      userID: userID == null ? this.userID : userID.value,
      barcode: barcode == null ? this.barcode : barcode.value,
      relatedNames: relatedNames == null ? this.relatedNames : relatedNames.value,
      removed: removed == null ? this.removed : removed.value,
      quantity: quantity == null ? this.quantity : quantity.value,
      unit: unit == null ? this.unit : unit.value,
      standardQuantity: standardQuantity == null ? this.standardQuantity : standardQuantity.value
    );
  }
  
  Ingredient.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _ingredientName = json['ingredientName'],
      _userID = json['userID'],
      _barcode = json['barcode'],
      _relatedNames = json['relatedNames']?.cast<String>(),
      _removed = json['removed'],
      _quantity = (json['quantity'] as num?)?.toDouble(),
      _unit = json['unit'],
      _standardQuantity = (json['standardQuantity'] as num?)?.toDouble(),
      _createdAt = json['createdAt'] != null ? amplify_core.TemporalDateTime.fromString(json['createdAt']) : null,
      _updatedAt = json['updatedAt'] != null ? amplify_core.TemporalDateTime.fromString(json['updatedAt']) : null;
  
  Map<String, dynamic> toJson() => {
    'id': id, 'ingredientName': _ingredientName, 'userID': _userID, 'barcode': _barcode, 'relatedNames': _relatedNames, 'removed': _removed, 'quantity': _quantity, 'unit': _unit, 'standardQuantity': _standardQuantity, 'createdAt': _createdAt?.format(), 'updatedAt': _updatedAt?.format()
  };
  
  Map<String, Object?> toMap() => {
    'id': id,
    'ingredientName': _ingredientName,
    'userID': _userID,
    'barcode': _barcode,
    'relatedNames': _relatedNames,
    'removed': _removed,
    'quantity': _quantity,
    'unit': _unit,
    'standardQuantity': _standardQuantity,
    'createdAt': _createdAt,
    'updatedAt': _updatedAt
  };

  static final amplify_core.QueryModelIdentifier<IngredientModelIdentifier> MODEL_IDENTIFIER = amplify_core.QueryModelIdentifier<IngredientModelIdentifier>();
  static final ID = amplify_core.QueryField(fieldName: "id");
  static final INGREDIENTNAME = amplify_core.QueryField(fieldName: "ingredientName");
  static final USERID = amplify_core.QueryField(fieldName: "userID");
  static final BARCODE = amplify_core.QueryField(fieldName: "barcode");
  static final RELATEDNAMES = amplify_core.QueryField(fieldName: "relatedNames");
  static final REMOVED = amplify_core.QueryField(fieldName: "removed");
  static final QUANTITY = amplify_core.QueryField(fieldName: "quantity");
  static final UNIT = amplify_core.QueryField(fieldName: "unit");
  static final STANDARDQUANTITY = amplify_core.QueryField(fieldName: "standardQuantity");
  static var schema = amplify_core.Model.defineSchema(define: (amplify_core.ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "Ingredient";
    modelSchemaDefinition.pluralName = "Ingredients";
    
    modelSchemaDefinition.authRules = [
      amplify_core.AuthRule(
        authStrategy: amplify_core.AuthStrategy.PRIVATE,
        operations: const [
          amplify_core.ModelOperation.READ
        ]),
      amplify_core.AuthRule(
        authStrategy: amplify_core.AuthStrategy.OWNER,
        ownerField: "userID",
        identityClaim: "cognito:username",
        provider: amplify_core.AuthRuleProvider.USERPOOLS,
        operations: const [
          amplify_core.ModelOperation.CREATE,
          amplify_core.ModelOperation.UPDATE,
          amplify_core.ModelOperation.DELETE,
          amplify_core.ModelOperation.READ
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
    
    modelSchemaDefinition.indexes = [
      amplify_core.ModelIndex(fields: const ["id"], name: null),
      amplify_core.ModelIndex(fields: const ["ingredientName"], name: "byIngredientName"),
      amplify_core.ModelIndex(fields: const ["userID"], name: "byUserID"),
      amplify_core.ModelIndex(fields: const ["barcode"], name: "byBarcode")
    ];
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.id());
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: Ingredient.INGREDIENTNAME,
      isRequired: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: Ingredient.USERID,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: Ingredient.BARCODE,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: Ingredient.RELATEDNAMES,
      isRequired: true,
      isArray: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.collection, ofModelName: amplify_core.ModelFieldTypeEnum.string.name)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: Ingredient.REMOVED,
      isRequired: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.bool)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: Ingredient.QUANTITY,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.double)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: Ingredient.UNIT,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: Ingredient.STANDARDQUANTITY,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.double)
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