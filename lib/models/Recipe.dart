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
  final int? _dietType;
  final int? _cuisineType;
  final String? _userID;
  final List<Ingredient>? _ingredients;
  final String? _instructions;
  final double? _ratings;
  final int? _fives;
  final int? _fours;
  final int? _threes;
  final int? _twos;
  final int? _ones;
  final int? _zeroes;
  final int? _likes;
  final int? _saved;
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
  
  int? get fives {
    return _fives;
  }
  
  int? get fours {
    return _fours;
  }
  
  int? get threes {
    return _threes;
  }
  
  int? get twos {
    return _twos;
  }
  
  int? get ones {
    return _ones;
  }
  
  int? get zeroes {
    return _zeroes;
  }
  
  int get likes {
    try {
      return _likes!;
    } catch(e) {
      throw amplify_core.AmplifyCodeGenModelException(
          amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  int get saved {
    try {
      return _saved!;
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
  
  const Recipe._internal({required this.id, required recipeName, required dietType, required cuisineType, userID, ingredients, required instructions, required ratings, fives, fours, threes, twos, ones, zeroes, required likes, required saved, required views, image, createdAt, updatedAt}): _recipeName = recipeName, _dietType = dietType, _cuisineType = cuisineType, _userID = userID, _ingredients = ingredients, _instructions = instructions, _ratings = ratings, _fives = fives, _fours = fours, _threes = threes, _twos = twos, _ones = ones, _zeroes = zeroes, _likes = likes, _saved = saved, _views = views, _image = image, _createdAt = createdAt, _updatedAt = updatedAt;
  
  factory Recipe({String? id, required String recipeName, required int dietType, required int cuisineType, String? userID, List<Ingredient>? ingredients, required String instructions, required double ratings, int? fives, int? fours, int? threes, int? twos, int? ones, int? zeroes, required int likes, required int saved, required int views, String? image}) {
    return Recipe._internal(
      id: id == null ? amplify_core.UUID.getUUID() : id,
      recipeName: recipeName,
      dietType: dietType,
      cuisineType: cuisineType,
      userID: userID,
      ingredients: ingredients != null ? List<Ingredient>.unmodifiable(ingredients) : ingredients,
      instructions: instructions,
      ratings: ratings,
      fives: fives,
      fours: fours,
      threes: threes,
      twos: twos,
      ones: ones,
      zeroes: zeroes,
      likes: likes,
      saved: saved,
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
      DeepCollectionEquality().equals(_ingredients, other._ingredients) &&
      _instructions == other._instructions &&
      _ratings == other._ratings &&
      _fives == other._fives &&
      _fours == other._fours &&
      _threes == other._threes &&
      _twos == other._twos &&
      _ones == other._ones &&
      _zeroes == other._zeroes &&
      _likes == other._likes &&
      _saved == other._saved &&
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
    buffer.write("fives=" + (_fives != null ? _fives!.toString() : "null") + ", ");
    buffer.write("fours=" + (_fours != null ? _fours!.toString() : "null") + ", ");
    buffer.write("threes=" + (_threes != null ? _threes!.toString() : "null") + ", ");
    buffer.write("twos=" + (_twos != null ? _twos!.toString() : "null") + ", ");
    buffer.write("ones=" + (_ones != null ? _ones!.toString() : "null") + ", ");
    buffer.write("zeroes=" + (_zeroes != null ? _zeroes!.toString() : "null") + ", ");
    buffer.write("likes=" + (_likes != null ? _likes!.toString() : "null") + ", ");
    buffer.write("saved=" + (_saved != null ? _saved!.toString() : "null") + ", ");
    buffer.write("views=" + (_views != null ? _views!.toString() : "null") + ", ");
    buffer.write("image=" + "$_image" + ", ");
    buffer.write("createdAt=" + (_createdAt != null ? _createdAt!.format() : "null") + ", ");
    buffer.write("updatedAt=" + (_updatedAt != null ? _updatedAt!.format() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  Recipe copyWith({String? recipeName, int? dietType, int? cuisineType, String? userID, List<Ingredient>? ingredients, String? instructions, double? ratings, int? fives, int? fours, int? threes, int? twos, int? ones, int? zeroes, int? likes, int? saved, int? views, String? image}) {
    return Recipe._internal(
      id: id,
      recipeName: recipeName ?? this.recipeName,
      dietType: dietType ?? this.dietType,
      cuisineType: cuisineType ?? this.cuisineType,
      userID: userID ?? this.userID,
      ingredients: ingredients ?? this.ingredients,
      instructions: instructions ?? this.instructions,
      ratings: ratings ?? this.ratings,
      fives: fives ?? this.fives,
      fours: fours ?? this.fours,
      threes: threes ?? this.threes,
      twos: twos ?? this.twos,
      ones: ones ?? this.ones,
      zeroes: zeroes ?? this.zeroes,
      likes: likes ?? this.likes,
      saved: saved ?? this.saved,
      views: views ?? this.views,
      image: image ?? this.image);
  }
  
  Recipe copyWithModelFieldValues({
    ModelFieldValue<String>? recipeName,
    ModelFieldValue<int>? dietType,
    ModelFieldValue<int>? cuisineType,
    ModelFieldValue<String?>? userID,
    ModelFieldValue<List<Ingredient>>? ingredients,
    ModelFieldValue<String>? instructions,
    ModelFieldValue<double>? ratings,
    ModelFieldValue<int?>? fives,
    ModelFieldValue<int?>? fours,
    ModelFieldValue<int?>? threes,
    ModelFieldValue<int?>? twos,
    ModelFieldValue<int?>? ones,
    ModelFieldValue<int?>? zeroes,
    ModelFieldValue<int>? likes,
    ModelFieldValue<int>? saved,
    ModelFieldValue<int>? views,
    ModelFieldValue<String?>? image
  }) {
    return Recipe._internal(
      id: id,
      recipeName: recipeName == null ? this.recipeName : recipeName.value,
      dietType: dietType == null ? this.dietType : dietType.value,
      cuisineType: cuisineType == null ? this.cuisineType : cuisineType.value,
      userID: userID == null ? this.userID : userID.value,
      ingredients: ingredients == null ? this.ingredients : ingredients.value,
      instructions: instructions == null ? this.instructions : instructions.value,
      ratings: ratings == null ? this.ratings : ratings.value,
      fives: fives == null ? this.fives : fives.value,
      fours: fours == null ? this.fours : fours.value,
      threes: threes == null ? this.threes : threes.value,
      twos: twos == null ? this.twos : twos.value,
      ones: ones == null ? this.ones : ones.value,
      zeroes: zeroes == null ? this.zeroes : zeroes.value,
      likes: likes == null ? this.likes : likes.value,
      saved: saved == null ? this.saved : saved.value,
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
      _ingredients = json['ingredients'] is List
        ? (json['ingredients'] as List)
          .where((e) => e?['serializedData'] != null)
          .map((e) => Ingredient.fromJson(new Map<String, dynamic>.from(e['serializedData'])))
          .toList()
        : null,
      _instructions = json['instructions'],
      _ratings = (json['ratings'] as num?)?.toDouble(),
      _fives = (json['fives'] as num?)?.toInt(),
      _fours = (json['fours'] as num?)?.toInt(),
      _threes = (json['threes'] as num?)?.toInt(),
      _twos = (json['twos'] as num?)?.toInt(),
      _ones = (json['ones'] as num?)?.toInt(),
      _zeroes = (json['zeroes'] as num?)?.toInt(),
      _likes = (json['likes'] as num?)?.toInt(),
      _saved = (json['saved'] as num?)?.toInt(),
      _views = (json['views'] as num?)?.toInt(),
      _image = json['image'],
      _createdAt = json['createdAt'] != null ? amplify_core.TemporalDateTime.fromString(json['createdAt']) : null,
      _updatedAt = json['updatedAt'] != null ? amplify_core.TemporalDateTime.fromString(json['updatedAt']) : null;
  
  Map<String, dynamic> toJson() => {
    'id': id, 'recipeName': _recipeName, 'dietType': _dietType, 'cuisineType': _cuisineType, 'userID': _userID, 'ingredients': _ingredients?.map((Ingredient? e) => e?.toJson()).toList(), 'instructions': _instructions, 'ratings': _ratings, 'fives': _fives, 'fours': _fours, 'threes': _threes, 'twos': _twos, 'ones': _ones, 'zeroes': _zeroes, 'likes': _likes, 'saved': _saved, 'views': _views, 'image': _image, 'createdAt': _createdAt?.format(), 'updatedAt': _updatedAt?.format()
  };
  
  Map<String, Object?> toMap() => {
    'id': id,
    'recipeName': _recipeName,
    'dietType': _dietType,
    'cuisineType': _cuisineType,
    'userID': _userID,
    'ingredients': _ingredients,
    'instructions': _instructions,
    'ratings': _ratings,
    'fives': _fives,
    'fours': _fours,
    'threes': _threes,
    'twos': _twos,
    'ones': _ones,
    'zeroes': _zeroes,
    'likes': _likes,
    'saved': _saved,
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
  static final INGREDIENTS = amplify_core.QueryField(
    fieldName: "ingredients",
    fieldType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.model, ofModelName: 'Ingredient'));
  static final INSTRUCTIONS = amplify_core.QueryField(fieldName: "instructions");
  static final RATINGS = amplify_core.QueryField(fieldName: "ratings");
  static final FIVES = amplify_core.QueryField(fieldName: "fives");
  static final FOURS = amplify_core.QueryField(fieldName: "fours");
  static final THREES = amplify_core.QueryField(fieldName: "threes");
  static final TWOS = amplify_core.QueryField(fieldName: "twos");
  static final ONES = amplify_core.QueryField(fieldName: "ones");
  static final ZEROES = amplify_core.QueryField(fieldName: "zeroes");
  static final LIKES = amplify_core.QueryField(fieldName: "likes");
  static final SAVED = amplify_core.QueryField(fieldName: "saved");
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
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.hasMany(
      key: Recipe.INGREDIENTS,
      isRequired: true,
      ofModelName: 'Ingredient',
      associatedKey: Ingredient.RECIPE
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
      key: Recipe.FIVES,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.int)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: Recipe.FOURS,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.int)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: Recipe.THREES,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.int)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: Recipe.TWOS,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.int)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: Recipe.ONES,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.int)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: Recipe.ZEROES,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.int)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: Recipe.LIKES,
      isRequired: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.int)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: Recipe.SAVED,
      isRequired: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.int)
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