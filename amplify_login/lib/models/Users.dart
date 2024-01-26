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

import 'package:amplify_core/amplify_core.dart';
import 'package:flutter/foundation.dart';


/** This is an auto generated class representing the Users type in your schema. */
@immutable
class Users extends Model {
  static const classType = const _UsersModelType();
  final String id;
  final String? _taxID;
  final String? _custKey;
  final String? _email;
  final String? _password;
  final TemporalDateTime? _createdAt;
  final TemporalDateTime? _updatedAt;

  @override
  getInstanceType() => classType;
  
  @Deprecated('[getId] is being deprecated in favor of custom primary key feature. Use getter [modelIdentifier] to get model identifier.')
  @override
  String getId() => id;
  
  UsersModelIdentifier get modelIdentifier {
      return UsersModelIdentifier(
        id: id
      );
  }
  
  String? get taxID {
    return _taxID;
  }
  
  String? get custKey {
    return _custKey;
  }
  
  String? get email {
    return _email;
  }
  
  String? get password {
    return _password;
  }
  
  TemporalDateTime? get createdAt {
    return _createdAt;
  }
  
  TemporalDateTime? get updatedAt {
    return _updatedAt;
  }
  
  const Users._internal({required this.id, taxID, custKey, email, password, createdAt, updatedAt}): _taxID = taxID, _custKey = custKey, _email = email, _password = password, _createdAt = createdAt, _updatedAt = updatedAt;
  
  factory Users({String? id, String? taxID, String? custKey, String? email, String? password}) {
    return Users._internal(
      id: id == null ? UUID.getUUID() : id,
      taxID: taxID,
      custKey: custKey,
      email: email,
      password: password);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Users &&
      id == other.id &&
      _taxID == other._taxID &&
      _custKey == other._custKey &&
      _email == other._email &&
      _password == other._password;
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("Users {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("taxID=" + "$_taxID" + ", ");
    buffer.write("custKey=" + "$_custKey" + ", ");
    buffer.write("email=" + "$_email" + ", ");
    buffer.write("password=" + "$_password" + ", ");
    buffer.write("createdAt=" + (_createdAt != null ? _createdAt!.format() : "null") + ", ");
    buffer.write("updatedAt=" + (_updatedAt != null ? _updatedAt!.format() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  Users copyWith({String? taxID, String? custKey, String? email, String? password}) {
    return Users._internal(
      id: id,
      taxID: taxID ?? this.taxID,
      custKey: custKey ?? this.custKey,
      email: email ?? this.email,
      password: password ?? this.password);
  }
  
  Users.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _taxID = json['taxID'],
      _custKey = json['custKey'],
      _email = json['email'],
      _password = json['password'],
      _createdAt = json['createdAt'] != null ? TemporalDateTime.fromString(json['createdAt']) : null,
      _updatedAt = json['updatedAt'] != null ? TemporalDateTime.fromString(json['updatedAt']) : null;
  
  Map<String, dynamic> toJson() => {
    'id': id, 'taxID': _taxID, 'custKey': _custKey, 'email': _email, 'password': _password, 'createdAt': _createdAt?.format(), 'updatedAt': _updatedAt?.format()
  };
  
  Map<String, Object?> toMap() => {
    'id': id, 'taxID': _taxID, 'custKey': _custKey, 'email': _email, 'password': _password, 'createdAt': _createdAt, 'updatedAt': _updatedAt
  };

  static final QueryModelIdentifier<UsersModelIdentifier> MODEL_IDENTIFIER = QueryModelIdentifier<UsersModelIdentifier>();
  static final QueryField ID = QueryField(fieldName: "id");
  static final QueryField TAXID = QueryField(fieldName: "taxID");
  static final QueryField CUSTKEY = QueryField(fieldName: "custKey");
  static final QueryField EMAIL = QueryField(fieldName: "email");
  static final QueryField PASSWORD = QueryField(fieldName: "password");
  static var schema = Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "Users";
    modelSchemaDefinition.pluralName = "Users";
    
    modelSchemaDefinition.authRules = [
      AuthRule(
        authStrategy: AuthStrategy.PUBLIC,
        operations: [
          ModelOperation.CREATE,
          ModelOperation.UPDATE,
          ModelOperation.DELETE,
          ModelOperation.READ
        ])
    ];
    
    modelSchemaDefinition.addField(ModelFieldDefinition.id());
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Users.TAXID,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Users.CUSTKEY,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Users.EMAIL,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Users.PASSWORD,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.nonQueryField(
      fieldName: 'createdAt',
      isRequired: false,
      isReadOnly: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.dateTime)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.nonQueryField(
      fieldName: 'updatedAt',
      isRequired: false,
      isReadOnly: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.dateTime)
    ));
  });
}

class _UsersModelType extends ModelType<Users> {
  const _UsersModelType();
  
  @override
  Users fromJson(Map<String, dynamic> jsonData) {
    return Users.fromJson(jsonData);
  }
  
  @override
  String modelName() {
    return 'Users';
  }
}

/**
 * This is an auto generated class representing the model identifier
 * of [Users] in your schema.
 */
@immutable
class UsersModelIdentifier implements ModelIdentifier<Users> {
  final String id;

  /** Create an instance of UsersModelIdentifier using [id] the primary key. */
  const UsersModelIdentifier({
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
  String toString() => 'UsersModelIdentifier(id: $id)';
  
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    
    return other is UsersModelIdentifier &&
      id == other.id;
  }
  
  @override
  int get hashCode =>
    id.hashCode;
}