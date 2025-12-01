// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'staff_updated_profile_isar.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetStaffUpdatedProfileDataCollection on Isar {
  IsarCollection<StaffUpdatedProfileData> get staffUpdatedProfileDatas =>
      this.collection();
}

const StaffUpdatedProfileDataSchema = CollectionSchema(
  name: r'StaffUpdatedProfileData',
  id: -8606930469941083080,
  properties: {
    r'staffUpdatedData': PropertySchema(
      id: 0,
      name: r'staffUpdatedData',
      type: IsarType.string,
    )
  },
  estimateSize: _staffUpdatedProfileDataEstimateSize,
  serialize: _staffUpdatedProfileDataSerialize,
  deserialize: _staffUpdatedProfileDataDeserialize,
  deserializeProp: _staffUpdatedProfileDataDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _staffUpdatedProfileDataGetId,
  getLinks: _staffUpdatedProfileDataGetLinks,
  attach: _staffUpdatedProfileDataAttach,
  version: '3.3.0-dev.3',
);

int _staffUpdatedProfileDataEstimateSize(
  StaffUpdatedProfileData object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.staffUpdatedData;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _staffUpdatedProfileDataSerialize(
  StaffUpdatedProfileData object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.staffUpdatedData);
}

StaffUpdatedProfileData _staffUpdatedProfileDataDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = StaffUpdatedProfileData(
    id: id,
    staffUpdatedData: reader.readStringOrNull(offsets[0]),
  );
  return object;
}

P _staffUpdatedProfileDataDeserializeProp<P>(
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

Id _staffUpdatedProfileDataGetId(StaffUpdatedProfileData object) {
  return object.id ?? Isar.autoIncrement;
}

List<IsarLinkBase<dynamic>> _staffUpdatedProfileDataGetLinks(
    StaffUpdatedProfileData object) {
  return [];
}

void _staffUpdatedProfileDataAttach(
    IsarCollection<dynamic> col, Id id, StaffUpdatedProfileData object) {
  object.id = id;
}

extension StaffUpdatedProfileDataQueryWhereSort
    on QueryBuilder<StaffUpdatedProfileData, StaffUpdatedProfileData, QWhere> {
  QueryBuilder<StaffUpdatedProfileData, StaffUpdatedProfileData, QAfterWhere>
      anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension StaffUpdatedProfileDataQueryWhere on QueryBuilder<
    StaffUpdatedProfileData, StaffUpdatedProfileData, QWhereClause> {
  QueryBuilder<StaffUpdatedProfileData, StaffUpdatedProfileData,
      QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<StaffUpdatedProfileData, StaffUpdatedProfileData,
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

  QueryBuilder<StaffUpdatedProfileData, StaffUpdatedProfileData,
      QAfterWhereClause> idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<StaffUpdatedProfileData, StaffUpdatedProfileData,
      QAfterWhereClause> idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<StaffUpdatedProfileData, StaffUpdatedProfileData,
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

extension StaffUpdatedProfileDataQueryFilter on QueryBuilder<
    StaffUpdatedProfileData, StaffUpdatedProfileData, QFilterCondition> {
  QueryBuilder<StaffUpdatedProfileData, StaffUpdatedProfileData,
      QAfterFilterCondition> idIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<StaffUpdatedProfileData, StaffUpdatedProfileData,
      QAfterFilterCondition> idIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<StaffUpdatedProfileData, StaffUpdatedProfileData,
      QAfterFilterCondition> idEqualTo(Id? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<StaffUpdatedProfileData, StaffUpdatedProfileData,
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

  QueryBuilder<StaffUpdatedProfileData, StaffUpdatedProfileData,
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

  QueryBuilder<StaffUpdatedProfileData, StaffUpdatedProfileData,
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

  QueryBuilder<StaffUpdatedProfileData, StaffUpdatedProfileData,
      QAfterFilterCondition> staffUpdatedDataIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'staffUpdatedData',
      ));
    });
  }

  QueryBuilder<StaffUpdatedProfileData, StaffUpdatedProfileData,
      QAfterFilterCondition> staffUpdatedDataIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'staffUpdatedData',
      ));
    });
  }

  QueryBuilder<StaffUpdatedProfileData, StaffUpdatedProfileData,
      QAfterFilterCondition> staffUpdatedDataEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'staffUpdatedData',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StaffUpdatedProfileData, StaffUpdatedProfileData,
      QAfterFilterCondition> staffUpdatedDataGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'staffUpdatedData',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StaffUpdatedProfileData, StaffUpdatedProfileData,
      QAfterFilterCondition> staffUpdatedDataLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'staffUpdatedData',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StaffUpdatedProfileData, StaffUpdatedProfileData,
      QAfterFilterCondition> staffUpdatedDataBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'staffUpdatedData',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StaffUpdatedProfileData, StaffUpdatedProfileData,
      QAfterFilterCondition> staffUpdatedDataStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'staffUpdatedData',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StaffUpdatedProfileData, StaffUpdatedProfileData,
      QAfterFilterCondition> staffUpdatedDataEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'staffUpdatedData',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StaffUpdatedProfileData, StaffUpdatedProfileData,
          QAfterFilterCondition>
      staffUpdatedDataContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'staffUpdatedData',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StaffUpdatedProfileData, StaffUpdatedProfileData,
          QAfterFilterCondition>
      staffUpdatedDataMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'staffUpdatedData',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StaffUpdatedProfileData, StaffUpdatedProfileData,
      QAfterFilterCondition> staffUpdatedDataIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'staffUpdatedData',
        value: '',
      ));
    });
  }

  QueryBuilder<StaffUpdatedProfileData, StaffUpdatedProfileData,
      QAfterFilterCondition> staffUpdatedDataIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'staffUpdatedData',
        value: '',
      ));
    });
  }
}

extension StaffUpdatedProfileDataQueryObject on QueryBuilder<
    StaffUpdatedProfileData, StaffUpdatedProfileData, QFilterCondition> {}

extension StaffUpdatedProfileDataQueryLinks on QueryBuilder<
    StaffUpdatedProfileData, StaffUpdatedProfileData, QFilterCondition> {}

extension StaffUpdatedProfileDataQuerySortBy
    on QueryBuilder<StaffUpdatedProfileData, StaffUpdatedProfileData, QSortBy> {
  QueryBuilder<StaffUpdatedProfileData, StaffUpdatedProfileData, QAfterSortBy>
      sortByStaffUpdatedData() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'staffUpdatedData', Sort.asc);
    });
  }

  QueryBuilder<StaffUpdatedProfileData, StaffUpdatedProfileData, QAfterSortBy>
      sortByStaffUpdatedDataDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'staffUpdatedData', Sort.desc);
    });
  }
}

extension StaffUpdatedProfileDataQuerySortThenBy on QueryBuilder<
    StaffUpdatedProfileData, StaffUpdatedProfileData, QSortThenBy> {
  QueryBuilder<StaffUpdatedProfileData, StaffUpdatedProfileData, QAfterSortBy>
      thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<StaffUpdatedProfileData, StaffUpdatedProfileData, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<StaffUpdatedProfileData, StaffUpdatedProfileData, QAfterSortBy>
      thenByStaffUpdatedData() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'staffUpdatedData', Sort.asc);
    });
  }

  QueryBuilder<StaffUpdatedProfileData, StaffUpdatedProfileData, QAfterSortBy>
      thenByStaffUpdatedDataDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'staffUpdatedData', Sort.desc);
    });
  }
}

extension StaffUpdatedProfileDataQueryWhereDistinct on QueryBuilder<
    StaffUpdatedProfileData, StaffUpdatedProfileData, QDistinct> {
  QueryBuilder<StaffUpdatedProfileData, StaffUpdatedProfileData, QDistinct>
      distinctByStaffUpdatedData({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'staffUpdatedData',
          caseSensitive: caseSensitive);
    });
  }
}

extension StaffUpdatedProfileDataQueryProperty on QueryBuilder<
    StaffUpdatedProfileData, StaffUpdatedProfileData, QQueryProperty> {
  QueryBuilder<StaffUpdatedProfileData, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<StaffUpdatedProfileData, String?, QQueryOperations>
      staffUpdatedDataProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'staffUpdatedData');
    });
  }
}
