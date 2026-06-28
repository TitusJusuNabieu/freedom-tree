// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $LocalReportsTable extends LocalReports
    with TableInfo<$LocalReportsTable, LocalReport> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LocalReportsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _clientIdMeta = const VerificationMeta(
    'clientId',
  );
  @override
  late final GeneratedColumn<String> clientId = GeneratedColumn<String>(
    'client_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _serverIdMeta = const VerificationMeta(
    'serverId',
  );
  @override
  late final GeneratedColumn<String> serverId = GeneratedColumn<String>(
    'server_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  late final GeneratedColumnWithTypeConverter<SyncStatus, String> syncStatus =
      GeneratedColumn<String>(
        'sync_status',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<SyncStatus>($LocalReportsTable.$convertersyncStatus);
  static const VerificationMeta _syncErrorMeta = const VerificationMeta(
    'syncError',
  );
  @override
  late final GeneratedColumn<String> syncError = GeneratedColumn<String>(
    'sync_error',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _lastSyncAttemptAtMeta = const VerificationMeta(
    'lastSyncAttemptAt',
  );
  @override
  late final GeneratedColumn<DateTime> lastSyncAttemptAt =
      GeneratedColumn<DateTime>(
        'last_sync_attempt_at',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _reportingMonthMeta = const VerificationMeta(
    'reportingMonth',
  );
  @override
  late final GeneratedColumn<DateTime> reportingMonth =
      GeneratedColumn<DateTime>(
        'reporting_month',
        aliasedName,
        false,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _communityMeta = const VerificationMeta(
    'community',
  );
  @override
  late final GeneratedColumn<String> community = GeneratedColumn<String>(
    'community',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _submittedByNameMeta = const VerificationMeta(
    'submittedByName',
  );
  @override
  late final GeneratedColumn<String> submittedByName = GeneratedColumn<String>(
    'submitted_by_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _submittedByPositionMeta =
      const VerificationMeta('submittedByPosition');
  @override
  late final GeneratedColumn<String> submittedByPosition =
      GeneratedColumn<String>(
        'submitted_by_position',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _dateSubmittedMeta = const VerificationMeta(
    'dateSubmitted',
  );
  @override
  late final GeneratedColumn<DateTime> dateSubmitted =
      GeneratedColumn<DateTime>(
        'date_submitted',
        aliasedName,
        false,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _pregnantWomenCountMeta =
      const VerificationMeta('pregnantWomenCount');
  @override
  late final GeneratedColumn<int> pregnantWomenCount = GeneratedColumn<int>(
    'pregnant_women_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _deliveriesTotalMeta = const VerificationMeta(
    'deliveriesTotal',
  );
  @override
  late final GeneratedColumn<int> deliveriesTotal = GeneratedColumn<int>(
    'deliveries_total',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _deliveriesAtFacilityMeta =
      const VerificationMeta('deliveriesAtFacility');
  @override
  late final GeneratedColumn<int> deliveriesAtFacility = GeneratedColumn<int>(
    'deliveries_at_facility',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _deliveriesAtHomeMeta = const VerificationMeta(
    'deliveriesAtHome',
  );
  @override
  late final GeneratedColumn<int> deliveriesAtHome = GeneratedColumn<int>(
    'deliveries_at_home',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _maternalDeathsMeta = const VerificationMeta(
    'maternalDeaths',
  );
  @override
  late final GeneratedColumn<int> maternalDeaths = GeneratedColumn<int>(
    'maternal_deaths',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<Set<String>, String>
  placeOfDeath = GeneratedColumn<String>(
    'place_of_death',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  ).withConverter<Set<String>>($LocalReportsTable.$converterplaceOfDeath);
  static const VerificationMeta _placeOfDeathOtherNoteMeta =
      const VerificationMeta('placeOfDeathOtherNote');
  @override
  late final GeneratedColumn<String> placeOfDeathOtherNote =
      GeneratedColumn<String>(
        'place_of_death_other_note',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _suspectedMaternalCauseMeta =
      const VerificationMeta('suspectedMaternalCause');
  @override
  late final GeneratedColumn<String> suspectedMaternalCause =
      GeneratedColumn<String>(
        'suspected_maternal_cause',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _liveBirthsMeta = const VerificationMeta(
    'liveBirths',
  );
  @override
  late final GeneratedColumn<int> liveBirths = GeneratedColumn<int>(
    'live_births',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _infantDeathsTotalMeta = const VerificationMeta(
    'infantDeathsTotal',
  );
  @override
  late final GeneratedColumn<int> infantDeathsTotal = GeneratedColumn<int>(
    'infant_deaths_total',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _infantDeathsWithin24hMeta =
      const VerificationMeta('infantDeathsWithin24h');
  @override
  late final GeneratedColumn<int> infantDeathsWithin24h = GeneratedColumn<int>(
    'infant_deaths_within24h',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _infantDeathsWithin1MonthMeta =
      const VerificationMeta('infantDeathsWithin1Month');
  @override
  late final GeneratedColumn<int> infantDeathsWithin1Month =
      GeneratedColumn<int>(
        'infant_deaths_within1_month',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _infantDeathsWithin12MonthsMeta =
      const VerificationMeta('infantDeathsWithin12Months');
  @override
  late final GeneratedColumn<int> infantDeathsWithin12Months =
      GeneratedColumn<int>(
        'infant_deaths_within12_months',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: true,
      );
  @override
  late final GeneratedColumnWithTypeConverter<Set<String>, String>
  infantDeathCauses = GeneratedColumn<String>(
    'infant_death_causes',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  ).withConverter<Set<String>>($LocalReportsTable.$converterinfantDeathCauses);
  static const VerificationMeta _infantDeathCausesOtherNoteMeta =
      const VerificationMeta('infantDeathCausesOtherNote');
  @override
  late final GeneratedColumn<String> infantDeathCausesOtherNote =
      GeneratedColumn<String>(
        'infant_death_causes_other_note',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _keyChallengesMeta = const VerificationMeta(
    'keyChallenges',
  );
  @override
  late final GeneratedColumn<String> keyChallenges = GeneratedColumn<String>(
    'key_challenges',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _actionsTakenMeta = const VerificationMeta(
    'actionsTaken',
  );
  @override
  late final GeneratedColumn<String> actionsTaken = GeneratedColumn<String>(
    'actions_taken',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _additionalCommentsMeta =
      const VerificationMeta('additionalComments');
  @override
  late final GeneratedColumn<String> additionalComments =
      GeneratedColumn<String>(
        'additional_comments',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _clientCreatedAtMeta = const VerificationMeta(
    'clientCreatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> clientCreatedAt =
      GeneratedColumn<DateTime>(
        'client_created_at',
        aliasedName,
        false,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _clientUpdatedAtMeta = const VerificationMeta(
    'clientUpdatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> clientUpdatedAt =
      GeneratedColumn<DateTime>(
        'client_updated_at',
        aliasedName,
        false,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: true,
      );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    clientId,
    serverId,
    syncStatus,
    syncError,
    lastSyncAttemptAt,
    reportingMonth,
    community,
    submittedByName,
    submittedByPosition,
    dateSubmitted,
    pregnantWomenCount,
    deliveriesTotal,
    deliveriesAtFacility,
    deliveriesAtHome,
    maternalDeaths,
    placeOfDeath,
    placeOfDeathOtherNote,
    suspectedMaternalCause,
    liveBirths,
    infantDeathsTotal,
    infantDeathsWithin24h,
    infantDeathsWithin1Month,
    infantDeathsWithin12Months,
    infantDeathCauses,
    infantDeathCausesOtherNote,
    keyChallenges,
    actionsTaken,
    additionalComments,
    clientCreatedAt,
    clientUpdatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'local_reports';
  @override
  VerificationContext validateIntegrity(
    Insertable<LocalReport> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('client_id')) {
      context.handle(
        _clientIdMeta,
        clientId.isAcceptableOrUnknown(data['client_id']!, _clientIdMeta),
      );
    } else if (isInserting) {
      context.missing(_clientIdMeta);
    }
    if (data.containsKey('server_id')) {
      context.handle(
        _serverIdMeta,
        serverId.isAcceptableOrUnknown(data['server_id']!, _serverIdMeta),
      );
    }
    if (data.containsKey('sync_error')) {
      context.handle(
        _syncErrorMeta,
        syncError.isAcceptableOrUnknown(data['sync_error']!, _syncErrorMeta),
      );
    }
    if (data.containsKey('last_sync_attempt_at')) {
      context.handle(
        _lastSyncAttemptAtMeta,
        lastSyncAttemptAt.isAcceptableOrUnknown(
          data['last_sync_attempt_at']!,
          _lastSyncAttemptAtMeta,
        ),
      );
    }
    if (data.containsKey('reporting_month')) {
      context.handle(
        _reportingMonthMeta,
        reportingMonth.isAcceptableOrUnknown(
          data['reporting_month']!,
          _reportingMonthMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_reportingMonthMeta);
    }
    if (data.containsKey('community')) {
      context.handle(
        _communityMeta,
        community.isAcceptableOrUnknown(data['community']!, _communityMeta),
      );
    } else if (isInserting) {
      context.missing(_communityMeta);
    }
    if (data.containsKey('submitted_by_name')) {
      context.handle(
        _submittedByNameMeta,
        submittedByName.isAcceptableOrUnknown(
          data['submitted_by_name']!,
          _submittedByNameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_submittedByNameMeta);
    }
    if (data.containsKey('submitted_by_position')) {
      context.handle(
        _submittedByPositionMeta,
        submittedByPosition.isAcceptableOrUnknown(
          data['submitted_by_position']!,
          _submittedByPositionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_submittedByPositionMeta);
    }
    if (data.containsKey('date_submitted')) {
      context.handle(
        _dateSubmittedMeta,
        dateSubmitted.isAcceptableOrUnknown(
          data['date_submitted']!,
          _dateSubmittedMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_dateSubmittedMeta);
    }
    if (data.containsKey('pregnant_women_count')) {
      context.handle(
        _pregnantWomenCountMeta,
        pregnantWomenCount.isAcceptableOrUnknown(
          data['pregnant_women_count']!,
          _pregnantWomenCountMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_pregnantWomenCountMeta);
    }
    if (data.containsKey('deliveries_total')) {
      context.handle(
        _deliveriesTotalMeta,
        deliveriesTotal.isAcceptableOrUnknown(
          data['deliveries_total']!,
          _deliveriesTotalMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_deliveriesTotalMeta);
    }
    if (data.containsKey('deliveries_at_facility')) {
      context.handle(
        _deliveriesAtFacilityMeta,
        deliveriesAtFacility.isAcceptableOrUnknown(
          data['deliveries_at_facility']!,
          _deliveriesAtFacilityMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_deliveriesAtFacilityMeta);
    }
    if (data.containsKey('deliveries_at_home')) {
      context.handle(
        _deliveriesAtHomeMeta,
        deliveriesAtHome.isAcceptableOrUnknown(
          data['deliveries_at_home']!,
          _deliveriesAtHomeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_deliveriesAtHomeMeta);
    }
    if (data.containsKey('maternal_deaths')) {
      context.handle(
        _maternalDeathsMeta,
        maternalDeaths.isAcceptableOrUnknown(
          data['maternal_deaths']!,
          _maternalDeathsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_maternalDeathsMeta);
    }
    if (data.containsKey('place_of_death_other_note')) {
      context.handle(
        _placeOfDeathOtherNoteMeta,
        placeOfDeathOtherNote.isAcceptableOrUnknown(
          data['place_of_death_other_note']!,
          _placeOfDeathOtherNoteMeta,
        ),
      );
    }
    if (data.containsKey('suspected_maternal_cause')) {
      context.handle(
        _suspectedMaternalCauseMeta,
        suspectedMaternalCause.isAcceptableOrUnknown(
          data['suspected_maternal_cause']!,
          _suspectedMaternalCauseMeta,
        ),
      );
    }
    if (data.containsKey('live_births')) {
      context.handle(
        _liveBirthsMeta,
        liveBirths.isAcceptableOrUnknown(data['live_births']!, _liveBirthsMeta),
      );
    } else if (isInserting) {
      context.missing(_liveBirthsMeta);
    }
    if (data.containsKey('infant_deaths_total')) {
      context.handle(
        _infantDeathsTotalMeta,
        infantDeathsTotal.isAcceptableOrUnknown(
          data['infant_deaths_total']!,
          _infantDeathsTotalMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_infantDeathsTotalMeta);
    }
    if (data.containsKey('infant_deaths_within24h')) {
      context.handle(
        _infantDeathsWithin24hMeta,
        infantDeathsWithin24h.isAcceptableOrUnknown(
          data['infant_deaths_within24h']!,
          _infantDeathsWithin24hMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_infantDeathsWithin24hMeta);
    }
    if (data.containsKey('infant_deaths_within1_month')) {
      context.handle(
        _infantDeathsWithin1MonthMeta,
        infantDeathsWithin1Month.isAcceptableOrUnknown(
          data['infant_deaths_within1_month']!,
          _infantDeathsWithin1MonthMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_infantDeathsWithin1MonthMeta);
    }
    if (data.containsKey('infant_deaths_within12_months')) {
      context.handle(
        _infantDeathsWithin12MonthsMeta,
        infantDeathsWithin12Months.isAcceptableOrUnknown(
          data['infant_deaths_within12_months']!,
          _infantDeathsWithin12MonthsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_infantDeathsWithin12MonthsMeta);
    }
    if (data.containsKey('infant_death_causes_other_note')) {
      context.handle(
        _infantDeathCausesOtherNoteMeta,
        infantDeathCausesOtherNote.isAcceptableOrUnknown(
          data['infant_death_causes_other_note']!,
          _infantDeathCausesOtherNoteMeta,
        ),
      );
    }
    if (data.containsKey('key_challenges')) {
      context.handle(
        _keyChallengesMeta,
        keyChallenges.isAcceptableOrUnknown(
          data['key_challenges']!,
          _keyChallengesMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_keyChallengesMeta);
    }
    if (data.containsKey('actions_taken')) {
      context.handle(
        _actionsTakenMeta,
        actionsTaken.isAcceptableOrUnknown(
          data['actions_taken']!,
          _actionsTakenMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_actionsTakenMeta);
    }
    if (data.containsKey('additional_comments')) {
      context.handle(
        _additionalCommentsMeta,
        additionalComments.isAcceptableOrUnknown(
          data['additional_comments']!,
          _additionalCommentsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_additionalCommentsMeta);
    }
    if (data.containsKey('client_created_at')) {
      context.handle(
        _clientCreatedAtMeta,
        clientCreatedAt.isAcceptableOrUnknown(
          data['client_created_at']!,
          _clientCreatedAtMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_clientCreatedAtMeta);
    }
    if (data.containsKey('client_updated_at')) {
      context.handle(
        _clientUpdatedAtMeta,
        clientUpdatedAt.isAcceptableOrUnknown(
          data['client_updated_at']!,
          _clientUpdatedAtMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_clientUpdatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LocalReport map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LocalReport(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      clientId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}client_id'],
      )!,
      serverId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}server_id'],
      ),
      syncStatus: $LocalReportsTable.$convertersyncStatus.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}sync_status'],
        )!,
      ),
      syncError: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sync_error'],
      ),
      lastSyncAttemptAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_sync_attempt_at'],
      ),
      reportingMonth: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}reporting_month'],
      )!,
      community: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}community'],
      )!,
      submittedByName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}submitted_by_name'],
      )!,
      submittedByPosition: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}submitted_by_position'],
      )!,
      dateSubmitted: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date_submitted'],
      )!,
      pregnantWomenCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}pregnant_women_count'],
      )!,
      deliveriesTotal: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}deliveries_total'],
      )!,
      deliveriesAtFacility: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}deliveries_at_facility'],
      )!,
      deliveriesAtHome: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}deliveries_at_home'],
      )!,
      maternalDeaths: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}maternal_deaths'],
      )!,
      placeOfDeath: $LocalReportsTable.$converterplaceOfDeath.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}place_of_death'],
        )!,
      ),
      placeOfDeathOtherNote: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}place_of_death_other_note'],
      ),
      suspectedMaternalCause: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}suspected_maternal_cause'],
      ),
      liveBirths: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}live_births'],
      )!,
      infantDeathsTotal: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}infant_deaths_total'],
      )!,
      infantDeathsWithin24h: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}infant_deaths_within24h'],
      )!,
      infantDeathsWithin1Month: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}infant_deaths_within1_month'],
      )!,
      infantDeathsWithin12Months: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}infant_deaths_within12_months'],
      )!,
      infantDeathCauses: $LocalReportsTable.$converterinfantDeathCauses.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}infant_death_causes'],
        )!,
      ),
      infantDeathCausesOtherNote: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}infant_death_causes_other_note'],
      ),
      keyChallenges: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}key_challenges'],
      )!,
      actionsTaken: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}actions_taken'],
      )!,
      additionalComments: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}additional_comments'],
      )!,
      clientCreatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}client_created_at'],
      )!,
      clientUpdatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}client_updated_at'],
      )!,
    );
  }

  @override
  $LocalReportsTable createAlias(String alias) {
    return $LocalReportsTable(attachedDatabase, alias);
  }

  static TypeConverter<SyncStatus, String> $convertersyncStatus =
      const SyncStatusConverter();
  static TypeConverter<Set<String>, String> $converterplaceOfDeath =
      const StringSetConverter();
  static TypeConverter<Set<String>, String> $converterinfantDeathCauses =
      const StringSetConverter();
}

class LocalReport extends DataClass implements Insertable<LocalReport> {
  final int id;
  final String clientId;
  final String? serverId;
  final SyncStatus syncStatus;
  final String? syncError;
  final DateTime? lastSyncAttemptAt;
  final DateTime reportingMonth;
  final String community;
  final String submittedByName;
  final String submittedByPosition;
  final DateTime dateSubmitted;
  final int pregnantWomenCount;
  final int deliveriesTotal;
  final int deliveriesAtFacility;
  final int deliveriesAtHome;
  final int maternalDeaths;
  final Set<String> placeOfDeath;
  final String? placeOfDeathOtherNote;
  final String? suspectedMaternalCause;
  final int liveBirths;
  final int infantDeathsTotal;
  final int infantDeathsWithin24h;
  final int infantDeathsWithin1Month;
  final int infantDeathsWithin12Months;
  final Set<String> infantDeathCauses;
  final String? infantDeathCausesOtherNote;
  final String keyChallenges;
  final String actionsTaken;
  final String additionalComments;
  final DateTime clientCreatedAt;
  final DateTime clientUpdatedAt;
  const LocalReport({
    required this.id,
    required this.clientId,
    this.serverId,
    required this.syncStatus,
    this.syncError,
    this.lastSyncAttemptAt,
    required this.reportingMonth,
    required this.community,
    required this.submittedByName,
    required this.submittedByPosition,
    required this.dateSubmitted,
    required this.pregnantWomenCount,
    required this.deliveriesTotal,
    required this.deliveriesAtFacility,
    required this.deliveriesAtHome,
    required this.maternalDeaths,
    required this.placeOfDeath,
    this.placeOfDeathOtherNote,
    this.suspectedMaternalCause,
    required this.liveBirths,
    required this.infantDeathsTotal,
    required this.infantDeathsWithin24h,
    required this.infantDeathsWithin1Month,
    required this.infantDeathsWithin12Months,
    required this.infantDeathCauses,
    this.infantDeathCausesOtherNote,
    required this.keyChallenges,
    required this.actionsTaken,
    required this.additionalComments,
    required this.clientCreatedAt,
    required this.clientUpdatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['client_id'] = Variable<String>(clientId);
    if (!nullToAbsent || serverId != null) {
      map['server_id'] = Variable<String>(serverId);
    }
    {
      map['sync_status'] = Variable<String>(
        $LocalReportsTable.$convertersyncStatus.toSql(syncStatus),
      );
    }
    if (!nullToAbsent || syncError != null) {
      map['sync_error'] = Variable<String>(syncError);
    }
    if (!nullToAbsent || lastSyncAttemptAt != null) {
      map['last_sync_attempt_at'] = Variable<DateTime>(lastSyncAttemptAt);
    }
    map['reporting_month'] = Variable<DateTime>(reportingMonth);
    map['community'] = Variable<String>(community);
    map['submitted_by_name'] = Variable<String>(submittedByName);
    map['submitted_by_position'] = Variable<String>(submittedByPosition);
    map['date_submitted'] = Variable<DateTime>(dateSubmitted);
    map['pregnant_women_count'] = Variable<int>(pregnantWomenCount);
    map['deliveries_total'] = Variable<int>(deliveriesTotal);
    map['deliveries_at_facility'] = Variable<int>(deliveriesAtFacility);
    map['deliveries_at_home'] = Variable<int>(deliveriesAtHome);
    map['maternal_deaths'] = Variable<int>(maternalDeaths);
    {
      map['place_of_death'] = Variable<String>(
        $LocalReportsTable.$converterplaceOfDeath.toSql(placeOfDeath),
      );
    }
    if (!nullToAbsent || placeOfDeathOtherNote != null) {
      map['place_of_death_other_note'] = Variable<String>(
        placeOfDeathOtherNote,
      );
    }
    if (!nullToAbsent || suspectedMaternalCause != null) {
      map['suspected_maternal_cause'] = Variable<String>(
        suspectedMaternalCause,
      );
    }
    map['live_births'] = Variable<int>(liveBirths);
    map['infant_deaths_total'] = Variable<int>(infantDeathsTotal);
    map['infant_deaths_within24h'] = Variable<int>(infantDeathsWithin24h);
    map['infant_deaths_within1_month'] = Variable<int>(
      infantDeathsWithin1Month,
    );
    map['infant_deaths_within12_months'] = Variable<int>(
      infantDeathsWithin12Months,
    );
    {
      map['infant_death_causes'] = Variable<String>(
        $LocalReportsTable.$converterinfantDeathCauses.toSql(infantDeathCauses),
      );
    }
    if (!nullToAbsent || infantDeathCausesOtherNote != null) {
      map['infant_death_causes_other_note'] = Variable<String>(
        infantDeathCausesOtherNote,
      );
    }
    map['key_challenges'] = Variable<String>(keyChallenges);
    map['actions_taken'] = Variable<String>(actionsTaken);
    map['additional_comments'] = Variable<String>(additionalComments);
    map['client_created_at'] = Variable<DateTime>(clientCreatedAt);
    map['client_updated_at'] = Variable<DateTime>(clientUpdatedAt);
    return map;
  }

  LocalReportsCompanion toCompanion(bool nullToAbsent) {
    return LocalReportsCompanion(
      id: Value(id),
      clientId: Value(clientId),
      serverId: serverId == null && nullToAbsent
          ? const Value.absent()
          : Value(serverId),
      syncStatus: Value(syncStatus),
      syncError: syncError == null && nullToAbsent
          ? const Value.absent()
          : Value(syncError),
      lastSyncAttemptAt: lastSyncAttemptAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastSyncAttemptAt),
      reportingMonth: Value(reportingMonth),
      community: Value(community),
      submittedByName: Value(submittedByName),
      submittedByPosition: Value(submittedByPosition),
      dateSubmitted: Value(dateSubmitted),
      pregnantWomenCount: Value(pregnantWomenCount),
      deliveriesTotal: Value(deliveriesTotal),
      deliveriesAtFacility: Value(deliveriesAtFacility),
      deliveriesAtHome: Value(deliveriesAtHome),
      maternalDeaths: Value(maternalDeaths),
      placeOfDeath: Value(placeOfDeath),
      placeOfDeathOtherNote: placeOfDeathOtherNote == null && nullToAbsent
          ? const Value.absent()
          : Value(placeOfDeathOtherNote),
      suspectedMaternalCause: suspectedMaternalCause == null && nullToAbsent
          ? const Value.absent()
          : Value(suspectedMaternalCause),
      liveBirths: Value(liveBirths),
      infantDeathsTotal: Value(infantDeathsTotal),
      infantDeathsWithin24h: Value(infantDeathsWithin24h),
      infantDeathsWithin1Month: Value(infantDeathsWithin1Month),
      infantDeathsWithin12Months: Value(infantDeathsWithin12Months),
      infantDeathCauses: Value(infantDeathCauses),
      infantDeathCausesOtherNote:
          infantDeathCausesOtherNote == null && nullToAbsent
          ? const Value.absent()
          : Value(infantDeathCausesOtherNote),
      keyChallenges: Value(keyChallenges),
      actionsTaken: Value(actionsTaken),
      additionalComments: Value(additionalComments),
      clientCreatedAt: Value(clientCreatedAt),
      clientUpdatedAt: Value(clientUpdatedAt),
    );
  }

  factory LocalReport.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LocalReport(
      id: serializer.fromJson<int>(json['id']),
      clientId: serializer.fromJson<String>(json['clientId']),
      serverId: serializer.fromJson<String?>(json['serverId']),
      syncStatus: serializer.fromJson<SyncStatus>(json['syncStatus']),
      syncError: serializer.fromJson<String?>(json['syncError']),
      lastSyncAttemptAt: serializer.fromJson<DateTime?>(
        json['lastSyncAttemptAt'],
      ),
      reportingMonth: serializer.fromJson<DateTime>(json['reportingMonth']),
      community: serializer.fromJson<String>(json['community']),
      submittedByName: serializer.fromJson<String>(json['submittedByName']),
      submittedByPosition: serializer.fromJson<String>(
        json['submittedByPosition'],
      ),
      dateSubmitted: serializer.fromJson<DateTime>(json['dateSubmitted']),
      pregnantWomenCount: serializer.fromJson<int>(json['pregnantWomenCount']),
      deliveriesTotal: serializer.fromJson<int>(json['deliveriesTotal']),
      deliveriesAtFacility: serializer.fromJson<int>(
        json['deliveriesAtFacility'],
      ),
      deliveriesAtHome: serializer.fromJson<int>(json['deliveriesAtHome']),
      maternalDeaths: serializer.fromJson<int>(json['maternalDeaths']),
      placeOfDeath: serializer.fromJson<Set<String>>(json['placeOfDeath']),
      placeOfDeathOtherNote: serializer.fromJson<String?>(
        json['placeOfDeathOtherNote'],
      ),
      suspectedMaternalCause: serializer.fromJson<String?>(
        json['suspectedMaternalCause'],
      ),
      liveBirths: serializer.fromJson<int>(json['liveBirths']),
      infantDeathsTotal: serializer.fromJson<int>(json['infantDeathsTotal']),
      infantDeathsWithin24h: serializer.fromJson<int>(
        json['infantDeathsWithin24h'],
      ),
      infantDeathsWithin1Month: serializer.fromJson<int>(
        json['infantDeathsWithin1Month'],
      ),
      infantDeathsWithin12Months: serializer.fromJson<int>(
        json['infantDeathsWithin12Months'],
      ),
      infantDeathCauses: serializer.fromJson<Set<String>>(
        json['infantDeathCauses'],
      ),
      infantDeathCausesOtherNote: serializer.fromJson<String?>(
        json['infantDeathCausesOtherNote'],
      ),
      keyChallenges: serializer.fromJson<String>(json['keyChallenges']),
      actionsTaken: serializer.fromJson<String>(json['actionsTaken']),
      additionalComments: serializer.fromJson<String>(
        json['additionalComments'],
      ),
      clientCreatedAt: serializer.fromJson<DateTime>(json['clientCreatedAt']),
      clientUpdatedAt: serializer.fromJson<DateTime>(json['clientUpdatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'clientId': serializer.toJson<String>(clientId),
      'serverId': serializer.toJson<String?>(serverId),
      'syncStatus': serializer.toJson<SyncStatus>(syncStatus),
      'syncError': serializer.toJson<String?>(syncError),
      'lastSyncAttemptAt': serializer.toJson<DateTime?>(lastSyncAttemptAt),
      'reportingMonth': serializer.toJson<DateTime>(reportingMonth),
      'community': serializer.toJson<String>(community),
      'submittedByName': serializer.toJson<String>(submittedByName),
      'submittedByPosition': serializer.toJson<String>(submittedByPosition),
      'dateSubmitted': serializer.toJson<DateTime>(dateSubmitted),
      'pregnantWomenCount': serializer.toJson<int>(pregnantWomenCount),
      'deliveriesTotal': serializer.toJson<int>(deliveriesTotal),
      'deliveriesAtFacility': serializer.toJson<int>(deliveriesAtFacility),
      'deliveriesAtHome': serializer.toJson<int>(deliveriesAtHome),
      'maternalDeaths': serializer.toJson<int>(maternalDeaths),
      'placeOfDeath': serializer.toJson<Set<String>>(placeOfDeath),
      'placeOfDeathOtherNote': serializer.toJson<String?>(
        placeOfDeathOtherNote,
      ),
      'suspectedMaternalCause': serializer.toJson<String?>(
        suspectedMaternalCause,
      ),
      'liveBirths': serializer.toJson<int>(liveBirths),
      'infantDeathsTotal': serializer.toJson<int>(infantDeathsTotal),
      'infantDeathsWithin24h': serializer.toJson<int>(infantDeathsWithin24h),
      'infantDeathsWithin1Month': serializer.toJson<int>(
        infantDeathsWithin1Month,
      ),
      'infantDeathsWithin12Months': serializer.toJson<int>(
        infantDeathsWithin12Months,
      ),
      'infantDeathCauses': serializer.toJson<Set<String>>(infantDeathCauses),
      'infantDeathCausesOtherNote': serializer.toJson<String?>(
        infantDeathCausesOtherNote,
      ),
      'keyChallenges': serializer.toJson<String>(keyChallenges),
      'actionsTaken': serializer.toJson<String>(actionsTaken),
      'additionalComments': serializer.toJson<String>(additionalComments),
      'clientCreatedAt': serializer.toJson<DateTime>(clientCreatedAt),
      'clientUpdatedAt': serializer.toJson<DateTime>(clientUpdatedAt),
    };
  }

  LocalReport copyWith({
    int? id,
    String? clientId,
    Value<String?> serverId = const Value.absent(),
    SyncStatus? syncStatus,
    Value<String?> syncError = const Value.absent(),
    Value<DateTime?> lastSyncAttemptAt = const Value.absent(),
    DateTime? reportingMonth,
    String? community,
    String? submittedByName,
    String? submittedByPosition,
    DateTime? dateSubmitted,
    int? pregnantWomenCount,
    int? deliveriesTotal,
    int? deliveriesAtFacility,
    int? deliveriesAtHome,
    int? maternalDeaths,
    Set<String>? placeOfDeath,
    Value<String?> placeOfDeathOtherNote = const Value.absent(),
    Value<String?> suspectedMaternalCause = const Value.absent(),
    int? liveBirths,
    int? infantDeathsTotal,
    int? infantDeathsWithin24h,
    int? infantDeathsWithin1Month,
    int? infantDeathsWithin12Months,
    Set<String>? infantDeathCauses,
    Value<String?> infantDeathCausesOtherNote = const Value.absent(),
    String? keyChallenges,
    String? actionsTaken,
    String? additionalComments,
    DateTime? clientCreatedAt,
    DateTime? clientUpdatedAt,
  }) => LocalReport(
    id: id ?? this.id,
    clientId: clientId ?? this.clientId,
    serverId: serverId.present ? serverId.value : this.serverId,
    syncStatus: syncStatus ?? this.syncStatus,
    syncError: syncError.present ? syncError.value : this.syncError,
    lastSyncAttemptAt: lastSyncAttemptAt.present
        ? lastSyncAttemptAt.value
        : this.lastSyncAttemptAt,
    reportingMonth: reportingMonth ?? this.reportingMonth,
    community: community ?? this.community,
    submittedByName: submittedByName ?? this.submittedByName,
    submittedByPosition: submittedByPosition ?? this.submittedByPosition,
    dateSubmitted: dateSubmitted ?? this.dateSubmitted,
    pregnantWomenCount: pregnantWomenCount ?? this.pregnantWomenCount,
    deliveriesTotal: deliveriesTotal ?? this.deliveriesTotal,
    deliveriesAtFacility: deliveriesAtFacility ?? this.deliveriesAtFacility,
    deliveriesAtHome: deliveriesAtHome ?? this.deliveriesAtHome,
    maternalDeaths: maternalDeaths ?? this.maternalDeaths,
    placeOfDeath: placeOfDeath ?? this.placeOfDeath,
    placeOfDeathOtherNote: placeOfDeathOtherNote.present
        ? placeOfDeathOtherNote.value
        : this.placeOfDeathOtherNote,
    suspectedMaternalCause: suspectedMaternalCause.present
        ? suspectedMaternalCause.value
        : this.suspectedMaternalCause,
    liveBirths: liveBirths ?? this.liveBirths,
    infantDeathsTotal: infantDeathsTotal ?? this.infantDeathsTotal,
    infantDeathsWithin24h: infantDeathsWithin24h ?? this.infantDeathsWithin24h,
    infantDeathsWithin1Month:
        infantDeathsWithin1Month ?? this.infantDeathsWithin1Month,
    infantDeathsWithin12Months:
        infantDeathsWithin12Months ?? this.infantDeathsWithin12Months,
    infantDeathCauses: infantDeathCauses ?? this.infantDeathCauses,
    infantDeathCausesOtherNote: infantDeathCausesOtherNote.present
        ? infantDeathCausesOtherNote.value
        : this.infantDeathCausesOtherNote,
    keyChallenges: keyChallenges ?? this.keyChallenges,
    actionsTaken: actionsTaken ?? this.actionsTaken,
    additionalComments: additionalComments ?? this.additionalComments,
    clientCreatedAt: clientCreatedAt ?? this.clientCreatedAt,
    clientUpdatedAt: clientUpdatedAt ?? this.clientUpdatedAt,
  );
  LocalReport copyWithCompanion(LocalReportsCompanion data) {
    return LocalReport(
      id: data.id.present ? data.id.value : this.id,
      clientId: data.clientId.present ? data.clientId.value : this.clientId,
      serverId: data.serverId.present ? data.serverId.value : this.serverId,
      syncStatus: data.syncStatus.present
          ? data.syncStatus.value
          : this.syncStatus,
      syncError: data.syncError.present ? data.syncError.value : this.syncError,
      lastSyncAttemptAt: data.lastSyncAttemptAt.present
          ? data.lastSyncAttemptAt.value
          : this.lastSyncAttemptAt,
      reportingMonth: data.reportingMonth.present
          ? data.reportingMonth.value
          : this.reportingMonth,
      community: data.community.present ? data.community.value : this.community,
      submittedByName: data.submittedByName.present
          ? data.submittedByName.value
          : this.submittedByName,
      submittedByPosition: data.submittedByPosition.present
          ? data.submittedByPosition.value
          : this.submittedByPosition,
      dateSubmitted: data.dateSubmitted.present
          ? data.dateSubmitted.value
          : this.dateSubmitted,
      pregnantWomenCount: data.pregnantWomenCount.present
          ? data.pregnantWomenCount.value
          : this.pregnantWomenCount,
      deliveriesTotal: data.deliveriesTotal.present
          ? data.deliveriesTotal.value
          : this.deliveriesTotal,
      deliveriesAtFacility: data.deliveriesAtFacility.present
          ? data.deliveriesAtFacility.value
          : this.deliveriesAtFacility,
      deliveriesAtHome: data.deliveriesAtHome.present
          ? data.deliveriesAtHome.value
          : this.deliveriesAtHome,
      maternalDeaths: data.maternalDeaths.present
          ? data.maternalDeaths.value
          : this.maternalDeaths,
      placeOfDeath: data.placeOfDeath.present
          ? data.placeOfDeath.value
          : this.placeOfDeath,
      placeOfDeathOtherNote: data.placeOfDeathOtherNote.present
          ? data.placeOfDeathOtherNote.value
          : this.placeOfDeathOtherNote,
      suspectedMaternalCause: data.suspectedMaternalCause.present
          ? data.suspectedMaternalCause.value
          : this.suspectedMaternalCause,
      liveBirths: data.liveBirths.present
          ? data.liveBirths.value
          : this.liveBirths,
      infantDeathsTotal: data.infantDeathsTotal.present
          ? data.infantDeathsTotal.value
          : this.infantDeathsTotal,
      infantDeathsWithin24h: data.infantDeathsWithin24h.present
          ? data.infantDeathsWithin24h.value
          : this.infantDeathsWithin24h,
      infantDeathsWithin1Month: data.infantDeathsWithin1Month.present
          ? data.infantDeathsWithin1Month.value
          : this.infantDeathsWithin1Month,
      infantDeathsWithin12Months: data.infantDeathsWithin12Months.present
          ? data.infantDeathsWithin12Months.value
          : this.infantDeathsWithin12Months,
      infantDeathCauses: data.infantDeathCauses.present
          ? data.infantDeathCauses.value
          : this.infantDeathCauses,
      infantDeathCausesOtherNote: data.infantDeathCausesOtherNote.present
          ? data.infantDeathCausesOtherNote.value
          : this.infantDeathCausesOtherNote,
      keyChallenges: data.keyChallenges.present
          ? data.keyChallenges.value
          : this.keyChallenges,
      actionsTaken: data.actionsTaken.present
          ? data.actionsTaken.value
          : this.actionsTaken,
      additionalComments: data.additionalComments.present
          ? data.additionalComments.value
          : this.additionalComments,
      clientCreatedAt: data.clientCreatedAt.present
          ? data.clientCreatedAt.value
          : this.clientCreatedAt,
      clientUpdatedAt: data.clientUpdatedAt.present
          ? data.clientUpdatedAt.value
          : this.clientUpdatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LocalReport(')
          ..write('id: $id, ')
          ..write('clientId: $clientId, ')
          ..write('serverId: $serverId, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('syncError: $syncError, ')
          ..write('lastSyncAttemptAt: $lastSyncAttemptAt, ')
          ..write('reportingMonth: $reportingMonth, ')
          ..write('community: $community, ')
          ..write('submittedByName: $submittedByName, ')
          ..write('submittedByPosition: $submittedByPosition, ')
          ..write('dateSubmitted: $dateSubmitted, ')
          ..write('pregnantWomenCount: $pregnantWomenCount, ')
          ..write('deliveriesTotal: $deliveriesTotal, ')
          ..write('deliveriesAtFacility: $deliveriesAtFacility, ')
          ..write('deliveriesAtHome: $deliveriesAtHome, ')
          ..write('maternalDeaths: $maternalDeaths, ')
          ..write('placeOfDeath: $placeOfDeath, ')
          ..write('placeOfDeathOtherNote: $placeOfDeathOtherNote, ')
          ..write('suspectedMaternalCause: $suspectedMaternalCause, ')
          ..write('liveBirths: $liveBirths, ')
          ..write('infantDeathsTotal: $infantDeathsTotal, ')
          ..write('infantDeathsWithin24h: $infantDeathsWithin24h, ')
          ..write('infantDeathsWithin1Month: $infantDeathsWithin1Month, ')
          ..write('infantDeathsWithin12Months: $infantDeathsWithin12Months, ')
          ..write('infantDeathCauses: $infantDeathCauses, ')
          ..write('infantDeathCausesOtherNote: $infantDeathCausesOtherNote, ')
          ..write('keyChallenges: $keyChallenges, ')
          ..write('actionsTaken: $actionsTaken, ')
          ..write('additionalComments: $additionalComments, ')
          ..write('clientCreatedAt: $clientCreatedAt, ')
          ..write('clientUpdatedAt: $clientUpdatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
    id,
    clientId,
    serverId,
    syncStatus,
    syncError,
    lastSyncAttemptAt,
    reportingMonth,
    community,
    submittedByName,
    submittedByPosition,
    dateSubmitted,
    pregnantWomenCount,
    deliveriesTotal,
    deliveriesAtFacility,
    deliveriesAtHome,
    maternalDeaths,
    placeOfDeath,
    placeOfDeathOtherNote,
    suspectedMaternalCause,
    liveBirths,
    infantDeathsTotal,
    infantDeathsWithin24h,
    infantDeathsWithin1Month,
    infantDeathsWithin12Months,
    infantDeathCauses,
    infantDeathCausesOtherNote,
    keyChallenges,
    actionsTaken,
    additionalComments,
    clientCreatedAt,
    clientUpdatedAt,
  ]);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LocalReport &&
          other.id == this.id &&
          other.clientId == this.clientId &&
          other.serverId == this.serverId &&
          other.syncStatus == this.syncStatus &&
          other.syncError == this.syncError &&
          other.lastSyncAttemptAt == this.lastSyncAttemptAt &&
          other.reportingMonth == this.reportingMonth &&
          other.community == this.community &&
          other.submittedByName == this.submittedByName &&
          other.submittedByPosition == this.submittedByPosition &&
          other.dateSubmitted == this.dateSubmitted &&
          other.pregnantWomenCount == this.pregnantWomenCount &&
          other.deliveriesTotal == this.deliveriesTotal &&
          other.deliveriesAtFacility == this.deliveriesAtFacility &&
          other.deliveriesAtHome == this.deliveriesAtHome &&
          other.maternalDeaths == this.maternalDeaths &&
          other.placeOfDeath == this.placeOfDeath &&
          other.placeOfDeathOtherNote == this.placeOfDeathOtherNote &&
          other.suspectedMaternalCause == this.suspectedMaternalCause &&
          other.liveBirths == this.liveBirths &&
          other.infantDeathsTotal == this.infantDeathsTotal &&
          other.infantDeathsWithin24h == this.infantDeathsWithin24h &&
          other.infantDeathsWithin1Month == this.infantDeathsWithin1Month &&
          other.infantDeathsWithin12Months == this.infantDeathsWithin12Months &&
          other.infantDeathCauses == this.infantDeathCauses &&
          other.infantDeathCausesOtherNote == this.infantDeathCausesOtherNote &&
          other.keyChallenges == this.keyChallenges &&
          other.actionsTaken == this.actionsTaken &&
          other.additionalComments == this.additionalComments &&
          other.clientCreatedAt == this.clientCreatedAt &&
          other.clientUpdatedAt == this.clientUpdatedAt);
}

class LocalReportsCompanion extends UpdateCompanion<LocalReport> {
  final Value<int> id;
  final Value<String> clientId;
  final Value<String?> serverId;
  final Value<SyncStatus> syncStatus;
  final Value<String?> syncError;
  final Value<DateTime?> lastSyncAttemptAt;
  final Value<DateTime> reportingMonth;
  final Value<String> community;
  final Value<String> submittedByName;
  final Value<String> submittedByPosition;
  final Value<DateTime> dateSubmitted;
  final Value<int> pregnantWomenCount;
  final Value<int> deliveriesTotal;
  final Value<int> deliveriesAtFacility;
  final Value<int> deliveriesAtHome;
  final Value<int> maternalDeaths;
  final Value<Set<String>> placeOfDeath;
  final Value<String?> placeOfDeathOtherNote;
  final Value<String?> suspectedMaternalCause;
  final Value<int> liveBirths;
  final Value<int> infantDeathsTotal;
  final Value<int> infantDeathsWithin24h;
  final Value<int> infantDeathsWithin1Month;
  final Value<int> infantDeathsWithin12Months;
  final Value<Set<String>> infantDeathCauses;
  final Value<String?> infantDeathCausesOtherNote;
  final Value<String> keyChallenges;
  final Value<String> actionsTaken;
  final Value<String> additionalComments;
  final Value<DateTime> clientCreatedAt;
  final Value<DateTime> clientUpdatedAt;
  const LocalReportsCompanion({
    this.id = const Value.absent(),
    this.clientId = const Value.absent(),
    this.serverId = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.syncError = const Value.absent(),
    this.lastSyncAttemptAt = const Value.absent(),
    this.reportingMonth = const Value.absent(),
    this.community = const Value.absent(),
    this.submittedByName = const Value.absent(),
    this.submittedByPosition = const Value.absent(),
    this.dateSubmitted = const Value.absent(),
    this.pregnantWomenCount = const Value.absent(),
    this.deliveriesTotal = const Value.absent(),
    this.deliveriesAtFacility = const Value.absent(),
    this.deliveriesAtHome = const Value.absent(),
    this.maternalDeaths = const Value.absent(),
    this.placeOfDeath = const Value.absent(),
    this.placeOfDeathOtherNote = const Value.absent(),
    this.suspectedMaternalCause = const Value.absent(),
    this.liveBirths = const Value.absent(),
    this.infantDeathsTotal = const Value.absent(),
    this.infantDeathsWithin24h = const Value.absent(),
    this.infantDeathsWithin1Month = const Value.absent(),
    this.infantDeathsWithin12Months = const Value.absent(),
    this.infantDeathCauses = const Value.absent(),
    this.infantDeathCausesOtherNote = const Value.absent(),
    this.keyChallenges = const Value.absent(),
    this.actionsTaken = const Value.absent(),
    this.additionalComments = const Value.absent(),
    this.clientCreatedAt = const Value.absent(),
    this.clientUpdatedAt = const Value.absent(),
  });
  LocalReportsCompanion.insert({
    this.id = const Value.absent(),
    required String clientId,
    this.serverId = const Value.absent(),
    required SyncStatus syncStatus,
    this.syncError = const Value.absent(),
    this.lastSyncAttemptAt = const Value.absent(),
    required DateTime reportingMonth,
    required String community,
    required String submittedByName,
    required String submittedByPosition,
    required DateTime dateSubmitted,
    required int pregnantWomenCount,
    required int deliveriesTotal,
    required int deliveriesAtFacility,
    required int deliveriesAtHome,
    required int maternalDeaths,
    required Set<String> placeOfDeath,
    this.placeOfDeathOtherNote = const Value.absent(),
    this.suspectedMaternalCause = const Value.absent(),
    required int liveBirths,
    required int infantDeathsTotal,
    required int infantDeathsWithin24h,
    required int infantDeathsWithin1Month,
    required int infantDeathsWithin12Months,
    required Set<String> infantDeathCauses,
    this.infantDeathCausesOtherNote = const Value.absent(),
    required String keyChallenges,
    required String actionsTaken,
    required String additionalComments,
    required DateTime clientCreatedAt,
    required DateTime clientUpdatedAt,
  }) : clientId = Value(clientId),
       syncStatus = Value(syncStatus),
       reportingMonth = Value(reportingMonth),
       community = Value(community),
       submittedByName = Value(submittedByName),
       submittedByPosition = Value(submittedByPosition),
       dateSubmitted = Value(dateSubmitted),
       pregnantWomenCount = Value(pregnantWomenCount),
       deliveriesTotal = Value(deliveriesTotal),
       deliveriesAtFacility = Value(deliveriesAtFacility),
       deliveriesAtHome = Value(deliveriesAtHome),
       maternalDeaths = Value(maternalDeaths),
       placeOfDeath = Value(placeOfDeath),
       liveBirths = Value(liveBirths),
       infantDeathsTotal = Value(infantDeathsTotal),
       infantDeathsWithin24h = Value(infantDeathsWithin24h),
       infantDeathsWithin1Month = Value(infantDeathsWithin1Month),
       infantDeathsWithin12Months = Value(infantDeathsWithin12Months),
       infantDeathCauses = Value(infantDeathCauses),
       keyChallenges = Value(keyChallenges),
       actionsTaken = Value(actionsTaken),
       additionalComments = Value(additionalComments),
       clientCreatedAt = Value(clientCreatedAt),
       clientUpdatedAt = Value(clientUpdatedAt);
  static Insertable<LocalReport> custom({
    Expression<int>? id,
    Expression<String>? clientId,
    Expression<String>? serverId,
    Expression<String>? syncStatus,
    Expression<String>? syncError,
    Expression<DateTime>? lastSyncAttemptAt,
    Expression<DateTime>? reportingMonth,
    Expression<String>? community,
    Expression<String>? submittedByName,
    Expression<String>? submittedByPosition,
    Expression<DateTime>? dateSubmitted,
    Expression<int>? pregnantWomenCount,
    Expression<int>? deliveriesTotal,
    Expression<int>? deliveriesAtFacility,
    Expression<int>? deliveriesAtHome,
    Expression<int>? maternalDeaths,
    Expression<String>? placeOfDeath,
    Expression<String>? placeOfDeathOtherNote,
    Expression<String>? suspectedMaternalCause,
    Expression<int>? liveBirths,
    Expression<int>? infantDeathsTotal,
    Expression<int>? infantDeathsWithin24h,
    Expression<int>? infantDeathsWithin1Month,
    Expression<int>? infantDeathsWithin12Months,
    Expression<String>? infantDeathCauses,
    Expression<String>? infantDeathCausesOtherNote,
    Expression<String>? keyChallenges,
    Expression<String>? actionsTaken,
    Expression<String>? additionalComments,
    Expression<DateTime>? clientCreatedAt,
    Expression<DateTime>? clientUpdatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (clientId != null) 'client_id': clientId,
      if (serverId != null) 'server_id': serverId,
      if (syncStatus != null) 'sync_status': syncStatus,
      if (syncError != null) 'sync_error': syncError,
      if (lastSyncAttemptAt != null) 'last_sync_attempt_at': lastSyncAttemptAt,
      if (reportingMonth != null) 'reporting_month': reportingMonth,
      if (community != null) 'community': community,
      if (submittedByName != null) 'submitted_by_name': submittedByName,
      if (submittedByPosition != null)
        'submitted_by_position': submittedByPosition,
      if (dateSubmitted != null) 'date_submitted': dateSubmitted,
      if (pregnantWomenCount != null)
        'pregnant_women_count': pregnantWomenCount,
      if (deliveriesTotal != null) 'deliveries_total': deliveriesTotal,
      if (deliveriesAtFacility != null)
        'deliveries_at_facility': deliveriesAtFacility,
      if (deliveriesAtHome != null) 'deliveries_at_home': deliveriesAtHome,
      if (maternalDeaths != null) 'maternal_deaths': maternalDeaths,
      if (placeOfDeath != null) 'place_of_death': placeOfDeath,
      if (placeOfDeathOtherNote != null)
        'place_of_death_other_note': placeOfDeathOtherNote,
      if (suspectedMaternalCause != null)
        'suspected_maternal_cause': suspectedMaternalCause,
      if (liveBirths != null) 'live_births': liveBirths,
      if (infantDeathsTotal != null) 'infant_deaths_total': infantDeathsTotal,
      if (infantDeathsWithin24h != null)
        'infant_deaths_within24h': infantDeathsWithin24h,
      if (infantDeathsWithin1Month != null)
        'infant_deaths_within1_month': infantDeathsWithin1Month,
      if (infantDeathsWithin12Months != null)
        'infant_deaths_within12_months': infantDeathsWithin12Months,
      if (infantDeathCauses != null) 'infant_death_causes': infantDeathCauses,
      if (infantDeathCausesOtherNote != null)
        'infant_death_causes_other_note': infantDeathCausesOtherNote,
      if (keyChallenges != null) 'key_challenges': keyChallenges,
      if (actionsTaken != null) 'actions_taken': actionsTaken,
      if (additionalComments != null) 'additional_comments': additionalComments,
      if (clientCreatedAt != null) 'client_created_at': clientCreatedAt,
      if (clientUpdatedAt != null) 'client_updated_at': clientUpdatedAt,
    });
  }

  LocalReportsCompanion copyWith({
    Value<int>? id,
    Value<String>? clientId,
    Value<String?>? serverId,
    Value<SyncStatus>? syncStatus,
    Value<String?>? syncError,
    Value<DateTime?>? lastSyncAttemptAt,
    Value<DateTime>? reportingMonth,
    Value<String>? community,
    Value<String>? submittedByName,
    Value<String>? submittedByPosition,
    Value<DateTime>? dateSubmitted,
    Value<int>? pregnantWomenCount,
    Value<int>? deliveriesTotal,
    Value<int>? deliveriesAtFacility,
    Value<int>? deliveriesAtHome,
    Value<int>? maternalDeaths,
    Value<Set<String>>? placeOfDeath,
    Value<String?>? placeOfDeathOtherNote,
    Value<String?>? suspectedMaternalCause,
    Value<int>? liveBirths,
    Value<int>? infantDeathsTotal,
    Value<int>? infantDeathsWithin24h,
    Value<int>? infantDeathsWithin1Month,
    Value<int>? infantDeathsWithin12Months,
    Value<Set<String>>? infantDeathCauses,
    Value<String?>? infantDeathCausesOtherNote,
    Value<String>? keyChallenges,
    Value<String>? actionsTaken,
    Value<String>? additionalComments,
    Value<DateTime>? clientCreatedAt,
    Value<DateTime>? clientUpdatedAt,
  }) {
    return LocalReportsCompanion(
      id: id ?? this.id,
      clientId: clientId ?? this.clientId,
      serverId: serverId ?? this.serverId,
      syncStatus: syncStatus ?? this.syncStatus,
      syncError: syncError ?? this.syncError,
      lastSyncAttemptAt: lastSyncAttemptAt ?? this.lastSyncAttemptAt,
      reportingMonth: reportingMonth ?? this.reportingMonth,
      community: community ?? this.community,
      submittedByName: submittedByName ?? this.submittedByName,
      submittedByPosition: submittedByPosition ?? this.submittedByPosition,
      dateSubmitted: dateSubmitted ?? this.dateSubmitted,
      pregnantWomenCount: pregnantWomenCount ?? this.pregnantWomenCount,
      deliveriesTotal: deliveriesTotal ?? this.deliveriesTotal,
      deliveriesAtFacility: deliveriesAtFacility ?? this.deliveriesAtFacility,
      deliveriesAtHome: deliveriesAtHome ?? this.deliveriesAtHome,
      maternalDeaths: maternalDeaths ?? this.maternalDeaths,
      placeOfDeath: placeOfDeath ?? this.placeOfDeath,
      placeOfDeathOtherNote:
          placeOfDeathOtherNote ?? this.placeOfDeathOtherNote,
      suspectedMaternalCause:
          suspectedMaternalCause ?? this.suspectedMaternalCause,
      liveBirths: liveBirths ?? this.liveBirths,
      infantDeathsTotal: infantDeathsTotal ?? this.infantDeathsTotal,
      infantDeathsWithin24h:
          infantDeathsWithin24h ?? this.infantDeathsWithin24h,
      infantDeathsWithin1Month:
          infantDeathsWithin1Month ?? this.infantDeathsWithin1Month,
      infantDeathsWithin12Months:
          infantDeathsWithin12Months ?? this.infantDeathsWithin12Months,
      infantDeathCauses: infantDeathCauses ?? this.infantDeathCauses,
      infantDeathCausesOtherNote:
          infantDeathCausesOtherNote ?? this.infantDeathCausesOtherNote,
      keyChallenges: keyChallenges ?? this.keyChallenges,
      actionsTaken: actionsTaken ?? this.actionsTaken,
      additionalComments: additionalComments ?? this.additionalComments,
      clientCreatedAt: clientCreatedAt ?? this.clientCreatedAt,
      clientUpdatedAt: clientUpdatedAt ?? this.clientUpdatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (clientId.present) {
      map['client_id'] = Variable<String>(clientId.value);
    }
    if (serverId.present) {
      map['server_id'] = Variable<String>(serverId.value);
    }
    if (syncStatus.present) {
      map['sync_status'] = Variable<String>(
        $LocalReportsTable.$convertersyncStatus.toSql(syncStatus.value),
      );
    }
    if (syncError.present) {
      map['sync_error'] = Variable<String>(syncError.value);
    }
    if (lastSyncAttemptAt.present) {
      map['last_sync_attempt_at'] = Variable<DateTime>(lastSyncAttemptAt.value);
    }
    if (reportingMonth.present) {
      map['reporting_month'] = Variable<DateTime>(reportingMonth.value);
    }
    if (community.present) {
      map['community'] = Variable<String>(community.value);
    }
    if (submittedByName.present) {
      map['submitted_by_name'] = Variable<String>(submittedByName.value);
    }
    if (submittedByPosition.present) {
      map['submitted_by_position'] = Variable<String>(
        submittedByPosition.value,
      );
    }
    if (dateSubmitted.present) {
      map['date_submitted'] = Variable<DateTime>(dateSubmitted.value);
    }
    if (pregnantWomenCount.present) {
      map['pregnant_women_count'] = Variable<int>(pregnantWomenCount.value);
    }
    if (deliveriesTotal.present) {
      map['deliveries_total'] = Variable<int>(deliveriesTotal.value);
    }
    if (deliveriesAtFacility.present) {
      map['deliveries_at_facility'] = Variable<int>(deliveriesAtFacility.value);
    }
    if (deliveriesAtHome.present) {
      map['deliveries_at_home'] = Variable<int>(deliveriesAtHome.value);
    }
    if (maternalDeaths.present) {
      map['maternal_deaths'] = Variable<int>(maternalDeaths.value);
    }
    if (placeOfDeath.present) {
      map['place_of_death'] = Variable<String>(
        $LocalReportsTable.$converterplaceOfDeath.toSql(placeOfDeath.value),
      );
    }
    if (placeOfDeathOtherNote.present) {
      map['place_of_death_other_note'] = Variable<String>(
        placeOfDeathOtherNote.value,
      );
    }
    if (suspectedMaternalCause.present) {
      map['suspected_maternal_cause'] = Variable<String>(
        suspectedMaternalCause.value,
      );
    }
    if (liveBirths.present) {
      map['live_births'] = Variable<int>(liveBirths.value);
    }
    if (infantDeathsTotal.present) {
      map['infant_deaths_total'] = Variable<int>(infantDeathsTotal.value);
    }
    if (infantDeathsWithin24h.present) {
      map['infant_deaths_within24h'] = Variable<int>(
        infantDeathsWithin24h.value,
      );
    }
    if (infantDeathsWithin1Month.present) {
      map['infant_deaths_within1_month'] = Variable<int>(
        infantDeathsWithin1Month.value,
      );
    }
    if (infantDeathsWithin12Months.present) {
      map['infant_deaths_within12_months'] = Variable<int>(
        infantDeathsWithin12Months.value,
      );
    }
    if (infantDeathCauses.present) {
      map['infant_death_causes'] = Variable<String>(
        $LocalReportsTable.$converterinfantDeathCauses.toSql(
          infantDeathCauses.value,
        ),
      );
    }
    if (infantDeathCausesOtherNote.present) {
      map['infant_death_causes_other_note'] = Variable<String>(
        infantDeathCausesOtherNote.value,
      );
    }
    if (keyChallenges.present) {
      map['key_challenges'] = Variable<String>(keyChallenges.value);
    }
    if (actionsTaken.present) {
      map['actions_taken'] = Variable<String>(actionsTaken.value);
    }
    if (additionalComments.present) {
      map['additional_comments'] = Variable<String>(additionalComments.value);
    }
    if (clientCreatedAt.present) {
      map['client_created_at'] = Variable<DateTime>(clientCreatedAt.value);
    }
    if (clientUpdatedAt.present) {
      map['client_updated_at'] = Variable<DateTime>(clientUpdatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LocalReportsCompanion(')
          ..write('id: $id, ')
          ..write('clientId: $clientId, ')
          ..write('serverId: $serverId, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('syncError: $syncError, ')
          ..write('lastSyncAttemptAt: $lastSyncAttemptAt, ')
          ..write('reportingMonth: $reportingMonth, ')
          ..write('community: $community, ')
          ..write('submittedByName: $submittedByName, ')
          ..write('submittedByPosition: $submittedByPosition, ')
          ..write('dateSubmitted: $dateSubmitted, ')
          ..write('pregnantWomenCount: $pregnantWomenCount, ')
          ..write('deliveriesTotal: $deliveriesTotal, ')
          ..write('deliveriesAtFacility: $deliveriesAtFacility, ')
          ..write('deliveriesAtHome: $deliveriesAtHome, ')
          ..write('maternalDeaths: $maternalDeaths, ')
          ..write('placeOfDeath: $placeOfDeath, ')
          ..write('placeOfDeathOtherNote: $placeOfDeathOtherNote, ')
          ..write('suspectedMaternalCause: $suspectedMaternalCause, ')
          ..write('liveBirths: $liveBirths, ')
          ..write('infantDeathsTotal: $infantDeathsTotal, ')
          ..write('infantDeathsWithin24h: $infantDeathsWithin24h, ')
          ..write('infantDeathsWithin1Month: $infantDeathsWithin1Month, ')
          ..write('infantDeathsWithin12Months: $infantDeathsWithin12Months, ')
          ..write('infantDeathCauses: $infantDeathCauses, ')
          ..write('infantDeathCausesOtherNote: $infantDeathCausesOtherNote, ')
          ..write('keyChallenges: $keyChallenges, ')
          ..write('actionsTaken: $actionsTaken, ')
          ..write('additionalComments: $additionalComments, ')
          ..write('clientCreatedAt: $clientCreatedAt, ')
          ..write('clientUpdatedAt: $clientUpdatedAt')
          ..write(')'))
        .toString();
  }
}

class $LocalEducationSurveysTable extends LocalEducationSurveys
    with TableInfo<$LocalEducationSurveysTable, LocalEducationSurvey> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LocalEducationSurveysTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _clientIdMeta = const VerificationMeta(
    'clientId',
  );
  @override
  late final GeneratedColumn<String> clientId = GeneratedColumn<String>(
    'client_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _serverIdMeta = const VerificationMeta(
    'serverId',
  );
  @override
  late final GeneratedColumn<String> serverId = GeneratedColumn<String>(
    'server_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  late final GeneratedColumnWithTypeConverter<SyncStatus, String> syncStatus =
      GeneratedColumn<String>(
        'sync_status',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<SyncStatus>(
        $LocalEducationSurveysTable.$convertersyncStatus,
      );
  static const VerificationMeta _syncErrorMeta = const VerificationMeta(
    'syncError',
  );
  @override
  late final GeneratedColumn<String> syncError = GeneratedColumn<String>(
    'sync_error',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _lastSyncAttemptAtMeta = const VerificationMeta(
    'lastSyncAttemptAt',
  );
  @override
  late final GeneratedColumn<DateTime> lastSyncAttemptAt =
      GeneratedColumn<DateTime>(
        'last_sync_attempt_at',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _enumeratorNameMeta = const VerificationMeta(
    'enumeratorName',
  );
  @override
  late final GeneratedColumn<String> enumeratorName = GeneratedColumn<String>(
    'enumerator_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _surveyDateMeta = const VerificationMeta(
    'surveyDate',
  );
  @override
  late final GeneratedColumn<DateTime> surveyDate = GeneratedColumn<DateTime>(
    'survey_date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _communityOrSchoolMeta = const VerificationMeta(
    'communityOrSchool',
  );
  @override
  late final GeneratedColumn<String> communityOrSchool =
      GeneratedColumn<String>(
        'community_or_school',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _districtMeta = const VerificationMeta(
    'district',
  );
  @override
  late final GeneratedColumn<String> district = GeneratedColumn<String>(
    'district',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _respondentNameMeta = const VerificationMeta(
    'respondentName',
  );
  @override
  late final GeneratedColumn<String> respondentName = GeneratedColumn<String>(
    'respondent_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _respondentCategoryMeta =
      const VerificationMeta('respondentCategory');
  @override
  late final GeneratedColumn<String> respondentCategory =
      GeneratedColumn<String>(
        'respondent_category',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _sexMeta = const VerificationMeta('sex');
  @override
  late final GeneratedColumn<String> sex = GeneratedColumn<String>(
    'sex',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _answersJsonMeta = const VerificationMeta(
    'answersJson',
  );
  @override
  late final GeneratedColumn<String> answersJson = GeneratedColumn<String>(
    'answers_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _clientCreatedAtMeta = const VerificationMeta(
    'clientCreatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> clientCreatedAt =
      GeneratedColumn<DateTime>(
        'client_created_at',
        aliasedName,
        false,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _clientUpdatedAtMeta = const VerificationMeta(
    'clientUpdatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> clientUpdatedAt =
      GeneratedColumn<DateTime>(
        'client_updated_at',
        aliasedName,
        false,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: true,
      );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    clientId,
    serverId,
    syncStatus,
    syncError,
    lastSyncAttemptAt,
    enumeratorName,
    surveyDate,
    communityOrSchool,
    district,
    respondentName,
    respondentCategory,
    sex,
    answersJson,
    clientCreatedAt,
    clientUpdatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'local_education_surveys';
  @override
  VerificationContext validateIntegrity(
    Insertable<LocalEducationSurvey> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('client_id')) {
      context.handle(
        _clientIdMeta,
        clientId.isAcceptableOrUnknown(data['client_id']!, _clientIdMeta),
      );
    } else if (isInserting) {
      context.missing(_clientIdMeta);
    }
    if (data.containsKey('server_id')) {
      context.handle(
        _serverIdMeta,
        serverId.isAcceptableOrUnknown(data['server_id']!, _serverIdMeta),
      );
    }
    if (data.containsKey('sync_error')) {
      context.handle(
        _syncErrorMeta,
        syncError.isAcceptableOrUnknown(data['sync_error']!, _syncErrorMeta),
      );
    }
    if (data.containsKey('last_sync_attempt_at')) {
      context.handle(
        _lastSyncAttemptAtMeta,
        lastSyncAttemptAt.isAcceptableOrUnknown(
          data['last_sync_attempt_at']!,
          _lastSyncAttemptAtMeta,
        ),
      );
    }
    if (data.containsKey('enumerator_name')) {
      context.handle(
        _enumeratorNameMeta,
        enumeratorName.isAcceptableOrUnknown(
          data['enumerator_name']!,
          _enumeratorNameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_enumeratorNameMeta);
    }
    if (data.containsKey('survey_date')) {
      context.handle(
        _surveyDateMeta,
        surveyDate.isAcceptableOrUnknown(data['survey_date']!, _surveyDateMeta),
      );
    } else if (isInserting) {
      context.missing(_surveyDateMeta);
    }
    if (data.containsKey('community_or_school')) {
      context.handle(
        _communityOrSchoolMeta,
        communityOrSchool.isAcceptableOrUnknown(
          data['community_or_school']!,
          _communityOrSchoolMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_communityOrSchoolMeta);
    }
    if (data.containsKey('district')) {
      context.handle(
        _districtMeta,
        district.isAcceptableOrUnknown(data['district']!, _districtMeta),
      );
    } else if (isInserting) {
      context.missing(_districtMeta);
    }
    if (data.containsKey('respondent_name')) {
      context.handle(
        _respondentNameMeta,
        respondentName.isAcceptableOrUnknown(
          data['respondent_name']!,
          _respondentNameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_respondentNameMeta);
    }
    if (data.containsKey('respondent_category')) {
      context.handle(
        _respondentCategoryMeta,
        respondentCategory.isAcceptableOrUnknown(
          data['respondent_category']!,
          _respondentCategoryMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_respondentCategoryMeta);
    }
    if (data.containsKey('sex')) {
      context.handle(
        _sexMeta,
        sex.isAcceptableOrUnknown(data['sex']!, _sexMeta),
      );
    } else if (isInserting) {
      context.missing(_sexMeta);
    }
    if (data.containsKey('answers_json')) {
      context.handle(
        _answersJsonMeta,
        answersJson.isAcceptableOrUnknown(
          data['answers_json']!,
          _answersJsonMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_answersJsonMeta);
    }
    if (data.containsKey('client_created_at')) {
      context.handle(
        _clientCreatedAtMeta,
        clientCreatedAt.isAcceptableOrUnknown(
          data['client_created_at']!,
          _clientCreatedAtMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_clientCreatedAtMeta);
    }
    if (data.containsKey('client_updated_at')) {
      context.handle(
        _clientUpdatedAtMeta,
        clientUpdatedAt.isAcceptableOrUnknown(
          data['client_updated_at']!,
          _clientUpdatedAtMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_clientUpdatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LocalEducationSurvey map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LocalEducationSurvey(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      clientId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}client_id'],
      )!,
      serverId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}server_id'],
      ),
      syncStatus: $LocalEducationSurveysTable.$convertersyncStatus.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}sync_status'],
        )!,
      ),
      syncError: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sync_error'],
      ),
      lastSyncAttemptAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_sync_attempt_at'],
      ),
      enumeratorName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}enumerator_name'],
      )!,
      surveyDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}survey_date'],
      )!,
      communityOrSchool: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}community_or_school'],
      )!,
      district: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}district'],
      )!,
      respondentName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}respondent_name'],
      )!,
      respondentCategory: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}respondent_category'],
      )!,
      sex: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sex'],
      )!,
      answersJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}answers_json'],
      )!,
      clientCreatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}client_created_at'],
      )!,
      clientUpdatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}client_updated_at'],
      )!,
    );
  }

  @override
  $LocalEducationSurveysTable createAlias(String alias) {
    return $LocalEducationSurveysTable(attachedDatabase, alias);
  }

  static TypeConverter<SyncStatus, String> $convertersyncStatus =
      const SyncStatusConverter();
}

class LocalEducationSurvey extends DataClass
    implements Insertable<LocalEducationSurvey> {
  final int id;
  final String clientId;
  final String? serverId;
  final SyncStatus syncStatus;
  final String? syncError;
  final DateTime? lastSyncAttemptAt;
  final String enumeratorName;
  final DateTime surveyDate;
  final String communityOrSchool;
  final String district;
  final String respondentName;
  final String respondentCategory;
  final String sex;
  final String answersJson;
  final DateTime clientCreatedAt;
  final DateTime clientUpdatedAt;
  const LocalEducationSurvey({
    required this.id,
    required this.clientId,
    this.serverId,
    required this.syncStatus,
    this.syncError,
    this.lastSyncAttemptAt,
    required this.enumeratorName,
    required this.surveyDate,
    required this.communityOrSchool,
    required this.district,
    required this.respondentName,
    required this.respondentCategory,
    required this.sex,
    required this.answersJson,
    required this.clientCreatedAt,
    required this.clientUpdatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['client_id'] = Variable<String>(clientId);
    if (!nullToAbsent || serverId != null) {
      map['server_id'] = Variable<String>(serverId);
    }
    {
      map['sync_status'] = Variable<String>(
        $LocalEducationSurveysTable.$convertersyncStatus.toSql(syncStatus),
      );
    }
    if (!nullToAbsent || syncError != null) {
      map['sync_error'] = Variable<String>(syncError);
    }
    if (!nullToAbsent || lastSyncAttemptAt != null) {
      map['last_sync_attempt_at'] = Variable<DateTime>(lastSyncAttemptAt);
    }
    map['enumerator_name'] = Variable<String>(enumeratorName);
    map['survey_date'] = Variable<DateTime>(surveyDate);
    map['community_or_school'] = Variable<String>(communityOrSchool);
    map['district'] = Variable<String>(district);
    map['respondent_name'] = Variable<String>(respondentName);
    map['respondent_category'] = Variable<String>(respondentCategory);
    map['sex'] = Variable<String>(sex);
    map['answers_json'] = Variable<String>(answersJson);
    map['client_created_at'] = Variable<DateTime>(clientCreatedAt);
    map['client_updated_at'] = Variable<DateTime>(clientUpdatedAt);
    return map;
  }

  LocalEducationSurveysCompanion toCompanion(bool nullToAbsent) {
    return LocalEducationSurveysCompanion(
      id: Value(id),
      clientId: Value(clientId),
      serverId: serverId == null && nullToAbsent
          ? const Value.absent()
          : Value(serverId),
      syncStatus: Value(syncStatus),
      syncError: syncError == null && nullToAbsent
          ? const Value.absent()
          : Value(syncError),
      lastSyncAttemptAt: lastSyncAttemptAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastSyncAttemptAt),
      enumeratorName: Value(enumeratorName),
      surveyDate: Value(surveyDate),
      communityOrSchool: Value(communityOrSchool),
      district: Value(district),
      respondentName: Value(respondentName),
      respondentCategory: Value(respondentCategory),
      sex: Value(sex),
      answersJson: Value(answersJson),
      clientCreatedAt: Value(clientCreatedAt),
      clientUpdatedAt: Value(clientUpdatedAt),
    );
  }

  factory LocalEducationSurvey.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LocalEducationSurvey(
      id: serializer.fromJson<int>(json['id']),
      clientId: serializer.fromJson<String>(json['clientId']),
      serverId: serializer.fromJson<String?>(json['serverId']),
      syncStatus: serializer.fromJson<SyncStatus>(json['syncStatus']),
      syncError: serializer.fromJson<String?>(json['syncError']),
      lastSyncAttemptAt: serializer.fromJson<DateTime?>(
        json['lastSyncAttemptAt'],
      ),
      enumeratorName: serializer.fromJson<String>(json['enumeratorName']),
      surveyDate: serializer.fromJson<DateTime>(json['surveyDate']),
      communityOrSchool: serializer.fromJson<String>(json['communityOrSchool']),
      district: serializer.fromJson<String>(json['district']),
      respondentName: serializer.fromJson<String>(json['respondentName']),
      respondentCategory: serializer.fromJson<String>(
        json['respondentCategory'],
      ),
      sex: serializer.fromJson<String>(json['sex']),
      answersJson: serializer.fromJson<String>(json['answersJson']),
      clientCreatedAt: serializer.fromJson<DateTime>(json['clientCreatedAt']),
      clientUpdatedAt: serializer.fromJson<DateTime>(json['clientUpdatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'clientId': serializer.toJson<String>(clientId),
      'serverId': serializer.toJson<String?>(serverId),
      'syncStatus': serializer.toJson<SyncStatus>(syncStatus),
      'syncError': serializer.toJson<String?>(syncError),
      'lastSyncAttemptAt': serializer.toJson<DateTime?>(lastSyncAttemptAt),
      'enumeratorName': serializer.toJson<String>(enumeratorName),
      'surveyDate': serializer.toJson<DateTime>(surveyDate),
      'communityOrSchool': serializer.toJson<String>(communityOrSchool),
      'district': serializer.toJson<String>(district),
      'respondentName': serializer.toJson<String>(respondentName),
      'respondentCategory': serializer.toJson<String>(respondentCategory),
      'sex': serializer.toJson<String>(sex),
      'answersJson': serializer.toJson<String>(answersJson),
      'clientCreatedAt': serializer.toJson<DateTime>(clientCreatedAt),
      'clientUpdatedAt': serializer.toJson<DateTime>(clientUpdatedAt),
    };
  }

  LocalEducationSurvey copyWith({
    int? id,
    String? clientId,
    Value<String?> serverId = const Value.absent(),
    SyncStatus? syncStatus,
    Value<String?> syncError = const Value.absent(),
    Value<DateTime?> lastSyncAttemptAt = const Value.absent(),
    String? enumeratorName,
    DateTime? surveyDate,
    String? communityOrSchool,
    String? district,
    String? respondentName,
    String? respondentCategory,
    String? sex,
    String? answersJson,
    DateTime? clientCreatedAt,
    DateTime? clientUpdatedAt,
  }) => LocalEducationSurvey(
    id: id ?? this.id,
    clientId: clientId ?? this.clientId,
    serverId: serverId.present ? serverId.value : this.serverId,
    syncStatus: syncStatus ?? this.syncStatus,
    syncError: syncError.present ? syncError.value : this.syncError,
    lastSyncAttemptAt: lastSyncAttemptAt.present
        ? lastSyncAttemptAt.value
        : this.lastSyncAttemptAt,
    enumeratorName: enumeratorName ?? this.enumeratorName,
    surveyDate: surveyDate ?? this.surveyDate,
    communityOrSchool: communityOrSchool ?? this.communityOrSchool,
    district: district ?? this.district,
    respondentName: respondentName ?? this.respondentName,
    respondentCategory: respondentCategory ?? this.respondentCategory,
    sex: sex ?? this.sex,
    answersJson: answersJson ?? this.answersJson,
    clientCreatedAt: clientCreatedAt ?? this.clientCreatedAt,
    clientUpdatedAt: clientUpdatedAt ?? this.clientUpdatedAt,
  );
  LocalEducationSurvey copyWithCompanion(LocalEducationSurveysCompanion data) {
    return LocalEducationSurvey(
      id: data.id.present ? data.id.value : this.id,
      clientId: data.clientId.present ? data.clientId.value : this.clientId,
      serverId: data.serverId.present ? data.serverId.value : this.serverId,
      syncStatus: data.syncStatus.present
          ? data.syncStatus.value
          : this.syncStatus,
      syncError: data.syncError.present ? data.syncError.value : this.syncError,
      lastSyncAttemptAt: data.lastSyncAttemptAt.present
          ? data.lastSyncAttemptAt.value
          : this.lastSyncAttemptAt,
      enumeratorName: data.enumeratorName.present
          ? data.enumeratorName.value
          : this.enumeratorName,
      surveyDate: data.surveyDate.present
          ? data.surveyDate.value
          : this.surveyDate,
      communityOrSchool: data.communityOrSchool.present
          ? data.communityOrSchool.value
          : this.communityOrSchool,
      district: data.district.present ? data.district.value : this.district,
      respondentName: data.respondentName.present
          ? data.respondentName.value
          : this.respondentName,
      respondentCategory: data.respondentCategory.present
          ? data.respondentCategory.value
          : this.respondentCategory,
      sex: data.sex.present ? data.sex.value : this.sex,
      answersJson: data.answersJson.present
          ? data.answersJson.value
          : this.answersJson,
      clientCreatedAt: data.clientCreatedAt.present
          ? data.clientCreatedAt.value
          : this.clientCreatedAt,
      clientUpdatedAt: data.clientUpdatedAt.present
          ? data.clientUpdatedAt.value
          : this.clientUpdatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LocalEducationSurvey(')
          ..write('id: $id, ')
          ..write('clientId: $clientId, ')
          ..write('serverId: $serverId, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('syncError: $syncError, ')
          ..write('lastSyncAttemptAt: $lastSyncAttemptAt, ')
          ..write('enumeratorName: $enumeratorName, ')
          ..write('surveyDate: $surveyDate, ')
          ..write('communityOrSchool: $communityOrSchool, ')
          ..write('district: $district, ')
          ..write('respondentName: $respondentName, ')
          ..write('respondentCategory: $respondentCategory, ')
          ..write('sex: $sex, ')
          ..write('answersJson: $answersJson, ')
          ..write('clientCreatedAt: $clientCreatedAt, ')
          ..write('clientUpdatedAt: $clientUpdatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    clientId,
    serverId,
    syncStatus,
    syncError,
    lastSyncAttemptAt,
    enumeratorName,
    surveyDate,
    communityOrSchool,
    district,
    respondentName,
    respondentCategory,
    sex,
    answersJson,
    clientCreatedAt,
    clientUpdatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LocalEducationSurvey &&
          other.id == this.id &&
          other.clientId == this.clientId &&
          other.serverId == this.serverId &&
          other.syncStatus == this.syncStatus &&
          other.syncError == this.syncError &&
          other.lastSyncAttemptAt == this.lastSyncAttemptAt &&
          other.enumeratorName == this.enumeratorName &&
          other.surveyDate == this.surveyDate &&
          other.communityOrSchool == this.communityOrSchool &&
          other.district == this.district &&
          other.respondentName == this.respondentName &&
          other.respondentCategory == this.respondentCategory &&
          other.sex == this.sex &&
          other.answersJson == this.answersJson &&
          other.clientCreatedAt == this.clientCreatedAt &&
          other.clientUpdatedAt == this.clientUpdatedAt);
}

class LocalEducationSurveysCompanion
    extends UpdateCompanion<LocalEducationSurvey> {
  final Value<int> id;
  final Value<String> clientId;
  final Value<String?> serverId;
  final Value<SyncStatus> syncStatus;
  final Value<String?> syncError;
  final Value<DateTime?> lastSyncAttemptAt;
  final Value<String> enumeratorName;
  final Value<DateTime> surveyDate;
  final Value<String> communityOrSchool;
  final Value<String> district;
  final Value<String> respondentName;
  final Value<String> respondentCategory;
  final Value<String> sex;
  final Value<String> answersJson;
  final Value<DateTime> clientCreatedAt;
  final Value<DateTime> clientUpdatedAt;
  const LocalEducationSurveysCompanion({
    this.id = const Value.absent(),
    this.clientId = const Value.absent(),
    this.serverId = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.syncError = const Value.absent(),
    this.lastSyncAttemptAt = const Value.absent(),
    this.enumeratorName = const Value.absent(),
    this.surveyDate = const Value.absent(),
    this.communityOrSchool = const Value.absent(),
    this.district = const Value.absent(),
    this.respondentName = const Value.absent(),
    this.respondentCategory = const Value.absent(),
    this.sex = const Value.absent(),
    this.answersJson = const Value.absent(),
    this.clientCreatedAt = const Value.absent(),
    this.clientUpdatedAt = const Value.absent(),
  });
  LocalEducationSurveysCompanion.insert({
    this.id = const Value.absent(),
    required String clientId,
    this.serverId = const Value.absent(),
    required SyncStatus syncStatus,
    this.syncError = const Value.absent(),
    this.lastSyncAttemptAt = const Value.absent(),
    required String enumeratorName,
    required DateTime surveyDate,
    required String communityOrSchool,
    required String district,
    required String respondentName,
    required String respondentCategory,
    required String sex,
    required String answersJson,
    required DateTime clientCreatedAt,
    required DateTime clientUpdatedAt,
  }) : clientId = Value(clientId),
       syncStatus = Value(syncStatus),
       enumeratorName = Value(enumeratorName),
       surveyDate = Value(surveyDate),
       communityOrSchool = Value(communityOrSchool),
       district = Value(district),
       respondentName = Value(respondentName),
       respondentCategory = Value(respondentCategory),
       sex = Value(sex),
       answersJson = Value(answersJson),
       clientCreatedAt = Value(clientCreatedAt),
       clientUpdatedAt = Value(clientUpdatedAt);
  static Insertable<LocalEducationSurvey> custom({
    Expression<int>? id,
    Expression<String>? clientId,
    Expression<String>? serverId,
    Expression<String>? syncStatus,
    Expression<String>? syncError,
    Expression<DateTime>? lastSyncAttemptAt,
    Expression<String>? enumeratorName,
    Expression<DateTime>? surveyDate,
    Expression<String>? communityOrSchool,
    Expression<String>? district,
    Expression<String>? respondentName,
    Expression<String>? respondentCategory,
    Expression<String>? sex,
    Expression<String>? answersJson,
    Expression<DateTime>? clientCreatedAt,
    Expression<DateTime>? clientUpdatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (clientId != null) 'client_id': clientId,
      if (serverId != null) 'server_id': serverId,
      if (syncStatus != null) 'sync_status': syncStatus,
      if (syncError != null) 'sync_error': syncError,
      if (lastSyncAttemptAt != null) 'last_sync_attempt_at': lastSyncAttemptAt,
      if (enumeratorName != null) 'enumerator_name': enumeratorName,
      if (surveyDate != null) 'survey_date': surveyDate,
      if (communityOrSchool != null) 'community_or_school': communityOrSchool,
      if (district != null) 'district': district,
      if (respondentName != null) 'respondent_name': respondentName,
      if (respondentCategory != null) 'respondent_category': respondentCategory,
      if (sex != null) 'sex': sex,
      if (answersJson != null) 'answers_json': answersJson,
      if (clientCreatedAt != null) 'client_created_at': clientCreatedAt,
      if (clientUpdatedAt != null) 'client_updated_at': clientUpdatedAt,
    });
  }

  LocalEducationSurveysCompanion copyWith({
    Value<int>? id,
    Value<String>? clientId,
    Value<String?>? serverId,
    Value<SyncStatus>? syncStatus,
    Value<String?>? syncError,
    Value<DateTime?>? lastSyncAttemptAt,
    Value<String>? enumeratorName,
    Value<DateTime>? surveyDate,
    Value<String>? communityOrSchool,
    Value<String>? district,
    Value<String>? respondentName,
    Value<String>? respondentCategory,
    Value<String>? sex,
    Value<String>? answersJson,
    Value<DateTime>? clientCreatedAt,
    Value<DateTime>? clientUpdatedAt,
  }) {
    return LocalEducationSurveysCompanion(
      id: id ?? this.id,
      clientId: clientId ?? this.clientId,
      serverId: serverId ?? this.serverId,
      syncStatus: syncStatus ?? this.syncStatus,
      syncError: syncError ?? this.syncError,
      lastSyncAttemptAt: lastSyncAttemptAt ?? this.lastSyncAttemptAt,
      enumeratorName: enumeratorName ?? this.enumeratorName,
      surveyDate: surveyDate ?? this.surveyDate,
      communityOrSchool: communityOrSchool ?? this.communityOrSchool,
      district: district ?? this.district,
      respondentName: respondentName ?? this.respondentName,
      respondentCategory: respondentCategory ?? this.respondentCategory,
      sex: sex ?? this.sex,
      answersJson: answersJson ?? this.answersJson,
      clientCreatedAt: clientCreatedAt ?? this.clientCreatedAt,
      clientUpdatedAt: clientUpdatedAt ?? this.clientUpdatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (clientId.present) {
      map['client_id'] = Variable<String>(clientId.value);
    }
    if (serverId.present) {
      map['server_id'] = Variable<String>(serverId.value);
    }
    if (syncStatus.present) {
      map['sync_status'] = Variable<String>(
        $LocalEducationSurveysTable.$convertersyncStatus.toSql(
          syncStatus.value,
        ),
      );
    }
    if (syncError.present) {
      map['sync_error'] = Variable<String>(syncError.value);
    }
    if (lastSyncAttemptAt.present) {
      map['last_sync_attempt_at'] = Variable<DateTime>(lastSyncAttemptAt.value);
    }
    if (enumeratorName.present) {
      map['enumerator_name'] = Variable<String>(enumeratorName.value);
    }
    if (surveyDate.present) {
      map['survey_date'] = Variable<DateTime>(surveyDate.value);
    }
    if (communityOrSchool.present) {
      map['community_or_school'] = Variable<String>(communityOrSchool.value);
    }
    if (district.present) {
      map['district'] = Variable<String>(district.value);
    }
    if (respondentName.present) {
      map['respondent_name'] = Variable<String>(respondentName.value);
    }
    if (respondentCategory.present) {
      map['respondent_category'] = Variable<String>(respondentCategory.value);
    }
    if (sex.present) {
      map['sex'] = Variable<String>(sex.value);
    }
    if (answersJson.present) {
      map['answers_json'] = Variable<String>(answersJson.value);
    }
    if (clientCreatedAt.present) {
      map['client_created_at'] = Variable<DateTime>(clientCreatedAt.value);
    }
    if (clientUpdatedAt.present) {
      map['client_updated_at'] = Variable<DateTime>(clientUpdatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LocalEducationSurveysCompanion(')
          ..write('id: $id, ')
          ..write('clientId: $clientId, ')
          ..write('serverId: $serverId, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('syncError: $syncError, ')
          ..write('lastSyncAttemptAt: $lastSyncAttemptAt, ')
          ..write('enumeratorName: $enumeratorName, ')
          ..write('surveyDate: $surveyDate, ')
          ..write('communityOrSchool: $communityOrSchool, ')
          ..write('district: $district, ')
          ..write('respondentName: $respondentName, ')
          ..write('respondentCategory: $respondentCategory, ')
          ..write('sex: $sex, ')
          ..write('answersJson: $answersJson, ')
          ..write('clientCreatedAt: $clientCreatedAt, ')
          ..write('clientUpdatedAt: $clientUpdatedAt')
          ..write(')'))
        .toString();
  }
}

class $LocalMaternalSurveysTable extends LocalMaternalSurveys
    with TableInfo<$LocalMaternalSurveysTable, LocalMaternalSurvey> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LocalMaternalSurveysTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _clientIdMeta = const VerificationMeta(
    'clientId',
  );
  @override
  late final GeneratedColumn<String> clientId = GeneratedColumn<String>(
    'client_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _serverIdMeta = const VerificationMeta(
    'serverId',
  );
  @override
  late final GeneratedColumn<String> serverId = GeneratedColumn<String>(
    'server_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  late final GeneratedColumnWithTypeConverter<SyncStatus, String> syncStatus =
      GeneratedColumn<String>(
        'sync_status',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<SyncStatus>(
        $LocalMaternalSurveysTable.$convertersyncStatus,
      );
  static const VerificationMeta _syncErrorMeta = const VerificationMeta(
    'syncError',
  );
  @override
  late final GeneratedColumn<String> syncError = GeneratedColumn<String>(
    'sync_error',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _lastSyncAttemptAtMeta = const VerificationMeta(
    'lastSyncAttemptAt',
  );
  @override
  late final GeneratedColumn<DateTime> lastSyncAttemptAt =
      GeneratedColumn<DateTime>(
        'last_sync_attempt_at',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _enumeratorNameMeta = const VerificationMeta(
    'enumeratorName',
  );
  @override
  late final GeneratedColumn<String> enumeratorName = GeneratedColumn<String>(
    'enumerator_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _surveyDateMeta = const VerificationMeta(
    'surveyDate',
  );
  @override
  late final GeneratedColumn<DateTime> surveyDate = GeneratedColumn<DateTime>(
    'survey_date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _communityMeta = const VerificationMeta(
    'community',
  );
  @override
  late final GeneratedColumn<String> community = GeneratedColumn<String>(
    'community',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _healthFacilityMeta = const VerificationMeta(
    'healthFacility',
  );
  @override
  late final GeneratedColumn<String> healthFacility = GeneratedColumn<String>(
    'health_facility',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _districtMeta = const VerificationMeta(
    'district',
  );
  @override
  late final GeneratedColumn<String> district = GeneratedColumn<String>(
    'district',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _respondentNameMeta = const VerificationMeta(
    'respondentName',
  );
  @override
  late final GeneratedColumn<String> respondentName = GeneratedColumn<String>(
    'respondent_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _respondentCategoryMeta =
      const VerificationMeta('respondentCategory');
  @override
  late final GeneratedColumn<String> respondentCategory =
      GeneratedColumn<String>(
        'respondent_category',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _sexMeta = const VerificationMeta('sex');
  @override
  late final GeneratedColumn<String> sex = GeneratedColumn<String>(
    'sex',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _answersJsonMeta = const VerificationMeta(
    'answersJson',
  );
  @override
  late final GeneratedColumn<String> answersJson = GeneratedColumn<String>(
    'answers_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _clientCreatedAtMeta = const VerificationMeta(
    'clientCreatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> clientCreatedAt =
      GeneratedColumn<DateTime>(
        'client_created_at',
        aliasedName,
        false,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _clientUpdatedAtMeta = const VerificationMeta(
    'clientUpdatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> clientUpdatedAt =
      GeneratedColumn<DateTime>(
        'client_updated_at',
        aliasedName,
        false,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: true,
      );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    clientId,
    serverId,
    syncStatus,
    syncError,
    lastSyncAttemptAt,
    enumeratorName,
    surveyDate,
    community,
    healthFacility,
    district,
    respondentName,
    respondentCategory,
    sex,
    answersJson,
    clientCreatedAt,
    clientUpdatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'local_maternal_surveys';
  @override
  VerificationContext validateIntegrity(
    Insertable<LocalMaternalSurvey> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('client_id')) {
      context.handle(
        _clientIdMeta,
        clientId.isAcceptableOrUnknown(data['client_id']!, _clientIdMeta),
      );
    } else if (isInserting) {
      context.missing(_clientIdMeta);
    }
    if (data.containsKey('server_id')) {
      context.handle(
        _serverIdMeta,
        serverId.isAcceptableOrUnknown(data['server_id']!, _serverIdMeta),
      );
    }
    if (data.containsKey('sync_error')) {
      context.handle(
        _syncErrorMeta,
        syncError.isAcceptableOrUnknown(data['sync_error']!, _syncErrorMeta),
      );
    }
    if (data.containsKey('last_sync_attempt_at')) {
      context.handle(
        _lastSyncAttemptAtMeta,
        lastSyncAttemptAt.isAcceptableOrUnknown(
          data['last_sync_attempt_at']!,
          _lastSyncAttemptAtMeta,
        ),
      );
    }
    if (data.containsKey('enumerator_name')) {
      context.handle(
        _enumeratorNameMeta,
        enumeratorName.isAcceptableOrUnknown(
          data['enumerator_name']!,
          _enumeratorNameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_enumeratorNameMeta);
    }
    if (data.containsKey('survey_date')) {
      context.handle(
        _surveyDateMeta,
        surveyDate.isAcceptableOrUnknown(data['survey_date']!, _surveyDateMeta),
      );
    } else if (isInserting) {
      context.missing(_surveyDateMeta);
    }
    if (data.containsKey('community')) {
      context.handle(
        _communityMeta,
        community.isAcceptableOrUnknown(data['community']!, _communityMeta),
      );
    } else if (isInserting) {
      context.missing(_communityMeta);
    }
    if (data.containsKey('health_facility')) {
      context.handle(
        _healthFacilityMeta,
        healthFacility.isAcceptableOrUnknown(
          data['health_facility']!,
          _healthFacilityMeta,
        ),
      );
    }
    if (data.containsKey('district')) {
      context.handle(
        _districtMeta,
        district.isAcceptableOrUnknown(data['district']!, _districtMeta),
      );
    } else if (isInserting) {
      context.missing(_districtMeta);
    }
    if (data.containsKey('respondent_name')) {
      context.handle(
        _respondentNameMeta,
        respondentName.isAcceptableOrUnknown(
          data['respondent_name']!,
          _respondentNameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_respondentNameMeta);
    }
    if (data.containsKey('respondent_category')) {
      context.handle(
        _respondentCategoryMeta,
        respondentCategory.isAcceptableOrUnknown(
          data['respondent_category']!,
          _respondentCategoryMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_respondentCategoryMeta);
    }
    if (data.containsKey('sex')) {
      context.handle(
        _sexMeta,
        sex.isAcceptableOrUnknown(data['sex']!, _sexMeta),
      );
    } else if (isInserting) {
      context.missing(_sexMeta);
    }
    if (data.containsKey('answers_json')) {
      context.handle(
        _answersJsonMeta,
        answersJson.isAcceptableOrUnknown(
          data['answers_json']!,
          _answersJsonMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_answersJsonMeta);
    }
    if (data.containsKey('client_created_at')) {
      context.handle(
        _clientCreatedAtMeta,
        clientCreatedAt.isAcceptableOrUnknown(
          data['client_created_at']!,
          _clientCreatedAtMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_clientCreatedAtMeta);
    }
    if (data.containsKey('client_updated_at')) {
      context.handle(
        _clientUpdatedAtMeta,
        clientUpdatedAt.isAcceptableOrUnknown(
          data['client_updated_at']!,
          _clientUpdatedAtMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_clientUpdatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LocalMaternalSurvey map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LocalMaternalSurvey(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      clientId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}client_id'],
      )!,
      serverId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}server_id'],
      ),
      syncStatus: $LocalMaternalSurveysTable.$convertersyncStatus.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}sync_status'],
        )!,
      ),
      syncError: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sync_error'],
      ),
      lastSyncAttemptAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_sync_attempt_at'],
      ),
      enumeratorName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}enumerator_name'],
      )!,
      surveyDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}survey_date'],
      )!,
      community: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}community'],
      )!,
      healthFacility: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}health_facility'],
      ),
      district: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}district'],
      )!,
      respondentName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}respondent_name'],
      )!,
      respondentCategory: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}respondent_category'],
      )!,
      sex: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sex'],
      )!,
      answersJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}answers_json'],
      )!,
      clientCreatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}client_created_at'],
      )!,
      clientUpdatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}client_updated_at'],
      )!,
    );
  }

  @override
  $LocalMaternalSurveysTable createAlias(String alias) {
    return $LocalMaternalSurveysTable(attachedDatabase, alias);
  }

  static TypeConverter<SyncStatus, String> $convertersyncStatus =
      const SyncStatusConverter();
}

class LocalMaternalSurvey extends DataClass
    implements Insertable<LocalMaternalSurvey> {
  final int id;
  final String clientId;
  final String? serverId;
  final SyncStatus syncStatus;
  final String? syncError;
  final DateTime? lastSyncAttemptAt;
  final String enumeratorName;
  final DateTime surveyDate;
  final String community;
  final String? healthFacility;
  final String district;
  final String respondentName;
  final String respondentCategory;
  final String sex;
  final String answersJson;
  final DateTime clientCreatedAt;
  final DateTime clientUpdatedAt;
  const LocalMaternalSurvey({
    required this.id,
    required this.clientId,
    this.serverId,
    required this.syncStatus,
    this.syncError,
    this.lastSyncAttemptAt,
    required this.enumeratorName,
    required this.surveyDate,
    required this.community,
    this.healthFacility,
    required this.district,
    required this.respondentName,
    required this.respondentCategory,
    required this.sex,
    required this.answersJson,
    required this.clientCreatedAt,
    required this.clientUpdatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['client_id'] = Variable<String>(clientId);
    if (!nullToAbsent || serverId != null) {
      map['server_id'] = Variable<String>(serverId);
    }
    {
      map['sync_status'] = Variable<String>(
        $LocalMaternalSurveysTable.$convertersyncStatus.toSql(syncStatus),
      );
    }
    if (!nullToAbsent || syncError != null) {
      map['sync_error'] = Variable<String>(syncError);
    }
    if (!nullToAbsent || lastSyncAttemptAt != null) {
      map['last_sync_attempt_at'] = Variable<DateTime>(lastSyncAttemptAt);
    }
    map['enumerator_name'] = Variable<String>(enumeratorName);
    map['survey_date'] = Variable<DateTime>(surveyDate);
    map['community'] = Variable<String>(community);
    if (!nullToAbsent || healthFacility != null) {
      map['health_facility'] = Variable<String>(healthFacility);
    }
    map['district'] = Variable<String>(district);
    map['respondent_name'] = Variable<String>(respondentName);
    map['respondent_category'] = Variable<String>(respondentCategory);
    map['sex'] = Variable<String>(sex);
    map['answers_json'] = Variable<String>(answersJson);
    map['client_created_at'] = Variable<DateTime>(clientCreatedAt);
    map['client_updated_at'] = Variable<DateTime>(clientUpdatedAt);
    return map;
  }

  LocalMaternalSurveysCompanion toCompanion(bool nullToAbsent) {
    return LocalMaternalSurveysCompanion(
      id: Value(id),
      clientId: Value(clientId),
      serverId: serverId == null && nullToAbsent
          ? const Value.absent()
          : Value(serverId),
      syncStatus: Value(syncStatus),
      syncError: syncError == null && nullToAbsent
          ? const Value.absent()
          : Value(syncError),
      lastSyncAttemptAt: lastSyncAttemptAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastSyncAttemptAt),
      enumeratorName: Value(enumeratorName),
      surveyDate: Value(surveyDate),
      community: Value(community),
      healthFacility: healthFacility == null && nullToAbsent
          ? const Value.absent()
          : Value(healthFacility),
      district: Value(district),
      respondentName: Value(respondentName),
      respondentCategory: Value(respondentCategory),
      sex: Value(sex),
      answersJson: Value(answersJson),
      clientCreatedAt: Value(clientCreatedAt),
      clientUpdatedAt: Value(clientUpdatedAt),
    );
  }

  factory LocalMaternalSurvey.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LocalMaternalSurvey(
      id: serializer.fromJson<int>(json['id']),
      clientId: serializer.fromJson<String>(json['clientId']),
      serverId: serializer.fromJson<String?>(json['serverId']),
      syncStatus: serializer.fromJson<SyncStatus>(json['syncStatus']),
      syncError: serializer.fromJson<String?>(json['syncError']),
      lastSyncAttemptAt: serializer.fromJson<DateTime?>(
        json['lastSyncAttemptAt'],
      ),
      enumeratorName: serializer.fromJson<String>(json['enumeratorName']),
      surveyDate: serializer.fromJson<DateTime>(json['surveyDate']),
      community: serializer.fromJson<String>(json['community']),
      healthFacility: serializer.fromJson<String?>(json['healthFacility']),
      district: serializer.fromJson<String>(json['district']),
      respondentName: serializer.fromJson<String>(json['respondentName']),
      respondentCategory: serializer.fromJson<String>(
        json['respondentCategory'],
      ),
      sex: serializer.fromJson<String>(json['sex']),
      answersJson: serializer.fromJson<String>(json['answersJson']),
      clientCreatedAt: serializer.fromJson<DateTime>(json['clientCreatedAt']),
      clientUpdatedAt: serializer.fromJson<DateTime>(json['clientUpdatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'clientId': serializer.toJson<String>(clientId),
      'serverId': serializer.toJson<String?>(serverId),
      'syncStatus': serializer.toJson<SyncStatus>(syncStatus),
      'syncError': serializer.toJson<String?>(syncError),
      'lastSyncAttemptAt': serializer.toJson<DateTime?>(lastSyncAttemptAt),
      'enumeratorName': serializer.toJson<String>(enumeratorName),
      'surveyDate': serializer.toJson<DateTime>(surveyDate),
      'community': serializer.toJson<String>(community),
      'healthFacility': serializer.toJson<String?>(healthFacility),
      'district': serializer.toJson<String>(district),
      'respondentName': serializer.toJson<String>(respondentName),
      'respondentCategory': serializer.toJson<String>(respondentCategory),
      'sex': serializer.toJson<String>(sex),
      'answersJson': serializer.toJson<String>(answersJson),
      'clientCreatedAt': serializer.toJson<DateTime>(clientCreatedAt),
      'clientUpdatedAt': serializer.toJson<DateTime>(clientUpdatedAt),
    };
  }

  LocalMaternalSurvey copyWith({
    int? id,
    String? clientId,
    Value<String?> serverId = const Value.absent(),
    SyncStatus? syncStatus,
    Value<String?> syncError = const Value.absent(),
    Value<DateTime?> lastSyncAttemptAt = const Value.absent(),
    String? enumeratorName,
    DateTime? surveyDate,
    String? community,
    Value<String?> healthFacility = const Value.absent(),
    String? district,
    String? respondentName,
    String? respondentCategory,
    String? sex,
    String? answersJson,
    DateTime? clientCreatedAt,
    DateTime? clientUpdatedAt,
  }) => LocalMaternalSurvey(
    id: id ?? this.id,
    clientId: clientId ?? this.clientId,
    serverId: serverId.present ? serverId.value : this.serverId,
    syncStatus: syncStatus ?? this.syncStatus,
    syncError: syncError.present ? syncError.value : this.syncError,
    lastSyncAttemptAt: lastSyncAttemptAt.present
        ? lastSyncAttemptAt.value
        : this.lastSyncAttemptAt,
    enumeratorName: enumeratorName ?? this.enumeratorName,
    surveyDate: surveyDate ?? this.surveyDate,
    community: community ?? this.community,
    healthFacility: healthFacility.present
        ? healthFacility.value
        : this.healthFacility,
    district: district ?? this.district,
    respondentName: respondentName ?? this.respondentName,
    respondentCategory: respondentCategory ?? this.respondentCategory,
    sex: sex ?? this.sex,
    answersJson: answersJson ?? this.answersJson,
    clientCreatedAt: clientCreatedAt ?? this.clientCreatedAt,
    clientUpdatedAt: clientUpdatedAt ?? this.clientUpdatedAt,
  );
  LocalMaternalSurvey copyWithCompanion(LocalMaternalSurveysCompanion data) {
    return LocalMaternalSurvey(
      id: data.id.present ? data.id.value : this.id,
      clientId: data.clientId.present ? data.clientId.value : this.clientId,
      serverId: data.serverId.present ? data.serverId.value : this.serverId,
      syncStatus: data.syncStatus.present
          ? data.syncStatus.value
          : this.syncStatus,
      syncError: data.syncError.present ? data.syncError.value : this.syncError,
      lastSyncAttemptAt: data.lastSyncAttemptAt.present
          ? data.lastSyncAttemptAt.value
          : this.lastSyncAttemptAt,
      enumeratorName: data.enumeratorName.present
          ? data.enumeratorName.value
          : this.enumeratorName,
      surveyDate: data.surveyDate.present
          ? data.surveyDate.value
          : this.surveyDate,
      community: data.community.present ? data.community.value : this.community,
      healthFacility: data.healthFacility.present
          ? data.healthFacility.value
          : this.healthFacility,
      district: data.district.present ? data.district.value : this.district,
      respondentName: data.respondentName.present
          ? data.respondentName.value
          : this.respondentName,
      respondentCategory: data.respondentCategory.present
          ? data.respondentCategory.value
          : this.respondentCategory,
      sex: data.sex.present ? data.sex.value : this.sex,
      answersJson: data.answersJson.present
          ? data.answersJson.value
          : this.answersJson,
      clientCreatedAt: data.clientCreatedAt.present
          ? data.clientCreatedAt.value
          : this.clientCreatedAt,
      clientUpdatedAt: data.clientUpdatedAt.present
          ? data.clientUpdatedAt.value
          : this.clientUpdatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LocalMaternalSurvey(')
          ..write('id: $id, ')
          ..write('clientId: $clientId, ')
          ..write('serverId: $serverId, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('syncError: $syncError, ')
          ..write('lastSyncAttemptAt: $lastSyncAttemptAt, ')
          ..write('enumeratorName: $enumeratorName, ')
          ..write('surveyDate: $surveyDate, ')
          ..write('community: $community, ')
          ..write('healthFacility: $healthFacility, ')
          ..write('district: $district, ')
          ..write('respondentName: $respondentName, ')
          ..write('respondentCategory: $respondentCategory, ')
          ..write('sex: $sex, ')
          ..write('answersJson: $answersJson, ')
          ..write('clientCreatedAt: $clientCreatedAt, ')
          ..write('clientUpdatedAt: $clientUpdatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    clientId,
    serverId,
    syncStatus,
    syncError,
    lastSyncAttemptAt,
    enumeratorName,
    surveyDate,
    community,
    healthFacility,
    district,
    respondentName,
    respondentCategory,
    sex,
    answersJson,
    clientCreatedAt,
    clientUpdatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LocalMaternalSurvey &&
          other.id == this.id &&
          other.clientId == this.clientId &&
          other.serverId == this.serverId &&
          other.syncStatus == this.syncStatus &&
          other.syncError == this.syncError &&
          other.lastSyncAttemptAt == this.lastSyncAttemptAt &&
          other.enumeratorName == this.enumeratorName &&
          other.surveyDate == this.surveyDate &&
          other.community == this.community &&
          other.healthFacility == this.healthFacility &&
          other.district == this.district &&
          other.respondentName == this.respondentName &&
          other.respondentCategory == this.respondentCategory &&
          other.sex == this.sex &&
          other.answersJson == this.answersJson &&
          other.clientCreatedAt == this.clientCreatedAt &&
          other.clientUpdatedAt == this.clientUpdatedAt);
}

class LocalMaternalSurveysCompanion
    extends UpdateCompanion<LocalMaternalSurvey> {
  final Value<int> id;
  final Value<String> clientId;
  final Value<String?> serverId;
  final Value<SyncStatus> syncStatus;
  final Value<String?> syncError;
  final Value<DateTime?> lastSyncAttemptAt;
  final Value<String> enumeratorName;
  final Value<DateTime> surveyDate;
  final Value<String> community;
  final Value<String?> healthFacility;
  final Value<String> district;
  final Value<String> respondentName;
  final Value<String> respondentCategory;
  final Value<String> sex;
  final Value<String> answersJson;
  final Value<DateTime> clientCreatedAt;
  final Value<DateTime> clientUpdatedAt;
  const LocalMaternalSurveysCompanion({
    this.id = const Value.absent(),
    this.clientId = const Value.absent(),
    this.serverId = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.syncError = const Value.absent(),
    this.lastSyncAttemptAt = const Value.absent(),
    this.enumeratorName = const Value.absent(),
    this.surveyDate = const Value.absent(),
    this.community = const Value.absent(),
    this.healthFacility = const Value.absent(),
    this.district = const Value.absent(),
    this.respondentName = const Value.absent(),
    this.respondentCategory = const Value.absent(),
    this.sex = const Value.absent(),
    this.answersJson = const Value.absent(),
    this.clientCreatedAt = const Value.absent(),
    this.clientUpdatedAt = const Value.absent(),
  });
  LocalMaternalSurveysCompanion.insert({
    this.id = const Value.absent(),
    required String clientId,
    this.serverId = const Value.absent(),
    required SyncStatus syncStatus,
    this.syncError = const Value.absent(),
    this.lastSyncAttemptAt = const Value.absent(),
    required String enumeratorName,
    required DateTime surveyDate,
    required String community,
    this.healthFacility = const Value.absent(),
    required String district,
    required String respondentName,
    required String respondentCategory,
    required String sex,
    required String answersJson,
    required DateTime clientCreatedAt,
    required DateTime clientUpdatedAt,
  }) : clientId = Value(clientId),
       syncStatus = Value(syncStatus),
       enumeratorName = Value(enumeratorName),
       surveyDate = Value(surveyDate),
       community = Value(community),
       district = Value(district),
       respondentName = Value(respondentName),
       respondentCategory = Value(respondentCategory),
       sex = Value(sex),
       answersJson = Value(answersJson),
       clientCreatedAt = Value(clientCreatedAt),
       clientUpdatedAt = Value(clientUpdatedAt);
  static Insertable<LocalMaternalSurvey> custom({
    Expression<int>? id,
    Expression<String>? clientId,
    Expression<String>? serverId,
    Expression<String>? syncStatus,
    Expression<String>? syncError,
    Expression<DateTime>? lastSyncAttemptAt,
    Expression<String>? enumeratorName,
    Expression<DateTime>? surveyDate,
    Expression<String>? community,
    Expression<String>? healthFacility,
    Expression<String>? district,
    Expression<String>? respondentName,
    Expression<String>? respondentCategory,
    Expression<String>? sex,
    Expression<String>? answersJson,
    Expression<DateTime>? clientCreatedAt,
    Expression<DateTime>? clientUpdatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (clientId != null) 'client_id': clientId,
      if (serverId != null) 'server_id': serverId,
      if (syncStatus != null) 'sync_status': syncStatus,
      if (syncError != null) 'sync_error': syncError,
      if (lastSyncAttemptAt != null) 'last_sync_attempt_at': lastSyncAttemptAt,
      if (enumeratorName != null) 'enumerator_name': enumeratorName,
      if (surveyDate != null) 'survey_date': surveyDate,
      if (community != null) 'community': community,
      if (healthFacility != null) 'health_facility': healthFacility,
      if (district != null) 'district': district,
      if (respondentName != null) 'respondent_name': respondentName,
      if (respondentCategory != null) 'respondent_category': respondentCategory,
      if (sex != null) 'sex': sex,
      if (answersJson != null) 'answers_json': answersJson,
      if (clientCreatedAt != null) 'client_created_at': clientCreatedAt,
      if (clientUpdatedAt != null) 'client_updated_at': clientUpdatedAt,
    });
  }

  LocalMaternalSurveysCompanion copyWith({
    Value<int>? id,
    Value<String>? clientId,
    Value<String?>? serverId,
    Value<SyncStatus>? syncStatus,
    Value<String?>? syncError,
    Value<DateTime?>? lastSyncAttemptAt,
    Value<String>? enumeratorName,
    Value<DateTime>? surveyDate,
    Value<String>? community,
    Value<String?>? healthFacility,
    Value<String>? district,
    Value<String>? respondentName,
    Value<String>? respondentCategory,
    Value<String>? sex,
    Value<String>? answersJson,
    Value<DateTime>? clientCreatedAt,
    Value<DateTime>? clientUpdatedAt,
  }) {
    return LocalMaternalSurveysCompanion(
      id: id ?? this.id,
      clientId: clientId ?? this.clientId,
      serverId: serverId ?? this.serverId,
      syncStatus: syncStatus ?? this.syncStatus,
      syncError: syncError ?? this.syncError,
      lastSyncAttemptAt: lastSyncAttemptAt ?? this.lastSyncAttemptAt,
      enumeratorName: enumeratorName ?? this.enumeratorName,
      surveyDate: surveyDate ?? this.surveyDate,
      community: community ?? this.community,
      healthFacility: healthFacility ?? this.healthFacility,
      district: district ?? this.district,
      respondentName: respondentName ?? this.respondentName,
      respondentCategory: respondentCategory ?? this.respondentCategory,
      sex: sex ?? this.sex,
      answersJson: answersJson ?? this.answersJson,
      clientCreatedAt: clientCreatedAt ?? this.clientCreatedAt,
      clientUpdatedAt: clientUpdatedAt ?? this.clientUpdatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (clientId.present) {
      map['client_id'] = Variable<String>(clientId.value);
    }
    if (serverId.present) {
      map['server_id'] = Variable<String>(serverId.value);
    }
    if (syncStatus.present) {
      map['sync_status'] = Variable<String>(
        $LocalMaternalSurveysTable.$convertersyncStatus.toSql(syncStatus.value),
      );
    }
    if (syncError.present) {
      map['sync_error'] = Variable<String>(syncError.value);
    }
    if (lastSyncAttemptAt.present) {
      map['last_sync_attempt_at'] = Variable<DateTime>(lastSyncAttemptAt.value);
    }
    if (enumeratorName.present) {
      map['enumerator_name'] = Variable<String>(enumeratorName.value);
    }
    if (surveyDate.present) {
      map['survey_date'] = Variable<DateTime>(surveyDate.value);
    }
    if (community.present) {
      map['community'] = Variable<String>(community.value);
    }
    if (healthFacility.present) {
      map['health_facility'] = Variable<String>(healthFacility.value);
    }
    if (district.present) {
      map['district'] = Variable<String>(district.value);
    }
    if (respondentName.present) {
      map['respondent_name'] = Variable<String>(respondentName.value);
    }
    if (respondentCategory.present) {
      map['respondent_category'] = Variable<String>(respondentCategory.value);
    }
    if (sex.present) {
      map['sex'] = Variable<String>(sex.value);
    }
    if (answersJson.present) {
      map['answers_json'] = Variable<String>(answersJson.value);
    }
    if (clientCreatedAt.present) {
      map['client_created_at'] = Variable<DateTime>(clientCreatedAt.value);
    }
    if (clientUpdatedAt.present) {
      map['client_updated_at'] = Variable<DateTime>(clientUpdatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LocalMaternalSurveysCompanion(')
          ..write('id: $id, ')
          ..write('clientId: $clientId, ')
          ..write('serverId: $serverId, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('syncError: $syncError, ')
          ..write('lastSyncAttemptAt: $lastSyncAttemptAt, ')
          ..write('enumeratorName: $enumeratorName, ')
          ..write('surveyDate: $surveyDate, ')
          ..write('community: $community, ')
          ..write('healthFacility: $healthFacility, ')
          ..write('district: $district, ')
          ..write('respondentName: $respondentName, ')
          ..write('respondentCategory: $respondentCategory, ')
          ..write('sex: $sex, ')
          ..write('answersJson: $answersJson, ')
          ..write('clientCreatedAt: $clientCreatedAt, ')
          ..write('clientUpdatedAt: $clientUpdatedAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $LocalReportsTable localReports = $LocalReportsTable(this);
  late final $LocalEducationSurveysTable localEducationSurveys =
      $LocalEducationSurveysTable(this);
  late final $LocalMaternalSurveysTable localMaternalSurveys =
      $LocalMaternalSurveysTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    localReports,
    localEducationSurveys,
    localMaternalSurveys,
  ];
}

typedef $$LocalReportsTableCreateCompanionBuilder =
    LocalReportsCompanion Function({
      Value<int> id,
      required String clientId,
      Value<String?> serverId,
      required SyncStatus syncStatus,
      Value<String?> syncError,
      Value<DateTime?> lastSyncAttemptAt,
      required DateTime reportingMonth,
      required String community,
      required String submittedByName,
      required String submittedByPosition,
      required DateTime dateSubmitted,
      required int pregnantWomenCount,
      required int deliveriesTotal,
      required int deliveriesAtFacility,
      required int deliveriesAtHome,
      required int maternalDeaths,
      required Set<String> placeOfDeath,
      Value<String?> placeOfDeathOtherNote,
      Value<String?> suspectedMaternalCause,
      required int liveBirths,
      required int infantDeathsTotal,
      required int infantDeathsWithin24h,
      required int infantDeathsWithin1Month,
      required int infantDeathsWithin12Months,
      required Set<String> infantDeathCauses,
      Value<String?> infantDeathCausesOtherNote,
      required String keyChallenges,
      required String actionsTaken,
      required String additionalComments,
      required DateTime clientCreatedAt,
      required DateTime clientUpdatedAt,
    });
typedef $$LocalReportsTableUpdateCompanionBuilder =
    LocalReportsCompanion Function({
      Value<int> id,
      Value<String> clientId,
      Value<String?> serverId,
      Value<SyncStatus> syncStatus,
      Value<String?> syncError,
      Value<DateTime?> lastSyncAttemptAt,
      Value<DateTime> reportingMonth,
      Value<String> community,
      Value<String> submittedByName,
      Value<String> submittedByPosition,
      Value<DateTime> dateSubmitted,
      Value<int> pregnantWomenCount,
      Value<int> deliveriesTotal,
      Value<int> deliveriesAtFacility,
      Value<int> deliveriesAtHome,
      Value<int> maternalDeaths,
      Value<Set<String>> placeOfDeath,
      Value<String?> placeOfDeathOtherNote,
      Value<String?> suspectedMaternalCause,
      Value<int> liveBirths,
      Value<int> infantDeathsTotal,
      Value<int> infantDeathsWithin24h,
      Value<int> infantDeathsWithin1Month,
      Value<int> infantDeathsWithin12Months,
      Value<Set<String>> infantDeathCauses,
      Value<String?> infantDeathCausesOtherNote,
      Value<String> keyChallenges,
      Value<String> actionsTaken,
      Value<String> additionalComments,
      Value<DateTime> clientCreatedAt,
      Value<DateTime> clientUpdatedAt,
    });

class $$LocalReportsTableFilterComposer
    extends Composer<_$AppDatabase, $LocalReportsTable> {
  $$LocalReportsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get clientId => $composableBuilder(
    column: $table.clientId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get serverId => $composableBuilder(
    column: $table.serverId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<SyncStatus, SyncStatus, String>
  get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<String> get syncError => $composableBuilder(
    column: $table.syncError,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastSyncAttemptAt => $composableBuilder(
    column: $table.lastSyncAttemptAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get reportingMonth => $composableBuilder(
    column: $table.reportingMonth,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get community => $composableBuilder(
    column: $table.community,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get submittedByName => $composableBuilder(
    column: $table.submittedByName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get submittedByPosition => $composableBuilder(
    column: $table.submittedByPosition,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get dateSubmitted => $composableBuilder(
    column: $table.dateSubmitted,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get pregnantWomenCount => $composableBuilder(
    column: $table.pregnantWomenCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get deliveriesTotal => $composableBuilder(
    column: $table.deliveriesTotal,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get deliveriesAtFacility => $composableBuilder(
    column: $table.deliveriesAtFacility,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get deliveriesAtHome => $composableBuilder(
    column: $table.deliveriesAtHome,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get maternalDeaths => $composableBuilder(
    column: $table.maternalDeaths,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<Set<String>, Set<String>, String>
  get placeOfDeath => $composableBuilder(
    column: $table.placeOfDeath,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<String> get placeOfDeathOtherNote => $composableBuilder(
    column: $table.placeOfDeathOtherNote,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get suspectedMaternalCause => $composableBuilder(
    column: $table.suspectedMaternalCause,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get liveBirths => $composableBuilder(
    column: $table.liveBirths,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get infantDeathsTotal => $composableBuilder(
    column: $table.infantDeathsTotal,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get infantDeathsWithin24h => $composableBuilder(
    column: $table.infantDeathsWithin24h,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get infantDeathsWithin1Month => $composableBuilder(
    column: $table.infantDeathsWithin1Month,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get infantDeathsWithin12Months => $composableBuilder(
    column: $table.infantDeathsWithin12Months,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<Set<String>, Set<String>, String>
  get infantDeathCauses => $composableBuilder(
    column: $table.infantDeathCauses,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<String> get infantDeathCausesOtherNote => $composableBuilder(
    column: $table.infantDeathCausesOtherNote,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get keyChallenges => $composableBuilder(
    column: $table.keyChallenges,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get actionsTaken => $composableBuilder(
    column: $table.actionsTaken,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get additionalComments => $composableBuilder(
    column: $table.additionalComments,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get clientCreatedAt => $composableBuilder(
    column: $table.clientCreatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get clientUpdatedAt => $composableBuilder(
    column: $table.clientUpdatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$LocalReportsTableOrderingComposer
    extends Composer<_$AppDatabase, $LocalReportsTable> {
  $$LocalReportsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get clientId => $composableBuilder(
    column: $table.clientId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get serverId => $composableBuilder(
    column: $table.serverId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get syncError => $composableBuilder(
    column: $table.syncError,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastSyncAttemptAt => $composableBuilder(
    column: $table.lastSyncAttemptAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get reportingMonth => $composableBuilder(
    column: $table.reportingMonth,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get community => $composableBuilder(
    column: $table.community,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get submittedByName => $composableBuilder(
    column: $table.submittedByName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get submittedByPosition => $composableBuilder(
    column: $table.submittedByPosition,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get dateSubmitted => $composableBuilder(
    column: $table.dateSubmitted,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get pregnantWomenCount => $composableBuilder(
    column: $table.pregnantWomenCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get deliveriesTotal => $composableBuilder(
    column: $table.deliveriesTotal,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get deliveriesAtFacility => $composableBuilder(
    column: $table.deliveriesAtFacility,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get deliveriesAtHome => $composableBuilder(
    column: $table.deliveriesAtHome,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get maternalDeaths => $composableBuilder(
    column: $table.maternalDeaths,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get placeOfDeath => $composableBuilder(
    column: $table.placeOfDeath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get placeOfDeathOtherNote => $composableBuilder(
    column: $table.placeOfDeathOtherNote,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get suspectedMaternalCause => $composableBuilder(
    column: $table.suspectedMaternalCause,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get liveBirths => $composableBuilder(
    column: $table.liveBirths,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get infantDeathsTotal => $composableBuilder(
    column: $table.infantDeathsTotal,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get infantDeathsWithin24h => $composableBuilder(
    column: $table.infantDeathsWithin24h,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get infantDeathsWithin1Month => $composableBuilder(
    column: $table.infantDeathsWithin1Month,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get infantDeathsWithin12Months => $composableBuilder(
    column: $table.infantDeathsWithin12Months,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get infantDeathCauses => $composableBuilder(
    column: $table.infantDeathCauses,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get infantDeathCausesOtherNote => $composableBuilder(
    column: $table.infantDeathCausesOtherNote,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get keyChallenges => $composableBuilder(
    column: $table.keyChallenges,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get actionsTaken => $composableBuilder(
    column: $table.actionsTaken,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get additionalComments => $composableBuilder(
    column: $table.additionalComments,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get clientCreatedAt => $composableBuilder(
    column: $table.clientCreatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get clientUpdatedAt => $composableBuilder(
    column: $table.clientUpdatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$LocalReportsTableAnnotationComposer
    extends Composer<_$AppDatabase, $LocalReportsTable> {
  $$LocalReportsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get clientId =>
      $composableBuilder(column: $table.clientId, builder: (column) => column);

  GeneratedColumn<String> get serverId =>
      $composableBuilder(column: $table.serverId, builder: (column) => column);

  GeneratedColumnWithTypeConverter<SyncStatus, String> get syncStatus =>
      $composableBuilder(
        column: $table.syncStatus,
        builder: (column) => column,
      );

  GeneratedColumn<String> get syncError =>
      $composableBuilder(column: $table.syncError, builder: (column) => column);

  GeneratedColumn<DateTime> get lastSyncAttemptAt => $composableBuilder(
    column: $table.lastSyncAttemptAt,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get reportingMonth => $composableBuilder(
    column: $table.reportingMonth,
    builder: (column) => column,
  );

  GeneratedColumn<String> get community =>
      $composableBuilder(column: $table.community, builder: (column) => column);

  GeneratedColumn<String> get submittedByName => $composableBuilder(
    column: $table.submittedByName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get submittedByPosition => $composableBuilder(
    column: $table.submittedByPosition,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get dateSubmitted => $composableBuilder(
    column: $table.dateSubmitted,
    builder: (column) => column,
  );

  GeneratedColumn<int> get pregnantWomenCount => $composableBuilder(
    column: $table.pregnantWomenCount,
    builder: (column) => column,
  );

  GeneratedColumn<int> get deliveriesTotal => $composableBuilder(
    column: $table.deliveriesTotal,
    builder: (column) => column,
  );

  GeneratedColumn<int> get deliveriesAtFacility => $composableBuilder(
    column: $table.deliveriesAtFacility,
    builder: (column) => column,
  );

  GeneratedColumn<int> get deliveriesAtHome => $composableBuilder(
    column: $table.deliveriesAtHome,
    builder: (column) => column,
  );

  GeneratedColumn<int> get maternalDeaths => $composableBuilder(
    column: $table.maternalDeaths,
    builder: (column) => column,
  );

  GeneratedColumnWithTypeConverter<Set<String>, String> get placeOfDeath =>
      $composableBuilder(
        column: $table.placeOfDeath,
        builder: (column) => column,
      );

  GeneratedColumn<String> get placeOfDeathOtherNote => $composableBuilder(
    column: $table.placeOfDeathOtherNote,
    builder: (column) => column,
  );

  GeneratedColumn<String> get suspectedMaternalCause => $composableBuilder(
    column: $table.suspectedMaternalCause,
    builder: (column) => column,
  );

  GeneratedColumn<int> get liveBirths => $composableBuilder(
    column: $table.liveBirths,
    builder: (column) => column,
  );

  GeneratedColumn<int> get infantDeathsTotal => $composableBuilder(
    column: $table.infantDeathsTotal,
    builder: (column) => column,
  );

  GeneratedColumn<int> get infantDeathsWithin24h => $composableBuilder(
    column: $table.infantDeathsWithin24h,
    builder: (column) => column,
  );

  GeneratedColumn<int> get infantDeathsWithin1Month => $composableBuilder(
    column: $table.infantDeathsWithin1Month,
    builder: (column) => column,
  );

  GeneratedColumn<int> get infantDeathsWithin12Months => $composableBuilder(
    column: $table.infantDeathsWithin12Months,
    builder: (column) => column,
  );

  GeneratedColumnWithTypeConverter<Set<String>, String> get infantDeathCauses =>
      $composableBuilder(
        column: $table.infantDeathCauses,
        builder: (column) => column,
      );

  GeneratedColumn<String> get infantDeathCausesOtherNote => $composableBuilder(
    column: $table.infantDeathCausesOtherNote,
    builder: (column) => column,
  );

  GeneratedColumn<String> get keyChallenges => $composableBuilder(
    column: $table.keyChallenges,
    builder: (column) => column,
  );

  GeneratedColumn<String> get actionsTaken => $composableBuilder(
    column: $table.actionsTaken,
    builder: (column) => column,
  );

  GeneratedColumn<String> get additionalComments => $composableBuilder(
    column: $table.additionalComments,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get clientCreatedAt => $composableBuilder(
    column: $table.clientCreatedAt,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get clientUpdatedAt => $composableBuilder(
    column: $table.clientUpdatedAt,
    builder: (column) => column,
  );
}

class $$LocalReportsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $LocalReportsTable,
          LocalReport,
          $$LocalReportsTableFilterComposer,
          $$LocalReportsTableOrderingComposer,
          $$LocalReportsTableAnnotationComposer,
          $$LocalReportsTableCreateCompanionBuilder,
          $$LocalReportsTableUpdateCompanionBuilder,
          (
            LocalReport,
            BaseReferences<_$AppDatabase, $LocalReportsTable, LocalReport>,
          ),
          LocalReport,
          PrefetchHooks Function()
        > {
  $$LocalReportsTableTableManager(_$AppDatabase db, $LocalReportsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LocalReportsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LocalReportsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LocalReportsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> clientId = const Value.absent(),
                Value<String?> serverId = const Value.absent(),
                Value<SyncStatus> syncStatus = const Value.absent(),
                Value<String?> syncError = const Value.absent(),
                Value<DateTime?> lastSyncAttemptAt = const Value.absent(),
                Value<DateTime> reportingMonth = const Value.absent(),
                Value<String> community = const Value.absent(),
                Value<String> submittedByName = const Value.absent(),
                Value<String> submittedByPosition = const Value.absent(),
                Value<DateTime> dateSubmitted = const Value.absent(),
                Value<int> pregnantWomenCount = const Value.absent(),
                Value<int> deliveriesTotal = const Value.absent(),
                Value<int> deliveriesAtFacility = const Value.absent(),
                Value<int> deliveriesAtHome = const Value.absent(),
                Value<int> maternalDeaths = const Value.absent(),
                Value<Set<String>> placeOfDeath = const Value.absent(),
                Value<String?> placeOfDeathOtherNote = const Value.absent(),
                Value<String?> suspectedMaternalCause = const Value.absent(),
                Value<int> liveBirths = const Value.absent(),
                Value<int> infantDeathsTotal = const Value.absent(),
                Value<int> infantDeathsWithin24h = const Value.absent(),
                Value<int> infantDeathsWithin1Month = const Value.absent(),
                Value<int> infantDeathsWithin12Months = const Value.absent(),
                Value<Set<String>> infantDeathCauses = const Value.absent(),
                Value<String?> infantDeathCausesOtherNote =
                    const Value.absent(),
                Value<String> keyChallenges = const Value.absent(),
                Value<String> actionsTaken = const Value.absent(),
                Value<String> additionalComments = const Value.absent(),
                Value<DateTime> clientCreatedAt = const Value.absent(),
                Value<DateTime> clientUpdatedAt = const Value.absent(),
              }) => LocalReportsCompanion(
                id: id,
                clientId: clientId,
                serverId: serverId,
                syncStatus: syncStatus,
                syncError: syncError,
                lastSyncAttemptAt: lastSyncAttemptAt,
                reportingMonth: reportingMonth,
                community: community,
                submittedByName: submittedByName,
                submittedByPosition: submittedByPosition,
                dateSubmitted: dateSubmitted,
                pregnantWomenCount: pregnantWomenCount,
                deliveriesTotal: deliveriesTotal,
                deliveriesAtFacility: deliveriesAtFacility,
                deliveriesAtHome: deliveriesAtHome,
                maternalDeaths: maternalDeaths,
                placeOfDeath: placeOfDeath,
                placeOfDeathOtherNote: placeOfDeathOtherNote,
                suspectedMaternalCause: suspectedMaternalCause,
                liveBirths: liveBirths,
                infantDeathsTotal: infantDeathsTotal,
                infantDeathsWithin24h: infantDeathsWithin24h,
                infantDeathsWithin1Month: infantDeathsWithin1Month,
                infantDeathsWithin12Months: infantDeathsWithin12Months,
                infantDeathCauses: infantDeathCauses,
                infantDeathCausesOtherNote: infantDeathCausesOtherNote,
                keyChallenges: keyChallenges,
                actionsTaken: actionsTaken,
                additionalComments: additionalComments,
                clientCreatedAt: clientCreatedAt,
                clientUpdatedAt: clientUpdatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String clientId,
                Value<String?> serverId = const Value.absent(),
                required SyncStatus syncStatus,
                Value<String?> syncError = const Value.absent(),
                Value<DateTime?> lastSyncAttemptAt = const Value.absent(),
                required DateTime reportingMonth,
                required String community,
                required String submittedByName,
                required String submittedByPosition,
                required DateTime dateSubmitted,
                required int pregnantWomenCount,
                required int deliveriesTotal,
                required int deliveriesAtFacility,
                required int deliveriesAtHome,
                required int maternalDeaths,
                required Set<String> placeOfDeath,
                Value<String?> placeOfDeathOtherNote = const Value.absent(),
                Value<String?> suspectedMaternalCause = const Value.absent(),
                required int liveBirths,
                required int infantDeathsTotal,
                required int infantDeathsWithin24h,
                required int infantDeathsWithin1Month,
                required int infantDeathsWithin12Months,
                required Set<String> infantDeathCauses,
                Value<String?> infantDeathCausesOtherNote =
                    const Value.absent(),
                required String keyChallenges,
                required String actionsTaken,
                required String additionalComments,
                required DateTime clientCreatedAt,
                required DateTime clientUpdatedAt,
              }) => LocalReportsCompanion.insert(
                id: id,
                clientId: clientId,
                serverId: serverId,
                syncStatus: syncStatus,
                syncError: syncError,
                lastSyncAttemptAt: lastSyncAttemptAt,
                reportingMonth: reportingMonth,
                community: community,
                submittedByName: submittedByName,
                submittedByPosition: submittedByPosition,
                dateSubmitted: dateSubmitted,
                pregnantWomenCount: pregnantWomenCount,
                deliveriesTotal: deliveriesTotal,
                deliveriesAtFacility: deliveriesAtFacility,
                deliveriesAtHome: deliveriesAtHome,
                maternalDeaths: maternalDeaths,
                placeOfDeath: placeOfDeath,
                placeOfDeathOtherNote: placeOfDeathOtherNote,
                suspectedMaternalCause: suspectedMaternalCause,
                liveBirths: liveBirths,
                infantDeathsTotal: infantDeathsTotal,
                infantDeathsWithin24h: infantDeathsWithin24h,
                infantDeathsWithin1Month: infantDeathsWithin1Month,
                infantDeathsWithin12Months: infantDeathsWithin12Months,
                infantDeathCauses: infantDeathCauses,
                infantDeathCausesOtherNote: infantDeathCausesOtherNote,
                keyChallenges: keyChallenges,
                actionsTaken: actionsTaken,
                additionalComments: additionalComments,
                clientCreatedAt: clientCreatedAt,
                clientUpdatedAt: clientUpdatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$LocalReportsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $LocalReportsTable,
      LocalReport,
      $$LocalReportsTableFilterComposer,
      $$LocalReportsTableOrderingComposer,
      $$LocalReportsTableAnnotationComposer,
      $$LocalReportsTableCreateCompanionBuilder,
      $$LocalReportsTableUpdateCompanionBuilder,
      (
        LocalReport,
        BaseReferences<_$AppDatabase, $LocalReportsTable, LocalReport>,
      ),
      LocalReport,
      PrefetchHooks Function()
    >;
typedef $$LocalEducationSurveysTableCreateCompanionBuilder =
    LocalEducationSurveysCompanion Function({
      Value<int> id,
      required String clientId,
      Value<String?> serverId,
      required SyncStatus syncStatus,
      Value<String?> syncError,
      Value<DateTime?> lastSyncAttemptAt,
      required String enumeratorName,
      required DateTime surveyDate,
      required String communityOrSchool,
      required String district,
      required String respondentName,
      required String respondentCategory,
      required String sex,
      required String answersJson,
      required DateTime clientCreatedAt,
      required DateTime clientUpdatedAt,
    });
typedef $$LocalEducationSurveysTableUpdateCompanionBuilder =
    LocalEducationSurveysCompanion Function({
      Value<int> id,
      Value<String> clientId,
      Value<String?> serverId,
      Value<SyncStatus> syncStatus,
      Value<String?> syncError,
      Value<DateTime?> lastSyncAttemptAt,
      Value<String> enumeratorName,
      Value<DateTime> surveyDate,
      Value<String> communityOrSchool,
      Value<String> district,
      Value<String> respondentName,
      Value<String> respondentCategory,
      Value<String> sex,
      Value<String> answersJson,
      Value<DateTime> clientCreatedAt,
      Value<DateTime> clientUpdatedAt,
    });

class $$LocalEducationSurveysTableFilterComposer
    extends Composer<_$AppDatabase, $LocalEducationSurveysTable> {
  $$LocalEducationSurveysTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get clientId => $composableBuilder(
    column: $table.clientId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get serverId => $composableBuilder(
    column: $table.serverId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<SyncStatus, SyncStatus, String>
  get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<String> get syncError => $composableBuilder(
    column: $table.syncError,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastSyncAttemptAt => $composableBuilder(
    column: $table.lastSyncAttemptAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get enumeratorName => $composableBuilder(
    column: $table.enumeratorName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get surveyDate => $composableBuilder(
    column: $table.surveyDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get communityOrSchool => $composableBuilder(
    column: $table.communityOrSchool,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get district => $composableBuilder(
    column: $table.district,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get respondentName => $composableBuilder(
    column: $table.respondentName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get respondentCategory => $composableBuilder(
    column: $table.respondentCategory,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sex => $composableBuilder(
    column: $table.sex,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get answersJson => $composableBuilder(
    column: $table.answersJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get clientCreatedAt => $composableBuilder(
    column: $table.clientCreatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get clientUpdatedAt => $composableBuilder(
    column: $table.clientUpdatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$LocalEducationSurveysTableOrderingComposer
    extends Composer<_$AppDatabase, $LocalEducationSurveysTable> {
  $$LocalEducationSurveysTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get clientId => $composableBuilder(
    column: $table.clientId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get serverId => $composableBuilder(
    column: $table.serverId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get syncError => $composableBuilder(
    column: $table.syncError,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastSyncAttemptAt => $composableBuilder(
    column: $table.lastSyncAttemptAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get enumeratorName => $composableBuilder(
    column: $table.enumeratorName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get surveyDate => $composableBuilder(
    column: $table.surveyDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get communityOrSchool => $composableBuilder(
    column: $table.communityOrSchool,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get district => $composableBuilder(
    column: $table.district,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get respondentName => $composableBuilder(
    column: $table.respondentName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get respondentCategory => $composableBuilder(
    column: $table.respondentCategory,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sex => $composableBuilder(
    column: $table.sex,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get answersJson => $composableBuilder(
    column: $table.answersJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get clientCreatedAt => $composableBuilder(
    column: $table.clientCreatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get clientUpdatedAt => $composableBuilder(
    column: $table.clientUpdatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$LocalEducationSurveysTableAnnotationComposer
    extends Composer<_$AppDatabase, $LocalEducationSurveysTable> {
  $$LocalEducationSurveysTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get clientId =>
      $composableBuilder(column: $table.clientId, builder: (column) => column);

  GeneratedColumn<String> get serverId =>
      $composableBuilder(column: $table.serverId, builder: (column) => column);

  GeneratedColumnWithTypeConverter<SyncStatus, String> get syncStatus =>
      $composableBuilder(
        column: $table.syncStatus,
        builder: (column) => column,
      );

  GeneratedColumn<String> get syncError =>
      $composableBuilder(column: $table.syncError, builder: (column) => column);

  GeneratedColumn<DateTime> get lastSyncAttemptAt => $composableBuilder(
    column: $table.lastSyncAttemptAt,
    builder: (column) => column,
  );

  GeneratedColumn<String> get enumeratorName => $composableBuilder(
    column: $table.enumeratorName,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get surveyDate => $composableBuilder(
    column: $table.surveyDate,
    builder: (column) => column,
  );

  GeneratedColumn<String> get communityOrSchool => $composableBuilder(
    column: $table.communityOrSchool,
    builder: (column) => column,
  );

  GeneratedColumn<String> get district =>
      $composableBuilder(column: $table.district, builder: (column) => column);

  GeneratedColumn<String> get respondentName => $composableBuilder(
    column: $table.respondentName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get respondentCategory => $composableBuilder(
    column: $table.respondentCategory,
    builder: (column) => column,
  );

  GeneratedColumn<String> get sex =>
      $composableBuilder(column: $table.sex, builder: (column) => column);

  GeneratedColumn<String> get answersJson => $composableBuilder(
    column: $table.answersJson,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get clientCreatedAt => $composableBuilder(
    column: $table.clientCreatedAt,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get clientUpdatedAt => $composableBuilder(
    column: $table.clientUpdatedAt,
    builder: (column) => column,
  );
}

class $$LocalEducationSurveysTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $LocalEducationSurveysTable,
          LocalEducationSurvey,
          $$LocalEducationSurveysTableFilterComposer,
          $$LocalEducationSurveysTableOrderingComposer,
          $$LocalEducationSurveysTableAnnotationComposer,
          $$LocalEducationSurveysTableCreateCompanionBuilder,
          $$LocalEducationSurveysTableUpdateCompanionBuilder,
          (
            LocalEducationSurvey,
            BaseReferences<
              _$AppDatabase,
              $LocalEducationSurveysTable,
              LocalEducationSurvey
            >,
          ),
          LocalEducationSurvey,
          PrefetchHooks Function()
        > {
  $$LocalEducationSurveysTableTableManager(
    _$AppDatabase db,
    $LocalEducationSurveysTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LocalEducationSurveysTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$LocalEducationSurveysTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$LocalEducationSurveysTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> clientId = const Value.absent(),
                Value<String?> serverId = const Value.absent(),
                Value<SyncStatus> syncStatus = const Value.absent(),
                Value<String?> syncError = const Value.absent(),
                Value<DateTime?> lastSyncAttemptAt = const Value.absent(),
                Value<String> enumeratorName = const Value.absent(),
                Value<DateTime> surveyDate = const Value.absent(),
                Value<String> communityOrSchool = const Value.absent(),
                Value<String> district = const Value.absent(),
                Value<String> respondentName = const Value.absent(),
                Value<String> respondentCategory = const Value.absent(),
                Value<String> sex = const Value.absent(),
                Value<String> answersJson = const Value.absent(),
                Value<DateTime> clientCreatedAt = const Value.absent(),
                Value<DateTime> clientUpdatedAt = const Value.absent(),
              }) => LocalEducationSurveysCompanion(
                id: id,
                clientId: clientId,
                serverId: serverId,
                syncStatus: syncStatus,
                syncError: syncError,
                lastSyncAttemptAt: lastSyncAttemptAt,
                enumeratorName: enumeratorName,
                surveyDate: surveyDate,
                communityOrSchool: communityOrSchool,
                district: district,
                respondentName: respondentName,
                respondentCategory: respondentCategory,
                sex: sex,
                answersJson: answersJson,
                clientCreatedAt: clientCreatedAt,
                clientUpdatedAt: clientUpdatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String clientId,
                Value<String?> serverId = const Value.absent(),
                required SyncStatus syncStatus,
                Value<String?> syncError = const Value.absent(),
                Value<DateTime?> lastSyncAttemptAt = const Value.absent(),
                required String enumeratorName,
                required DateTime surveyDate,
                required String communityOrSchool,
                required String district,
                required String respondentName,
                required String respondentCategory,
                required String sex,
                required String answersJson,
                required DateTime clientCreatedAt,
                required DateTime clientUpdatedAt,
              }) => LocalEducationSurveysCompanion.insert(
                id: id,
                clientId: clientId,
                serverId: serverId,
                syncStatus: syncStatus,
                syncError: syncError,
                lastSyncAttemptAt: lastSyncAttemptAt,
                enumeratorName: enumeratorName,
                surveyDate: surveyDate,
                communityOrSchool: communityOrSchool,
                district: district,
                respondentName: respondentName,
                respondentCategory: respondentCategory,
                sex: sex,
                answersJson: answersJson,
                clientCreatedAt: clientCreatedAt,
                clientUpdatedAt: clientUpdatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$LocalEducationSurveysTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $LocalEducationSurveysTable,
      LocalEducationSurvey,
      $$LocalEducationSurveysTableFilterComposer,
      $$LocalEducationSurveysTableOrderingComposer,
      $$LocalEducationSurveysTableAnnotationComposer,
      $$LocalEducationSurveysTableCreateCompanionBuilder,
      $$LocalEducationSurveysTableUpdateCompanionBuilder,
      (
        LocalEducationSurvey,
        BaseReferences<
          _$AppDatabase,
          $LocalEducationSurveysTable,
          LocalEducationSurvey
        >,
      ),
      LocalEducationSurvey,
      PrefetchHooks Function()
    >;
typedef $$LocalMaternalSurveysTableCreateCompanionBuilder =
    LocalMaternalSurveysCompanion Function({
      Value<int> id,
      required String clientId,
      Value<String?> serverId,
      required SyncStatus syncStatus,
      Value<String?> syncError,
      Value<DateTime?> lastSyncAttemptAt,
      required String enumeratorName,
      required DateTime surveyDate,
      required String community,
      Value<String?> healthFacility,
      required String district,
      required String respondentName,
      required String respondentCategory,
      required String sex,
      required String answersJson,
      required DateTime clientCreatedAt,
      required DateTime clientUpdatedAt,
    });
typedef $$LocalMaternalSurveysTableUpdateCompanionBuilder =
    LocalMaternalSurveysCompanion Function({
      Value<int> id,
      Value<String> clientId,
      Value<String?> serverId,
      Value<SyncStatus> syncStatus,
      Value<String?> syncError,
      Value<DateTime?> lastSyncAttemptAt,
      Value<String> enumeratorName,
      Value<DateTime> surveyDate,
      Value<String> community,
      Value<String?> healthFacility,
      Value<String> district,
      Value<String> respondentName,
      Value<String> respondentCategory,
      Value<String> sex,
      Value<String> answersJson,
      Value<DateTime> clientCreatedAt,
      Value<DateTime> clientUpdatedAt,
    });

class $$LocalMaternalSurveysTableFilterComposer
    extends Composer<_$AppDatabase, $LocalMaternalSurveysTable> {
  $$LocalMaternalSurveysTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get clientId => $composableBuilder(
    column: $table.clientId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get serverId => $composableBuilder(
    column: $table.serverId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<SyncStatus, SyncStatus, String>
  get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<String> get syncError => $composableBuilder(
    column: $table.syncError,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastSyncAttemptAt => $composableBuilder(
    column: $table.lastSyncAttemptAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get enumeratorName => $composableBuilder(
    column: $table.enumeratorName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get surveyDate => $composableBuilder(
    column: $table.surveyDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get community => $composableBuilder(
    column: $table.community,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get healthFacility => $composableBuilder(
    column: $table.healthFacility,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get district => $composableBuilder(
    column: $table.district,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get respondentName => $composableBuilder(
    column: $table.respondentName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get respondentCategory => $composableBuilder(
    column: $table.respondentCategory,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sex => $composableBuilder(
    column: $table.sex,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get answersJson => $composableBuilder(
    column: $table.answersJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get clientCreatedAt => $composableBuilder(
    column: $table.clientCreatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get clientUpdatedAt => $composableBuilder(
    column: $table.clientUpdatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$LocalMaternalSurveysTableOrderingComposer
    extends Composer<_$AppDatabase, $LocalMaternalSurveysTable> {
  $$LocalMaternalSurveysTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get clientId => $composableBuilder(
    column: $table.clientId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get serverId => $composableBuilder(
    column: $table.serverId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get syncError => $composableBuilder(
    column: $table.syncError,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastSyncAttemptAt => $composableBuilder(
    column: $table.lastSyncAttemptAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get enumeratorName => $composableBuilder(
    column: $table.enumeratorName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get surveyDate => $composableBuilder(
    column: $table.surveyDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get community => $composableBuilder(
    column: $table.community,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get healthFacility => $composableBuilder(
    column: $table.healthFacility,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get district => $composableBuilder(
    column: $table.district,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get respondentName => $composableBuilder(
    column: $table.respondentName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get respondentCategory => $composableBuilder(
    column: $table.respondentCategory,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sex => $composableBuilder(
    column: $table.sex,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get answersJson => $composableBuilder(
    column: $table.answersJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get clientCreatedAt => $composableBuilder(
    column: $table.clientCreatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get clientUpdatedAt => $composableBuilder(
    column: $table.clientUpdatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$LocalMaternalSurveysTableAnnotationComposer
    extends Composer<_$AppDatabase, $LocalMaternalSurveysTable> {
  $$LocalMaternalSurveysTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get clientId =>
      $composableBuilder(column: $table.clientId, builder: (column) => column);

  GeneratedColumn<String> get serverId =>
      $composableBuilder(column: $table.serverId, builder: (column) => column);

  GeneratedColumnWithTypeConverter<SyncStatus, String> get syncStatus =>
      $composableBuilder(
        column: $table.syncStatus,
        builder: (column) => column,
      );

  GeneratedColumn<String> get syncError =>
      $composableBuilder(column: $table.syncError, builder: (column) => column);

  GeneratedColumn<DateTime> get lastSyncAttemptAt => $composableBuilder(
    column: $table.lastSyncAttemptAt,
    builder: (column) => column,
  );

  GeneratedColumn<String> get enumeratorName => $composableBuilder(
    column: $table.enumeratorName,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get surveyDate => $composableBuilder(
    column: $table.surveyDate,
    builder: (column) => column,
  );

  GeneratedColumn<String> get community =>
      $composableBuilder(column: $table.community, builder: (column) => column);

  GeneratedColumn<String> get healthFacility => $composableBuilder(
    column: $table.healthFacility,
    builder: (column) => column,
  );

  GeneratedColumn<String> get district =>
      $composableBuilder(column: $table.district, builder: (column) => column);

  GeneratedColumn<String> get respondentName => $composableBuilder(
    column: $table.respondentName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get respondentCategory => $composableBuilder(
    column: $table.respondentCategory,
    builder: (column) => column,
  );

  GeneratedColumn<String> get sex =>
      $composableBuilder(column: $table.sex, builder: (column) => column);

  GeneratedColumn<String> get answersJson => $composableBuilder(
    column: $table.answersJson,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get clientCreatedAt => $composableBuilder(
    column: $table.clientCreatedAt,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get clientUpdatedAt => $composableBuilder(
    column: $table.clientUpdatedAt,
    builder: (column) => column,
  );
}

class $$LocalMaternalSurveysTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $LocalMaternalSurveysTable,
          LocalMaternalSurvey,
          $$LocalMaternalSurveysTableFilterComposer,
          $$LocalMaternalSurveysTableOrderingComposer,
          $$LocalMaternalSurveysTableAnnotationComposer,
          $$LocalMaternalSurveysTableCreateCompanionBuilder,
          $$LocalMaternalSurveysTableUpdateCompanionBuilder,
          (
            LocalMaternalSurvey,
            BaseReferences<
              _$AppDatabase,
              $LocalMaternalSurveysTable,
              LocalMaternalSurvey
            >,
          ),
          LocalMaternalSurvey,
          PrefetchHooks Function()
        > {
  $$LocalMaternalSurveysTableTableManager(
    _$AppDatabase db,
    $LocalMaternalSurveysTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LocalMaternalSurveysTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LocalMaternalSurveysTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$LocalMaternalSurveysTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> clientId = const Value.absent(),
                Value<String?> serverId = const Value.absent(),
                Value<SyncStatus> syncStatus = const Value.absent(),
                Value<String?> syncError = const Value.absent(),
                Value<DateTime?> lastSyncAttemptAt = const Value.absent(),
                Value<String> enumeratorName = const Value.absent(),
                Value<DateTime> surveyDate = const Value.absent(),
                Value<String> community = const Value.absent(),
                Value<String?> healthFacility = const Value.absent(),
                Value<String> district = const Value.absent(),
                Value<String> respondentName = const Value.absent(),
                Value<String> respondentCategory = const Value.absent(),
                Value<String> sex = const Value.absent(),
                Value<String> answersJson = const Value.absent(),
                Value<DateTime> clientCreatedAt = const Value.absent(),
                Value<DateTime> clientUpdatedAt = const Value.absent(),
              }) => LocalMaternalSurveysCompanion(
                id: id,
                clientId: clientId,
                serverId: serverId,
                syncStatus: syncStatus,
                syncError: syncError,
                lastSyncAttemptAt: lastSyncAttemptAt,
                enumeratorName: enumeratorName,
                surveyDate: surveyDate,
                community: community,
                healthFacility: healthFacility,
                district: district,
                respondentName: respondentName,
                respondentCategory: respondentCategory,
                sex: sex,
                answersJson: answersJson,
                clientCreatedAt: clientCreatedAt,
                clientUpdatedAt: clientUpdatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String clientId,
                Value<String?> serverId = const Value.absent(),
                required SyncStatus syncStatus,
                Value<String?> syncError = const Value.absent(),
                Value<DateTime?> lastSyncAttemptAt = const Value.absent(),
                required String enumeratorName,
                required DateTime surveyDate,
                required String community,
                Value<String?> healthFacility = const Value.absent(),
                required String district,
                required String respondentName,
                required String respondentCategory,
                required String sex,
                required String answersJson,
                required DateTime clientCreatedAt,
                required DateTime clientUpdatedAt,
              }) => LocalMaternalSurveysCompanion.insert(
                id: id,
                clientId: clientId,
                serverId: serverId,
                syncStatus: syncStatus,
                syncError: syncError,
                lastSyncAttemptAt: lastSyncAttemptAt,
                enumeratorName: enumeratorName,
                surveyDate: surveyDate,
                community: community,
                healthFacility: healthFacility,
                district: district,
                respondentName: respondentName,
                respondentCategory: respondentCategory,
                sex: sex,
                answersJson: answersJson,
                clientCreatedAt: clientCreatedAt,
                clientUpdatedAt: clientUpdatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$LocalMaternalSurveysTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $LocalMaternalSurveysTable,
      LocalMaternalSurvey,
      $$LocalMaternalSurveysTableFilterComposer,
      $$LocalMaternalSurveysTableOrderingComposer,
      $$LocalMaternalSurveysTableAnnotationComposer,
      $$LocalMaternalSurveysTableCreateCompanionBuilder,
      $$LocalMaternalSurveysTableUpdateCompanionBuilder,
      (
        LocalMaternalSurvey,
        BaseReferences<
          _$AppDatabase,
          $LocalMaternalSurveysTable,
          LocalMaternalSurvey
        >,
      ),
      LocalMaternalSurvey,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$LocalReportsTableTableManager get localReports =>
      $$LocalReportsTableTableManager(_db, _db.localReports);
  $$LocalEducationSurveysTableTableManager get localEducationSurveys =>
      $$LocalEducationSurveysTableTableManager(_db, _db.localEducationSurveys);
  $$LocalMaternalSurveysTableTableManager get localMaternalSurveys =>
      $$LocalMaternalSurveysTableTableManager(_db, _db.localMaternalSurveys);
}
