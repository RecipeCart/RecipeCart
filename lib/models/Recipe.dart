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


/** This is an auto generated class representing the Recipe type in your schema. */
class Recipe extends amplify_core.Model {
  static const classType = const _RecipeModelType();
  final String id;
  final String? _recipeName;
  final int? _dietType;
  final int? _cuisineType;
  final String? _userID;
  final String? _instructions;
  final double? _ratings;
  final int? _views;
  final String? _image;
  final amplify_core.TemporalDateTime? _createdAt;
  final amplify_core.TemporalDateTime? _updatedAt;

  @override
  getInstanceType() => classType;
  
  @Deprecated('[getId] is being deprecated in favor of custom primary key feature. Use getter [modelIdentifier] to get model identifier.')
  @override
  String getId() => id;
  
  RecipeModelIdentifier get modelIdentifier {
    try {
      return RecipeModelIdentifier(
        id: id,
        recipeName: _recipeName!
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
  
  String get recipeName {
    try {
      return _recipeName!;
    } catch(e) {
      throw amplify_core.AmplifyCodeGenModelException(
          amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
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
  
  int get cuisineType {
    try {
      return _cuisineType!;
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
  
  String get instructions {
    try {
      return _instructions!;
    } catch(e) {
      throw amplify_core.AmplifyCodeGenModelException(
          amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  double get ratings {
    try {
      return _ratings!;
    } catch(e) {
      throw amplify_core.AmplifyCodeGenModelException(
          amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  int get views {
    try {
      return _views!;
    } catch(e) {
      throw amplify_core.AmplifyCodeGenModelException(
          amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  String? get image {
    return _image;
  }
  
  amplify_core.TemporalDateTime? get createdAt {
    return _createdAt;
  }
  
  amplify_core.TemporalDateTime? get updatedAt {
    return _updatedAt;
  }
  
  const Recipe._internal({required this.id, required recipeName, required dietType, required cuisineType, userID, required instructions, required ratings, required views, image, createdAt, updatedAt}): _recipeName = recipeName, _dietType = dietType, _cuisineType = cuisineType, _userID = userID, _instructions = instructions, _ratings = ratings, _views = views, _image = image, _createdAt = createdAt, _updatedAt = updatedAt;
  
  factory Recipe({String? id, required String recipeName, required int dietType, required int cuisineType, String? userID, required String instructions, required double ratings, required int views, String? image}) {
    return Recipe._internal(
      id: id == null ? amplify_core.UUID.getUUID() : id,
      recipeName: recipeName,
      dietType: dietType,
      cuisineType: cuisineType,
      userID: userID,
      instructions: instructions,
      ratings: ratings,
      views: views,
      image: image);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Recipe &&
      id == other.id &&
      _recipeName == other._recipeName &&
      _dietType == other._dietType &&
      _cuisineType == other._cuisineType &&
      _userID == other._userID &&
      _instructions == other._instructions &&
      _ratings == other._ratings &&
      _views == other._views &&
      _image == other._image;
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("Recipe {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("recipeName=" + "$_recipeName" + ", ");
    buffer.write("dietType=" + (_dietType != null ? _dietType!.toString() : "null") + ", ");
    buffer.write("cuisineType=" + (_cuisineType != null ? _cuisineType!.toString() : "null") + ", ");
    buffer.write("userID=" + "$_userID" + ", ");
    buffer.write("instructions=" + "$_instructions" + ", ");
    buffer.write("ratings=" + (_ratings != null ? _ratings!.toString() : "null") + ", ");
    buffer.write("views=" + (_views != null ? _views!.toString() : "null") + ", ");
    buffer.write("image=" + "$_image" + ", ");
    buffer.write("createdAt=" + (_createdAt != null ? _createdAt!.format() : "null") + ", ");
    buffer.write("updatedAt=" + (_updatedAt != null ? _updatedAt!.format() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  Recipe copyWith({int? dietType, int? cuisineType, String? userID, String? instructions, double? ratings, int? views, String? image}) {
    return Recipe._internal(
      id: id,
      recipeName: recipeName,
      dietType: dietType ?? this.dietType,
      cuisineType: cuisineType ?? this.cuisineType,
      userID: userID ?? this.userID,
      instructions: instructions ?? this.instructions,
      ratings: ratings ?? this.ratings,
      views: views ?? this.views,
      image: image ?? this.image);
  }
  
  Recipe copyWithModelFieldValues({
    ModelFieldValue<int>? dietType,
    ModelFieldValue<int>? cuisineType,
    ModelFieldValue<String?>? userID,
    ModelFieldValue<String>? instructions,
    ModelFieldValue<double>? ratings,
    ModelFieldValue<int>? views,
    ModelFieldValue<String?>? image
  }) {
    return Recipe._internal(
      id: id,
      recipeName: recipeName,
      dietType: dietType == null ? this.dietType : dietType.value,
      cuisineType: cuisineType == null ? this.cuisineType : cuisineType.value,
      userID: userID == null ? this.userID : userID.value,
      instructions: instructions == null ? this.instructions : instructions.value,
      ratings: ratings == null ? this.ratings : ratings.value,
      views: views == null ? this.views : views.value,
      image: image == null ? this.image : image.value
    );
  }
  
  Recipe.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _recipeName = json['recipeName'],
      _dietType = (json['dietType'] as num?)?.toInt(),
      _cuisineType = (json['cuisineType'] as num?)?.toInt(),
      _userID = json['userID'],
      _instructions = json['instructions'],
      _ratings = (json['ratings'] as num?)?.toDouble(),
      _views = (json['views'] as num?)?.toInt(),
      _image = json['image'],
      _createdAt = json['createdAt'] != null ? amplify_core.TemporalDateTime.fromString(json['createdAt']) : null,
      _updatedAt = json['updatedAt'] != null ? amplify_core.TemporalDateTime.fromString(json['updatedAt']) : null;
  
  Map<String, dynamic> toJson() => {
    'id': id, 'recipeName': _recipeName, 'dietType': _dietType, 'cuisineType': _cuisineType, 'userID': _userID, 'instructions': _instructions, 'ratings': _ratings, 'views': _views, 'image': _image, 'createdAt': _createdAt?.format(), 'updatedAt': _updatedAt?.format()
  };
  
  Map<String, Object?> toMap() => {
    'id': id,
    'recipeName': _recipeName,
    'dietType': _dietType,
    'cuisineType': _cuisineType,
    'userID': _userID,
    'instructions': _instructions,
    'ratings': _ratings,
    'views': _views,
    'image': _image,
    'createdAt': _createdAt,
    'updatedAt': _updatedAt
  };

  static final amplify_core.QueryModelIdentifier<RecipeModelIdentifier> MODEL_IDENTIFIER = amplify_core.QueryModelIdentifier<RecipeModelIdentifier>();
  static final ID = amplify_core.QueryField(fieldName: "id");
  static final RECIPENAME = amplify_core.QueryField(fieldName: "recipeName");
  static final DIETTYPE = amplify_core.QueryField(fieldName: "dietType");
  static final CUISINETYPE = amplify_core.QueryField(fieldName: "cuisineType");
  static final USERID = amplify_core.QueryField(fieldName: "userID");
  static final INSTRUCTIONS = amplify_core.QueryField(fieldName: "instructions");
  static final RATINGS = amplify_core.QueryField(fieldName: "ratings");
  static final VIEWS = amplify_core.QueryField(fieldName: "views");
  static final IMAGE = amplify_core.QueryField(fieldName: "image");
  static var schema = amplify_core.Model.defineSchema(define: (amplify_core.ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "Recipe";
    modelSchemaDefinition.pluralName = "Recipes";
    
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
      amplify_core.ModelIndex(fields: const ["id", "recipeName"], name: null),
      amplify_core.ModelIndex(fields: const ["recipeName"], name: "byRecipeName"),
      amplify_core.ModelIndex(fields: const ["dietType", "cuisineType"], name: "byDietByCuisine"),
      amplify_core.ModelIndex(fields: const ["userID"], name: "byUserID"),
      amplify_core.ModelIndex(fields: const ["ratings", "views"], name: "byRatingsByViews")
    ];
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.id());
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: Recipe.RECIPENAME,
      isRequired: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: Recipe.DIETTYPE,
      isRequired: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.int)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: Recipe.CUISINETYPE,
      isRequired: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.int)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: Recipe.USERID,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: Recipe.INSTRUCTIONS,
      isRequired: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: Recipe.RATINGS,
      isRequired: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.double)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: Recipe.VIEWS,
      isRequired: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.int)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: Recipe.IMAGE,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
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

class _RecipeModelType extends amplify_core.ModelType<Recipe> {
  const _RecipeModelType();
  
  @override
  Recipe fromJson(Map<String, dynamic> jsonData) {
    return Recipe.fromJson(jsonData);
  }
  
  @override
  String modelName() {
    return 'Recipe';
  }
}

/**
 * This is an auto generated class representing the model identifier
 * of [Recipe] in your schema.
 */
class RecipeModelIdentifier implements amplify_core.ModelIdentifier<Recipe> {
  final String id;
  final String recipeName;

  /**
   * Create an instance of RecipeModelIdentifier using [id] the primary key.
   * And [recipeName] the sort key.
   */
  const RecipeModelIdentifier({
    required this.id,
    required this.recipeName});
  
  @override
  Map<String, dynamic> serializeAsMap() => (<String, dynamic>{
    'id': id,
    'recipeName': recipeName
  });
  
  @override
  List<Map<String, dynamic>> serializeAsList() => serializeAsMap()
    .entries
    .map((entry) => (<String, dynamic>{ entry.key: entry.value }))
    .toList();
  
  @override
  String serializeAsString() => serializeAsMap().values.join('#');
  
  @override
  String toString() => 'RecipeModelIdentifier(id: $id, recipeName: $recipeName)';
  
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    
    return other is RecipeModelIdentifier &&
      id == other.id &&
      recipeName == other.recipeName;
  }
  
  @override
  int get hashCode =>
    id.hashCode ^
    recipeName.hashCode;
}