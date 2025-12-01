// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_jobcard_isar.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetUpdateJobcardDraftIsarCollection on Isar {
  IsarCollection<UpdateJobcardDraftIsar> get updateJobcardDraftIsars =>
      this.collection();
}

const UpdateJobcardDraftIsarSchema = CollectionSchema(
  name: r'UpdateJobcardDraftIsar',
  id: -1198253928724372298,
  properties: {
    r'batteryImagePath': PropertySchema(
      id: 0,
      name: r'batteryImagePath',
      type: IsarType.string,
    ),
    r'dashboardImagePath': PropertySchema(
      id: 1,
      name: r'dashboardImagePath',
      type: IsarType.string,
    ),
    r'engineImagePath': PropertySchema(
      id: 2,
      name: r'engineImagePath',
      type: IsarType.string,
    ),
    r'formData': PropertySchema(
      id: 3,
      name: r'formData',
      type: IsarType.string,
    ),
    r'frontImagePath': PropertySchema(
      id: 4,
      name: r'frontImagePath',
      type: IsarType.string,
    ),
    r'image1Path': PropertySchema(
      id: 5,
      name: r'image1Path',
      type: IsarType.string,
    ),
    r'image2Path': PropertySchema(
      id: 6,
      name: r'image2Path',
      type: IsarType.string,
    ),
    r'image3Path': PropertySchema(
      id: 7,
      name: r'image3Path',
      type: IsarType.string,
    ),
    r'image4Path': PropertySchema(
      id: 8,
      name: r'image4Path',
      type: IsarType.string,
    ),
    r'jobcardId': PropertySchema(
      id: 9,
      name: r'jobcardId',
      type: IsarType.string,
    ),
    r'leftHandSideImagePath': PropertySchema(
      id: 10,
      name: r'leftHandSideImagePath',
      type: IsarType.string,
    ),
    r'rearImagePath': PropertySchema(
      id: 11,
      name: r'rearImagePath',
      type: IsarType.string,
    ),
    r'rightHandSideImagePath': PropertySchema(
      id: 12,
      name: r'rightHandSideImagePath',
      type: IsarType.string,
    ),
    r'speedometerImagePath': PropertySchema(
      id: 13,
      name: r'speedometerImagePath',
      type: IsarType.string,
    )
  },
  estimateSize: _updateJobcardDraftIsarEstimateSize,
  serialize: _updateJobcardDraftIsarSerialize,
  deserialize: _updateJobcardDraftIsarDeserialize,
  deserializeProp: _updateJobcardDraftIsarDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _updateJobcardDraftIsarGetId,
  getLinks: _updateJobcardDraftIsarGetLinks,
  attach: _updateJobcardDraftIsarAttach,
  version: '3.3.0-dev.3',
);

int _updateJobcardDraftIsarEstimateSize(
  UpdateJobcardDraftIsar object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.batteryImagePath;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.dashboardImagePath;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.engineImagePath;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.formData.length * 3;
  {
    final value = object.frontImagePath;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.image1Path;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.image2Path;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.image3Path;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.image4Path;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.jobcardId;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.leftHandSideImagePath;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.rearImagePath;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.rightHandSideImagePath;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.speedometerImagePath;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _updateJobcardDraftIsarSerialize(
  UpdateJobcardDraftIsar object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.batteryImagePath);
  writer.writeString(offsets[1], object.dashboardImagePath);
  writer.writeString(offsets[2], object.engineImagePath);
  writer.writeString(offsets[3], object.formData);
  writer.writeString(offsets[4], object.frontImagePath);
  writer.writeString(offsets[5], object.image1Path);
  writer.writeString(offsets[6], object.image2Path);
  writer.writeString(offsets[7], object.image3Path);
  writer.writeString(offsets[8], object.image4Path);
  writer.writeString(offsets[9], object.jobcardId);
  writer.writeString(offsets[10], object.leftHandSideImagePath);
  writer.writeString(offsets[11], object.rearImagePath);
  writer.writeString(offsets[12], object.rightHandSideImagePath);
  writer.writeString(offsets[13], object.speedometerImagePath);
}

UpdateJobcardDraftIsar _updateJobcardDraftIsarDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = UpdateJobcardDraftIsar(
    batteryImagePath: reader.readStringOrNull(offsets[0]),
    dashboardImagePath: reader.readStringOrNull(offsets[1]),
    engineImagePath: reader.readStringOrNull(offsets[2]),
    formData: reader.readStringOrNull(offsets[3]) ?? "",
    frontImagePath: reader.readStringOrNull(offsets[4]),
    image1Path: reader.readStringOrNull(offsets[5]),
    image2Path: reader.readStringOrNull(offsets[6]),
    image3Path: reader.readStringOrNull(offsets[7]),
    image4Path: reader.readStringOrNull(offsets[8]),
    jobcardId: reader.readStringOrNull(offsets[9]),
    leftHandSideImagePath: reader.readStringOrNull(offsets[10]),
    rearImagePath: reader.readStringOrNull(offsets[11]),
    rightHandSideImagePath: reader.readStringOrNull(offsets[12]),
    speedometerImagePath: reader.readStringOrNull(offsets[13]),
  );
  object.id = id;
  return object;
}

P _updateJobcardDraftIsarDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringOrNull(offset)) as P;
    case 1:
      return (reader.readStringOrNull(offset)) as P;
    case 2:
      return (reader.readStringOrNull(offset)) as P;
    case 3:
      return (reader.readStringOrNull(offset) ?? "") as P;
    case 4:
      return (reader.readStringOrNull(offset)) as P;
    case 5:
      return (reader.readStringOrNull(offset)) as P;
    case 6:
      return (reader.readStringOrNull(offset)) as P;
    case 7:
      return (reader.readStringOrNull(offset)) as P;
    case 8:
      return (reader.readStringOrNull(offset)) as P;
    case 9:
      return (reader.readStringOrNull(offset)) as P;
    case 10:
      return (reader.readStringOrNull(offset)) as P;
    case 11:
      return (reader.readStringOrNull(offset)) as P;
    case 12:
      return (reader.readStringOrNull(offset)) as P;
    case 13:
      return (reader.readStringOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _updateJobcardDraftIsarGetId(UpdateJobcardDraftIsar object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _updateJobcardDraftIsarGetLinks(
    UpdateJobcardDraftIsar object) {
  return [];
}

void _updateJobcardDraftIsarAttach(
    IsarCollection<dynamic> col, Id id, UpdateJobcardDraftIsar object) {
  object.id = id;
}

extension UpdateJobcardDraftIsarQueryWhereSort
    on QueryBuilder<UpdateJobcardDraftIsar, UpdateJobcardDraftIsar, QWhere> {
  QueryBuilder<UpdateJobcardDraftIsar, UpdateJobcardDraftIsar, QAfterWhere>
      anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension UpdateJobcardDraftIsarQueryWhere on QueryBuilder<
    UpdateJobcardDraftIsar, UpdateJobcardDraftIsar, QWhereClause> {
  QueryBuilder<UpdateJobcardDraftIsar, UpdateJobcardDraftIsar,
      QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<UpdateJobcardDraftIsar, UpdateJobcardDraftIsar,
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

  QueryBuilder<UpdateJobcardDraftIsar, UpdateJobcardDraftIsar,
      QAfterWhereClause> idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<UpdateJobcardDraftIsar, UpdateJobcardDraftIsar,
      QAfterWhereClause> idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<UpdateJobcardDraftIsar, UpdateJobcardDraftIsar,
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

extension UpdateJobcardDraftIsarQueryFilter on QueryBuilder<
    UpdateJobcardDraftIsar, UpdateJobcardDraftIsar, QFilterCondition> {
  QueryBuilder<UpdateJobcardDraftIsar, UpdateJobcardDraftIsar,
      QAfterFilterCondition> batteryImagePathIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'batteryImagePath',
      ));
    });
  }

  QueryBuilder<UpdateJobcardDraftIsar, UpdateJobcardDraftIsar,
      QAfterFilterCondition> batteryImagePathIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'batteryImagePath',
      ));
    });
  }

  QueryBuilder<UpdateJobcardDraftIsar, UpdateJobcardDraftIsar,
      QAfterFilterCondition> batteryImagePathEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'batteryImagePath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UpdateJobcardDraftIsar, UpdateJobcardDraftIsar,
      QAfterFilterCondition> batteryImagePathGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'batteryImagePath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UpdateJobcardDraftIsar, UpdateJobcardDraftIsar,
      QAfterFilterCondition> batteryImagePathLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'batteryImagePath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UpdateJobcardDraftIsar, UpdateJobcardDraftIsar,
      QAfterFilterCondition> batteryImagePathBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'batteryImagePath',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UpdateJobcardDraftIsar, UpdateJobcardDraftIsar,
      QAfterFilterCondition> batteryImagePathStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'batteryImagePath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UpdateJobcardDraftIsar, UpdateJobcardDraftIsar,
      QAfterFilterCondition> batteryImagePathEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'batteryImagePath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UpdateJobcardDraftIsar, UpdateJobcardDraftIsar,
          QAfterFilterCondition>
      batteryImagePathContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'batteryImagePath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UpdateJobcardDraftIsar, UpdateJobcardDraftIsar,
          QAfterFilterCondition>
      batteryImagePathMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'batteryImagePath',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UpdateJobcardDraftIsar, UpdateJobcardDraftIsar,
      QAfterFilterCondition> batteryImagePathIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'batteryImagePath',
        value: '',
      ));
    });
  }

  QueryBuilder<UpdateJobcardDraftIsar, UpdateJobcardDraftIsar,
      QAfterFilterCondition> batteryImagePathIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'batteryImagePath',
        value: '',
      ));
    });
  }

  QueryBuilder<UpdateJobcardDraftIsar, UpdateJobcardDraftIsar,
      QAfterFilterCondition> dashboardImagePathIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'dashboardImagePath',
      ));
    });
  }

  QueryBuilder<UpdateJobcardDraftIsar, UpdateJobcardDraftIsar,
      QAfterFilterCondition> dashboardImagePathIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'dashboardImagePath',
      ));
    });
  }

  QueryBuilder<UpdateJobcardDraftIsar, UpdateJobcardDraftIsar,
      QAfterFilterCondition> dashboardImagePathEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'dashboardImagePath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UpdateJobcardDraftIsar, UpdateJobcardDraftIsar,
      QAfterFilterCondition> dashboardImagePathGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'dashboardImagePath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UpdateJobcardDraftIsar, UpdateJobcardDraftIsar,
      QAfterFilterCondition> dashboardImagePathLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'dashboardImagePath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UpdateJobcardDraftIsar, UpdateJobcardDraftIsar,
      QAfterFilterCondition> dashboardImagePathBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'dashboardImagePath',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UpdateJobcardDraftIsar, UpdateJobcardDraftIsar,
      QAfterFilterCondition> dashboardImagePathStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'dashboardImagePath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UpdateJobcardDraftIsar, UpdateJobcardDraftIsar,
      QAfterFilterCondition> dashboardImagePathEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'dashboardImagePath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UpdateJobcardDraftIsar, UpdateJobcardDraftIsar,
          QAfterFilterCondition>
      dashboardImagePathContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'dashboardImagePath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UpdateJobcardDraftIsar, UpdateJobcardDraftIsar,
          QAfterFilterCondition>
      dashboardImagePathMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'dashboardImagePath',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UpdateJobcardDraftIsar, UpdateJobcardDraftIsar,
      QAfterFilterCondition> dashboardImagePathIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'dashboardImagePath',
        value: '',
      ));
    });
  }

  QueryBuilder<UpdateJobcardDraftIsar, UpdateJobcardDraftIsar,
      QAfterFilterCondition> dashboardImagePathIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'dashboardImagePath',
        value: '',
      ));
    });
  }

  QueryBuilder<UpdateJobcardDraftIsar, UpdateJobcardDraftIsar,
      QAfterFilterCondition> engineImagePathIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'engineImagePath',
      ));
    });
  }

  QueryBuilder<UpdateJobcardDraftIsar, UpdateJobcardDraftIsar,
      QAfterFilterCondition> engineImagePathIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'engineImagePath',
      ));
    });
  }

  QueryBuilder<UpdateJobcardDraftIsar, UpdateJobcardDraftIsar,
      QAfterFilterCondition> engineImagePathEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'engineImagePath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UpdateJobcardDraftIsar, UpdateJobcardDraftIsar,
      QAfterFilterCondition> engineImagePathGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'engineImagePath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UpdateJobcardDraftIsar, UpdateJobcardDraftIsar,
      QAfterFilterCondition> engineImagePathLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'engineImagePath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UpdateJobcardDraftIsar, UpdateJobcardDraftIsar,
      QAfterFilterCondition> engineImagePathBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'engineImagePath',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UpdateJobcardDraftIsar, UpdateJobcardDraftIsar,
      QAfterFilterCondition> engineImagePathStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'engineImagePath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UpdateJobcardDraftIsar, UpdateJobcardDraftIsar,
      QAfterFilterCondition> engineImagePathEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'engineImagePath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UpdateJobcardDraftIsar, UpdateJobcardDraftIsar,
          QAfterFilterCondition>
      engineImagePathContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'engineImagePath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UpdateJobcardDraftIsar, UpdateJobcardDraftIsar,
          QAfterFilterCondition>
      engineImagePathMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'engineImagePath',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UpdateJobcardDraftIsar, UpdateJobcardDraftIsar,
      QAfterFilterCondition> engineImagePathIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'engineImagePath',
        value: '',
      ));
    });
  }

  QueryBuilder<UpdateJobcardDraftIsar, UpdateJobcardDraftIsar,
      QAfterFilterCondition> engineImagePathIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'engineImagePath',
        value: '',
      ));
    });
  }

  QueryBuilder<UpdateJobcardDraftIsar, UpdateJobcardDraftIsar,
      QAfterFilterCondition> formDataEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'formData',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UpdateJobcardDraftIsar, UpdateJobcardDraftIsar,
      QAfterFilterCondition> formDataGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'formData',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UpdateJobcardDraftIsar, UpdateJobcardDraftIsar,
      QAfterFilterCondition> formDataLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'formData',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UpdateJobcardDraftIsar, UpdateJobcardDraftIsar,
      QAfterFilterCondition> formDataBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'formData',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UpdateJobcardDraftIsar, UpdateJobcardDraftIsar,
      QAfterFilterCondition> formDataStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'formData',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UpdateJobcardDraftIsar, UpdateJobcardDraftIsar,
      QAfterFilterCondition> formDataEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'formData',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UpdateJobcardDraftIsar, UpdateJobcardDraftIsar,
          QAfterFilterCondition>
      formDataContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'formData',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UpdateJobcardDraftIsar, UpdateJobcardDraftIsar,
          QAfterFilterCondition>
      formDataMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'formData',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UpdateJobcardDraftIsar, UpdateJobcardDraftIsar,
      QAfterFilterCondition> formDataIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'formData',
        value: '',
      ));
    });
  }

  QueryBuilder<UpdateJobcardDraftIsar, UpdateJobcardDraftIsar,
      QAfterFilterCondition> formDataIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'formData',
        value: '',
      ));
    });
  }

  QueryBuilder<UpdateJobcardDraftIsar, UpdateJobcardDraftIsar,
      QAfterFilterCondition> frontImagePathIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'frontImagePath',
      ));
    });
  }

  QueryBuilder<UpdateJobcardDraftIsar, UpdateJobcardDraftIsar,
      QAfterFilterCondition> frontImagePathIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'frontImagePath',
      ));
    });
  }

  QueryBuilder<UpdateJobcardDraftIsar, UpdateJobcardDraftIsar,
      QAfterFilterCondition> frontImagePathEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'frontImagePath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UpdateJobcardDraftIsar, UpdateJobcardDraftIsar,
      QAfterFilterCondition> frontImagePathGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'frontImagePath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UpdateJobcardDraftIsar, UpdateJobcardDraftIsar,
      QAfterFilterCondition> frontImagePathLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'frontImagePath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UpdateJobcardDraftIsar, UpdateJobcardDraftIsar,
      QAfterFilterCondition> frontImagePathBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'frontImagePath',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UpdateJobcardDraftIsar, UpdateJobcardDraftIsar,
      QAfterFilterCondition> frontImagePathStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'frontImagePath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UpdateJobcardDraftIsar, UpdateJobcardDraftIsar,
      QAfterFilterCondition> frontImagePathEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'frontImagePath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UpdateJobcardDraftIsar, UpdateJobcardDraftIsar,
          QAfterFilterCondition>
      frontImagePathContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'frontImagePath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UpdateJobcardDraftIsar, UpdateJobcardDraftIsar,
          QAfterFilterCondition>
      frontImagePathMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'frontImagePath',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UpdateJobcardDraftIsar, UpdateJobcardDraftIsar,
      QAfterFilterCondition> frontImagePathIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'frontImagePath',
        value: '',
      ));
    });
  }

  QueryBuilder<UpdateJobcardDraftIsar, UpdateJobcardDraftIsar,
      QAfterFilterCondition> frontImagePathIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'frontImagePath',
        value: '',
      ));
    });
  }

  QueryBuilder<UpdateJobcardDraftIsar, UpdateJobcardDraftIsar,
      QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<UpdateJobcardDraftIsar, UpdateJobcardDraftIsar,
      QAfterFilterCondition> idGreaterThan(
    Id value, {
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

  QueryBuilder<UpdateJobcardDraftIsar, UpdateJobcardDraftIsar,
      QAfterFilterCondition> idLessThan(
    Id value, {
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

  QueryBuilder<UpdateJobcardDraftIsar, UpdateJobcardDraftIsar,
      QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
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

  QueryBuilder<UpdateJobcardDraftIsar, UpdateJobcardDraftIsar,
      QAfterFilterCondition> image1PathIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'image1Path',
      ));
    });
  }

  QueryBuilder<UpdateJobcardDraftIsar, UpdateJobcardDraftIsar,
      QAfterFilterCondition> image1PathIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'image1Path',
      ));
    });
  }

  QueryBuilder<UpdateJobcardDraftIsar, UpdateJobcardDraftIsar,
      QAfterFilterCondition> image1PathEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'image1Path',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UpdateJobcardDraftIsar, UpdateJobcardDraftIsar,
      QAfterFilterCondition> image1PathGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'image1Path',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UpdateJobcardDraftIsar, UpdateJobcardDraftIsar,
      QAfterFilterCondition> image1PathLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'image1Path',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UpdateJobcardDraftIsar, UpdateJobcardDraftIsar,
      QAfterFilterCondition> image1PathBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'image1Path',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UpdateJobcardDraftIsar, UpdateJobcardDraftIsar,
      QAfterFilterCondition> image1PathStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'image1Path',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UpdateJobcardDraftIsar, UpdateJobcardDraftIsar,
      QAfterFilterCondition> image1PathEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'image1Path',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UpdateJobcardDraftIsar, UpdateJobcardDraftIsar,
          QAfterFilterCondition>
      image1PathContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'image1Path',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UpdateJobcardDraftIsar, UpdateJobcardDraftIsar,
          QAfterFilterCondition>
      image1PathMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'image1Path',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UpdateJobcardDraftIsar, UpdateJobcardDraftIsar,
      QAfterFilterCondition> image1PathIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'image1Path',
        value: '',
      ));
    });
  }

  QueryBuilder<UpdateJobcardDraftIsar, UpdateJobcardDraftIsar,
      QAfterFilterCondition> image1PathIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'image1Path',
        value: '',
      ));
    });
  }

  QueryBuilder<UpdateJobcardDraftIsar, UpdateJobcardDraftIsar,
      QAfterFilterCondition> image2PathIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'image2Path',
      ));
    });
  }

  QueryBuilder<UpdateJobcardDraftIsar, UpdateJobcardDraftIsar,
      QAfterFilterCondition> image2PathIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'image2Path',
      ));
    });
  }

  QueryBuilder<UpdateJobcardDraftIsar, UpdateJobcardDraftIsar,
      QAfterFilterCondition> image2PathEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'image2Path',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UpdateJobcardDraftIsar, UpdateJobcardDraftIsar,
      QAfterFilterCondition> image2PathGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'image2Path',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UpdateJobcardDraftIsar, UpdateJobcardDraftIsar,
      QAfterFilterCondition> image2PathLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'image2Path',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UpdateJobcardDraftIsar, UpdateJobcardDraftIsar,
      QAfterFilterCondition> image2PathBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'image2Path',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UpdateJobcardDraftIsar, UpdateJobcardDraftIsar,
      QAfterFilterCondition> image2PathStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'image2Path',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UpdateJobcardDraftIsar, UpdateJobcardDraftIsar,
      QAfterFilterCondition> image2PathEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'image2Path',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UpdateJobcardDraftIsar, UpdateJobcardDraftIsar,
          QAfterFilterCondition>
      image2PathContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'image2Path',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UpdateJobcardDraftIsar, UpdateJobcardDraftIsar,
          QAfterFilterCondition>
      image2PathMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'image2Path',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UpdateJobcardDraftIsar, UpdateJobcardDraftIsar,
      QAfterFilterCondition> image2PathIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'image2Path',
        value: '',
      ));
    });
  }

  QueryBuilder<UpdateJobcardDraftIsar, UpdateJobcardDraftIsar,
      QAfterFilterCondition> image2PathIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'image2Path',
        value: '',
      ));
    });
  }

  QueryBuilder<UpdateJobcardDraftIsar, UpdateJobcardDraftIsar,
      QAfterFilterCondition> image3PathIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'image3Path',
      ));
    });
  }

  QueryBuilder<UpdateJobcardDraftIsar, UpdateJobcardDraftIsar,
      QAfterFilterCondition> image3PathIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'image3Path',
      ));
    });
  }

  QueryBuilder<UpdateJobcardDraftIsar, UpdateJobcardDraftIsar,
      QAfterFilterCondition> image3PathEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'image3Path',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UpdateJobcardDraftIsar, UpdateJobcardDraftIsar,
      QAfterFilterCondition> image3PathGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'image3Path',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UpdateJobcardDraftIsar, UpdateJobcardDraftIsar,
      QAfterFilterCondition> image3PathLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'image3Path',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UpdateJobcardDraftIsar, UpdateJobcardDraftIsar,
      QAfterFilterCondition> image3PathBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'image3Path',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UpdateJobcardDraftIsar, UpdateJobcardDraftIsar,
      QAfterFilterCondition> image3PathStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'image3Path',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UpdateJobcardDraftIsar, UpdateJobcardDraftIsar,
      QAfterFilterCondition> image3PathEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'image3Path',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UpdateJobcardDraftIsar, UpdateJobcardDraftIsar,
          QAfterFilterCondition>
      image3PathContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'image3Path',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UpdateJobcardDraftIsar, UpdateJobcardDraftIsar,
          QAfterFilterCondition>
      image3PathMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'image3Path',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UpdateJobcardDraftIsar, UpdateJobcardDraftIsar,
      QAfterFilterCondition> image3PathIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'image3Path',
        value: '',
      ));
    });
  }

  QueryBuilder<UpdateJobcardDraftIsar, UpdateJobcardDraftIsar,
      QAfterFilterCondition> image3PathIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'image3Path',
        value: '',
      ));
    });
  }

  QueryBuilder<UpdateJobcardDraftIsar, UpdateJobcardDraftIsar,
      QAfterFilterCondition> image4PathIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'image4Path',
      ));
    });
  }

  QueryBuilder<UpdateJobcardDraftIsar, UpdateJobcardDraftIsar,
      QAfterFilterCondition> image4PathIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'image4Path',
      ));
    });
  }

  QueryBuilder<UpdateJobcardDraftIsar, UpdateJobcardDraftIsar,
      QAfterFilterCondition> image4PathEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'image4Path',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UpdateJobcardDraftIsar, UpdateJobcardDraftIsar,
      QAfterFilterCondition> image4PathGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'image4Path',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UpdateJobcardDraftIsar, UpdateJobcardDraftIsar,
      QAfterFilterCondition> image4PathLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'image4Path',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UpdateJobcardDraftIsar, UpdateJobcardDraftIsar,
      QAfterFilterCondition> image4PathBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'image4Path',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UpdateJobcardDraftIsar, UpdateJobcardDraftIsar,
      QAfterFilterCondition> image4PathStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'image4Path',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UpdateJobcardDraftIsar, UpdateJobcardDraftIsar,
      QAfterFilterCondition> image4PathEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'image4Path',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UpdateJobcardDraftIsar, UpdateJobcardDraftIsar,
          QAfterFilterCondition>
      image4PathContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'image4Path',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UpdateJobcardDraftIsar, UpdateJobcardDraftIsar,
          QAfterFilterCondition>
      image4PathMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'image4Path',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UpdateJobcardDraftIsar, UpdateJobcardDraftIsar,
      QAfterFilterCondition> image4PathIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'image4Path',
        value: '',
      ));
    });
  }

  QueryBuilder<UpdateJobcardDraftIsar, UpdateJobcardDraftIsar,
      QAfterFilterCondition> image4PathIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'image4Path',
        value: '',
      ));
    });
  }

  QueryBuilder<UpdateJobcardDraftIsar, UpdateJobcardDraftIsar,
      QAfterFilterCondition> jobcardIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'jobcardId',
      ));
    });
  }

  QueryBuilder<UpdateJobcardDraftIsar, UpdateJobcardDraftIsar,
      QAfterFilterCondition> jobcardIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'jobcardId',
      ));
    });
  }

  QueryBuilder<UpdateJobcardDraftIsar, UpdateJobcardDraftIsar,
      QAfterFilterCondition> jobcardIdEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'jobcardId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UpdateJobcardDraftIsar, UpdateJobcardDraftIsar,
      QAfterFilterCondition> jobcardIdGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'jobcardId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UpdateJobcardDraftIsar, UpdateJobcardDraftIsar,
      QAfterFilterCondition> jobcardIdLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'jobcardId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UpdateJobcardDraftIsar, UpdateJobcardDraftIsar,
      QAfterFilterCondition> jobcardIdBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'jobcardId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UpdateJobcardDraftIsar, UpdateJobcardDraftIsar,
      QAfterFilterCondition> jobcardIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'jobcardId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UpdateJobcardDraftIsar, UpdateJobcardDraftIsar,
      QAfterFilterCondition> jobcardIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'jobcardId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UpdateJobcardDraftIsar, UpdateJobcardDraftIsar,
          QAfterFilterCondition>
      jobcardIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'jobcardId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UpdateJobcardDraftIsar, UpdateJobcardDraftIsar,
          QAfterFilterCondition>
      jobcardIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'jobcardId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UpdateJobcardDraftIsar, UpdateJobcardDraftIsar,
      QAfterFilterCondition> jobcardIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'jobcardId',
        value: '',
      ));
    });
  }

  QueryBuilder<UpdateJobcardDraftIsar, UpdateJobcardDraftIsar,
      QAfterFilterCondition> jobcardIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'jobcardId',
        value: '',
      ));
    });
  }

  QueryBuilder<UpdateJobcardDraftIsar, UpdateJobcardDraftIsar,
      QAfterFilterCondition> leftHandSideImagePathIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'leftHandSideImagePath',
      ));
    });
  }

  QueryBuilder<UpdateJobcardDraftIsar, UpdateJobcardDraftIsar,
      QAfterFilterCondition> leftHandSideImagePathIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'leftHandSideImagePath',
      ));
    });
  }

  QueryBuilder<UpdateJobcardDraftIsar, UpdateJobcardDraftIsar,
      QAfterFilterCondition> leftHandSideImagePathEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'leftHandSideImagePath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UpdateJobcardDraftIsar, UpdateJobcardDraftIsar,
      QAfterFilterCondition> leftHandSideImagePathGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'leftHandSideImagePath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UpdateJobcardDraftIsar, UpdateJobcardDraftIsar,
      QAfterFilterCondition> leftHandSideImagePathLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'leftHandSideImagePath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UpdateJobcardDraftIsar, UpdateJobcardDraftIsar,
      QAfterFilterCondition> leftHandSideImagePathBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'leftHandSideImagePath',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UpdateJobcardDraftIsar, UpdateJobcardDraftIsar,
      QAfterFilterCondition> leftHandSideImagePathStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'leftHandSideImagePath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UpdateJobcardDraftIsar, UpdateJobcardDraftIsar,
      QAfterFilterCondition> leftHandSideImagePathEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'leftHandSideImagePath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UpdateJobcardDraftIsar, UpdateJobcardDraftIsar,
          QAfterFilterCondition>
      leftHandSideImagePathContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'leftHandSideImagePath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UpdateJobcardDraftIsar, UpdateJobcardDraftIsar,
          QAfterFilterCondition>
      leftHandSideImagePathMatches(String pattern,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'leftHandSideImagePath',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UpdateJobcardDraftIsar, UpdateJobcardDraftIsar,
      QAfterFilterCondition> leftHandSideImagePathIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'leftHandSideImagePath',
        value: '',
      ));
    });
  }

  QueryBuilder<UpdateJobcardDraftIsar, UpdateJobcardDraftIsar,
      QAfterFilterCondition> leftHandSideImagePathIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'leftHandSideImagePath',
        value: '',
      ));
    });
  }

  QueryBuilder<UpdateJobcardDraftIsar, UpdateJobcardDraftIsar,
      QAfterFilterCondition> rearImagePathIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'rearImagePath',
      ));
    });
  }

  QueryBuilder<UpdateJobcardDraftIsar, UpdateJobcardDraftIsar,
      QAfterFilterCondition> rearImagePathIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'rearImagePath',
      ));
    });
  }

  QueryBuilder<UpdateJobcardDraftIsar, UpdateJobcardDraftIsar,
      QAfterFilterCondition> rearImagePathEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'rearImagePath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UpdateJobcardDraftIsar, UpdateJobcardDraftIsar,
      QAfterFilterCondition> rearImagePathGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'rearImagePath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UpdateJobcardDraftIsar, UpdateJobcardDraftIsar,
      QAfterFilterCondition> rearImagePathLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'rearImagePath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UpdateJobcardDraftIsar, UpdateJobcardDraftIsar,
      QAfterFilterCondition> rearImagePathBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'rearImagePath',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UpdateJobcardDraftIsar, UpdateJobcardDraftIsar,
      QAfterFilterCondition> rearImagePathStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'rearImagePath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UpdateJobcardDraftIsar, UpdateJobcardDraftIsar,
      QAfterFilterCondition> rearImagePathEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'rearImagePath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UpdateJobcardDraftIsar, UpdateJobcardDraftIsar,
          QAfterFilterCondition>
      rearImagePathContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'rearImagePath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UpdateJobcardDraftIsar, UpdateJobcardDraftIsar,
          QAfterFilterCondition>
      rearImagePathMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'rearImagePath',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UpdateJobcardDraftIsar, UpdateJobcardDraftIsar,
      QAfterFilterCondition> rearImagePathIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'rearImagePath',
        value: '',
      ));
    });
  }

  QueryBuilder<UpdateJobcardDraftIsar, UpdateJobcardDraftIsar,
      QAfterFilterCondition> rearImagePathIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'rearImagePath',
        value: '',
      ));
    });
  }

  QueryBuilder<UpdateJobcardDraftIsar, UpdateJobcardDraftIsar,
      QAfterFilterCondition> rightHandSideImagePathIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'rightHandSideImagePath',
      ));
    });
  }

  QueryBuilder<UpdateJobcardDraftIsar, UpdateJobcardDraftIsar,
      QAfterFilterCondition> rightHandSideImagePathIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'rightHandSideImagePath',
      ));
    });
  }

  QueryBuilder<UpdateJobcardDraftIsar, UpdateJobcardDraftIsar,
      QAfterFilterCondition> rightHandSideImagePathEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'rightHandSideImagePath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UpdateJobcardDraftIsar, UpdateJobcardDraftIsar,
      QAfterFilterCondition> rightHandSideImagePathGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'rightHandSideImagePath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UpdateJobcardDraftIsar, UpdateJobcardDraftIsar,
      QAfterFilterCondition> rightHandSideImagePathLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'rightHandSideImagePath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UpdateJobcardDraftIsar, UpdateJobcardDraftIsar,
      QAfterFilterCondition> rightHandSideImagePathBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'rightHandSideImagePath',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UpdateJobcardDraftIsar, UpdateJobcardDraftIsar,
      QAfterFilterCondition> rightHandSideImagePathStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'rightHandSideImagePath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UpdateJobcardDraftIsar, UpdateJobcardDraftIsar,
      QAfterFilterCondition> rightHandSideImagePathEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'rightHandSideImagePath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UpdateJobcardDraftIsar, UpdateJobcardDraftIsar,
          QAfterFilterCondition>
      rightHandSideImagePathContains(String value,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'rightHandSideImagePath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UpdateJobcardDraftIsar, UpdateJobcardDraftIsar,
          QAfterFilterCondition>
      rightHandSideImagePathMatches(String pattern,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'rightHandSideImagePath',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UpdateJobcardDraftIsar, UpdateJobcardDraftIsar,
      QAfterFilterCondition> rightHandSideImagePathIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'rightHandSideImagePath',
        value: '',
      ));
    });
  }

  QueryBuilder<UpdateJobcardDraftIsar, UpdateJobcardDraftIsar,
      QAfterFilterCondition> rightHandSideImagePathIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'rightHandSideImagePath',
        value: '',
      ));
    });
  }

  QueryBuilder<UpdateJobcardDraftIsar, UpdateJobcardDraftIsar,
      QAfterFilterCondition> speedometerImagePathIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'speedometerImagePath',
      ));
    });
  }

  QueryBuilder<UpdateJobcardDraftIsar, UpdateJobcardDraftIsar,
      QAfterFilterCondition> speedometerImagePathIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'speedometerImagePath',
      ));
    });
  }

  QueryBuilder<UpdateJobcardDraftIsar, UpdateJobcardDraftIsar,
      QAfterFilterCondition> speedometerImagePathEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'speedometerImagePath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UpdateJobcardDraftIsar, UpdateJobcardDraftIsar,
      QAfterFilterCondition> speedometerImagePathGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'speedometerImagePath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UpdateJobcardDraftIsar, UpdateJobcardDraftIsar,
      QAfterFilterCondition> speedometerImagePathLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'speedometerImagePath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UpdateJobcardDraftIsar, UpdateJobcardDraftIsar,
      QAfterFilterCondition> speedometerImagePathBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'speedometerImagePath',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UpdateJobcardDraftIsar, UpdateJobcardDraftIsar,
      QAfterFilterCondition> speedometerImagePathStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'speedometerImagePath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UpdateJobcardDraftIsar, UpdateJobcardDraftIsar,
      QAfterFilterCondition> speedometerImagePathEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'speedometerImagePath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UpdateJobcardDraftIsar, UpdateJobcardDraftIsar,
          QAfterFilterCondition>
      speedometerImagePathContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'speedometerImagePath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UpdateJobcardDraftIsar, UpdateJobcardDraftIsar,
          QAfterFilterCondition>
      speedometerImagePathMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'speedometerImagePath',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UpdateJobcardDraftIsar, UpdateJobcardDraftIsar,
      QAfterFilterCondition> speedometerImagePathIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'speedometerImagePath',
        value: '',
      ));
    });
  }

  QueryBuilder<UpdateJobcardDraftIsar, UpdateJobcardDraftIsar,
      QAfterFilterCondition> speedometerImagePathIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'speedometerImagePath',
        value: '',
      ));
    });
  }
}

extension UpdateJobcardDraftIsarQueryObject on QueryBuilder<
    UpdateJobcardDraftIsar, UpdateJobcardDraftIsar, QFilterCondition> {}

extension UpdateJobcardDraftIsarQueryLinks on QueryBuilder<
    UpdateJobcardDraftIsar, UpdateJobcardDraftIsar, QFilterCondition> {}

extension UpdateJobcardDraftIsarQuerySortBy
    on QueryBuilder<UpdateJobcardDraftIsar, UpdateJobcardDraftIsar, QSortBy> {
  QueryBuilder<UpdateJobcardDraftIsar, UpdateJobcardDraftIsar, QAfterSortBy>
      sortByBatteryImagePath() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'batteryImagePath', Sort.asc);
    });
  }

  QueryBuilder<UpdateJobcardDraftIsar, UpdateJobcardDraftIsar, QAfterSortBy>
      sortByBatteryImagePathDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'batteryImagePath', Sort.desc);
    });
  }

  QueryBuilder<UpdateJobcardDraftIsar, UpdateJobcardDraftIsar, QAfterSortBy>
      sortByDashboardImagePath() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dashboardImagePath', Sort.asc);
    });
  }

  QueryBuilder<UpdateJobcardDraftIsar, UpdateJobcardDraftIsar, QAfterSortBy>
      sortByDashboardImagePathDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dashboardImagePath', Sort.desc);
    });
  }

  QueryBuilder<UpdateJobcardDraftIsar, UpdateJobcardDraftIsar, QAfterSortBy>
      sortByEngineImagePath() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'engineImagePath', Sort.asc);
    });
  }

  QueryBuilder<UpdateJobcardDraftIsar, UpdateJobcardDraftIsar, QAfterSortBy>
      sortByEngineImagePathDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'engineImagePath', Sort.desc);
    });
  }

  QueryBuilder<UpdateJobcardDraftIsar, UpdateJobcardDraftIsar, QAfterSortBy>
      sortByFormData() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'formData', Sort.asc);
    });
  }

  QueryBuilder<UpdateJobcardDraftIsar, UpdateJobcardDraftIsar, QAfterSortBy>
      sortByFormDataDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'formData', Sort.desc);
    });
  }

  QueryBuilder<UpdateJobcardDraftIsar, UpdateJobcardDraftIsar, QAfterSortBy>
      sortByFrontImagePath() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'frontImagePath', Sort.asc);
    });
  }

  QueryBuilder<UpdateJobcardDraftIsar, UpdateJobcardDraftIsar, QAfterSortBy>
      sortByFrontImagePathDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'frontImagePath', Sort.desc);
    });
  }

  QueryBuilder<UpdateJobcardDraftIsar, UpdateJobcardDraftIsar, QAfterSortBy>
      sortByImage1Path() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'image1Path', Sort.asc);
    });
  }

  QueryBuilder<UpdateJobcardDraftIsar, UpdateJobcardDraftIsar, QAfterSortBy>
      sortByImage1PathDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'image1Path', Sort.desc);
    });
  }

  QueryBuilder<UpdateJobcardDraftIsar, UpdateJobcardDraftIsar, QAfterSortBy>
      sortByImage2Path() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'image2Path', Sort.asc);
    });
  }

  QueryBuilder<UpdateJobcardDraftIsar, UpdateJobcardDraftIsar, QAfterSortBy>
      sortByImage2PathDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'image2Path', Sort.desc);
    });
  }

  QueryBuilder<UpdateJobcardDraftIsar, UpdateJobcardDraftIsar, QAfterSortBy>
      sortByImage3Path() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'image3Path', Sort.asc);
    });
  }

  QueryBuilder<UpdateJobcardDraftIsar, UpdateJobcardDraftIsar, QAfterSortBy>
      sortByImage3PathDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'image3Path', Sort.desc);
    });
  }

  QueryBuilder<UpdateJobcardDraftIsar, UpdateJobcardDraftIsar, QAfterSortBy>
      sortByImage4Path() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'image4Path', Sort.asc);
    });
  }

  QueryBuilder<UpdateJobcardDraftIsar, UpdateJobcardDraftIsar, QAfterSortBy>
      sortByImage4PathDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'image4Path', Sort.desc);
    });
  }

  QueryBuilder<UpdateJobcardDraftIsar, UpdateJobcardDraftIsar, QAfterSortBy>
      sortByJobcardId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'jobcardId', Sort.asc);
    });
  }

  QueryBuilder<UpdateJobcardDraftIsar, UpdateJobcardDraftIsar, QAfterSortBy>
      sortByJobcardIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'jobcardId', Sort.desc);
    });
  }

  QueryBuilder<UpdateJobcardDraftIsar, UpdateJobcardDraftIsar, QAfterSortBy>
      sortByLeftHandSideImagePath() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'leftHandSideImagePath', Sort.asc);
    });
  }

  QueryBuilder<UpdateJobcardDraftIsar, UpdateJobcardDraftIsar, QAfterSortBy>
      sortByLeftHandSideImagePathDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'leftHandSideImagePath', Sort.desc);
    });
  }

  QueryBuilder<UpdateJobcardDraftIsar, UpdateJobcardDraftIsar, QAfterSortBy>
      sortByRearImagePath() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rearImagePath', Sort.asc);
    });
  }

  QueryBuilder<UpdateJobcardDraftIsar, UpdateJobcardDraftIsar, QAfterSortBy>
      sortByRearImagePathDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rearImagePath', Sort.desc);
    });
  }

  QueryBuilder<UpdateJobcardDraftIsar, UpdateJobcardDraftIsar, QAfterSortBy>
      sortByRightHandSideImagePath() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rightHandSideImagePath', Sort.asc);
    });
  }

  QueryBuilder<UpdateJobcardDraftIsar, UpdateJobcardDraftIsar, QAfterSortBy>
      sortByRightHandSideImagePathDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rightHandSideImagePath', Sort.desc);
    });
  }

  QueryBuilder<UpdateJobcardDraftIsar, UpdateJobcardDraftIsar, QAfterSortBy>
      sortBySpeedometerImagePath() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'speedometerImagePath', Sort.asc);
    });
  }

  QueryBuilder<UpdateJobcardDraftIsar, UpdateJobcardDraftIsar, QAfterSortBy>
      sortBySpeedometerImagePathDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'speedometerImagePath', Sort.desc);
    });
  }
}

extension UpdateJobcardDraftIsarQuerySortThenBy on QueryBuilder<
    UpdateJobcardDraftIsar, UpdateJobcardDraftIsar, QSortThenBy> {
  QueryBuilder<UpdateJobcardDraftIsar, UpdateJobcardDraftIsar, QAfterSortBy>
      thenByBatteryImagePath() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'batteryImagePath', Sort.asc);
    });
  }

  QueryBuilder<UpdateJobcardDraftIsar, UpdateJobcardDraftIsar, QAfterSortBy>
      thenByBatteryImagePathDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'batteryImagePath', Sort.desc);
    });
  }

  QueryBuilder<UpdateJobcardDraftIsar, UpdateJobcardDraftIsar, QAfterSortBy>
      thenByDashboardImagePath() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dashboardImagePath', Sort.asc);
    });
  }

  QueryBuilder<UpdateJobcardDraftIsar, UpdateJobcardDraftIsar, QAfterSortBy>
      thenByDashboardImagePathDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dashboardImagePath', Sort.desc);
    });
  }

  QueryBuilder<UpdateJobcardDraftIsar, UpdateJobcardDraftIsar, QAfterSortBy>
      thenByEngineImagePath() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'engineImagePath', Sort.asc);
    });
  }

  QueryBuilder<UpdateJobcardDraftIsar, UpdateJobcardDraftIsar, QAfterSortBy>
      thenByEngineImagePathDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'engineImagePath', Sort.desc);
    });
  }

  QueryBuilder<UpdateJobcardDraftIsar, UpdateJobcardDraftIsar, QAfterSortBy>
      thenByFormData() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'formData', Sort.asc);
    });
  }

  QueryBuilder<UpdateJobcardDraftIsar, UpdateJobcardDraftIsar, QAfterSortBy>
      thenByFormDataDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'formData', Sort.desc);
    });
  }

  QueryBuilder<UpdateJobcardDraftIsar, UpdateJobcardDraftIsar, QAfterSortBy>
      thenByFrontImagePath() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'frontImagePath', Sort.asc);
    });
  }

  QueryBuilder<UpdateJobcardDraftIsar, UpdateJobcardDraftIsar, QAfterSortBy>
      thenByFrontImagePathDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'frontImagePath', Sort.desc);
    });
  }

  QueryBuilder<UpdateJobcardDraftIsar, UpdateJobcardDraftIsar, QAfterSortBy>
      thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<UpdateJobcardDraftIsar, UpdateJobcardDraftIsar, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<UpdateJobcardDraftIsar, UpdateJobcardDraftIsar, QAfterSortBy>
      thenByImage1Path() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'image1Path', Sort.asc);
    });
  }

  QueryBuilder<UpdateJobcardDraftIsar, UpdateJobcardDraftIsar, QAfterSortBy>
      thenByImage1PathDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'image1Path', Sort.desc);
    });
  }

  QueryBuilder<UpdateJobcardDraftIsar, UpdateJobcardDraftIsar, QAfterSortBy>
      thenByImage2Path() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'image2Path', Sort.asc);
    });
  }

  QueryBuilder<UpdateJobcardDraftIsar, UpdateJobcardDraftIsar, QAfterSortBy>
      thenByImage2PathDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'image2Path', Sort.desc);
    });
  }

  QueryBuilder<UpdateJobcardDraftIsar, UpdateJobcardDraftIsar, QAfterSortBy>
      thenByImage3Path() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'image3Path', Sort.asc);
    });
  }

  QueryBuilder<UpdateJobcardDraftIsar, UpdateJobcardDraftIsar, QAfterSortBy>
      thenByImage3PathDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'image3Path', Sort.desc);
    });
  }

  QueryBuilder<UpdateJobcardDraftIsar, UpdateJobcardDraftIsar, QAfterSortBy>
      thenByImage4Path() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'image4Path', Sort.asc);
    });
  }

  QueryBuilder<UpdateJobcardDraftIsar, UpdateJobcardDraftIsar, QAfterSortBy>
      thenByImage4PathDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'image4Path', Sort.desc);
    });
  }

  QueryBuilder<UpdateJobcardDraftIsar, UpdateJobcardDraftIsar, QAfterSortBy>
      thenByJobcardId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'jobcardId', Sort.asc);
    });
  }

  QueryBuilder<UpdateJobcardDraftIsar, UpdateJobcardDraftIsar, QAfterSortBy>
      thenByJobcardIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'jobcardId', Sort.desc);
    });
  }

  QueryBuilder<UpdateJobcardDraftIsar, UpdateJobcardDraftIsar, QAfterSortBy>
      thenByLeftHandSideImagePath() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'leftHandSideImagePath', Sort.asc);
    });
  }

  QueryBuilder<UpdateJobcardDraftIsar, UpdateJobcardDraftIsar, QAfterSortBy>
      thenByLeftHandSideImagePathDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'leftHandSideImagePath', Sort.desc);
    });
  }

  QueryBuilder<UpdateJobcardDraftIsar, UpdateJobcardDraftIsar, QAfterSortBy>
      thenByRearImagePath() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rearImagePath', Sort.asc);
    });
  }

  QueryBuilder<UpdateJobcardDraftIsar, UpdateJobcardDraftIsar, QAfterSortBy>
      thenByRearImagePathDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rearImagePath', Sort.desc);
    });
  }

  QueryBuilder<UpdateJobcardDraftIsar, UpdateJobcardDraftIsar, QAfterSortBy>
      thenByRightHandSideImagePath() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rightHandSideImagePath', Sort.asc);
    });
  }

  QueryBuilder<UpdateJobcardDraftIsar, UpdateJobcardDraftIsar, QAfterSortBy>
      thenByRightHandSideImagePathDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rightHandSideImagePath', Sort.desc);
    });
  }

  QueryBuilder<UpdateJobcardDraftIsar, UpdateJobcardDraftIsar, QAfterSortBy>
      thenBySpeedometerImagePath() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'speedometerImagePath', Sort.asc);
    });
  }

  QueryBuilder<UpdateJobcardDraftIsar, UpdateJobcardDraftIsar, QAfterSortBy>
      thenBySpeedometerImagePathDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'speedometerImagePath', Sort.desc);
    });
  }
}

extension UpdateJobcardDraftIsarQueryWhereDistinct
    on QueryBuilder<UpdateJobcardDraftIsar, UpdateJobcardDraftIsar, QDistinct> {
  QueryBuilder<UpdateJobcardDraftIsar, UpdateJobcardDraftIsar, QDistinct>
      distinctByBatteryImagePath({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'batteryImagePath',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UpdateJobcardDraftIsar, UpdateJobcardDraftIsar, QDistinct>
      distinctByDashboardImagePath({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'dashboardImagePath',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UpdateJobcardDraftIsar, UpdateJobcardDraftIsar, QDistinct>
      distinctByEngineImagePath({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'engineImagePath',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UpdateJobcardDraftIsar, UpdateJobcardDraftIsar, QDistinct>
      distinctByFormData({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'formData', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UpdateJobcardDraftIsar, UpdateJobcardDraftIsar, QDistinct>
      distinctByFrontImagePath({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'frontImagePath',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UpdateJobcardDraftIsar, UpdateJobcardDraftIsar, QDistinct>
      distinctByImage1Path({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'image1Path', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UpdateJobcardDraftIsar, UpdateJobcardDraftIsar, QDistinct>
      distinctByImage2Path({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'image2Path', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UpdateJobcardDraftIsar, UpdateJobcardDraftIsar, QDistinct>
      distinctByImage3Path({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'image3Path', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UpdateJobcardDraftIsar, UpdateJobcardDraftIsar, QDistinct>
      distinctByImage4Path({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'image4Path', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UpdateJobcardDraftIsar, UpdateJobcardDraftIsar, QDistinct>
      distinctByJobcardId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'jobcardId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UpdateJobcardDraftIsar, UpdateJobcardDraftIsar, QDistinct>
      distinctByLeftHandSideImagePath({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'leftHandSideImagePath',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UpdateJobcardDraftIsar, UpdateJobcardDraftIsar, QDistinct>
      distinctByRearImagePath({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'rearImagePath',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UpdateJobcardDraftIsar, UpdateJobcardDraftIsar, QDistinct>
      distinctByRightHandSideImagePath({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'rightHandSideImagePath',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UpdateJobcardDraftIsar, UpdateJobcardDraftIsar, QDistinct>
      distinctBySpeedometerImagePath({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'speedometerImagePath',
          caseSensitive: caseSensitive);
    });
  }
}

extension UpdateJobcardDraftIsarQueryProperty on QueryBuilder<
    UpdateJobcardDraftIsar, UpdateJobcardDraftIsar, QQueryProperty> {
  QueryBuilder<UpdateJobcardDraftIsar, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<UpdateJobcardDraftIsar, String?, QQueryOperations>
      batteryImagePathProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'batteryImagePath');
    });
  }

  QueryBuilder<UpdateJobcardDraftIsar, String?, QQueryOperations>
      dashboardImagePathProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'dashboardImagePath');
    });
  }

  QueryBuilder<UpdateJobcardDraftIsar, String?, QQueryOperations>
      engineImagePathProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'engineImagePath');
    });
  }

  QueryBuilder<UpdateJobcardDraftIsar, String, QQueryOperations>
      formDataProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'formData');
    });
  }

  QueryBuilder<UpdateJobcardDraftIsar, String?, QQueryOperations>
      frontImagePathProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'frontImagePath');
    });
  }

  QueryBuilder<UpdateJobcardDraftIsar, String?, QQueryOperations>
      image1PathProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'image1Path');
    });
  }

  QueryBuilder<UpdateJobcardDraftIsar, String?, QQueryOperations>
      image2PathProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'image2Path');
    });
  }

  QueryBuilder<UpdateJobcardDraftIsar, String?, QQueryOperations>
      image3PathProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'image3Path');
    });
  }

  QueryBuilder<UpdateJobcardDraftIsar, String?, QQueryOperations>
      image4PathProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'image4Path');
    });
  }

  QueryBuilder<UpdateJobcardDraftIsar, String?, QQueryOperations>
      jobcardIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'jobcardId');
    });
  }

  QueryBuilder<UpdateJobcardDraftIsar, String?, QQueryOperations>
      leftHandSideImagePathProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'leftHandSideImagePath');
    });
  }

  QueryBuilder<UpdateJobcardDraftIsar, String?, QQueryOperations>
      rearImagePathProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'rearImagePath');
    });
  }

  QueryBuilder<UpdateJobcardDraftIsar, String?, QQueryOperations>
      rightHandSideImagePathProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'rightHandSideImagePath');
    });
  }

  QueryBuilder<UpdateJobcardDraftIsar, String?, QQueryOperations>
      speedometerImagePathProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'speedometerImagePath');
    });
  }
}
