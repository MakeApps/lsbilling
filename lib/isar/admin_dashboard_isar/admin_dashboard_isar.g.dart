// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin_dashboard_isar.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetDashboardIsarCollection on Isar {
  IsarCollection<DashboardIsar> get dashboardIsars => this.collection();
}

const DashboardIsarSchema = CollectionSchema(
  name: r'DashboardIsar',
  id: 1955251364536140426,
  properties: {
    r'customerCountFilter': PropertySchema(
      id: 0,
      name: r'customerCountFilter',
      type: IsarType.long,
    ),
    r'delivered': PropertySchema(
      id: 1,
      name: r'delivered',
      type: IsarType.long,
    ),
    r'estimateCountFilter': PropertySchema(
      id: 2,
      name: r'estimateCountFilter',
      type: IsarType.long,
    ),
    r'invoiceCountFilter': PropertySchema(
      id: 3,
      name: r'invoiceCountFilter',
      type: IsarType.long,
    ),
    r'jobcardCountFilter': PropertySchema(
      id: 4,
      name: r'jobcardCountFilter',
      type: IsarType.long,
    ),
    r'newEntries': PropertySchema(
      id: 5,
      name: r'newEntries',
      type: IsarType.long,
    ),
    r'totalCustomer': PropertySchema(
      id: 6,
      name: r'totalCustomer',
      type: IsarType.long,
    ),
    r'totalEstimate': PropertySchema(
      id: 7,
      name: r'totalEstimate',
      type: IsarType.long,
    ),
    r'totalInvoice': PropertySchema(
      id: 8,
      name: r'totalInvoice',
      type: IsarType.long,
    ),
    r'totalLabour': PropertySchema(
      id: 9,
      name: r'totalLabour',
      type: IsarType.long,
    ),
    r'totalMechanic': PropertySchema(
      id: 10,
      name: r'totalMechanic',
      type: IsarType.long,
    ),
    r'totalOutstanding': PropertySchema(
      id: 11,
      name: r'totalOutstanding',
      type: IsarType.long,
    ),
    r'totalProduct': PropertySchema(
      id: 12,
      name: r'totalProduct',
      type: IsarType.long,
    ),
    r'totalRepair': PropertySchema(
      id: 13,
      name: r'totalRepair',
      type: IsarType.long,
    ),
    r'totalRevenue': PropertySchema(
      id: 14,
      name: r'totalRevenue',
      type: IsarType.long,
    ),
    r'totalSparePart': PropertySchema(
      id: 15,
      name: r'totalSparePart',
      type: IsarType.long,
    ),
    r'totalVehicle': PropertySchema(
      id: 16,
      name: r'totalVehicle',
      type: IsarType.long,
    ),
    r'userCount': PropertySchema(
      id: 17,
      name: r'userCount',
      type: IsarType.long,
    )
  },
  estimateSize: _dashboardIsarEstimateSize,
  serialize: _dashboardIsarSerialize,
  deserialize: _dashboardIsarDeserialize,
  deserializeProp: _dashboardIsarDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _dashboardIsarGetId,
  getLinks: _dashboardIsarGetLinks,
  attach: _dashboardIsarAttach,
  version: '3.3.0-dev.3',
);

int _dashboardIsarEstimateSize(
  DashboardIsar object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  return bytesCount;
}

void _dashboardIsarSerialize(
  DashboardIsar object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.customerCountFilter);
  writer.writeLong(offsets[1], object.delivered);
  writer.writeLong(offsets[2], object.estimateCountFilter);
  writer.writeLong(offsets[3], object.invoiceCountFilter);
  writer.writeLong(offsets[4], object.jobcardCountFilter);
  writer.writeLong(offsets[5], object.newEntries);
  writer.writeLong(offsets[6], object.totalCustomer);
  writer.writeLong(offsets[7], object.totalEstimate);
  writer.writeLong(offsets[8], object.totalInvoice);
  writer.writeLong(offsets[9], object.totalLabour);
  writer.writeLong(offsets[10], object.totalMechanic);
  writer.writeLong(offsets[11], object.totalOutstanding);
  writer.writeLong(offsets[12], object.totalProduct);
  writer.writeLong(offsets[13], object.totalRepair);
  writer.writeLong(offsets[14], object.totalRevenue);
  writer.writeLong(offsets[15], object.totalSparePart);
  writer.writeLong(offsets[16], object.totalVehicle);
  writer.writeLong(offsets[17], object.userCount);
}

DashboardIsar _dashboardIsarDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = DashboardIsar(
    customerCountFilter: reader.readLongOrNull(offsets[0]) ?? 0,
    delivered: reader.readLongOrNull(offsets[1]) ?? 0,
    estimateCountFilter: reader.readLongOrNull(offsets[2]) ?? 0,
    id: id,
    invoiceCountFilter: reader.readLongOrNull(offsets[3]) ?? 0,
    jobcardCountFilter: reader.readLongOrNull(offsets[4]) ?? 0,
    newEntries: reader.readLongOrNull(offsets[5]) ?? 0,
    totalCustomer: reader.readLongOrNull(offsets[6]) ?? 0,
    totalEstimate: reader.readLongOrNull(offsets[7]) ?? 0,
    totalInvoice: reader.readLongOrNull(offsets[8]) ?? 0,
    totalLabour: reader.readLongOrNull(offsets[9]) ?? 0,
    totalMechanic: reader.readLongOrNull(offsets[10]) ?? 0,
    totalOutstanding: reader.readLongOrNull(offsets[11]) ?? 0,
    totalProduct: reader.readLongOrNull(offsets[12]) ?? 0,
    totalRepair: reader.readLongOrNull(offsets[13]) ?? 0,
    totalRevenue: reader.readLongOrNull(offsets[14]) ?? 0,
    totalSparePart: reader.readLongOrNull(offsets[15]) ?? 0,
    totalVehicle: reader.readLongOrNull(offsets[16]) ?? 0,
    userCount: reader.readLongOrNull(offsets[17]) ?? 0,
  );
  return object;
}

P _dashboardIsarDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLongOrNull(offset) ?? 0) as P;
    case 1:
      return (reader.readLongOrNull(offset) ?? 0) as P;
    case 2:
      return (reader.readLongOrNull(offset) ?? 0) as P;
    case 3:
      return (reader.readLongOrNull(offset) ?? 0) as P;
    case 4:
      return (reader.readLongOrNull(offset) ?? 0) as P;
    case 5:
      return (reader.readLongOrNull(offset) ?? 0) as P;
    case 6:
      return (reader.readLongOrNull(offset) ?? 0) as P;
    case 7:
      return (reader.readLongOrNull(offset) ?? 0) as P;
    case 8:
      return (reader.readLongOrNull(offset) ?? 0) as P;
    case 9:
      return (reader.readLongOrNull(offset) ?? 0) as P;
    case 10:
      return (reader.readLongOrNull(offset) ?? 0) as P;
    case 11:
      return (reader.readLongOrNull(offset) ?? 0) as P;
    case 12:
      return (reader.readLongOrNull(offset) ?? 0) as P;
    case 13:
      return (reader.readLongOrNull(offset) ?? 0) as P;
    case 14:
      return (reader.readLongOrNull(offset) ?? 0) as P;
    case 15:
      return (reader.readLongOrNull(offset) ?? 0) as P;
    case 16:
      return (reader.readLongOrNull(offset) ?? 0) as P;
    case 17:
      return (reader.readLongOrNull(offset) ?? 0) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _dashboardIsarGetId(DashboardIsar object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _dashboardIsarGetLinks(DashboardIsar object) {
  return [];
}

void _dashboardIsarAttach(
    IsarCollection<dynamic> col, Id id, DashboardIsar object) {
  object.id = id;
}

extension DashboardIsarQueryWhereSort
    on QueryBuilder<DashboardIsar, DashboardIsar, QWhere> {
  QueryBuilder<DashboardIsar, DashboardIsar, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension DashboardIsarQueryWhere
    on QueryBuilder<DashboardIsar, DashboardIsar, QWhereClause> {
  QueryBuilder<DashboardIsar, DashboardIsar, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<DashboardIsar, DashboardIsar, QAfterWhereClause> idNotEqualTo(
      Id id) {
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

  QueryBuilder<DashboardIsar, DashboardIsar, QAfterWhereClause> idGreaterThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<DashboardIsar, DashboardIsar, QAfterWhereClause> idLessThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<DashboardIsar, DashboardIsar, QAfterWhereClause> idBetween(
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

extension DashboardIsarQueryFilter
    on QueryBuilder<DashboardIsar, DashboardIsar, QFilterCondition> {
  QueryBuilder<DashboardIsar, DashboardIsar, QAfterFilterCondition>
      customerCountFilterEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'customerCountFilter',
        value: value,
      ));
    });
  }

  QueryBuilder<DashboardIsar, DashboardIsar, QAfterFilterCondition>
      customerCountFilterGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'customerCountFilter',
        value: value,
      ));
    });
  }

  QueryBuilder<DashboardIsar, DashboardIsar, QAfterFilterCondition>
      customerCountFilterLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'customerCountFilter',
        value: value,
      ));
    });
  }

  QueryBuilder<DashboardIsar, DashboardIsar, QAfterFilterCondition>
      customerCountFilterBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'customerCountFilter',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<DashboardIsar, DashboardIsar, QAfterFilterCondition>
      deliveredEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'delivered',
        value: value,
      ));
    });
  }

  QueryBuilder<DashboardIsar, DashboardIsar, QAfterFilterCondition>
      deliveredGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'delivered',
        value: value,
      ));
    });
  }

  QueryBuilder<DashboardIsar, DashboardIsar, QAfterFilterCondition>
      deliveredLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'delivered',
        value: value,
      ));
    });
  }

  QueryBuilder<DashboardIsar, DashboardIsar, QAfterFilterCondition>
      deliveredBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'delivered',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<DashboardIsar, DashboardIsar, QAfterFilterCondition>
      estimateCountFilterEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'estimateCountFilter',
        value: value,
      ));
    });
  }

  QueryBuilder<DashboardIsar, DashboardIsar, QAfterFilterCondition>
      estimateCountFilterGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'estimateCountFilter',
        value: value,
      ));
    });
  }

  QueryBuilder<DashboardIsar, DashboardIsar, QAfterFilterCondition>
      estimateCountFilterLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'estimateCountFilter',
        value: value,
      ));
    });
  }

  QueryBuilder<DashboardIsar, DashboardIsar, QAfterFilterCondition>
      estimateCountFilterBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'estimateCountFilter',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<DashboardIsar, DashboardIsar, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<DashboardIsar, DashboardIsar, QAfterFilterCondition>
      idGreaterThan(
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

  QueryBuilder<DashboardIsar, DashboardIsar, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<DashboardIsar, DashboardIsar, QAfterFilterCondition> idBetween(
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

  QueryBuilder<DashboardIsar, DashboardIsar, QAfterFilterCondition>
      invoiceCountFilterEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'invoiceCountFilter',
        value: value,
      ));
    });
  }

  QueryBuilder<DashboardIsar, DashboardIsar, QAfterFilterCondition>
      invoiceCountFilterGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'invoiceCountFilter',
        value: value,
      ));
    });
  }

  QueryBuilder<DashboardIsar, DashboardIsar, QAfterFilterCondition>
      invoiceCountFilterLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'invoiceCountFilter',
        value: value,
      ));
    });
  }

  QueryBuilder<DashboardIsar, DashboardIsar, QAfterFilterCondition>
      invoiceCountFilterBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'invoiceCountFilter',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<DashboardIsar, DashboardIsar, QAfterFilterCondition>
      jobcardCountFilterEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'jobcardCountFilter',
        value: value,
      ));
    });
  }

  QueryBuilder<DashboardIsar, DashboardIsar, QAfterFilterCondition>
      jobcardCountFilterGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'jobcardCountFilter',
        value: value,
      ));
    });
  }

  QueryBuilder<DashboardIsar, DashboardIsar, QAfterFilterCondition>
      jobcardCountFilterLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'jobcardCountFilter',
        value: value,
      ));
    });
  }

  QueryBuilder<DashboardIsar, DashboardIsar, QAfterFilterCondition>
      jobcardCountFilterBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'jobcardCountFilter',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<DashboardIsar, DashboardIsar, QAfterFilterCondition>
      newEntriesEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'newEntries',
        value: value,
      ));
    });
  }

  QueryBuilder<DashboardIsar, DashboardIsar, QAfterFilterCondition>
      newEntriesGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'newEntries',
        value: value,
      ));
    });
  }

  QueryBuilder<DashboardIsar, DashboardIsar, QAfterFilterCondition>
      newEntriesLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'newEntries',
        value: value,
      ));
    });
  }

  QueryBuilder<DashboardIsar, DashboardIsar, QAfterFilterCondition>
      newEntriesBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'newEntries',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<DashboardIsar, DashboardIsar, QAfterFilterCondition>
      totalCustomerEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'totalCustomer',
        value: value,
      ));
    });
  }

  QueryBuilder<DashboardIsar, DashboardIsar, QAfterFilterCondition>
      totalCustomerGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'totalCustomer',
        value: value,
      ));
    });
  }

  QueryBuilder<DashboardIsar, DashboardIsar, QAfterFilterCondition>
      totalCustomerLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'totalCustomer',
        value: value,
      ));
    });
  }

  QueryBuilder<DashboardIsar, DashboardIsar, QAfterFilterCondition>
      totalCustomerBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'totalCustomer',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<DashboardIsar, DashboardIsar, QAfterFilterCondition>
      totalEstimateEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'totalEstimate',
        value: value,
      ));
    });
  }

  QueryBuilder<DashboardIsar, DashboardIsar, QAfterFilterCondition>
      totalEstimateGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'totalEstimate',
        value: value,
      ));
    });
  }

  QueryBuilder<DashboardIsar, DashboardIsar, QAfterFilterCondition>
      totalEstimateLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'totalEstimate',
        value: value,
      ));
    });
  }

  QueryBuilder<DashboardIsar, DashboardIsar, QAfterFilterCondition>
      totalEstimateBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'totalEstimate',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<DashboardIsar, DashboardIsar, QAfterFilterCondition>
      totalInvoiceEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'totalInvoice',
        value: value,
      ));
    });
  }

  QueryBuilder<DashboardIsar, DashboardIsar, QAfterFilterCondition>
      totalInvoiceGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'totalInvoice',
        value: value,
      ));
    });
  }

  QueryBuilder<DashboardIsar, DashboardIsar, QAfterFilterCondition>
      totalInvoiceLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'totalInvoice',
        value: value,
      ));
    });
  }

  QueryBuilder<DashboardIsar, DashboardIsar, QAfterFilterCondition>
      totalInvoiceBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'totalInvoice',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<DashboardIsar, DashboardIsar, QAfterFilterCondition>
      totalLabourEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'totalLabour',
        value: value,
      ));
    });
  }

  QueryBuilder<DashboardIsar, DashboardIsar, QAfterFilterCondition>
      totalLabourGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'totalLabour',
        value: value,
      ));
    });
  }

  QueryBuilder<DashboardIsar, DashboardIsar, QAfterFilterCondition>
      totalLabourLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'totalLabour',
        value: value,
      ));
    });
  }

  QueryBuilder<DashboardIsar, DashboardIsar, QAfterFilterCondition>
      totalLabourBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'totalLabour',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<DashboardIsar, DashboardIsar, QAfterFilterCondition>
      totalMechanicEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'totalMechanic',
        value: value,
      ));
    });
  }

  QueryBuilder<DashboardIsar, DashboardIsar, QAfterFilterCondition>
      totalMechanicGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'totalMechanic',
        value: value,
      ));
    });
  }

  QueryBuilder<DashboardIsar, DashboardIsar, QAfterFilterCondition>
      totalMechanicLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'totalMechanic',
        value: value,
      ));
    });
  }

  QueryBuilder<DashboardIsar, DashboardIsar, QAfterFilterCondition>
      totalMechanicBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'totalMechanic',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<DashboardIsar, DashboardIsar, QAfterFilterCondition>
      totalOutstandingEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'totalOutstanding',
        value: value,
      ));
    });
  }

  QueryBuilder<DashboardIsar, DashboardIsar, QAfterFilterCondition>
      totalOutstandingGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'totalOutstanding',
        value: value,
      ));
    });
  }

  QueryBuilder<DashboardIsar, DashboardIsar, QAfterFilterCondition>
      totalOutstandingLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'totalOutstanding',
        value: value,
      ));
    });
  }

  QueryBuilder<DashboardIsar, DashboardIsar, QAfterFilterCondition>
      totalOutstandingBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'totalOutstanding',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<DashboardIsar, DashboardIsar, QAfterFilterCondition>
      totalProductEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'totalProduct',
        value: value,
      ));
    });
  }

  QueryBuilder<DashboardIsar, DashboardIsar, QAfterFilterCondition>
      totalProductGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'totalProduct',
        value: value,
      ));
    });
  }

  QueryBuilder<DashboardIsar, DashboardIsar, QAfterFilterCondition>
      totalProductLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'totalProduct',
        value: value,
      ));
    });
  }

  QueryBuilder<DashboardIsar, DashboardIsar, QAfterFilterCondition>
      totalProductBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'totalProduct',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<DashboardIsar, DashboardIsar, QAfterFilterCondition>
      totalRepairEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'totalRepair',
        value: value,
      ));
    });
  }

  QueryBuilder<DashboardIsar, DashboardIsar, QAfterFilterCondition>
      totalRepairGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'totalRepair',
        value: value,
      ));
    });
  }

  QueryBuilder<DashboardIsar, DashboardIsar, QAfterFilterCondition>
      totalRepairLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'totalRepair',
        value: value,
      ));
    });
  }

  QueryBuilder<DashboardIsar, DashboardIsar, QAfterFilterCondition>
      totalRepairBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'totalRepair',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<DashboardIsar, DashboardIsar, QAfterFilterCondition>
      totalRevenueEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'totalRevenue',
        value: value,
      ));
    });
  }

  QueryBuilder<DashboardIsar, DashboardIsar, QAfterFilterCondition>
      totalRevenueGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'totalRevenue',
        value: value,
      ));
    });
  }

  QueryBuilder<DashboardIsar, DashboardIsar, QAfterFilterCondition>
      totalRevenueLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'totalRevenue',
        value: value,
      ));
    });
  }

  QueryBuilder<DashboardIsar, DashboardIsar, QAfterFilterCondition>
      totalRevenueBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'totalRevenue',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<DashboardIsar, DashboardIsar, QAfterFilterCondition>
      totalSparePartEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'totalSparePart',
        value: value,
      ));
    });
  }

  QueryBuilder<DashboardIsar, DashboardIsar, QAfterFilterCondition>
      totalSparePartGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'totalSparePart',
        value: value,
      ));
    });
  }

  QueryBuilder<DashboardIsar, DashboardIsar, QAfterFilterCondition>
      totalSparePartLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'totalSparePart',
        value: value,
      ));
    });
  }

  QueryBuilder<DashboardIsar, DashboardIsar, QAfterFilterCondition>
      totalSparePartBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'totalSparePart',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<DashboardIsar, DashboardIsar, QAfterFilterCondition>
      totalVehicleEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'totalVehicle',
        value: value,
      ));
    });
  }

  QueryBuilder<DashboardIsar, DashboardIsar, QAfterFilterCondition>
      totalVehicleGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'totalVehicle',
        value: value,
      ));
    });
  }

  QueryBuilder<DashboardIsar, DashboardIsar, QAfterFilterCondition>
      totalVehicleLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'totalVehicle',
        value: value,
      ));
    });
  }

  QueryBuilder<DashboardIsar, DashboardIsar, QAfterFilterCondition>
      totalVehicleBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'totalVehicle',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<DashboardIsar, DashboardIsar, QAfterFilterCondition>
      userCountEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'userCount',
        value: value,
      ));
    });
  }

  QueryBuilder<DashboardIsar, DashboardIsar, QAfterFilterCondition>
      userCountGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'userCount',
        value: value,
      ));
    });
  }

  QueryBuilder<DashboardIsar, DashboardIsar, QAfterFilterCondition>
      userCountLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'userCount',
        value: value,
      ));
    });
  }

  QueryBuilder<DashboardIsar, DashboardIsar, QAfterFilterCondition>
      userCountBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'userCount',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension DashboardIsarQueryObject
    on QueryBuilder<DashboardIsar, DashboardIsar, QFilterCondition> {}

extension DashboardIsarQueryLinks
    on QueryBuilder<DashboardIsar, DashboardIsar, QFilterCondition> {}

extension DashboardIsarQuerySortBy
    on QueryBuilder<DashboardIsar, DashboardIsar, QSortBy> {
  QueryBuilder<DashboardIsar, DashboardIsar, QAfterSortBy>
      sortByCustomerCountFilter() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'customerCountFilter', Sort.asc);
    });
  }

  QueryBuilder<DashboardIsar, DashboardIsar, QAfterSortBy>
      sortByCustomerCountFilterDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'customerCountFilter', Sort.desc);
    });
  }

  QueryBuilder<DashboardIsar, DashboardIsar, QAfterSortBy> sortByDelivered() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'delivered', Sort.asc);
    });
  }

  QueryBuilder<DashboardIsar, DashboardIsar, QAfterSortBy>
      sortByDeliveredDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'delivered', Sort.desc);
    });
  }

  QueryBuilder<DashboardIsar, DashboardIsar, QAfterSortBy>
      sortByEstimateCountFilter() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'estimateCountFilter', Sort.asc);
    });
  }

  QueryBuilder<DashboardIsar, DashboardIsar, QAfterSortBy>
      sortByEstimateCountFilterDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'estimateCountFilter', Sort.desc);
    });
  }

  QueryBuilder<DashboardIsar, DashboardIsar, QAfterSortBy>
      sortByInvoiceCountFilter() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'invoiceCountFilter', Sort.asc);
    });
  }

  QueryBuilder<DashboardIsar, DashboardIsar, QAfterSortBy>
      sortByInvoiceCountFilterDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'invoiceCountFilter', Sort.desc);
    });
  }

  QueryBuilder<DashboardIsar, DashboardIsar, QAfterSortBy>
      sortByJobcardCountFilter() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'jobcardCountFilter', Sort.asc);
    });
  }

  QueryBuilder<DashboardIsar, DashboardIsar, QAfterSortBy>
      sortByJobcardCountFilterDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'jobcardCountFilter', Sort.desc);
    });
  }

  QueryBuilder<DashboardIsar, DashboardIsar, QAfterSortBy> sortByNewEntries() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'newEntries', Sort.asc);
    });
  }

  QueryBuilder<DashboardIsar, DashboardIsar, QAfterSortBy>
      sortByNewEntriesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'newEntries', Sort.desc);
    });
  }

  QueryBuilder<DashboardIsar, DashboardIsar, QAfterSortBy>
      sortByTotalCustomer() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalCustomer', Sort.asc);
    });
  }

  QueryBuilder<DashboardIsar, DashboardIsar, QAfterSortBy>
      sortByTotalCustomerDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalCustomer', Sort.desc);
    });
  }

  QueryBuilder<DashboardIsar, DashboardIsar, QAfterSortBy>
      sortByTotalEstimate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalEstimate', Sort.asc);
    });
  }

  QueryBuilder<DashboardIsar, DashboardIsar, QAfterSortBy>
      sortByTotalEstimateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalEstimate', Sort.desc);
    });
  }

  QueryBuilder<DashboardIsar, DashboardIsar, QAfterSortBy>
      sortByTotalInvoice() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalInvoice', Sort.asc);
    });
  }

  QueryBuilder<DashboardIsar, DashboardIsar, QAfterSortBy>
      sortByTotalInvoiceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalInvoice', Sort.desc);
    });
  }

  QueryBuilder<DashboardIsar, DashboardIsar, QAfterSortBy> sortByTotalLabour() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalLabour', Sort.asc);
    });
  }

  QueryBuilder<DashboardIsar, DashboardIsar, QAfterSortBy>
      sortByTotalLabourDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalLabour', Sort.desc);
    });
  }

  QueryBuilder<DashboardIsar, DashboardIsar, QAfterSortBy>
      sortByTotalMechanic() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalMechanic', Sort.asc);
    });
  }

  QueryBuilder<DashboardIsar, DashboardIsar, QAfterSortBy>
      sortByTotalMechanicDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalMechanic', Sort.desc);
    });
  }

  QueryBuilder<DashboardIsar, DashboardIsar, QAfterSortBy>
      sortByTotalOutstanding() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalOutstanding', Sort.asc);
    });
  }

  QueryBuilder<DashboardIsar, DashboardIsar, QAfterSortBy>
      sortByTotalOutstandingDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalOutstanding', Sort.desc);
    });
  }

  QueryBuilder<DashboardIsar, DashboardIsar, QAfterSortBy>
      sortByTotalProduct() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalProduct', Sort.asc);
    });
  }

  QueryBuilder<DashboardIsar, DashboardIsar, QAfterSortBy>
      sortByTotalProductDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalProduct', Sort.desc);
    });
  }

  QueryBuilder<DashboardIsar, DashboardIsar, QAfterSortBy> sortByTotalRepair() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalRepair', Sort.asc);
    });
  }

  QueryBuilder<DashboardIsar, DashboardIsar, QAfterSortBy>
      sortByTotalRepairDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalRepair', Sort.desc);
    });
  }

  QueryBuilder<DashboardIsar, DashboardIsar, QAfterSortBy>
      sortByTotalRevenue() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalRevenue', Sort.asc);
    });
  }

  QueryBuilder<DashboardIsar, DashboardIsar, QAfterSortBy>
      sortByTotalRevenueDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalRevenue', Sort.desc);
    });
  }

  QueryBuilder<DashboardIsar, DashboardIsar, QAfterSortBy>
      sortByTotalSparePart() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalSparePart', Sort.asc);
    });
  }

  QueryBuilder<DashboardIsar, DashboardIsar, QAfterSortBy>
      sortByTotalSparePartDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalSparePart', Sort.desc);
    });
  }

  QueryBuilder<DashboardIsar, DashboardIsar, QAfterSortBy>
      sortByTotalVehicle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalVehicle', Sort.asc);
    });
  }

  QueryBuilder<DashboardIsar, DashboardIsar, QAfterSortBy>
      sortByTotalVehicleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalVehicle', Sort.desc);
    });
  }

  QueryBuilder<DashboardIsar, DashboardIsar, QAfterSortBy> sortByUserCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userCount', Sort.asc);
    });
  }

  QueryBuilder<DashboardIsar, DashboardIsar, QAfterSortBy>
      sortByUserCountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userCount', Sort.desc);
    });
  }
}

extension DashboardIsarQuerySortThenBy
    on QueryBuilder<DashboardIsar, DashboardIsar, QSortThenBy> {
  QueryBuilder<DashboardIsar, DashboardIsar, QAfterSortBy>
      thenByCustomerCountFilter() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'customerCountFilter', Sort.asc);
    });
  }

  QueryBuilder<DashboardIsar, DashboardIsar, QAfterSortBy>
      thenByCustomerCountFilterDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'customerCountFilter', Sort.desc);
    });
  }

  QueryBuilder<DashboardIsar, DashboardIsar, QAfterSortBy> thenByDelivered() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'delivered', Sort.asc);
    });
  }

  QueryBuilder<DashboardIsar, DashboardIsar, QAfterSortBy>
      thenByDeliveredDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'delivered', Sort.desc);
    });
  }

  QueryBuilder<DashboardIsar, DashboardIsar, QAfterSortBy>
      thenByEstimateCountFilter() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'estimateCountFilter', Sort.asc);
    });
  }

  QueryBuilder<DashboardIsar, DashboardIsar, QAfterSortBy>
      thenByEstimateCountFilterDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'estimateCountFilter', Sort.desc);
    });
  }

  QueryBuilder<DashboardIsar, DashboardIsar, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<DashboardIsar, DashboardIsar, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<DashboardIsar, DashboardIsar, QAfterSortBy>
      thenByInvoiceCountFilter() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'invoiceCountFilter', Sort.asc);
    });
  }

  QueryBuilder<DashboardIsar, DashboardIsar, QAfterSortBy>
      thenByInvoiceCountFilterDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'invoiceCountFilter', Sort.desc);
    });
  }

  QueryBuilder<DashboardIsar, DashboardIsar, QAfterSortBy>
      thenByJobcardCountFilter() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'jobcardCountFilter', Sort.asc);
    });
  }

  QueryBuilder<DashboardIsar, DashboardIsar, QAfterSortBy>
      thenByJobcardCountFilterDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'jobcardCountFilter', Sort.desc);
    });
  }

  QueryBuilder<DashboardIsar, DashboardIsar, QAfterSortBy> thenByNewEntries() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'newEntries', Sort.asc);
    });
  }

  QueryBuilder<DashboardIsar, DashboardIsar, QAfterSortBy>
      thenByNewEntriesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'newEntries', Sort.desc);
    });
  }

  QueryBuilder<DashboardIsar, DashboardIsar, QAfterSortBy>
      thenByTotalCustomer() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalCustomer', Sort.asc);
    });
  }

  QueryBuilder<DashboardIsar, DashboardIsar, QAfterSortBy>
      thenByTotalCustomerDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalCustomer', Sort.desc);
    });
  }

  QueryBuilder<DashboardIsar, DashboardIsar, QAfterSortBy>
      thenByTotalEstimate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalEstimate', Sort.asc);
    });
  }

  QueryBuilder<DashboardIsar, DashboardIsar, QAfterSortBy>
      thenByTotalEstimateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalEstimate', Sort.desc);
    });
  }

  QueryBuilder<DashboardIsar, DashboardIsar, QAfterSortBy>
      thenByTotalInvoice() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalInvoice', Sort.asc);
    });
  }

  QueryBuilder<DashboardIsar, DashboardIsar, QAfterSortBy>
      thenByTotalInvoiceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalInvoice', Sort.desc);
    });
  }

  QueryBuilder<DashboardIsar, DashboardIsar, QAfterSortBy> thenByTotalLabour() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalLabour', Sort.asc);
    });
  }

  QueryBuilder<DashboardIsar, DashboardIsar, QAfterSortBy>
      thenByTotalLabourDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalLabour', Sort.desc);
    });
  }

  QueryBuilder<DashboardIsar, DashboardIsar, QAfterSortBy>
      thenByTotalMechanic() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalMechanic', Sort.asc);
    });
  }

  QueryBuilder<DashboardIsar, DashboardIsar, QAfterSortBy>
      thenByTotalMechanicDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalMechanic', Sort.desc);
    });
  }

  QueryBuilder<DashboardIsar, DashboardIsar, QAfterSortBy>
      thenByTotalOutstanding() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalOutstanding', Sort.asc);
    });
  }

  QueryBuilder<DashboardIsar, DashboardIsar, QAfterSortBy>
      thenByTotalOutstandingDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalOutstanding', Sort.desc);
    });
  }

  QueryBuilder<DashboardIsar, DashboardIsar, QAfterSortBy>
      thenByTotalProduct() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalProduct', Sort.asc);
    });
  }

  QueryBuilder<DashboardIsar, DashboardIsar, QAfterSortBy>
      thenByTotalProductDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalProduct', Sort.desc);
    });
  }

  QueryBuilder<DashboardIsar, DashboardIsar, QAfterSortBy> thenByTotalRepair() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalRepair', Sort.asc);
    });
  }

  QueryBuilder<DashboardIsar, DashboardIsar, QAfterSortBy>
      thenByTotalRepairDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalRepair', Sort.desc);
    });
  }

  QueryBuilder<DashboardIsar, DashboardIsar, QAfterSortBy>
      thenByTotalRevenue() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalRevenue', Sort.asc);
    });
  }

  QueryBuilder<DashboardIsar, DashboardIsar, QAfterSortBy>
      thenByTotalRevenueDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalRevenue', Sort.desc);
    });
  }

  QueryBuilder<DashboardIsar, DashboardIsar, QAfterSortBy>
      thenByTotalSparePart() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalSparePart', Sort.asc);
    });
  }

  QueryBuilder<DashboardIsar, DashboardIsar, QAfterSortBy>
      thenByTotalSparePartDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalSparePart', Sort.desc);
    });
  }

  QueryBuilder<DashboardIsar, DashboardIsar, QAfterSortBy>
      thenByTotalVehicle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalVehicle', Sort.asc);
    });
  }

  QueryBuilder<DashboardIsar, DashboardIsar, QAfterSortBy>
      thenByTotalVehicleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalVehicle', Sort.desc);
    });
  }

  QueryBuilder<DashboardIsar, DashboardIsar, QAfterSortBy> thenByUserCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userCount', Sort.asc);
    });
  }

  QueryBuilder<DashboardIsar, DashboardIsar, QAfterSortBy>
      thenByUserCountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userCount', Sort.desc);
    });
  }
}

extension DashboardIsarQueryWhereDistinct
    on QueryBuilder<DashboardIsar, DashboardIsar, QDistinct> {
  QueryBuilder<DashboardIsar, DashboardIsar, QDistinct>
      distinctByCustomerCountFilter() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'customerCountFilter');
    });
  }

  QueryBuilder<DashboardIsar, DashboardIsar, QDistinct> distinctByDelivered() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'delivered');
    });
  }

  QueryBuilder<DashboardIsar, DashboardIsar, QDistinct>
      distinctByEstimateCountFilter() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'estimateCountFilter');
    });
  }

  QueryBuilder<DashboardIsar, DashboardIsar, QDistinct>
      distinctByInvoiceCountFilter() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'invoiceCountFilter');
    });
  }

  QueryBuilder<DashboardIsar, DashboardIsar, QDistinct>
      distinctByJobcardCountFilter() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'jobcardCountFilter');
    });
  }

  QueryBuilder<DashboardIsar, DashboardIsar, QDistinct> distinctByNewEntries() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'newEntries');
    });
  }

  QueryBuilder<DashboardIsar, DashboardIsar, QDistinct>
      distinctByTotalCustomer() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'totalCustomer');
    });
  }

  QueryBuilder<DashboardIsar, DashboardIsar, QDistinct>
      distinctByTotalEstimate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'totalEstimate');
    });
  }

  QueryBuilder<DashboardIsar, DashboardIsar, QDistinct>
      distinctByTotalInvoice() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'totalInvoice');
    });
  }

  QueryBuilder<DashboardIsar, DashboardIsar, QDistinct>
      distinctByTotalLabour() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'totalLabour');
    });
  }

  QueryBuilder<DashboardIsar, DashboardIsar, QDistinct>
      distinctByTotalMechanic() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'totalMechanic');
    });
  }

  QueryBuilder<DashboardIsar, DashboardIsar, QDistinct>
      distinctByTotalOutstanding() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'totalOutstanding');
    });
  }

  QueryBuilder<DashboardIsar, DashboardIsar, QDistinct>
      distinctByTotalProduct() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'totalProduct');
    });
  }

  QueryBuilder<DashboardIsar, DashboardIsar, QDistinct>
      distinctByTotalRepair() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'totalRepair');
    });
  }

  QueryBuilder<DashboardIsar, DashboardIsar, QDistinct>
      distinctByTotalRevenue() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'totalRevenue');
    });
  }

  QueryBuilder<DashboardIsar, DashboardIsar, QDistinct>
      distinctByTotalSparePart() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'totalSparePart');
    });
  }

  QueryBuilder<DashboardIsar, DashboardIsar, QDistinct>
      distinctByTotalVehicle() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'totalVehicle');
    });
  }

  QueryBuilder<DashboardIsar, DashboardIsar, QDistinct> distinctByUserCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'userCount');
    });
  }
}

extension DashboardIsarQueryProperty
    on QueryBuilder<DashboardIsar, DashboardIsar, QQueryProperty> {
  QueryBuilder<DashboardIsar, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<DashboardIsar, int, QQueryOperations>
      customerCountFilterProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'customerCountFilter');
    });
  }

  QueryBuilder<DashboardIsar, int, QQueryOperations> deliveredProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'delivered');
    });
  }

  QueryBuilder<DashboardIsar, int, QQueryOperations>
      estimateCountFilterProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'estimateCountFilter');
    });
  }

  QueryBuilder<DashboardIsar, int, QQueryOperations>
      invoiceCountFilterProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'invoiceCountFilter');
    });
  }

  QueryBuilder<DashboardIsar, int, QQueryOperations>
      jobcardCountFilterProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'jobcardCountFilter');
    });
  }

  QueryBuilder<DashboardIsar, int, QQueryOperations> newEntriesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'newEntries');
    });
  }

  QueryBuilder<DashboardIsar, int, QQueryOperations> totalCustomerProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'totalCustomer');
    });
  }

  QueryBuilder<DashboardIsar, int, QQueryOperations> totalEstimateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'totalEstimate');
    });
  }

  QueryBuilder<DashboardIsar, int, QQueryOperations> totalInvoiceProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'totalInvoice');
    });
  }

  QueryBuilder<DashboardIsar, int, QQueryOperations> totalLabourProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'totalLabour');
    });
  }

  QueryBuilder<DashboardIsar, int, QQueryOperations> totalMechanicProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'totalMechanic');
    });
  }

  QueryBuilder<DashboardIsar, int, QQueryOperations>
      totalOutstandingProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'totalOutstanding');
    });
  }

  QueryBuilder<DashboardIsar, int, QQueryOperations> totalProductProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'totalProduct');
    });
  }

  QueryBuilder<DashboardIsar, int, QQueryOperations> totalRepairProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'totalRepair');
    });
  }

  QueryBuilder<DashboardIsar, int, QQueryOperations> totalRevenueProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'totalRevenue');
    });
  }

  QueryBuilder<DashboardIsar, int, QQueryOperations> totalSparePartProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'totalSparePart');
    });
  }

  QueryBuilder<DashboardIsar, int, QQueryOperations> totalVehicleProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'totalVehicle');
    });
  }

  QueryBuilder<DashboardIsar, int, QQueryOperations> userCountProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'userCount');
    });
  }
}
