// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_profile_data_isar.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetUpdateProfileDataCollection on Isar {
  IsarCollection<UpdateProfileData> get updateProfileDatas => this.collection();
}

const UpdateProfileDataSchema = CollectionSchema(
  name: r'UpdateProfileData',
  id: 3600262233672932620,
  properties: {
    r'updateProfileInfo': PropertySchema(
      id: 0,
      name: r'updateProfileInfo',
      type: IsarType.string,
    )
  },
  estimateSize: _updateProfileDataEstimateSize,
  serialize: _updateProfileDataSerialize,
  deserialize: _updateProfileDataDeserialize,
  deserializeProp: _updateProfileDataDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _updateProfileDataGetId,
  getLinks: _updateProfileDataGetLinks,
  attach: _updateProfileDataAttach,
  version: '3.3.0-dev.3',
);

int _updateProfileDataEstimateSize(
  UpdateProfileData object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.updateProfileInfo;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _updateProfileDataSerialize(
  UpdateProfileData object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.updateProfileInfo);
}

UpdateProfileData _updateProfileDataDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = UpdateProfileData(
    id: id,
    updateProfileInfo: reader.readStringOrNull(offsets[0]),
  );
  return object;
}

P _updateProfileDataDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _updateProfileDataGetId(UpdateProfileData object) {
  return object.id ?? Isar.autoIncrement;
}

List<IsarLinkBase<dynamic>> _updateProfileDataGetLinks(
    UpdateProfileData object) {
  return [];
}

void _updateProfileDataAttach(
    IsarCollection<dynamic> col, Id id, UpdateProfileData object) {
  object.id = id;
}

extension UpdateProfileDataQueryWhereSort
    on QueryBuilder<UpdateProfileData, UpdateProfileData, QWhere> {
  QueryBuilder<UpdateProfileData, UpdateProfileData, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension UpdateProfileDataQueryWhere
    on QueryBuilder<UpdateProfileData, UpdateProfileData, QWhereClause> {
  QueryBuilder<UpdateProfileData, UpdateProfileData, QAfterWhereClause>
      idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<UpdateProfileData, UpdateProfileData, QAfterWhereClause>
      idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<UpdateProfileData, UpdateProfileData, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<UpdateProfileData, UpdateProfileData, QAfterWhereClause>
      idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<UpdateProfileData, UpdateProfileData, QAfterWhereClause>
      idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension UpdateProfileDataQueryFilter
    on QueryBuilder<UpdateProfileData, UpdateProfileData, QFilterCondition> {
  QueryBuilder<UpdateProfileData, UpdateProfileData, QAfterFilterCondition>
      idIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<UpdateProfileData, UpdateProfileData, QAfterFilterCondition>
      idIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<UpdateProfileData, UpdateProfileData, QAfterFilterCondition>
      idEqualTo(Id? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<UpdateProfileData, UpdateProfileData, QAfterFilterCondition>
      idGreaterThan(
    Id? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<UpdateProfileData, UpdateProfileData, QAfterFilterCondition>
      idLessThan(
    Id? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<UpdateProfileData, UpdateProfileData, QAfterFilterCondition>
      idBetween(
    Id? lower,
    Id? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<UpdateProfileData, UpdateProfileData, QAfterFilterCondition>
      updateProfileInfoIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'updateProfileInfo',
      ));
    });
  }

  QueryBuilder<UpdateProfileData, UpdateProfileData, QAfterFilterCondition>
      updateProfileInfoIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'updateProfileInfo',
      ));
    });
  }

  QueryBuilder<UpdateProfileData, UpdateProfileData, QAfterFilterCondition>
      updateProfileInfoEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'updateProfileInfo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UpdateProfileData, UpdateProfileData, QAfterFilterCondition>
      updateProfileInfoGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'updateProfileInfo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UpdateProfileData, UpdateProfileData, QAfterFilterCondition>
      updateProfileInfoLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'updateProfileInfo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UpdateProfileData, UpdateProfileData, QAfterFilterCondition>
      updateProfileInfoBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'updateProfileInfo',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UpdateProfileData, UpdateProfileData, QAfterFilterCondition>
      updateProfileInfoStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'updateProfileInfo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UpdateProfileData, UpdateProfileData, QAfterFilterCondition>
      updateProfileInfoEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'updateProfileInfo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UpdateProfileData, UpdateProfileData, QAfterFilterCondition>
      updateProfileInfoContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'updateProfileInfo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UpdateProfileData, UpdateProfileData, QAfterFilterCondition>
      updateProfileInfoMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'updateProfileInfo',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UpdateProfileData, UpdateProfileData, QAfterFilterCondition>
      updateProfileInfoIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'updateProfileInfo',
        value: '',
      ));
    });
  }

  QueryBuilder<UpdateProfileData, UpdateProfileData, QAfterFilterCondition>
      updateProfileInfoIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'updateProfileInfo',
        value: '',
      ));
    });
  }
}

extension UpdateProfileDataQueryObject
    on QueryBuilder<UpdateProfileData, UpdateProfileData, QFilterCondition> {}

extension UpdateProfileDataQueryLinks
    on QueryBuilder<UpdateProfileData, UpdateProfileData, QFilterCondition> {}

extension UpdateProfileDataQuerySortBy
    on QueryBuilder<UpdateProfileData, UpdateProfileData, QSortBy> {
  QueryBuilder<UpdateProfileData, UpdateProfileData, QAfterSortBy>
      sortByUpdateProfileInfo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updateProfileInfo', Sort.asc);
    });
  }

  QueryBuilder<UpdateProfileData, UpdateProfileData, QAfterSortBy>
      sortByUpdateProfileInfoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updateProfileInfo', Sort.desc);
    });
  }
}

extension UpdateProfileDataQuerySortThenBy
    on QueryBuilder<UpdateProfileData, UpdateProfileData, QSortThenBy> {
  QueryBuilder<UpdateProfileData, UpdateProfileData, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<UpdateProfileData, UpdateProfileData, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<UpdateProfileData, UpdateProfileData, QAfterSortBy>
      thenByUpdateProfileInfo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updateProfileInfo', Sort.asc);
    });
  }

  QueryBuilder<UpdateProfileData, UpdateProfileData, QAfterSortBy>
      thenByUpdateProfileInfoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updateProfileInfo', Sort.desc);
    });
  }
}

extension UpdateProfileDataQueryWhereDistinct
    on QueryBuilder<UpdateProfileData, UpdateProfileData, QDistinct> {
  QueryBuilder<UpdateProfileData, UpdateProfileData, QDistinct>
      distinctByUpdateProfileInfo({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'updateProfileInfo',
          caseSensitive: caseSensitive);
    });
  }
}

extension UpdateProfileDataQueryProperty
    on QueryBuilder<UpdateProfileData, UpdateProfileData, QQueryProperty> {
  QueryBuilder<UpdateProfileData, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<UpdateProfileData, String?, QQueryOperations>
      updateProfileInfoProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'updateProfileInfo');
    });
  }
}
