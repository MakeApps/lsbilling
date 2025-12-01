// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'invoice_list_isar.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetInvoiceListIsarCollection on Isar {
  IsarCollection<InvoiceListIsar> get invoiceListIsars => this.collection();
}

const InvoiceListIsarSchema = CollectionSchema(
  name: r'InvoiceListIsar',
  id: 1106178429797326143,
  properties: {
    r'address': PropertySchema(
      id: 0,
      name: r'address',
      type: IsarType.string,
    ),
    r'afterDiscountAmount': PropertySchema(
      id: 1,
      name: r'afterDiscountAmount',
      type: IsarType.string,
    ),
    r'afterPayTotalAmount': PropertySchema(
      id: 2,
      name: r'afterPayTotalAmount',
      type: IsarType.string,
    ),
    r'createdAtTime': PropertySchema(
      id: 3,
      name: r'createdAtTime',
      type: IsarType.string,
    ),
    r'deletedAt': PropertySchema(
      id: 4,
      name: r'deletedAt',
      type: IsarType.string,
    ),
    r'email': PropertySchema(
      id: 5,
      name: r'email',
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
    r'invoiceNumber': PropertySchema(
      id: 8,
      name: r'invoiceNumber',
      type: IsarType.long,
    ),
    r'invoiceTotal': PropertySchema(
      id: 9,
      name: r'invoiceTotal',
      type: IsarType.string,
    ),
    r'manufacturers': PropertySchema(
      id: 10,
      name: r'manufacturers',
      type: IsarType.string,
    ),
    r'mobileNumber': PropertySchema(
      id: 11,
      name: r'mobileNumber',
      type: IsarType.string,
    ),
    r'paidAmount': PropertySchema(
      id: 12,
      name: r'paidAmount',
      type: IsarType.string,
    ),
    r'tempDate': PropertySchema(
      id: 13,
      name: r'tempDate',
      type: IsarType.string,
    ),
    r'timestamp': PropertySchema(
      id: 14,
      name: r'timestamp',
      type: IsarType.long,
    ),
    r'updateAt': PropertySchema(
      id: 15,
      name: r'updateAt',
      type: IsarType.string,
    ),
    r'vehicleName': PropertySchema(
      id: 16,
      name: r'vehicleName',
      type: IsarType.string,
    ),
    r'vehicleNumber': PropertySchema(
      id: 17,
      name: r'vehicleNumber',
      type: IsarType.string,
    )
  },
  estimateSize: _invoiceListIsarEstimateSize,
  serialize: _invoiceListIsarSerialize,
  deserialize: _invoiceListIsarDeserialize,
  deserializeProp: _invoiceListIsarDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _invoiceListIsarGetId,
  getLinks: _invoiceListIsarGetLinks,
  attach: _invoiceListIsarAttach,
  version: '3.3.0-dev.3',
);

int _invoiceListIsarEstimateSize(
  InvoiceListIsar object,
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
    final value = object.afterDiscountAmount;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.afterPayTotalAmount;
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
    final value = object.fullname;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.invoiceTotal;
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
    final value = object.paidAmount;
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

void _invoiceListIsarSerialize(
  InvoiceListIsar object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.address);
  writer.writeString(offsets[1], object.afterDiscountAmount);
  writer.writeString(offsets[2], object.afterPayTotalAmount);
  writer.writeString(offsets[3], object.createdAtTime);
  writer.writeString(offsets[4], object.deletedAt);
  writer.writeString(offsets[5], object.email);
  writer.writeLong(offsets[6], object.flag);
  writer.writeString(offsets[7], object.fullname);
  writer.writeLong(offsets[8], object.invoiceNumber);
  writer.writeString(offsets[9], object.invoiceTotal);
  writer.writeString(offsets[10], object.manufacturers);
  writer.writeString(offsets[11], object.mobileNumber);
  writer.writeString(offsets[12], object.paidAmount);
  writer.writeString(offsets[13], object.tempDate);
  writer.writeLong(offsets[14], object.timestamp);
  writer.writeString(offsets[15], object.updateAt);
  writer.writeString(offsets[16], object.vehicleName);
  writer.writeString(offsets[17], object.vehicleNumber);
}

InvoiceListIsar _invoiceListIsarDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = InvoiceListIsar(
    address: reader.readStringOrNull(offsets[0]),
    afterDiscountAmount: reader.readStringOrNull(offsets[1]),
    afterPayTotalAmount: reader.readStringOrNull(offsets[2]),
    createdAtTime: reader.readStringOrNull(offsets[3]),
    deletedAt: reader.readStringOrNull(offsets[4]),
    email: reader.readStringOrNull(offsets[5]),
    flag: reader.readLongOrNull(offsets[6]),
    fullname: reader.readStringOrNull(offsets[7]),
    id: id,
    invoiceNumber: reader.readLongOrNull(offsets[8]),
    invoiceTotal: reader.readStringOrNull(offsets[9]),
    manufacturers: reader.readStringOrNull(offsets[10]),
    mobileNumber: reader.readStringOrNull(offsets[11]),
    paidAmount: reader.readStringOrNull(offsets[12]),
    tempDate: reader.readStringOrNull(offsets[13]),
    timestamp: reader.readLongOrNull(offsets[14]),
    updateAt: reader.readStringOrNull(offsets[15]),
    vehicleName: reader.readStringOrNull(offsets[16]),
    vehicleNumber: reader.readStringOrNull(offsets[17]),
  );
  return object;
}

P _invoiceListIsarDeserializeProp<P>(
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
      return (reader.readStringOrNull(offset)) as P;
    case 5:
      return (reader.readStringOrNull(offset)) as P;
    case 6:
      return (reader.readLongOrNull(offset)) as P;
    case 7:
      return (reader.readStringOrNull(offset)) as P;
    case 8:
      return (reader.readLongOrNull(offset)) as P;
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
      return (reader.readLongOrNull(offset)) as P;
    case 15:
      return (reader.readStringOrNull(offset)) as P;
    case 16:
      return (reader.readStringOrNull(offset)) as P;
    case 17:
      return (reader.readStringOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _invoiceListIsarGetId(InvoiceListIsar object) {
  return object.id ?? Isar.autoIncrement;
}

List<IsarLinkBase<dynamic>> _invoiceListIsarGetLinks(InvoiceListIsar object) {
  return [];
}

void _invoiceListIsarAttach(
    IsarCollection<dynamic> col, Id id, InvoiceListIsar object) {
  object.id = id;
}

extension InvoiceListIsarQueryWhereSort
    on QueryBuilder<InvoiceListIsar, InvoiceListIsar, QWhere> {
  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension InvoiceListIsarQueryWhere
    on QueryBuilder<InvoiceListIsar, InvoiceListIsar, QWhereClause> {
  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QAfterWhereClause>
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

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QAfterWhereClause> idLessThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QAfterWhereClause> idBetween(
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

extension InvoiceListIsarQueryFilter
    on QueryBuilder<InvoiceListIsar, InvoiceListIsar, QFilterCondition> {
  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QAfterFilterCondition>
      addressIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'address',
      ));
    });
  }

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QAfterFilterCondition>
      addressIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'address',
      ));
    });
  }

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QAfterFilterCondition>
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

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QAfterFilterCondition>
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

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QAfterFilterCondition>
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

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QAfterFilterCondition>
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

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QAfterFilterCondition>
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

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QAfterFilterCondition>
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

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QAfterFilterCondition>
      addressContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'address',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QAfterFilterCondition>
      addressMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'address',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QAfterFilterCondition>
      addressIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'address',
        value: '',
      ));
    });
  }

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QAfterFilterCondition>
      addressIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'address',
        value: '',
      ));
    });
  }

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QAfterFilterCondition>
      afterDiscountAmountIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'afterDiscountAmount',
      ));
    });
  }

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QAfterFilterCondition>
      afterDiscountAmountIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'afterDiscountAmount',
      ));
    });
  }

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QAfterFilterCondition>
      afterDiscountAmountEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'afterDiscountAmount',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QAfterFilterCondition>
      afterDiscountAmountGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'afterDiscountAmount',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QAfterFilterCondition>
      afterDiscountAmountLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'afterDiscountAmount',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QAfterFilterCondition>
      afterDiscountAmountBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'afterDiscountAmount',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QAfterFilterCondition>
      afterDiscountAmountStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'afterDiscountAmount',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QAfterFilterCondition>
      afterDiscountAmountEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'afterDiscountAmount',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QAfterFilterCondition>
      afterDiscountAmountContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'afterDiscountAmount',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QAfterFilterCondition>
      afterDiscountAmountMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'afterDiscountAmount',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QAfterFilterCondition>
      afterDiscountAmountIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'afterDiscountAmount',
        value: '',
      ));
    });
  }

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QAfterFilterCondition>
      afterDiscountAmountIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'afterDiscountAmount',
        value: '',
      ));
    });
  }

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QAfterFilterCondition>
      afterPayTotalAmountIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'afterPayTotalAmount',
      ));
    });
  }

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QAfterFilterCondition>
      afterPayTotalAmountIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'afterPayTotalAmount',
      ));
    });
  }

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QAfterFilterCondition>
      afterPayTotalAmountEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'afterPayTotalAmount',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QAfterFilterCondition>
      afterPayTotalAmountGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'afterPayTotalAmount',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QAfterFilterCondition>
      afterPayTotalAmountLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'afterPayTotalAmount',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QAfterFilterCondition>
      afterPayTotalAmountBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'afterPayTotalAmount',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QAfterFilterCondition>
      afterPayTotalAmountStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'afterPayTotalAmount',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QAfterFilterCondition>
      afterPayTotalAmountEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'afterPayTotalAmount',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QAfterFilterCondition>
      afterPayTotalAmountContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'afterPayTotalAmount',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QAfterFilterCondition>
      afterPayTotalAmountMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'afterPayTotalAmount',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QAfterFilterCondition>
      afterPayTotalAmountIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'afterPayTotalAmount',
        value: '',
      ));
    });
  }

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QAfterFilterCondition>
      afterPayTotalAmountIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'afterPayTotalAmount',
        value: '',
      ));
    });
  }

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QAfterFilterCondition>
      createdAtTimeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'createdAtTime',
      ));
    });
  }

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QAfterFilterCondition>
      createdAtTimeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'createdAtTime',
      ));
    });
  }

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QAfterFilterCondition>
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

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QAfterFilterCondition>
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

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QAfterFilterCondition>
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

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QAfterFilterCondition>
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

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QAfterFilterCondition>
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

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QAfterFilterCondition>
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

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QAfterFilterCondition>
      createdAtTimeContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'createdAtTime',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QAfterFilterCondition>
      createdAtTimeMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'createdAtTime',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QAfterFilterCondition>
      createdAtTimeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'createdAtTime',
        value: '',
      ));
    });
  }

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QAfterFilterCondition>
      createdAtTimeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'createdAtTime',
        value: '',
      ));
    });
  }

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QAfterFilterCondition>
      deletedAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'deletedAt',
      ));
    });
  }

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QAfterFilterCondition>
      deletedAtIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'deletedAt',
      ));
    });
  }

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QAfterFilterCondition>
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

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QAfterFilterCondition>
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

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QAfterFilterCondition>
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

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QAfterFilterCondition>
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

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QAfterFilterCondition>
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

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QAfterFilterCondition>
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

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QAfterFilterCondition>
      deletedAtContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'deletedAt',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QAfterFilterCondition>
      deletedAtMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'deletedAt',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QAfterFilterCondition>
      deletedAtIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'deletedAt',
        value: '',
      ));
    });
  }

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QAfterFilterCondition>
      deletedAtIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'deletedAt',
        value: '',
      ));
    });
  }

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QAfterFilterCondition>
      emailIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'email',
      ));
    });
  }

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QAfterFilterCondition>
      emailIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'email',
      ));
    });
  }

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QAfterFilterCondition>
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

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QAfterFilterCondition>
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

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QAfterFilterCondition>
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

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QAfterFilterCondition>
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

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QAfterFilterCondition>
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

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QAfterFilterCondition>
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

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QAfterFilterCondition>
      emailContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'email',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QAfterFilterCondition>
      emailMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'email',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QAfterFilterCondition>
      emailIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'email',
        value: '',
      ));
    });
  }

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QAfterFilterCondition>
      emailIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'email',
        value: '',
      ));
    });
  }

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QAfterFilterCondition>
      flagIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'flag',
      ));
    });
  }

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QAfterFilterCondition>
      flagIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'flag',
      ));
    });
  }

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QAfterFilterCondition>
      flagEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'flag',
        value: value,
      ));
    });
  }

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QAfterFilterCondition>
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

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QAfterFilterCondition>
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

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QAfterFilterCondition>
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

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QAfterFilterCondition>
      fullnameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'fullname',
      ));
    });
  }

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QAfterFilterCondition>
      fullnameIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'fullname',
      ));
    });
  }

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QAfterFilterCondition>
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

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QAfterFilterCondition>
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

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QAfterFilterCondition>
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

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QAfterFilterCondition>
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

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QAfterFilterCondition>
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

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QAfterFilterCondition>
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

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QAfterFilterCondition>
      fullnameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'fullname',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QAfterFilterCondition>
      fullnameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'fullname',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QAfterFilterCondition>
      fullnameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'fullname',
        value: '',
      ));
    });
  }

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QAfterFilterCondition>
      fullnameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'fullname',
        value: '',
      ));
    });
  }

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QAfterFilterCondition>
      idIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QAfterFilterCondition>
      idIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QAfterFilterCondition>
      idEqualTo(Id? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QAfterFilterCondition>
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

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QAfterFilterCondition>
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

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QAfterFilterCondition>
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

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QAfterFilterCondition>
      invoiceNumberIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'invoiceNumber',
      ));
    });
  }

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QAfterFilterCondition>
      invoiceNumberIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'invoiceNumber',
      ));
    });
  }

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QAfterFilterCondition>
      invoiceNumberEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'invoiceNumber',
        value: value,
      ));
    });
  }

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QAfterFilterCondition>
      invoiceNumberGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'invoiceNumber',
        value: value,
      ));
    });
  }

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QAfterFilterCondition>
      invoiceNumberLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'invoiceNumber',
        value: value,
      ));
    });
  }

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QAfterFilterCondition>
      invoiceNumberBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'invoiceNumber',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QAfterFilterCondition>
      invoiceTotalIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'invoiceTotal',
      ));
    });
  }

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QAfterFilterCondition>
      invoiceTotalIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'invoiceTotal',
      ));
    });
  }

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QAfterFilterCondition>
      invoiceTotalEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'invoiceTotal',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QAfterFilterCondition>
      invoiceTotalGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'invoiceTotal',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QAfterFilterCondition>
      invoiceTotalLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'invoiceTotal',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QAfterFilterCondition>
      invoiceTotalBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'invoiceTotal',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QAfterFilterCondition>
      invoiceTotalStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'invoiceTotal',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QAfterFilterCondition>
      invoiceTotalEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'invoiceTotal',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QAfterFilterCondition>
      invoiceTotalContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'invoiceTotal',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QAfterFilterCondition>
      invoiceTotalMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'invoiceTotal',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QAfterFilterCondition>
      invoiceTotalIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'invoiceTotal',
        value: '',
      ));
    });
  }

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QAfterFilterCondition>
      invoiceTotalIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'invoiceTotal',
        value: '',
      ));
    });
  }

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QAfterFilterCondition>
      manufacturersIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'manufacturers',
      ));
    });
  }

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QAfterFilterCondition>
      manufacturersIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'manufacturers',
      ));
    });
  }

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QAfterFilterCondition>
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

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QAfterFilterCondition>
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

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QAfterFilterCondition>
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

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QAfterFilterCondition>
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

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QAfterFilterCondition>
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

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QAfterFilterCondition>
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

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QAfterFilterCondition>
      manufacturersContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'manufacturers',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QAfterFilterCondition>
      manufacturersMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'manufacturers',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QAfterFilterCondition>
      manufacturersIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'manufacturers',
        value: '',
      ));
    });
  }

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QAfterFilterCondition>
      manufacturersIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'manufacturers',
        value: '',
      ));
    });
  }

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QAfterFilterCondition>
      mobileNumberIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'mobileNumber',
      ));
    });
  }

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QAfterFilterCondition>
      mobileNumberIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'mobileNumber',
      ));
    });
  }

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QAfterFilterCondition>
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

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QAfterFilterCondition>
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

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QAfterFilterCondition>
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

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QAfterFilterCondition>
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

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QAfterFilterCondition>
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

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QAfterFilterCondition>
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

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QAfterFilterCondition>
      mobileNumberContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'mobileNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QAfterFilterCondition>
      mobileNumberMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'mobileNumber',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QAfterFilterCondition>
      mobileNumberIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'mobileNumber',
        value: '',
      ));
    });
  }

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QAfterFilterCondition>
      mobileNumberIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'mobileNumber',
        value: '',
      ));
    });
  }

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QAfterFilterCondition>
      paidAmountIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'paidAmount',
      ));
    });
  }

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QAfterFilterCondition>
      paidAmountIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'paidAmount',
      ));
    });
  }

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QAfterFilterCondition>
      paidAmountEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'paidAmount',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QAfterFilterCondition>
      paidAmountGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'paidAmount',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QAfterFilterCondition>
      paidAmountLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'paidAmount',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QAfterFilterCondition>
      paidAmountBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'paidAmount',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QAfterFilterCondition>
      paidAmountStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'paidAmount',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QAfterFilterCondition>
      paidAmountEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'paidAmount',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QAfterFilterCondition>
      paidAmountContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'paidAmount',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QAfterFilterCondition>
      paidAmountMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'paidAmount',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QAfterFilterCondition>
      paidAmountIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'paidAmount',
        value: '',
      ));
    });
  }

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QAfterFilterCondition>
      paidAmountIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'paidAmount',
        value: '',
      ));
    });
  }

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QAfterFilterCondition>
      tempDateIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'tempDate',
      ));
    });
  }

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QAfterFilterCondition>
      tempDateIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'tempDate',
      ));
    });
  }

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QAfterFilterCondition>
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

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QAfterFilterCondition>
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

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QAfterFilterCondition>
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

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QAfterFilterCondition>
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

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QAfterFilterCondition>
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

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QAfterFilterCondition>
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

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QAfterFilterCondition>
      tempDateContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'tempDate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QAfterFilterCondition>
      tempDateMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'tempDate',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QAfterFilterCondition>
      tempDateIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'tempDate',
        value: '',
      ));
    });
  }

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QAfterFilterCondition>
      tempDateIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'tempDate',
        value: '',
      ));
    });
  }

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QAfterFilterCondition>
      timestampIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'timestamp',
      ));
    });
  }

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QAfterFilterCondition>
      timestampIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'timestamp',
      ));
    });
  }

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QAfterFilterCondition>
      timestampEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'timestamp',
        value: value,
      ));
    });
  }

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QAfterFilterCondition>
      timestampGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'timestamp',
        value: value,
      ));
    });
  }

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QAfterFilterCondition>
      timestampLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'timestamp',
        value: value,
      ));
    });
  }

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QAfterFilterCondition>
      timestampBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'timestamp',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QAfterFilterCondition>
      updateAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'updateAt',
      ));
    });
  }

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QAfterFilterCondition>
      updateAtIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'updateAt',
      ));
    });
  }

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QAfterFilterCondition>
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

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QAfterFilterCondition>
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

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QAfterFilterCondition>
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

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QAfterFilterCondition>
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

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QAfterFilterCondition>
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

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QAfterFilterCondition>
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

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QAfterFilterCondition>
      updateAtContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'updateAt',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QAfterFilterCondition>
      updateAtMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'updateAt',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QAfterFilterCondition>
      updateAtIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'updateAt',
        value: '',
      ));
    });
  }

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QAfterFilterCondition>
      updateAtIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'updateAt',
        value: '',
      ));
    });
  }

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QAfterFilterCondition>
      vehicleNameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'vehicleName',
      ));
    });
  }

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QAfterFilterCondition>
      vehicleNameIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'vehicleName',
      ));
    });
  }

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QAfterFilterCondition>
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

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QAfterFilterCondition>
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

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QAfterFilterCondition>
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

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QAfterFilterCondition>
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

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QAfterFilterCondition>
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

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QAfterFilterCondition>
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

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QAfterFilterCondition>
      vehicleNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'vehicleName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QAfterFilterCondition>
      vehicleNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'vehicleName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QAfterFilterCondition>
      vehicleNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'vehicleName',
        value: '',
      ));
    });
  }

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QAfterFilterCondition>
      vehicleNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'vehicleName',
        value: '',
      ));
    });
  }

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QAfterFilterCondition>
      vehicleNumberIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'vehicleNumber',
      ));
    });
  }

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QAfterFilterCondition>
      vehicleNumberIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'vehicleNumber',
      ));
    });
  }

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QAfterFilterCondition>
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

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QAfterFilterCondition>
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

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QAfterFilterCondition>
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

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QAfterFilterCondition>
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

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QAfterFilterCondition>
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

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QAfterFilterCondition>
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

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QAfterFilterCondition>
      vehicleNumberContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'vehicleNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QAfterFilterCondition>
      vehicleNumberMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'vehicleNumber',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QAfterFilterCondition>
      vehicleNumberIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'vehicleNumber',
        value: '',
      ));
    });
  }

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QAfterFilterCondition>
      vehicleNumberIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'vehicleNumber',
        value: '',
      ));
    });
  }
}

extension InvoiceListIsarQueryObject
    on QueryBuilder<InvoiceListIsar, InvoiceListIsar, QFilterCondition> {}

extension InvoiceListIsarQueryLinks
    on QueryBuilder<InvoiceListIsar, InvoiceListIsar, QFilterCondition> {}

extension InvoiceListIsarQuerySortBy
    on QueryBuilder<InvoiceListIsar, InvoiceListIsar, QSortBy> {
  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QAfterSortBy> sortByAddress() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'address', Sort.asc);
    });
  }

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QAfterSortBy>
      sortByAddressDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'address', Sort.desc);
    });
  }

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QAfterSortBy>
      sortByAfterDiscountAmount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'afterDiscountAmount', Sort.asc);
    });
  }

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QAfterSortBy>
      sortByAfterDiscountAmountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'afterDiscountAmount', Sort.desc);
    });
  }

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QAfterSortBy>
      sortByAfterPayTotalAmount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'afterPayTotalAmount', Sort.asc);
    });
  }

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QAfterSortBy>
      sortByAfterPayTotalAmountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'afterPayTotalAmount', Sort.desc);
    });
  }

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QAfterSortBy>
      sortByCreatedAtTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAtTime', Sort.asc);
    });
  }

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QAfterSortBy>
      sortByCreatedAtTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAtTime', Sort.desc);
    });
  }

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QAfterSortBy>
      sortByDeletedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'deletedAt', Sort.asc);
    });
  }

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QAfterSortBy>
      sortByDeletedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'deletedAt', Sort.desc);
    });
  }

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QAfterSortBy> sortByEmail() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'email', Sort.asc);
    });
  }

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QAfterSortBy>
      sortByEmailDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'email', Sort.desc);
    });
  }

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QAfterSortBy> sortByFlag() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'flag', Sort.asc);
    });
  }

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QAfterSortBy>
      sortByFlagDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'flag', Sort.desc);
    });
  }

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QAfterSortBy>
      sortByFullname() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fullname', Sort.asc);
    });
  }

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QAfterSortBy>
      sortByFullnameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fullname', Sort.desc);
    });
  }

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QAfterSortBy>
      sortByInvoiceNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'invoiceNumber', Sort.asc);
    });
  }

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QAfterSortBy>
      sortByInvoiceNumberDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'invoiceNumber', Sort.desc);
    });
  }

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QAfterSortBy>
      sortByInvoiceTotal() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'invoiceTotal', Sort.asc);
    });
  }

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QAfterSortBy>
      sortByInvoiceTotalDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'invoiceTotal', Sort.desc);
    });
  }

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QAfterSortBy>
      sortByManufacturers() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'manufacturers', Sort.asc);
    });
  }

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QAfterSortBy>
      sortByManufacturersDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'manufacturers', Sort.desc);
    });
  }

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QAfterSortBy>
      sortByMobileNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mobileNumber', Sort.asc);
    });
  }

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QAfterSortBy>
      sortByMobileNumberDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mobileNumber', Sort.desc);
    });
  }

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QAfterSortBy>
      sortByPaidAmount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'paidAmount', Sort.asc);
    });
  }

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QAfterSortBy>
      sortByPaidAmountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'paidAmount', Sort.desc);
    });
  }

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QAfterSortBy>
      sortByTempDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tempDate', Sort.asc);
    });
  }

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QAfterSortBy>
      sortByTempDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tempDate', Sort.desc);
    });
  }

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QAfterSortBy>
      sortByTimestamp() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timestamp', Sort.asc);
    });
  }

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QAfterSortBy>
      sortByTimestampDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timestamp', Sort.desc);
    });
  }

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QAfterSortBy>
      sortByUpdateAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updateAt', Sort.asc);
    });
  }

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QAfterSortBy>
      sortByUpdateAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updateAt', Sort.desc);
    });
  }

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QAfterSortBy>
      sortByVehicleName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'vehicleName', Sort.asc);
    });
  }

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QAfterSortBy>
      sortByVehicleNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'vehicleName', Sort.desc);
    });
  }

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QAfterSortBy>
      sortByVehicleNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'vehicleNumber', Sort.asc);
    });
  }

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QAfterSortBy>
      sortByVehicleNumberDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'vehicleNumber', Sort.desc);
    });
  }
}

extension InvoiceListIsarQuerySortThenBy
    on QueryBuilder<InvoiceListIsar, InvoiceListIsar, QSortThenBy> {
  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QAfterSortBy> thenByAddress() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'address', Sort.asc);
    });
  }

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QAfterSortBy>
      thenByAddressDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'address', Sort.desc);
    });
  }

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QAfterSortBy>
      thenByAfterDiscountAmount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'afterDiscountAmount', Sort.asc);
    });
  }

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QAfterSortBy>
      thenByAfterDiscountAmountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'afterDiscountAmount', Sort.desc);
    });
  }

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QAfterSortBy>
      thenByAfterPayTotalAmount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'afterPayTotalAmount', Sort.asc);
    });
  }

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QAfterSortBy>
      thenByAfterPayTotalAmountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'afterPayTotalAmount', Sort.desc);
    });
  }

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QAfterSortBy>
      thenByCreatedAtTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAtTime', Sort.asc);
    });
  }

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QAfterSortBy>
      thenByCreatedAtTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAtTime', Sort.desc);
    });
  }

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QAfterSortBy>
      thenByDeletedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'deletedAt', Sort.asc);
    });
  }

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QAfterSortBy>
      thenByDeletedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'deletedAt', Sort.desc);
    });
  }

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QAfterSortBy> thenByEmail() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'email', Sort.asc);
    });
  }

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QAfterSortBy>
      thenByEmailDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'email', Sort.desc);
    });
  }

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QAfterSortBy> thenByFlag() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'flag', Sort.asc);
    });
  }

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QAfterSortBy>
      thenByFlagDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'flag', Sort.desc);
    });
  }

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QAfterSortBy>
      thenByFullname() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fullname', Sort.asc);
    });
  }

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QAfterSortBy>
      thenByFullnameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fullname', Sort.desc);
    });
  }

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QAfterSortBy>
      thenByInvoiceNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'invoiceNumber', Sort.asc);
    });
  }

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QAfterSortBy>
      thenByInvoiceNumberDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'invoiceNumber', Sort.desc);
    });
  }

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QAfterSortBy>
      thenByInvoiceTotal() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'invoiceTotal', Sort.asc);
    });
  }

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QAfterSortBy>
      thenByInvoiceTotalDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'invoiceTotal', Sort.desc);
    });
  }

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QAfterSortBy>
      thenByManufacturers() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'manufacturers', Sort.asc);
    });
  }

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QAfterSortBy>
      thenByManufacturersDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'manufacturers', Sort.desc);
    });
  }

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QAfterSortBy>
      thenByMobileNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mobileNumber', Sort.asc);
    });
  }

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QAfterSortBy>
      thenByMobileNumberDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mobileNumber', Sort.desc);
    });
  }

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QAfterSortBy>
      thenByPaidAmount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'paidAmount', Sort.asc);
    });
  }

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QAfterSortBy>
      thenByPaidAmountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'paidAmount', Sort.desc);
    });
  }

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QAfterSortBy>
      thenByTempDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tempDate', Sort.asc);
    });
  }

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QAfterSortBy>
      thenByTempDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tempDate', Sort.desc);
    });
  }

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QAfterSortBy>
      thenByTimestamp() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timestamp', Sort.asc);
    });
  }

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QAfterSortBy>
      thenByTimestampDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timestamp', Sort.desc);
    });
  }

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QAfterSortBy>
      thenByUpdateAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updateAt', Sort.asc);
    });
  }

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QAfterSortBy>
      thenByUpdateAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updateAt', Sort.desc);
    });
  }

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QAfterSortBy>
      thenByVehicleName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'vehicleName', Sort.asc);
    });
  }

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QAfterSortBy>
      thenByVehicleNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'vehicleName', Sort.desc);
    });
  }

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QAfterSortBy>
      thenByVehicleNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'vehicleNumber', Sort.asc);
    });
  }

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QAfterSortBy>
      thenByVehicleNumberDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'vehicleNumber', Sort.desc);
    });
  }
}

extension InvoiceListIsarQueryWhereDistinct
    on QueryBuilder<InvoiceListIsar, InvoiceListIsar, QDistinct> {
  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QDistinct> distinctByAddress(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'address', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QDistinct>
      distinctByAfterDiscountAmount({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'afterDiscountAmount',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QDistinct>
      distinctByAfterPayTotalAmount({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'afterPayTotalAmount',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QDistinct>
      distinctByCreatedAtTime({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'createdAtTime',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QDistinct> distinctByDeletedAt(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'deletedAt', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QDistinct> distinctByEmail(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'email', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QDistinct> distinctByFlag() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'flag');
    });
  }

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QDistinct> distinctByFullname(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'fullname', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QDistinct>
      distinctByInvoiceNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'invoiceNumber');
    });
  }

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QDistinct>
      distinctByInvoiceTotal({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'invoiceTotal', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QDistinct>
      distinctByManufacturers({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'manufacturers',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QDistinct>
      distinctByMobileNumber({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'mobileNumber', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QDistinct>
      distinctByPaidAmount({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'paidAmount', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QDistinct> distinctByTempDate(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'tempDate', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QDistinct>
      distinctByTimestamp() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'timestamp');
    });
  }

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QDistinct> distinctByUpdateAt(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'updateAt', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QDistinct>
      distinctByVehicleName({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'vehicleName', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<InvoiceListIsar, InvoiceListIsar, QDistinct>
      distinctByVehicleNumber({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'vehicleNumber',
          caseSensitive: caseSensitive);
    });
  }
}

extension InvoiceListIsarQueryProperty
    on QueryBuilder<InvoiceListIsar, InvoiceListIsar, QQueryProperty> {
  QueryBuilder<InvoiceListIsar, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<InvoiceListIsar, String?, QQueryOperations> addressProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'address');
    });
  }

  QueryBuilder<InvoiceListIsar, String?, QQueryOperations>
      afterDiscountAmountProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'afterDiscountAmount');
    });
  }

  QueryBuilder<InvoiceListIsar, String?, QQueryOperations>
      afterPayTotalAmountProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'afterPayTotalAmount');
    });
  }

  QueryBuilder<InvoiceListIsar, String?, QQueryOperations>
      createdAtTimeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'createdAtTime');
    });
  }

  QueryBuilder<InvoiceListIsar, String?, QQueryOperations> deletedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'deletedAt');
    });
  }

  QueryBuilder<InvoiceListIsar, String?, QQueryOperations> emailProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'email');
    });
  }

  QueryBuilder<InvoiceListIsar, int?, QQueryOperations> flagProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'flag');
    });
  }

  QueryBuilder<InvoiceListIsar, String?, QQueryOperations> fullnameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'fullname');
    });
  }

  QueryBuilder<InvoiceListIsar, int?, QQueryOperations>
      invoiceNumberProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'invoiceNumber');
    });
  }

  QueryBuilder<InvoiceListIsar, String?, QQueryOperations>
      invoiceTotalProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'invoiceTotal');
    });
  }

  QueryBuilder<InvoiceListIsar, String?, QQueryOperations>
      manufacturersProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'manufacturers');
    });
  }

  QueryBuilder<InvoiceListIsar, String?, QQueryOperations>
      mobileNumberProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'mobileNumber');
    });
  }

  QueryBuilder<InvoiceListIsar, String?, QQueryOperations>
      paidAmountProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'paidAmount');
    });
  }

  QueryBuilder<InvoiceListIsar, String?, QQueryOperations> tempDateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'tempDate');
    });
  }

  QueryBuilder<InvoiceListIsar, int?, QQueryOperations> timestampProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'timestamp');
    });
  }

  QueryBuilder<InvoiceListIsar, String?, QQueryOperations> updateAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'updateAt');
    });
  }

  QueryBuilder<InvoiceListIsar, String?, QQueryOperations>
      vehicleNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'vehicleName');
    });
  }

  QueryBuilder<InvoiceListIsar, String?, QQueryOperations>
      vehicleNumberProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'vehicleNumber');
    });
  }
}
