// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_information_isar.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetProfileInformationIsarCollection on Isar {
  IsarCollection<ProfileInformationIsar> get profileInformationIsars =>
      this.collection();
}

const ProfileInformationIsarSchema = CollectionSchema(
  name: r'ProfileInformationIsar',
  id: 7933609423550149511,
  properties: {
    r'profileInformation': PropertySchema(
      id: 0,
      name: r'profileInformation',
      type: IsarType.string,
    )
  },
  estimateSize: _profileInformationIsarEstimateSize,
  serialize: _profileInformationIsarSerialize,
  deserialize: _profileInformationIsarDeserialize,
  deserializeProp: _profileInformationIsarDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _profileInformationIsarGetId,
  getLinks: _profileInformationIsarGetLinks,
  attach: _profileInformationIsarAttach,
  version: '3.3.0-dev.3',
);

int _profileInformationIsarEstimateSize(
  ProfileInformationIsar object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.profileInformation;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _profileInformationIsarSerialize(
  ProfileInformationIsar object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.profileInformation);
}

ProfileInformationIsar _profileInformationIsarDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = ProfileInformationIsar(
    id: id,
    profileInformation: reader.readStringOrNull(offsets[0]),
  );
  return object;
}

P _profileInformationIsarDeserializeProp<P>(
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

Id _profileInformationIsarGetId(ProfileInformationIsar object) {
  return object.id ?? Isar.autoIncrement;
}

List<IsarLinkBase<dynamic>> _profileInformationIsarGetLinks(
    ProfileInformationIsar object) {
  return [];
}

void _profileInformationIsarAttach(
    IsarCollection<dynamic> col, Id id, ProfileInformationIsar object) {
  object.id = id;
}

extension ProfileInformationIsarQueryWhereSort
    on QueryBuilder<ProfileInformationIsar, ProfileInformationIsar, QWhere> {
  QueryBuilder<ProfileInformationIsar, ProfileInformationIsar, QAfterWhere>
      anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension ProfileInformationIsarQueryWhere on QueryBuilder<
    ProfileInformationIsar, ProfileInformationIsar, QWhereClause> {
  QueryBuilder<ProfileInformationIsar, ProfileInformationIsar,
      QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<ProfileInformationIsar, ProfileInformationIsar,
      QAfterWhereClause> idNotEqualTo(Id id) {
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

  QueryBuilder<ProfileInformationIsar, ProfileInformationIsar,
      QAfterWhereClause> idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<ProfileInformationIsar, ProfileInformationIsar,
      QAfterWhereClause> idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<ProfileInformationIsar, ProfileInformationIsar,
      QAfterWhereClause> idBetween(
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

extension ProfileInformationIsarQueryFilter on QueryBuilder<
    ProfileInformationIsar, ProfileInformationIsar, QFilterCondition> {
  QueryBuilder<ProfileInformationIsar, ProfileInformationIsar,
      QAfterFilterCondition> idIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<ProfileInformationIsar, ProfileInformationIsar,
      QAfterFilterCondition> idIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<ProfileInformationIsar, ProfileInformationIsar,
      QAfterFilterCondition> idEqualTo(Id? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<ProfileInformationIsar, ProfileInformationIsar,
      QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<ProfileInformationIsar, ProfileInformationIsar,
      QAfterFilterCondition> idLessThan(
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

  QueryBuilder<ProfileInformationIsar, ProfileInformationIsar,
      QAfterFilterCondition> idBetween(
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

  QueryBuilder<ProfileInformationIsar, ProfileInformationIsar,
      QAfterFilterCondition> profileInformationIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'profileInformation',
      ));
    });
  }

  QueryBuilder<ProfileInformationIsar, ProfileInformationIsar,
      QAfterFilterCondition> profileInformationIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'profileInformation',
      ));
    });
  }

  QueryBuilder<ProfileInformationIsar, ProfileInformationIsar,
      QAfterFilterCondition> profileInformationEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'profileInformation',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProfileInformationIsar, ProfileInformationIsar,
      QAfterFilterCondition> profileInformationGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'profileInformation',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProfileInformationIsar, ProfileInformationIsar,
      QAfterFilterCondition> profileInformationLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'profileInformation',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProfileInformationIsar, ProfileInformationIsar,
      QAfterFilterCondition> profileInformationBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'profileInformation',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProfileInformationIsar, ProfileInformationIsar,
      QAfterFilterCondition> profileInformationStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'profileInformation',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProfileInformationIsar, ProfileInformationIsar,
      QAfterFilterCondition> profileInformationEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'profileInformation',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProfileInformationIsar, ProfileInformationIsar,
          QAfterFilterCondition>
      profileInformationContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'profileInformation',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProfileInformationIsar, ProfileInformationIsar,
          QAfterFilterCondition>
      profileInformationMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'profileInformation',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProfileInformationIsar, ProfileInformationIsar,
      QAfterFilterCondition> profileInformationIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'profileInformation',
        value: '',
      ));
    });
  }

  QueryBuilder<ProfileInformationIsar, ProfileInformationIsar,
      QAfterFilterCondition> profileInformationIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'profileInformation',
        value: '',
      ));
    });
  }
}

extension ProfileInformationIsarQueryObject on QueryBuilder<
    ProfileInformationIsar, ProfileInformationIsar, QFilterCondition> {}

extension ProfileInformationIsarQueryLinks on QueryBuilder<
    ProfileInformationIsar, ProfileInformationIsar, QFilterCondition> {}

extension ProfileInformationIsarQuerySortBy
    on QueryBuilder<ProfileInformationIsar, ProfileInformationIsar, QSortBy> {
  QueryBuilder<ProfileInformationIsar, ProfileInformationIsar, QAfterSortBy>
      sortByProfileInformation() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'profileInformation', Sort.asc);
    });
  }

  QueryBuilder<ProfileInformationIsar, ProfileInformationIsar, QAfterSortBy>
      sortByProfileInformationDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'profileInformation', Sort.desc);
    });
  }
}

extension ProfileInformationIsarQuerySortThenBy on QueryBuilder<
    ProfileInformationIsar, ProfileInformationIsar, QSortThenBy> {
  QueryBuilder<ProfileInformationIsar, ProfileInformationIsar, QAfterSortBy>
      thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<ProfileInformationIsar, ProfileInformationIsar, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<ProfileInformationIsar, ProfileInformationIsar, QAfterSortBy>
      thenByProfileInformation() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'profileInformation', Sort.asc);
    });
  }

  QueryBuilder<ProfileInformationIsar, ProfileInformationIsar, QAfterSortBy>
      thenByProfileInformationDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'profileInformation', Sort.desc);
    });
  }
}

extension ProfileInformationIsarQueryWhereDistinct
    on QueryBuilder<ProfileInformationIsar, ProfileInformationIsar, QDistinct> {
  QueryBuilder<ProfileInformationIsar, ProfileInformationIsar, QDistinct>
      distinctByProfileInformation({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'profileInformation',
          caseSensitive: caseSensitive);
    });
  }
}

extension ProfileInformationIsarQueryProperty on QueryBuilder<
    ProfileInformationIsar, ProfileInformationIsar, QQueryProperty> {
  QueryBuilder<ProfileInformationIsar, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<ProfileInformationIsar, String?, QQueryOperations>
      profileInformationProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'profileInformation');
    });
  }
}
