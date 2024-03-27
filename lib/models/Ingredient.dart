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
  final List<double>? _vector;
  final String? _barcode;
  final double? _quantity;
  final Settings? _settings;
  final amplify_core.TemporalDateTime? _createdAt;
  final amplify_core.TemporalDateTime? _updatedAt;

  @override
  getInstanceType() => classType;
  
  @Deprecated('[getId] is being deprecated in favor of custom primary key feature. Use getter [modelIdentifier] to get model identifier.')
  @override
  String getId() => id;
  
  IngredientModelIdentifier get modelIdentifier {
    try {
      return IngredientModelIdentifier(
        id: id,
        ingredientName: _ingredientName!
      );
    } catch(e) {
      throw amplify_core.AmplifyCodeGenModelException(
          amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
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
  
  List<double>? get vector {
    return _vector;
  }
  
  String? get barcode {
    return _barcode;
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
  
  Settings? get settings {
    return _settings;
  }
  
  amplify_core.TemporalDateTime? get createdAt {
    return _createdAt;
  }
  
  amplify_core.TemporalDateTime? get updatedAt {
    return _updatedAt;
  }
  
  const Ingredient._internal({required this.id, required ingredientName, userID, vector, barcode, required quantity, settings, createdAt, updatedAt}): _ingredientName = ingredientName, _userID = userID, _vector = vector, _barcode = barcode, _quantity = quantity, _settings = settings, _createdAt = createdAt, _updatedAt = updatedAt;
  
  factory Ingredient({String? id, required String ingredientName, String? userID, List<double>? vector, String? barcode, required double quantity, Settings? settings}) {
    return Ingredient._internal(
      id: id == null ? amplify_core.UUID.getUUID() : id,
      ingredientName: ingredientName,
      userID: userID,
      vector: vector != null ? List<double>.unmodifiable(vector) : vector,
      barcode: barcode,
      quantity: quantity,
      settings: settings);
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
      DeepCollectionEquality().equals(_vector, other._vector) &&
      _barcode == other._barcode &&
      _quantity == other._quantity &&
      _settings == other._settings;
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
    buffer.write("vector=" + (_vector != null ? _vector!.toString() : "null") + ", ");
    buffer.write("barcode=" + "$_barcode" + ", ");
    buffer.write("quantity=" + (_quantity != null ? _quantity!.toString() : "null") + ", ");
    buffer.write("settings=" + (_settings != null ? _settings!.toString() : "null") + ", ");
    buffer.write("createdAt=" + (_createdAt != null ? _createdAt!.format() : "null") + ", ");
    buffer.write("updatedAt=" + (_updatedAt != null ? _updatedAt!.format() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  Ingredient copyWith({String? userID, List<double>? vector, String? barcode, double? quantity, Settings? settings}) {
    return Ingredient._internal(
      id: id,
      ingredientName: ingredientName,
      userID: userID ?? this.userID,
      vector: vector ?? this.vector,
      barcode: barcode ?? this.barcode,
      quantity: quantity ?? this.quantity,
      settings: settings ?? this.settings);
  }
  
  Ingredient copyWithModelFieldValues({
    ModelFieldValue<String?>? userID,
    ModelFieldValue<List<double>?>? vector,
    ModelFieldValue<String?>? barcode,
    ModelFieldValue<double>? quantity,
    ModelFieldValue<Settings?>? settings
  }) {
    return Ingredient._internal(
      id: id,
      ingredientName: ingredientName,
      userID: userID == null ? this.userID : userID.value,
      vector: vector == null ? this.vector : vector.value,
      barcode: barcode == null ? this.barcode : barcode.value,
      quantity: quantity == null ? this.quantity : quantity.value,
      settings: settings == null ? this.settings : settings.value
    );
  }
  
  Ingredient.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _ingredientName = json['ingredientName'],
      _userID = json['userID'],
      _vector = (json['vector'] as List?)?.map((e) => (e as num).toDouble()).toList(),
      _barcode = json['barcode'],
      _quantity = (json['quantity'] as num?)?.toDouble(),
      _settings = json['settings']?['serializedData'] != null
        ? Settings.fromJson(new Map<String, dynamic>.from(json['settings']['serializedData']))
        : null,
      _createdAt = json['createdAt'] != null ? amplify_core.TemporalDateTime.fromString(json['createdAt']) : null,
      _updatedAt = json['updatedAt'] != null ? amplify_core.TemporalDateTime.fromString(json['updatedAt']) : null;
  
  Map<String, dynamic> toJson() => {
    'id': id, 'ingredientName': _ingredientName, 'userID': _userID, 'vector': _vector, 'barcode': _barcode, 'quantity': _quantity, 'settings': _settings?.toJson(), 'createdAt': _createdAt?.format(), 'updatedAt': _updatedAt?.format()
  };
  
  Map<String, Object?> toMap() => {
    'id': id,
    'ingredientName': _ingredientName,
    'userID': _userID,
    'vector': _vector,
    'barcode': _barcode,
    'quantity': _quantity,
    'settings': _settings,
    'createdAt': _createdAt,
    'updatedAt': _updatedAt
  };

  static final amplify_core.QueryModelIdentifier<IngredientModelIdentifier> MODEL_IDENTIFIER = amplify_core.QueryModelIdentifier<IngredientModelIdentifier>();
  static final ID = amplify_core.QueryField(fieldName: "id");
  static final INGREDIENTNAME = amplify_core.QueryField(fieldName: "ingredientName");
  static final USERID = amplify_core.QueryField(fieldName: "userID");
  static final VECTOR = amplify_core.QueryField(fieldName: "vector");
  static final BARCODE = amplify_core.QueryField(fieldName: "barcode");
  static final QUANTITY = amplify_core.QueryField(fieldName: "quantity");
  static final SETTINGS = amplify_core.QueryField(
    fieldName: "settings",
    fieldType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.model, ofModelName: 'Settings'));
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
      amplify_core.ModelIndex(fields: const ["id", "ingredientName"], name: null),
      amplify_core.ModelIndex(fields: const ["ingredientName"], name: "byIngredientName"),
      amplify_core.ModelIndex(fields: const ["userID"], name: "byUserID"),
      amplify_core.ModelIndex(fields: const ["barcode"], name: "byBarcode"),
      amplify_core.ModelIndex(fields: const ["settingsID"], name: "bySettings")
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
      key: Ingredient.VECTOR,
      isRequired: false,
      isArray: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.collection, ofModelName: amplify_core.ModelFieldTypeEnum.double.name)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: Ingredient.BARCODE,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: Ingredient.QUANTITY,
      isRequired: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.double)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.belongsTo(
      key: Ingredient.SETTINGS,
      isRequired: false,
      targetNames: ['settingsID'],
      ofModelName: 'Settings'
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
  final String ingredientName;

  /**
   * Create an instance of IngredientModelIdentifier using [id] the primary key.
   * And [ingredientName] the sort key.
   */
  const IngredientModelIdentifier({
    required this.id,
    required this.ingredientName});
  
  @override
  Map<String, dynamic> serializeAsMap() => (<String, dynamic>{
    'id': id,
    'ingredientName': ingredientName
  });
  
  @override
  List<Map<String, dynamic>> serializeAsList() => serializeAsMap()
    .entries
    .map((entry) => (<String, dynamic>{ entry.key: entry.value }))
    .toList();
  
  @override
  String serializeAsString() => serializeAsMap().values.join('#');
  
  @override
  String toString() => 'IngredientModelIdentifier(id: $id, ingredientName: $ingredientName)';
  
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    
    return other is IngredientModelIdentifier &&
      id == other.id &&
      ingredientName == other.ingredientName;
  }
  
  @override
  int get hashCode =>
    id.hashCode ^
    ingredientName.hashCode;
}