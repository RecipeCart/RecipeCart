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


/** This is an auto generated class representing the Recipe type in your schema. */
class Recipe extends amplify_core.Model {
  static const classType = const _RecipeModelType();
  final String id;
  final String? _recipeName;
  final List<Ingredient>? _ingredients;
  final String? _instructions;
  final double? _ratings;
  final String? _image;
  final int? _views;
  final amplify_core.TemporalDateTime? _createdAt;
  final amplify_core.TemporalDateTime? _updatedAt;
  final String? _userSavedRecipesId;

  @override
  getInstanceType() => classType;
  
  @Deprecated('[getId] is being deprecated in favor of custom primary key feature. Use getter [modelIdentifier] to get model identifier.')
  @override
  String getId() => id;
  
  RecipeModelIdentifier get modelIdentifier {
      return RecipeModelIdentifier(
        id: id
      );
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
  
  List<Ingredient>? get ingredients {
    return _ingredients;
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
  
  String? get image {
    return _image;
  }
  
  int? get views {
    return _views;
  }
  
  amplify_core.TemporalDateTime? get createdAt {
    return _createdAt;
  }
  
  amplify_core.TemporalDateTime? get updatedAt {
    return _updatedAt;
  }
  
  String? get userSavedRecipesId {
    return _userSavedRecipesId;
  }
  
  const Recipe._internal({required this.id, required recipeName, ingredients, required instructions, required ratings, image, views, createdAt, updatedAt, userSavedRecipesId}): _recipeName = recipeName, _ingredients = ingredients, _instructions = instructions, _ratings = ratings, _image = image, _views = views, _createdAt = createdAt, _updatedAt = updatedAt, _userSavedRecipesId = userSavedRecipesId;
  
  factory Recipe({String? id, required String recipeName, List<Ingredient>? ingredients, required String instructions, required double ratings, String? image, int? views, String? userSavedRecipesId}) {
    return Recipe._internal(
      id: id == null ? amplify_core.UUID.getUUID() : id,
      recipeName: recipeName,
      ingredients: ingredients != null ? List<Ingredient>.unmodifiable(ingredients) : ingredients,
      instructions: instructions,
      ratings: ratings,
      image: image,
      views: views,
      userSavedRecipesId: userSavedRecipesId);
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
      DeepCollectionEquality().equals(_ingredients, other._ingredients) &&
      _instructions == other._instructions &&
      _ratings == other._ratings &&
      _image == other._image &&
      _views == other._views &&
      _userSavedRecipesId == other._userSavedRecipesId;
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("Recipe {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("recipeName=" + "$_recipeName" + ", ");
    buffer.write("instructions=" + "$_instructions" + ", ");
    buffer.write("ratings=" + (_ratings != null ? _ratings!.toString() : "null") + ", ");
    buffer.write("image=" + "$_image" + ", ");
    buffer.write("views=" + (_views != null ? _views!.toString() : "null") + ", ");
    buffer.write("createdAt=" + (_createdAt != null ? _createdAt!.format() : "null") + ", ");
    buffer.write("updatedAt=" + (_updatedAt != null ? _updatedAt!.format() : "null") + ", ");
    buffer.write("userSavedRecipesId=" + "$_userSavedRecipesId");
    buffer.write("}");
    
    return buffer.toString();
  }
  
  Recipe copyWith({String? recipeName, List<Ingredient>? ingredients, String? instructions, double? ratings, String? image, int? views, String? userSavedRecipesId}) {
    return Recipe._internal(
      id: id,
      recipeName: recipeName ?? this.recipeName,
      ingredients: ingredients ?? this.ingredients,
      instructions: instructions ?? this.instructions,
      ratings: ratings ?? this.ratings,
      image: image ?? this.image,
      views: views ?? this.views,
      userSavedRecipesId: userSavedRecipesId ?? this.userSavedRecipesId);
  }
  
  Recipe copyWithModelFieldValues({
    ModelFieldValue<String>? recipeName,
    ModelFieldValue<List<Ingredient>?>? ingredients,
    ModelFieldValue<String>? instructions,
    ModelFieldValue<double>? ratings,
    ModelFieldValue<String?>? image,
    ModelFieldValue<int?>? views,
    ModelFieldValue<String?>? userSavedRecipesId
  }) {
    return Recipe._internal(
      id: id,
      recipeName: recipeName == null ? this.recipeName : recipeName.value,
      ingredients: ingredients == null ? this.ingredients : ingredients.value,
      instructions: instructions == null ? this.instructions : instructions.value,
      ratings: ratings == null ? this.ratings : ratings.value,
      image: image == null ? this.image : image.value,
      views: views == null ? this.views : views.value,
      userSavedRecipesId: userSavedRecipesId == null ? this.userSavedRecipesId : userSavedRecipesId.value
    );
  }
  
  Recipe.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _recipeName = json['recipeName'],
      _ingredients = json['ingredients'] is List
        ? (json['ingredients'] as List)
          .where((e) => e?['serializedData'] != null)
          .map((e) => Ingredient.fromJson(new Map<String, dynamic>.from(e['serializedData'])))
          .toList()
        : null,
      _instructions = json['instructions'],
      _ratings = (json['ratings'] as num?)?.toDouble(),
      _image = json['image'],
      _views = (json['views'] as num?)?.toInt(),
      _createdAt = json['createdAt'] != null ? amplify_core.TemporalDateTime.fromString(json['createdAt']) : null,
      _updatedAt = json['updatedAt'] != null ? amplify_core.TemporalDateTime.fromString(json['updatedAt']) : null,
      _userSavedRecipesId = json['userSavedRecipesId'];
  
  Map<String, dynamic> toJson() => {
    'id': id, 'recipeName': _recipeName, 'ingredients': _ingredients?.map((Ingredient? e) => e?.toJson()).toList(), 'instructions': _instructions, 'ratings': _ratings, 'image': _image, 'views': _views, 'createdAt': _createdAt?.format(), 'updatedAt': _updatedAt?.format(), 'userSavedRecipesId': _userSavedRecipesId
  };
  
  Map<String, Object?> toMap() => {
    'id': id,
    'recipeName': _recipeName,
    'ingredients': _ingredients,
    'instructions': _instructions,
    'ratings': _ratings,
    'image': _image,
    'views': _views,
    'createdAt': _createdAt,
    'updatedAt': _updatedAt,
    'userSavedRecipesId': _userSavedRecipesId
  };

  static final amplify_core.QueryModelIdentifier<RecipeModelIdentifier> MODEL_IDENTIFIER = amplify_core.QueryModelIdentifier<RecipeModelIdentifier>();
  static final ID = amplify_core.QueryField(fieldName: "id");
  static final RECIPENAME = amplify_core.QueryField(fieldName: "recipeName");
  static final INGREDIENTS = amplify_core.QueryField(
    fieldName: "ingredients",
    fieldType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.model, ofModelName: 'Ingredient'));
  static final INSTRUCTIONS = amplify_core.QueryField(fieldName: "instructions");
  static final RATINGS = amplify_core.QueryField(fieldName: "ratings");
  static final IMAGE = amplify_core.QueryField(fieldName: "image");
  static final VIEWS = amplify_core.QueryField(fieldName: "views");
  static final USERSAVEDRECIPESID = amplify_core.QueryField(fieldName: "userSavedRecipesId");
  static var schema = amplify_core.Model.defineSchema(define: (amplify_core.ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "Recipe";
    modelSchemaDefinition.pluralName = "Recipes";
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.id());
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: Recipe.RECIPENAME,
      isRequired: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.hasMany(
      key: Recipe.INGREDIENTS,
      isRequired: false,
      ofModelName: 'Ingredient',
      associatedKey: Ingredient.RECIPEINGREDIENTSID
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
      key: Recipe.IMAGE,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: Recipe.VIEWS,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.int)
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
      key: Recipe.USERSAVEDRECIPESID,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
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

  /** Create an instance of RecipeModelIdentifier using [id] the primary key. */
  const RecipeModelIdentifier({
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
  String toString() => 'RecipeModelIdentifier(id: $id)';
  
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    
    return other is RecipeModelIdentifier &&
      id == other.id;
  }
  
  @override
  int get hashCode =>
    id.hashCode;
}