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


/** This is an auto generated class representing the RecipeIngredient type in your schema. */
class RecipeIngredient extends amplify_core.Model {
  static const classType = const _RecipeIngredientModelType();
  final String id;
  final Recipe? _recipe;
  final Ingredient? _ingredient;
  final amplify_core.TemporalDateTime? _createdAt;
  final amplify_core.TemporalDateTime? _updatedAt;

  @override
  getInstanceType() => classType;
  
  @Deprecated('[getId] is being deprecated in favor of custom primary key feature. Use getter [modelIdentifier] to get model identifier.')
  @override
  String getId() => id;
  
  RecipeIngredientModelIdentifier get modelIdentifier {
      return RecipeIngredientModelIdentifier(
        id: id
      );
  }
  
  Recipe get recipe {
    try {
      return _recipe!;
    } catch(e) {
      throw amplify_core.AmplifyCodeGenModelException(
          amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  Ingredient get ingredient {
    try {
      return _ingredient!;
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
  
  const RecipeIngredient._internal({required this.id, required recipe, required ingredient, createdAt, updatedAt}): _recipe = recipe, _ingredient = ingredient, _createdAt = createdAt, _updatedAt = updatedAt;
  
  factory RecipeIngredient({String? id, required Recipe recipe, required Ingredient ingredient}) {
    return RecipeIngredient._internal(
      id: id == null ? amplify_core.UUID.getUUID() : id,
      recipe: recipe,
      ingredient: ingredient);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is RecipeIngredient &&
      id == other.id &&
      _recipe == other._recipe &&
      _ingredient == other._ingredient;
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("RecipeIngredient {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("recipe=" + (_recipe != null ? _recipe!.toString() : "null") + ", ");
    buffer.write("ingredient=" + (_ingredient != null ? _ingredient!.toString() : "null") + ", ");
    buffer.write("createdAt=" + (_createdAt != null ? _createdAt!.format() : "null") + ", ");
    buffer.write("updatedAt=" + (_updatedAt != null ? _updatedAt!.format() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  RecipeIngredient copyWith({Recipe? recipe, Ingredient? ingredient}) {
    return RecipeIngredient._internal(
      id: id,
      recipe: recipe ?? this.recipe,
      ingredient: ingredient ?? this.ingredient);
  }
  
  RecipeIngredient copyWithModelFieldValues({
    ModelFieldValue<Recipe>? recipe,
    ModelFieldValue<Ingredient>? ingredient
  }) {
    return RecipeIngredient._internal(
      id: id,
      recipe: recipe == null ? this.recipe : recipe.value,
      ingredient: ingredient == null ? this.ingredient : ingredient.value
    );
  }
  
  RecipeIngredient.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _recipe = json['recipe']?['serializedData'] != null
        ? Recipe.fromJson(new Map<String, dynamic>.from(json['recipe']['serializedData']))
        : null,
      _ingredient = json['ingredient']?['serializedData'] != null
        ? Ingredient.fromJson(new Map<String, dynamic>.from(json['ingredient']['serializedData']))
        : null,
      _createdAt = json['createdAt'] != null ? amplify_core.TemporalDateTime.fromString(json['createdAt']) : null,
      _updatedAt = json['updatedAt'] != null ? amplify_core.TemporalDateTime.fromString(json['updatedAt']) : null;
  
  Map<String, dynamic> toJson() => {
    'id': id, 'recipe': _recipe?.toJson(), 'ingredient': _ingredient?.toJson(), 'createdAt': _createdAt?.format(), 'updatedAt': _updatedAt?.format()
  };
  
  Map<String, Object?> toMap() => {
    'id': id,
    'recipe': _recipe,
    'ingredient': _ingredient,
    'createdAt': _createdAt,
    'updatedAt': _updatedAt
  };

  static final amplify_core.QueryModelIdentifier<RecipeIngredientModelIdentifier> MODEL_IDENTIFIER = amplify_core.QueryModelIdentifier<RecipeIngredientModelIdentifier>();
  static final ID = amplify_core.QueryField(fieldName: "id");
  static final RECIPE = amplify_core.QueryField(
    fieldName: "recipe",
    fieldType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.model, ofModelName: 'Recipe'));
  static final INGREDIENT = amplify_core.QueryField(
    fieldName: "ingredient",
    fieldType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.model, ofModelName: 'Ingredient'));
  static var schema = amplify_core.Model.defineSchema(define: (amplify_core.ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "RecipeIngredient";
    modelSchemaDefinition.pluralName = "RecipeIngredients";
    
    modelSchemaDefinition.indexes = [
      amplify_core.ModelIndex(fields: const ["recipeId", "reciperecipeName"], name: "byRecipe"),
      amplify_core.ModelIndex(fields: const ["ingredientId", "ingredientingredientName"], name: "byIngredient")
    ];
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.id());
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.belongsTo(
      key: RecipeIngredient.RECIPE,
      isRequired: true,
      targetNames: ['recipeId', 'reciperecipeName'],
      ofModelName: 'Recipe'
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.belongsTo(
      key: RecipeIngredient.INGREDIENT,
      isRequired: true,
      targetNames: ['ingredientId', 'ingredientingredientName'],
      ofModelName: 'Ingredient'
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

class _RecipeIngredientModelType extends amplify_core.ModelType<RecipeIngredient> {
  const _RecipeIngredientModelType();
  
  @override
  RecipeIngredient fromJson(Map<String, dynamic> jsonData) {
    return RecipeIngredient.fromJson(jsonData);
  }
  
  @override
  String modelName() {
    return 'RecipeIngredient';
  }
}

/**
 * This is an auto generated class representing the model identifier
 * of [RecipeIngredient] in your schema.
 */
class RecipeIngredientModelIdentifier implements amplify_core.ModelIdentifier<RecipeIngredient> {
  final String id;

  /** Create an instance of RecipeIngredientModelIdentifier using [id] the primary key. */
  const RecipeIngredientModelIdentifier({
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
  String toString() => 'RecipeIngredientModelIdentifier(id: $id)';
  
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    
    return other is RecipeIngredientModelIdentifier &&
      id == other.id;
  }
  
  @override
  int get hashCode =>
    id.hashCode;
}