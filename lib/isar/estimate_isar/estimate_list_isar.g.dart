// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'estimate_list_isar.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetEstimateListIsarCollection on Isar {
  IsarCollection<EstimateListIsar> get estimateListIsars => this.collection();
}

const EstimateListIsarSchema = CollectionSchema(
  name: r'EstimateListIsar',
  id: 1765731127945735565,
  properties: {
    r'address': PropertySchema(
      id: 0,
      name: r'address',
      type: IsarType.string,
    ),
    r'createdAtTime': PropertySchema(
      id: 1,
      name: r'createdAtTime',
      type: IsarType.string,
    ),
    r'deletedAt': PropertySchema(
      id: 2,
      name: r'deletedAt',
      type: IsarType.string,
    ),
    r'email': PropertySchema(
      id: 3,
      name: r'email',
      type: IsarType.string,
    ),
    r'estimateNumber': PropertySchema(
      id: 4,
      name: r'estimateNumber',
      type: IsarType.long,
    ),
    r'estimateTotal': PropertySchema(
      id: 5,
      name: r'estimateTotal',
      type: IsarType.string,
    ),
    r'flag': PropertySchema(
      id: 6,
      name: r'flag',
      type: IsarType.long,
    ),
    r'fullname': PropertySchema(
      id: 7,
      name: r'fullname',
      type: IsarType.string,
    ),
    r'kms': PropertySchema(
      id: 8,
      name: r'kms',
      type: IsarType.string,
    ),
    r'manufacturers': PropertySchema(
      id: 9,
      name: r'manufacturers',
      type: IsarType.string,
    ),
    r'mobileNumber': PropertySchema(
      id: 10,
      name: r'mobileNumber',
      type: IsarType.string,
    ),
    r'tempDate': PropertySchema(
      id: 11,
      name: r'tempDate',
      type: IsarType.string,
    ),
    r'timestamp': PropertySchema(
      id: 12,
      name: r'timestamp',
      type: IsarType.string,
    ),
    r'updateAt': PropertySchema(
      id: 13,
      name: r'updateAt',
      type: IsarType.string,
    ),
    r'vehicleName': PropertySchema(
      id: 14,
      name: r'vehicleName',
      type: IsarType.string,
    ),
    r'vehicleNumber': PropertySchema(
      id: 15,
      name: r'vehicleNumber',
      type: IsarType.string,
    )
  },
  estimateSize: _estimateListIsarEstimateSize,
  serialize: _estimateListIsarSerialize,
  deserialize: _estimateListIsarDeserialize,
  deserializeProp: _estimateListIsarDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _estimateListIsarGetId,
  getLinks: _estimateListIsarGetLinks,
  attach: _estimateListIsarAttach,
  version: '3.3.0-dev.3',
);

int _estimateListIsarEstimateSize(
  EstimateListIsar object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.address;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.createdAtTime;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.deletedAt;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.email;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.estimateTotal;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.fullname;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.kms;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.manufacturers;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.mobileNumber;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.tempDate;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.timestamp;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.updateAt;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.vehicleName;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.vehicleNumber;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _estimateListIsarSerialize(
  EstimateListIsar object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.address);
  writer.writeString(offsets[1], object.createdAtTime);
  writer.writeString(offsets[2], object.deletedAt);
  writer.writeString(offsets[3], object.email);
  writer.writeLong(offsets[4], object.estimateNumber);
  writer.writeString(offsets[5], object.estimateTotal);
  writer.writeLong(offsets[6], object.flag);
  writer.writeString(offsets[7], object.fullname);
  writer.writeString(offsets[8], object.kms);
  writer.writeString(offsets[9], object.manufacturers);
  writer.writeString(offsets[10], object.mobileNumber);
  writer.writeString(offsets[11], object.tempDate);
  writer.writeString(offsets[12], object.timestamp);
  writer.writeString(offsets[13], object.updateAt);
  writer.writeString(offsets[14], object.vehicleName);
  writer.writeString(offsets[15], object.vehicleNumber);
}

EstimateListIsar _estimateListIsarDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = EstimateListIsar(
    address: reader.readStringOrNull(offsets[0]),
    createdAtTime: reader.readStringOrNull(offsets[1]),
    deletedAt: reader.readStringOrNull(offsets[2]),
    email: reader.readStringOrNull(offsets[3]),
    estimateNumber: reader.readLongOrNull(offsets[4]),
    estimateTotal: reader.readStringOrNull(offsets[5]),
    flag: reader.readLongOrNull(offsets[6]),
    fullname: reader.readStringOrNull(offsets[7]),
    id: id,
    kms: reader.readStringOrNull(offsets[8]),
    manufacturers: reader.readStringOrNull(offsets[9]),
    mobileNumber: reader.readStringOrNull(offsets[10]),
    tempDate: reader.readStringOrNull(offsets[11]),
    timestamp: reader.readStringOrNull(offsets[12]),
    updateAt: reader.readStringOrNull(offsets[13]),
    vehicleName: reader.readStringOrNull(offsets[14]),
    vehicleNumber: reader.readStringOrNull(offsets[15]),
  );
  return object;
}

P _estimateListIsarDeserializeProp<P>(
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
      return (reader.readStringOrNull(offset)) as P;
    case 4:
      return (reader.readLongOrNull(offset)) as P;
    case 5:
      return (reader.readStringOrNull(offset)) as P;
    case 6:
      return (reader.readLongOrNull(offset)) as P;
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
    case 14:
      return (reader.readStringOrNull(offset)) as P;
    case 15:
      return (reader.readStringOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _estimateListIsarGetId(EstimateListIsar object) {
  return object.id ?? Isar.autoIncrement;
}

List<IsarLinkBase<dynamic>> _estimateListIsarGetLinks(EstimateListIsar object) {
  return [];
}

void _estimateListIsarAttach(
    IsarCollection<dynamic> col, Id id, EstimateListIsar object) {
  object.id = id;
}

extension EstimateListIsarQueryWhereSort
    on QueryBuilder<EstimateListIsar, EstimateListIsar, QWhere> {
  QueryBuilder<EstimateListIsar, EstimateListIsar, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension EstimateListIsarQueryWhere
    on QueryBuilder<EstimateListIsar, EstimateListIsar, QWhereClause> {
  QueryBuilder<EstimateListIsar, EstimateListIsar, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<EstimateListIsar, EstimateListIsar, QAfterWhereClause>
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

  QueryBuilder<EstimateListIsar, EstimateListIsar, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<EstimateListIsar, EstimateListIsar, QAfterWhereClause>
      idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<EstimateListIsar, EstimateListIsar, QAfterWhereClause> idBetween(
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

extension EstimateListIsarQueryFilter
    on QueryBuilder<EstimateListIsar, EstimateListIsar, QFilterCondition> {
  QueryBuilder<EstimateListIsar, EstimateListIsar, QAfterFilterCondition>
      addressIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'address',
      ));
    });
  }

  QueryBuilder<EstimateListIsar, EstimateListIsar, QAfterFilterCondition>
      addressIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'address',
      ));
    });
  }

  QueryBuilder<EstimateListIsar, EstimateListIsar, QAfterFilterCondition>
      addressEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'address',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EstimateListIsar, EstimateListIsar, QAfterFilterCondition>
      addressGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'address',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EstimateListIsar, EstimateListIsar, QAfterFilterCondition>
      addressLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'address',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EstimateListIsar, EstimateListIsar, QAfterFilterCondition>
      addressBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'address',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EstimateListIsar, EstimateListIsar, QAfterFilterCondition>
      addressStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'address',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EstimateListIsar, EstimateListIsar, QAfterFilterCondition>
      addressEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'address',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EstimateListIsar, EstimateListIsar, QAfterFilterCondition>
      addressContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'address',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EstimateListIsar, EstimateListIsar, QAfterFilterCondition>
      addressMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'address',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EstimateListIsar, EstimateListIsar, QAfterFilterCondition>
      addressIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'address',
        value: '',
      ));
    });
  }

  QueryBuilder<EstimateListIsar, EstimateListIsar, QAfterFilterCondition>
      addressIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'address',
        value: '',
      ));
    });
  }

  QueryBuilder<EstimateListIsar, EstimateListIsar, QAfterFilterCondition>
      createdAtTimeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'createdAtTime',
      ));
    });
  }

  QueryBuilder<EstimateListIsar, EstimateListIsar, QAfterFilterCondition>
      createdAtTimeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'createdAtTime',
      ));
    });
  }

  QueryBuilder<EstimateListIsar, EstimateListIsar, QAfterFilterCondition>
      createdAtTimeEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'createdAtTime',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EstimateListIsar, EstimateListIsar, QAfterFilterCondition>
      createdAtTimeGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'createdAtTime',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EstimateListIsar, EstimateListIsar, QAfterFilterCondition>
      createdAtTimeLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'createdAtTime',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EstimateListIsar, EstimateListIsar, QAfterFilterCondition>
      createdAtTimeBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'createdAtTime',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EstimateListIsar, EstimateListIsar, QAfterFilterCondition>
      createdAtTimeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'createdAtTime',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EstimateListIsar, EstimateListIsar, QAfterFilterCondition>
      createdAtTimeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'createdAtTime',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EstimateListIsar, EstimateListIsar, QAfterFilterCondition>
      createdAtTimeContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'createdAtTime',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EstimateListIsar, EstimateListIsar, QAfterFilterCondition>
      createdAtTimeMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'createdAtTime',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EstimateListIsar, EstimateListIsar, QAfterFilterCondition>
      createdAtTimeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'createdAtTime',
        value: '',
      ));
    });
  }

  QueryBuilder<EstimateListIsar, EstimateListIsar, QAfterFilterCondition>
      createdAtTimeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'createdAtTime',
        value: '',
      ));
    });
  }

  QueryBuilder<EstimateListIsar, EstimateListIsar, QAfterFilterCondition>
      deletedAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'deletedAt',
      ));
    });
  }

  QueryBuilder<EstimateListIsar, EstimateListIsar, QAfterFilterCondition>
      deletedAtIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'deletedAt',
      ));
    });
  }

  QueryBuilder<EstimateListIsar, EstimateListIsar, QAfterFilterCondition>
      deletedAtEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'deletedAt',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EstimateListIsar, EstimateListIsar, QAfterFilterCondition>
      deletedAtGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'deletedAt',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EstimateListIsar, EstimateListIsar, QAfterFilterCondition>
      deletedAtLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'deletedAt',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EstimateListIsar, EstimateListIsar, QAfterFilterCondition>
      deletedAtBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'deletedAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EstimateListIsar, EstimateListIsar, QAfterFilterCondition>
      deletedAtStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'deletedAt',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EstimateListIsar, EstimateListIsar, QAfterFilterCondition>
      deletedAtEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'deletedAt',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EstimateListIsar, EstimateListIsar, QAfterFilterCondition>
      deletedAtContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'deletedAt',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EstimateListIsar, EstimateListIsar, QAfterFilterCondition>
      deletedAtMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'deletedAt',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EstimateListIsar, EstimateListIsar, QAfterFilterCondition>
      deletedAtIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'deletedAt',
        value: '',
      ));
    });
  }

  QueryBuilder<EstimateListIsar, EstimateListIsar, QAfterFilterCondition>
      deletedAtIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'deletedAt',
        value: '',
      ));
    });
  }

  QueryBuilder<EstimateListIsar, EstimateListIsar, QAfterFilterCondition>
      emailIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'email',
      ));
    });
  }

  QueryBuilder<EstimateListIsar, EstimateListIsar, QAfterFilterCondition>
      emailIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'email',
      ));
    });
  }

  QueryBuilder<EstimateListIsar, EstimateListIsar, QAfterFilterCondition>
      emailEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'email',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EstimateListIsar, EstimateListIsar, QAfterFilterCondition>
      emailGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'email',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EstimateListIsar, EstimateListIsar, QAfterFilterCondition>
      emailLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'email',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EstimateListIsar, EstimateListIsar, QAfterFilterCondition>
      emailBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'email',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EstimateListIsar, EstimateListIsar, QAfterFilterCondition>
      emailStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'email',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EstimateListIsar, EstimateListIsar, QAfterFilterCondition>
      emailEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'email',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EstimateListIsar, EstimateListIsar, QAfterFilterCondition>
      emailContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'email',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EstimateListIsar, EstimateListIsar, QAfterFilterCondition>
      emailMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'email',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EstimateListIsar, EstimateListIsar, QAfterFilterCondition>
      emailIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'email',
        value: '',
      ));
    });
  }

  QueryBuilder<EstimateListIsar, EstimateListIsar, QAfterFilterCondition>
      emailIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'email',
        value: '',
      ));
    });
  }

  QueryBuilder<EstimateListIsar, EstimateListIsar, QAfterFilterCondition>
      estimateNumberIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'estimateNumber',
      ));
    });
  }

  QueryBuilder<EstimateListIsar, EstimateListIsar, QAfterFilterCondition>
      estimateNumberIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'estimateNumber',
      ));
    });
  }

  QueryBuilder<EstimateListIsar, EstimateListIsar, QAfterFilterCondition>
      estimateNumberEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'estimateNumber',
        value: value,
      ));
    });
  }

  QueryBuilder<EstimateListIsar, EstimateListIsar, QAfterFilterCondition>
      estimateNumberGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'estimateNumber',
        value: value,
      ));
    });
  }

  QueryBuilder<EstimateListIsar, EstimateListIsar, QAfterFilterCondition>
      estimateNumberLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'estimateNumber',
        value: value,
      ));
    });
  }

  QueryBuilder<EstimateListIsar, EstimateListIsar, QAfterFilterCondition>
      estimateNumberBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'estimateNumber',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<EstimateListIsar, EstimateListIsar, QAfterFilterCondition>
      estimateTotalIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'estimateTotal',
      ));
    });
  }

  QueryBuilder<EstimateListIsar, EstimateListIsar, QAfterFilterCondition>
      estimateTotalIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'estimateTotal',
      ));
    });
  }

  QueryBuilder<EstimateListIsar, EstimateListIsar, QAfterFilterCondition>
      estimateTotalEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'estimateTotal',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EstimateListIsar, EstimateListIsar, QAfterFilterCondition>
      estimateTotalGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'estimateTotal',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EstimateListIsar, EstimateListIsar, QAfterFilterCondition>
      estimateTotalLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'estimateTotal',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EstimateListIsar, EstimateListIsar, QAfterFilterCondition>
      estimateTotalBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'estimateTotal',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EstimateListIsar, EstimateListIsar, QAfterFilterCondition>
      estimateTotalStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'estimateTotal',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EstimateListIsar, EstimateListIsar, QAfterFilterCondition>
      estimateTotalEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'estimateTotal',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EstimateListIsar, EstimateListIsar, QAfterFilterCondition>
      estimateTotalContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'estimateTotal',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EstimateListIsar, EstimateListIsar, QAfterFilterCondition>
      estimateTotalMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'estimateTotal',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EstimateListIsar, EstimateListIsar, QAfterFilterCondition>
      estimateTotalIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'estimateTotal',
        value: '',
      ));
    });
  }

  QueryBuilder<EstimateListIsar, EstimateListIsar, QAfterFilterCondition>
      estimateTotalIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'estimateTotal',
        value: '',
      ));
    });
  }

  QueryBuilder<EstimateListIsar, EstimateListIsar, QAfterFilterCondition>
      flagIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'flag',
      ));
    });
  }

  QueryBuilder<EstimateListIsar, EstimateListIsar, QAfterFilterCondition>
      flagIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'flag',
      ));
    });
  }

  QueryBuilder<EstimateListIsar, EstimateListIsar, QAfterFilterCondition>
      flagEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'flag',
        value: value,
      ));
    });
  }

  QueryBuilder<EstimateListIsar, EstimateListIsar, QAfterFilterCondition>
      flagGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'flag',
        value: value,
      ));
    });
  }

  QueryBuilder<EstimateListIsar, EstimateListIsar, QAfterFilterCondition>
      flagLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'flag',
        value: value,
      ));
    });
  }

  QueryBuilder<EstimateListIsar, EstimateListIsar, QAfterFilterCondition>
      flagBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'flag',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<EstimateListIsar, EstimateListIsar, QAfterFilterCondition>
      fullnameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'fullname',
      ));
    });
  }

  QueryBuilder<EstimateListIsar, EstimateListIsar, QAfterFilterCondition>
      fullnameIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'fullname',
      ));
    });
  }

  QueryBuilder<EstimateListIsar, EstimateListIsar, QAfterFilterCondition>
      fullnameEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'fullname',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EstimateListIsar, EstimateListIsar, QAfterFilterCondition>
      fullnameGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'fullname',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EstimateListIsar, EstimateListIsar, QAfterFilterCondition>
      fullnameLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'fullname',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EstimateListIsar, EstimateListIsar, QAfterFilterCondition>
      fullnameBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'fullname',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EstimateListIsar, EstimateListIsar, QAfterFilterCondition>
      fullnameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'fullname',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EstimateListIsar, EstimateListIsar, QAfterFilterCondition>
      fullnameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'fullname',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EstimateListIsar, EstimateListIsar, QAfterFilterCondition>
      fullnameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'fullname',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EstimateListIsar, EstimateListIsar, QAfterFilterCondition>
      fullnameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'fullname',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EstimateListIsar, EstimateListIsar, QAfterFilterCondition>
      fullnameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'fullname',
        value: '',
      ));
    });
  }

  QueryBuilder<EstimateListIsar, EstimateListIsar, QAfterFilterCondition>
      fullnameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'fullname',
        value: '',
      ));
    });
  }

  QueryBuilder<EstimateListIsar, EstimateListIsar, QAfterFilterCondition>
      idIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<EstimateListIsar, EstimateListIsar, QAfterFilterCondition>
      idIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<EstimateListIsar, EstimateListIsar, QAfterFilterCondition>
      idEqualTo(Id? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<EstimateListIsar, EstimateListIsar, QAfterFilterCondition>
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

  QueryBuilder<EstimateListIsar, EstimateListIsar, QAfterFilterCondition>
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

  QueryBuilder<EstimateListIsar, EstimateListIsar, QAfterFilterCondition>
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

  QueryBuilder<EstimateListIsar, EstimateListIsar, QAfterFilterCondition>
      kmsIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'kms',
      ));
    });
  }

  QueryBuilder<EstimateListIsar, EstimateListIsar, QAfterFilterCondition>
      kmsIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'kms',
      ));
    });
  }

  QueryBuilder<EstimateListIsar, EstimateListIsar, QAfterFilterCondition>
      kmsEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'kms',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EstimateListIsar, EstimateListIsar, QAfterFilterCondition>
      kmsGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'kms',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EstimateListIsar, EstimateListIsar, QAfterFilterCondition>
      kmsLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'kms',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EstimateListIsar, EstimateListIsar, QAfterFilterCondition>
      kmsBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'kms',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EstimateListIsar, EstimateListIsar, QAfterFilterCondition>
      kmsStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'kms',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EstimateListIsar, EstimateListIsar, QAfterFilterCondition>
      kmsEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'kms',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EstimateListIsar, EstimateListIsar, QAfterFilterCondition>
      kmsContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'kms',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EstimateListIsar, EstimateListIsar, QAfterFilterCondition>
      kmsMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'kms',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EstimateListIsar, EstimateListIsar, QAfterFilterCondition>
      kmsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'kms',
        value: '',
      ));
    });
  }

  QueryBuilder<EstimateListIsar, EstimateListIsar, QAfterFilterCondition>
      kmsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'kms',
        value: '',
      ));
    });
  }

  QueryBuilder<EstimateListIsar, EstimateListIsar, QAfterFilterCondition>
      manufacturersIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'manufacturers',
      ));
    });
  }

  QueryBuilder<EstimateListIsar, EstimateListIsar, QAfterFilterCondition>
      manufacturersIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'manufacturers',
      ));
    });
  }

  QueryBuilder<EstimateListIsar, EstimateListIsar, QAfterFilterCondition>
      manufacturersEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'manufacturers',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EstimateListIsar, EstimateListIsar, QAfterFilterCondition>
      manufacturersGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'manufacturers',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EstimateListIsar, EstimateListIsar, QAfterFilterCondition>
      manufacturersLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'manufacturers',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EstimateListIsar, EstimateListIsar, QAfterFilterCondition>
      manufacturersBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'manufacturers',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EstimateListIsar, EstimateListIsar, QAfterFilterCondition>
      manufacturersStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'manufacturers',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EstimateListIsar, EstimateListIsar, QAfterFilterCondition>
      manufacturersEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'manufacturers',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EstimateListIsar, EstimateListIsar, QAfterFilterCondition>
      manufacturersContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'manufacturers',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EstimateListIsar, EstimateListIsar, QAfterFilterCondition>
      manufacturersMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'manufacturers',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EstimateListIsar, EstimateListIsar, QAfterFilterCondition>
      manufacturersIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'manufacturers',
        value: '',
      ));
    });
  }

  QueryBuilder<EstimateListIsar, EstimateListIsar, QAfterFilterCondition>
      manufacturersIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'manufacturers',
        value: '',
      ));
    });
  }

  QueryBuilder<EstimateListIsar, EstimateListIsar, QAfterFilterCondition>
      mobileNumberIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'mobileNumber',
      ));
    });
  }

  QueryBuilder<EstimateListIsar, EstimateListIsar, QAfterFilterCondition>
      mobileNumberIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'mobileNumber',
      ));
    });
  }

  QueryBuilder<EstimateListIsar, EstimateListIsar, QAfterFilterCondition>
      mobileNumberEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'mobileNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EstimateListIsar, EstimateListIsar, QAfterFilterCondition>
      mobileNumberGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'mobileNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EstimateListIsar, EstimateListIsar, QAfterFilterCondition>
      mobileNumberLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'mobileNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EstimateListIsar, EstimateListIsar, QAfterFilterCondition>
      mobileNumberBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'mobileNumber',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EstimateListIsar, EstimateListIsar, QAfterFilterCondition>
      mobileNumberStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'mobileNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EstimateListIsar, EstimateListIsar, QAfterFilterCondition>
      mobileNumberEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'mobileNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EstimateListIsar, EstimateListIsar, QAfterFilterCondition>
      mobileNumberContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'mobileNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EstimateListIsar, EstimateListIsar, QAfterFilterCondition>
      mobileNumberMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'mobileNumber',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EstimateListIsar, EstimateListIsar, QAfterFilterCondition>
      mobileNumberIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'mobileNumber',
        value: '',
      ));
    });
  }

  QueryBuilder<EstimateListIsar, EstimateListIsar, QAfterFilterCondition>
      mobileNumberIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'mobileNumber',
        value: '',
      ));
    });
  }

  QueryBuilder<EstimateListIsar, EstimateListIsar, QAfterFilterCondition>
      tempDateIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'tempDate',
      ));
    });
  }

  QueryBuilder<EstimateListIsar, EstimateListIsar, QAfterFilterCondition>
      tempDateIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'tempDate',
      ));
    });
  }

  QueryBuilder<EstimateListIsar, EstimateListIsar, QAfterFilterCondition>
      tempDateEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'tempDate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EstimateListIsar, EstimateListIsar, QAfterFilterCondition>
      tempDateGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'tempDate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EstimateListIsar, EstimateListIsar, QAfterFilterCondition>
      tempDateLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'tempDate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EstimateListIsar, EstimateListIsar, QAfterFilterCondition>
      tempDateBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'tempDate',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EstimateListIsar, EstimateListIsar, QAfterFilterCondition>
      tempDateStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'tempDate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EstimateListIsar, EstimateListIsar, QAfterFilterCondition>
      tempDateEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'tempDate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EstimateListIsar, EstimateListIsar, QAfterFilterCondition>
      tempDateContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'tempDate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EstimateListIsar, EstimateListIsar, QAfterFilterCondition>
      tempDateMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'tempDate',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EstimateListIsar, EstimateListIsar, QAfterFilterCondition>
      tempDateIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'tempDate',
        value: '',
      ));
    });
  }

  QueryBuilder<EstimateListIsar, EstimateListIsar, QAfterFilterCondition>
      tempDateIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'tempDate',
        value: '',
      ));
    });
  }

  QueryBuilder<EstimateListIsar, EstimateListIsar, QAfterFilterCondition>
      timestampIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'timestamp',
      ));
    });
  }

  QueryBuilder<EstimateListIsar, EstimateListIsar, QAfterFilterCondition>
      timestampIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'timestamp',
      ));
    });
  }

  QueryBuilder<EstimateListIsar, EstimateListIsar, QAfterFilterCondition>
      timestampEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'timestamp',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EstimateListIsar, EstimateListIsar, QAfterFilterCondition>
      timestampGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'timestamp',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EstimateListIsar, EstimateListIsar, QAfterFilterCondition>
      timestampLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'timestamp',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EstimateListIsar, EstimateListIsar, QAfterFilterCondition>
      timestampBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'timestamp',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EstimateListIsar, EstimateListIsar, QAfterFilterCondition>
      timestampStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'timestamp',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EstimateListIsar, EstimateListIsar, QAfterFilterCondition>
      timestampEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'timestamp',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EstimateListIsar, EstimateListIsar, QAfterFilterCondition>
      timestampContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'timestamp',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EstimateListIsar, EstimateListIsar, QAfterFilterCondition>
      timestampMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'timestamp',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EstimateListIsar, EstimateListIsar, QAfterFilterCondition>
      timestampIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'timestamp',
        value: '',
      ));
    });
  }

  QueryBuilder<EstimateListIsar, EstimateListIsar, QAfterFilterCondition>
      timestampIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'timestamp',
        value: '',
      ));
    });
  }

  QueryBuilder<EstimateListIsar, EstimateListIsar, QAfterFilterCondition>
      updateAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'updateAt',
      ));
    });
  }

  QueryBuilder<EstimateListIsar, EstimateListIsar, QAfterFilterCondition>
      updateAtIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'updateAt',
      ));
    });
  }

  QueryBuilder<EstimateListIsar, EstimateListIsar, QAfterFilterCondition>
      updateAtEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'updateAt',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EstimateListIsar, EstimateListIsar, QAfterFilterCondition>
      updateAtGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'updateAt',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EstimateListIsar, EstimateListIsar, QAfterFilterCondition>
      updateAtLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'updateAt',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EstimateListIsar, EstimateListIsar, QAfterFilterCondition>
      updateAtBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'updateAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EstimateListIsar, EstimateListIsar, QAfterFilterCondition>
      updateAtStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'updateAt',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EstimateListIsar, EstimateListIsar, QAfterFilterCondition>
      updateAtEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'updateAt',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EstimateListIsar, EstimateListIsar, QAfterFilterCondition>
      updateAtContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'updateAt',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EstimateListIsar, EstimateListIsar, QAfterFilterCondition>
      updateAtMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'updateAt',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EstimateListIsar, EstimateListIsar, QAfterFilterCondition>
      updateAtIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'updateAt',
        value: '',
      ));
    });
  }

  QueryBuilder<EstimateListIsar, EstimateListIsar, QAfterFilterCondition>
      updateAtIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'updateAt',
        value: '',
      ));
    });
  }

  QueryBuilder<EstimateListIsar, EstimateListIsar, QAfterFilterCondition>
      vehicleNameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'vehicleName',
      ));
    });
  }

  QueryBuilder<EstimateListIsar, EstimateListIsar, QAfterFilterCondition>
      vehicleNameIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'vehicleName',
      ));
    });
  }

  QueryBuilder<EstimateListIsar, EstimateListIsar, QAfterFilterCondition>
      vehicleNameEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'vehicleName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EstimateListIsar, EstimateListIsar, QAfterFilterCondition>
      vehicleNameGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'vehicleName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EstimateListIsar, EstimateListIsar, QAfterFilterCondition>
      vehicleNameLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'vehicleName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EstimateListIsar, EstimateListIsar, QAfterFilterCondition>
      vehicleNameBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'vehicleName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EstimateListIsar, EstimateListIsar, QAfterFilterCondition>
      vehicleNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'vehicleName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EstimateListIsar, EstimateListIsar, QAfterFilterCondition>
      vehicleNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'vehicleName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EstimateListIsar, EstimateListIsar, QAfterFilterCondition>
      vehicleNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'vehicleName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EstimateListIsar, EstimateListIsar, QAfterFilterCondition>
      vehicleNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'vehicleName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EstimateListIsar, EstimateListIsar, QAfterFilterCondition>
      vehicleNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'vehicleName',
        value: '',
      ));
    });
  }

  QueryBuilder<EstimateListIsar, EstimateListIsar, QAfterFilterCondition>
      vehicleNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'vehicleName',
        value: '',
      ));
    });
  }

  QueryBuilder<EstimateListIsar, EstimateListIsar, QAfterFilterCondition>
      vehicleNumberIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'vehicleNumber',
      ));
    });
  }

  QueryBuilder<EstimateListIsar, EstimateListIsar, QAfterFilterCondition>
      vehicleNumberIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'vehicleNumber',
      ));
    });
  }

  QueryBuilder<EstimateListIsar, EstimateListIsar, QAfterFilterCondition>
      vehicleNumberEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'vehicleNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EstimateListIsar, EstimateListIsar, QAfterFilterCondition>
      vehicleNumberGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'vehicleNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EstimateListIsar, EstimateListIsar, QAfterFilterCondition>
      vehicleNumberLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'vehicleNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EstimateListIsar, EstimateListIsar, QAfterFilterCondition>
      vehicleNumberBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'vehicleNumber',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EstimateListIsar, EstimateListIsar, QAfterFilterCondition>
      vehicleNumberStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'vehicleNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EstimateListIsar, EstimateListIsar, QAfterFilterCondition>
      vehicleNumberEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'vehicleNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EstimateListIsar, EstimateListIsar, QAfterFilterCondition>
      vehicleNumberContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'vehicleNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EstimateListIsar, EstimateListIsar, QAfterFilterCondition>
      vehicleNumberMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'vehicleNumber',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EstimateListIsar, EstimateListIsar, QAfterFilterCondition>
      vehicleNumberIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'vehicleNumber',
        value: '',
      ));
    });
  }

  QueryBuilder<EstimateListIsar, EstimateListIsar, QAfterFilterCondition>
      vehicleNumberIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'vehicleNumber',
        value: '',
      ));
    });
  }
}

extension EstimateListIsarQueryObject
    on QueryBuilder<EstimateListIsar, EstimateListIsar, QFilterCondition> {}

extension EstimateListIsarQueryLinks
    on QueryBuilder<EstimateListIsar, EstimateListIsar, QFilterCondition> {}

extension EstimateListIsarQuerySortBy
    on QueryBuilder<EstimateListIsar, EstimateListIsar, QSortBy> {
  QueryBuilder<EstimateListIsar, EstimateListIsar, QAfterSortBy>
      sortByAddress() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'address', Sort.asc);
    });
  }

  QueryBuilder<EstimateListIsar, EstimateListIsar, QAfterSortBy>
      sortByAddressDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'address', Sort.desc);
    });
  }

  QueryBuilder<EstimateListIsar, EstimateListIsar, QAfterSortBy>
      sortByCreatedAtTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAtTime', Sort.asc);
    });
  }

  QueryBuilder<EstimateListIsar, EstimateListIsar, QAfterSortBy>
      sortByCreatedAtTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAtTime', Sort.desc);
    });
  }

  QueryBuilder<EstimateListIsar, EstimateListIsar, QAfterSortBy>
      sortByDeletedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'deletedAt', Sort.asc);
    });
  }

  QueryBuilder<EstimateListIsar, EstimateListIsar, QAfterSortBy>
      sortByDeletedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'deletedAt', Sort.desc);
    });
  }

  QueryBuilder<EstimateListIsar, EstimateListIsar, QAfterSortBy> sortByEmail() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'email', Sort.asc);
    });
  }

  QueryBuilder<EstimateListIsar, EstimateListIsar, QAfterSortBy>
      sortByEmailDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'email', Sort.desc);
    });
  }

  QueryBuilder<EstimateListIsar, EstimateListIsar, QAfterSortBy>
      sortByEstimateNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'estimateNumber', Sort.asc);
    });
  }

  QueryBuilder<EstimateListIsar, EstimateListIsar, QAfterSortBy>
      sortByEstimateNumberDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'estimateNumber', Sort.desc);
    });
  }

  QueryBuilder<EstimateListIsar, EstimateListIsar, QAfterSortBy>
      sortByEstimateTotal() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'estimateTotal', Sort.asc);
    });
  }

  QueryBuilder<EstimateListIsar, EstimateListIsar, QAfterSortBy>
      sortByEstimateTotalDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'estimateTotal', Sort.desc);
    });
  }

  QueryBuilder<EstimateListIsar, EstimateListIsar, QAfterSortBy> sortByFlag() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'flag', Sort.asc);
    });
  }

  QueryBuilder<EstimateListIsar, EstimateListIsar, QAfterSortBy>
      sortByFlagDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'flag', Sort.desc);
    });
  }

  QueryBuilder<EstimateListIsar, EstimateListIsar, QAfterSortBy>
      sortByFullname() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fullname', Sort.asc);
    });
  }

  QueryBuilder<EstimateListIsar, EstimateListIsar, QAfterSortBy>
      sortByFullnameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fullname', Sort.desc);
    });
  }

  QueryBuilder<EstimateListIsar, EstimateListIsar, QAfterSortBy> sortByKms() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'kms', Sort.asc);
    });
  }

  QueryBuilder<EstimateListIsar, EstimateListIsar, QAfterSortBy>
      sortByKmsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'kms', Sort.desc);
    });
  }

  QueryBuilder<EstimateListIsar, EstimateListIsar, QAfterSortBy>
      sortByManufacturers() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'manufacturers', Sort.asc);
    });
  }

  QueryBuilder<EstimateListIsar, EstimateListIsar, QAfterSortBy>
      sortByManufacturersDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'manufacturers', Sort.desc);
    });
  }

  QueryBuilder<EstimateListIsar, EstimateListIsar, QAfterSortBy>
      sortByMobileNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mobileNumber', Sort.asc);
    });
  }

  QueryBuilder<EstimateListIsar, EstimateListIsar, QAfterSortBy>
      sortByMobileNumberDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mobileNumber', Sort.desc);
    });
  }

  QueryBuilder<EstimateListIsar, EstimateListIsar, QAfterSortBy>
      sortByTempDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tempDate', Sort.asc);
    });
  }

  QueryBuilder<EstimateListIsar, EstimateListIsar, QAfterSortBy>
      sortByTempDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tempDate', Sort.desc);
    });
  }

  QueryBuilder<EstimateListIsar, EstimateListIsar, QAfterSortBy>
      sortByTimestamp() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timestamp', Sort.asc);
    });
  }

  QueryBuilder<EstimateListIsar, EstimateListIsar, QAfterSortBy>
      sortByTimestampDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timestamp', Sort.desc);
    });
  }

  QueryBuilder<EstimateListIsar, EstimateListIsar, QAfterSortBy>
      sortByUpdateAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updateAt', Sort.asc);
    });
  }

  QueryBuilder<EstimateListIsar, EstimateListIsar, QAfterSortBy>
      sortByUpdateAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updateAt', Sort.desc);
    });
  }

  QueryBuilder<EstimateListIsar, EstimateListIsar, QAfterSortBy>
      sortByVehicleName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'vehicleName', Sort.asc);
    });
  }

  QueryBuilder<EstimateListIsar, EstimateListIsar, QAfterSortBy>
      sortByVehicleNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'vehicleName', Sort.desc);
    });
  }

  QueryBuilder<EstimateListIsar, EstimateListIsar, QAfterSortBy>
      sortByVehicleNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'vehicleNumber', Sort.asc);
    });
  }

  QueryBuilder<EstimateListIsar, EstimateListIsar, QAfterSortBy>
      sortByVehicleNumberDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'vehicleNumber', Sort.desc);
    });
  }
}

extension EstimateListIsarQuerySortThenBy
    on QueryBuilder<EstimateListIsar, EstimateListIsar, QSortThenBy> {
  QueryBuilder<EstimateListIsar, EstimateListIsar, QAfterSortBy>
      thenByAddress() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'address', Sort.asc);
    });
  }

  QueryBuilder<EstimateListIsar, EstimateListIsar, QAfterSortBy>
      thenByAddressDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'address', Sort.desc);
    });
  }

  QueryBuilder<EstimateListIsar, EstimateListIsar, QAfterSortBy>
      thenByCreatedAtTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAtTime', Sort.asc);
    });
  }

  QueryBuilder<EstimateListIsar, EstimateListIsar, QAfterSortBy>
      thenByCreatedAtTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAtTime', Sort.desc);
    });
  }

  QueryBuilder<EstimateListIsar, EstimateListIsar, QAfterSortBy>
      thenByDeletedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'deletedAt', Sort.asc);
    });
  }

  QueryBuilder<EstimateListIsar, EstimateListIsar, QAfterSortBy>
      thenByDeletedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'deletedAt', Sort.desc);
    });
  }

  QueryBuilder<EstimateListIsar, EstimateListIsar, QAfterSortBy> thenByEmail() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'email', Sort.asc);
    });
  }

  QueryBuilder<EstimateListIsar, EstimateListIsar, QAfterSortBy>
      thenByEmailDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'email', Sort.desc);
    });
  }

  QueryBuilder<EstimateListIsar, EstimateListIsar, QAfterSortBy>
      thenByEstimateNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'estimateNumber', Sort.asc);
    });
  }

  QueryBuilder<EstimateListIsar, EstimateListIsar, QAfterSortBy>
      thenByEstimateNumberDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'estimateNumber', Sort.desc);
    });
  }

  QueryBuilder<EstimateListIsar, EstimateListIsar, QAfterSortBy>
      thenByEstimateTotal() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'estimateTotal', Sort.asc);
    });
  }

  QueryBuilder<EstimateListIsar, EstimateListIsar, QAfterSortBy>
      thenByEstimateTotalDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'estimateTotal', Sort.desc);
    });
  }

  QueryBuilder<EstimateListIsar, EstimateListIsar, QAfterSortBy> thenByFlag() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'flag', Sort.asc);
    });
  }

  QueryBuilder<EstimateListIsar, EstimateListIsar, QAfterSortBy>
      thenByFlagDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'flag', Sort.desc);
    });
  }

  QueryBuilder<EstimateListIsar, EstimateListIsar, QAfterSortBy>
      thenByFullname() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fullname', Sort.asc);
    });
  }

  QueryBuilder<EstimateListIsar, EstimateListIsar, QAfterSortBy>
      thenByFullnameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fullname', Sort.desc);
    });
  }

  QueryBuilder<EstimateListIsar, EstimateListIsar, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<EstimateListIsar, EstimateListIsar, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<EstimateListIsar, EstimateListIsar, QAfterSortBy> thenByKms() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'kms', Sort.asc);
    });
  }

  QueryBuilder<EstimateListIsar, EstimateListIsar, QAfterSortBy>
      thenByKmsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'kms', Sort.desc);
    });
  }

  QueryBuilder<EstimateListIsar, EstimateListIsar, QAfterSortBy>
      thenByManufacturers() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'manufacturers', Sort.asc);
    });
  }

  QueryBuilder<EstimateListIsar, EstimateListIsar, QAfterSortBy>
      thenByManufacturersDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'manufacturers', Sort.desc);
    });
  }

  QueryBuilder<EstimateListIsar, EstimateListIsar, QAfterSortBy>
      thenByMobileNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mobileNumber', Sort.asc);
    });
  }

  QueryBuilder<EstimateListIsar, EstimateListIsar, QAfterSortBy>
      thenByMobileNumberDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mobileNumber', Sort.desc);
    });
  }

  QueryBuilder<EstimateListIsar, EstimateListIsar, QAfterSortBy>
      thenByTempDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tempDate', Sort.asc);
    });
  }

  QueryBuilder<EstimateListIsar, EstimateListIsar, QAfterSortBy>
      thenByTempDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tempDate', Sort.desc);
    });
  }

  QueryBuilder<EstimateListIsar, EstimateListIsar, QAfterSortBy>
      thenByTimestamp() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timestamp', Sort.asc);
    });
  }

  QueryBuilder<EstimateListIsar, EstimateListIsar, QAfterSortBy>
      thenByTimestampDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timestamp', Sort.desc);
    });
  }

  QueryBuilder<EstimateListIsar, EstimateListIsar, QAfterSortBy>
      thenByUpdateAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updateAt', Sort.asc);
    });
  }

  QueryBuilder<EstimateListIsar, EstimateListIsar, QAfterSortBy>
      thenByUpdateAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updateAt', Sort.desc);
    });
  }

  QueryBuilder<EstimateListIsar, EstimateListIsar, QAfterSortBy>
      thenByVehicleName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'vehicleName', Sort.asc);
    });
  }

  QueryBuilder<EstimateListIsar, EstimateListIsar, QAfterSortBy>
      thenByVehicleNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'vehicleName', Sort.desc);
    });
  }

  QueryBuilder<EstimateListIsar, EstimateListIsar, QAfterSortBy>
      thenByVehicleNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'vehicleNumber', Sort.asc);
    });
  }

  QueryBuilder<EstimateListIsar, EstimateListIsar, QAfterSortBy>
      thenByVehicleNumberDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'vehicleNumber', Sort.desc);
    });
  }
}

extension EstimateListIsarQueryWhereDistinct
    on QueryBuilder<EstimateListIsar, EstimateListIsar, QDistinct> {
  QueryBuilder<EstimateListIsar, EstimateListIsar, QDistinct> distinctByAddress(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'address', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<EstimateListIsar, EstimateListIsar, QDistinct>
      distinctByCreatedAtTime({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'createdAtTime',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<EstimateListIsar, EstimateListIsar, QDistinct>
      distinctByDeletedAt({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'deletedAt', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<EstimateListIsar, EstimateListIsar, QDistinct> distinctByEmail(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'email', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<EstimateListIsar, EstimateListIsar, QDistinct>
      distinctByEstimateNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'estimateNumber');
    });
  }

  QueryBuilder<EstimateListIsar, EstimateListIsar, QDistinct>
      distinctByEstimateTotal({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'estimateTotal',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<EstimateListIsar, EstimateListIsar, QDistinct> distinctByFlag() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'flag');
    });
  }

  QueryBuilder<EstimateListIsar, EstimateListIsar, QDistinct>
      distinctByFullname({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'fullname', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<EstimateListIsar, EstimateListIsar, QDistinct> distinctByKms(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'kms', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<EstimateListIsar, EstimateListIsar, QDistinct>
      distinctByManufacturers({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'manufacturers',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<EstimateListIsar, EstimateListIsar, QDistinct>
      distinctByMobileNumber({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'mobileNumber', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<EstimateListIsar, EstimateListIsar, QDistinct>
      distinctByTempDate({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'tempDate', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<EstimateListIsar, EstimateListIsar, QDistinct>
      distinctByTimestamp({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'timestamp', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<EstimateListIsar, EstimateListIsar, QDistinct>
      distinctByUpdateAt({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'updateAt', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<EstimateListIsar, EstimateListIsar, QDistinct>
      distinctByVehicleName({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'vehicleName', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<EstimateListIsar, EstimateListIsar, QDistinct>
      distinctByVehicleNumber({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'vehicleNumber',
          caseSensitive: caseSensitive);
    });
  }
}

extension EstimateListIsarQueryProperty
    on QueryBuilder<EstimateListIsar, EstimateListIsar, QQueryProperty> {
  QueryBuilder<EstimateListIsar, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<EstimateListIsar, String?, QQueryOperations> addressProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'address');
    });
  }

  QueryBuilder<EstimateListIsar, String?, QQueryOperations>
      createdAtTimeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'createdAtTime');
    });
  }

  QueryBuilder<EstimateListIsar, String?, QQueryOperations>
      deletedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'deletedAt');
    });
  }

  QueryBuilder<EstimateListIsar, String?, QQueryOperations> emailProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'email');
    });
  }

  QueryBuilder<EstimateListIsar, int?, QQueryOperations>
      estimateNumberProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'estimateNumber');
    });
  }

  QueryBuilder<EstimateListIsar, String?, QQueryOperations>
      estimateTotalProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'estimateTotal');
    });
  }

  QueryBuilder<EstimateListIsar, int?, QQueryOperations> flagProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'flag');
    });
  }

  QueryBuilder<EstimateListIsar, String?, QQueryOperations> fullnameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'fullname');
    });
  }

  QueryBuilder<EstimateListIsar, String?, QQueryOperations> kmsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'kms');
    });
  }

  QueryBuilder<EstimateListIsar, String?, QQueryOperations>
      manufacturersProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'manufacturers');
    });
  }

  QueryBuilder<EstimateListIsar, String?, QQueryOperations>
      mobileNumberProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'mobileNumber');
    });
  }

  QueryBuilder<EstimateListIsar, String?, QQueryOperations> tempDateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'tempDate');
    });
  }

  QueryBuilder<EstimateListIsar, String?, QQueryOperations>
      timestampProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'timestamp');
    });
  }

  QueryBuilder<EstimateListIsar, String?, QQueryOperations> updateAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'updateAt');
    });
  }

  QueryBuilder<EstimateListIsar, String?, QQueryOperations>
      vehicleNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'vehicleName');
    });
  }

  QueryBuilder<EstimateListIsar, String?, QQueryOperations>
      vehicleNumberProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'vehicleNumber');
    });
  }
}
