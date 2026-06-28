import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:freedomtree_mobile/app/theme.dart';
import 'package:freedomtree_mobile/core/storage/surveys_dao.dart';
import 'package:freedomtree_mobile/features/auth/auth_controller.dart';
import 'package:freedomtree_mobile/features/surveys/survey_enums.dart';

const _uuid = Uuid();

class MaternalSurveyFormScreen extends StatefulWidget {
  const MaternalSurveyFormScreen({
    super.key,
    required this.authController,
    required this.surveysDao,
  });

  final AuthController authController;
  final SurveysDao surveysDao;

  @override
  State<MaternalSurveyFormScreen> createState() => _MaternalSurveyFormScreenState();
}

class _MaternalSurveyFormScreenState extends State<MaternalSurveyFormScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _submitting = false;
  String? _error;

  // Metadata fields
  late String _enumeratorName;
  DateTime _surveyDate = DateTime.now();
  String _community = '';
  String _healthFacility = '';
  String _district = '';
  String _respondentName = '';
  String? _respondentCategory;
  String? _sex;

  // Section A extra
  String _age = '';
  String _maritalStatus = '';
  String _childrenUnderFive = '';

  // Section B — ANC
  final Map<String, dynamic> _sectionB = {};

  // Section C — Safe Delivery
  final Map<String, dynamic> _sectionC = {};

  // Section D — PNC
  final Map<String, dynamic> _sectionD = {};

  // Section E — Infant Health
  final Map<String, dynamic> _sectionE = {};

  // Section F — Knowledge & Behavior Change
  final Map<String, dynamic> _sectionF = {};

  // Section G — Community Health Education
  final Map<String, dynamic> _sectionG = {};

  // Section H — Project Impact
  final Map<String, dynamic> _sectionH = {};

  // Section I — Health Facility Assessment
  final Map<String, dynamic> _sectionI = {};

  // Section J — Sustainability
  final Map<String, dynamic> _sectionJ = {};

  @override
  void initState() {
    super.initState();
    final user = widget.authController.currentUser;
    _enumeratorName = user?.name ?? '';
    _community = user?.community ?? '';
  }

  Future<void> _pickDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: _surveyDate,
      firstDate: DateTime(now.year - 2),
      lastDate: now,
      helpText: 'Select survey date',
    );
    if (picked != null) setState(() => _surveyDate = picked);
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    if (_respondentCategory == null) {
      setState(() => _error = 'Please select a respondent category.');
      return;
    }
    if (_sex == null) {
      setState(() => _error = 'Please select sex.');
      return;
    }
    _formKey.currentState!.save();
    setState(() {
      _submitting = true;
      _error = null;
    });

    try {
      final clientId = _uuid.v4();
      final now = DateTime.now();

      final answers = <String, dynamic>{
        'section_a_profile': {
          'age': _age,
          'marital_status': _maritalStatus,
          'children_under_five': _childrenUnderFive,
        },
        'section_b_anc': _sectionB,
        'section_c_safe_delivery': _sectionC,
        'section_d_postnatal_care': _sectionD,
        'section_e_infant_health': _sectionE,
        'section_f_knowledge_behavior': _sectionF,
        'section_g_community_education': _sectionG,
        'section_h_project_impact': _sectionH,
        'section_i_facility_assessment': _sectionI,
        'section_j_sustainability': _sectionJ,
      };

      await widget.surveysDao.saveMaternal(
        clientId: clientId,
        enumeratorName: _enumeratorName,
        surveyDate: _surveyDate,
        community: _community,
        healthFacility: _healthFacility.isNotEmpty ? _healthFacility : null,
        district: _district,
        respondentName: _respondentName,
        respondentCategory: _respondentCategory!,
        sex: _sex!,
        answersJson: jsonEncode(answers),
        clientCreatedAt: now,
      );

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Survey saved. It will sync automatically when online.'),
          backgroundColor: FtColors.green,
        ),
      );
      Navigator.of(context).pop();
    } catch (e) {
      setState(() => _error = e.toString());
    } finally {
      if (mounted) setState(() => _submitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Maternal Health Survey')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // ── Enumerator Information ──────────────────────────────────
            _SectionHeader('Enumerator Information'),
            _FormTextField(
              label: 'Enumerator Name',
              initialValue: _enumeratorName,
              onSaved: (v) => _enumeratorName = v ?? '',
              required: true,
            ),
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(
                'Date: ${_surveyDate.toLocal().toString().slice(0, 10)}',
              ),
              trailing: const Icon(Icons.calendar_month, color: FtColors.orange),
              onTap: _pickDate,
            ),
            _FormTextField(
              label: 'Community',
              initialValue: _community,
              onSaved: (v) => _community = v ?? '',
              required: true,
            ),
            _FormTextField(
              label: 'Health Facility (optional)',
              initialValue: _healthFacility,
              onSaved: (v) => _healthFacility = v ?? '',
            ),
            _FormTextField(
              label: 'District',
              initialValue: _district,
              onSaved: (v) => _district = v ?? '',
              required: true,
            ),
            _FormTextField(
              label: 'Respondent Name',
              initialValue: _respondentName,
              onSaved: (v) => _respondentName = v ?? '',
              required: true,
            ),

            // ── Section A: Respondent Profile ───────────────────────────
            const SizedBox(height: 24),
            _SectionHeader('Section A: Respondent Profile'),
            _SingleChoice(
              label: 'Sex',
              options: const [('male', 'Male'), ('female', 'Female')],
              value: _sex,
              onChanged: (v) => setState(() => _sex = v),
            ),
            _FormTextField(
              label: 'Age (years)',
              initialValue: _age,
              onSaved: (v) => _age = v ?? '',
              keyboardType: TextInputType.number,
            ),
            _SingleChoice(
              label: 'Respondent Category',
              options: maternalRespondentCategories,
              value: _respondentCategory,
              onChanged: (v) => setState(() => _respondentCategory = v),
            ),
            _SingleChoice(
              label: 'Marital Status',
              options: const [
                ('single', 'Single'),
                ('married', 'Married'),
                ('divorced', 'Divorced'),
                ('widowed', 'Widowed'),
              ],
              value: _maritalStatus.isNotEmpty ? _maritalStatus : null,
              onChanged: (v) => setState(() => _maritalStatus = v ?? ''),
            ),
            _FormTextField(
              label: 'Number of Children Under Five',
              initialValue: _childrenUnderFive,
              onSaved: (v) => _childrenUnderFive = v ?? '',
              keyboardType: TextInputType.number,
            ),

            // ── Section B: Access to Maternal Health Services ───────────
            const SizedBox(height: 24),
            _SectionHeader('Section B: Access to Maternal Health Services'),
            _SingleChoice(
              label:
                  'During your most recent pregnancy, did you attend Antenatal Care (ANC)?',
              options: yesNoOptions,
              value: _sectionB['attended_anc'] as String?,
              onChanged: (v) => setState(() => _sectionB['attended_anc'] = v),
            ),
            _SingleChoice(
              label: 'How many ANC visits did you complete?',
              options: const [
                ('1_3', '1–3 Visits'),
                ('4_7', '4–7 Visits'),
                ('8_plus', '8 or More Visits'),
                ('none', 'None'),
              ],
              value: _sectionB['anc_visits'] as String?,
              onChanged: (v) => setState(() => _sectionB['anc_visits'] = v),
            ),
            _SingleChoice(
              label: 'Where did you receive ANC services?',
              options: const [
                ('government_facility', 'Government Health Facility'),
                ('private_clinic', 'Private Clinic'),
                ('community_health_post', 'Community Health Post'),
                ('traditional_provider', 'Traditional Provider'),
                ('other', 'Other'),
              ],
              value: _sectionB['anc_location'] as String?,
              onChanged: (v) => setState(() => _sectionB['anc_location'] = v),
            ),
            _SingleChoice(
              label: 'Did the project help improve your access to ANC services?',
              options: yesNoOptions,
              value: _sectionB['project_improved_anc'] as String?,
              onChanged: (v) =>
                  setState(() => _sectionB['project_improved_anc'] = v),
            ),
            _MultiCheck(
              label: 'What barriers, if any, prevented you from accessing ANC services?',
              options: const [
                ('distance', 'Distance'),
                ('cost', 'Cost'),
                ('lack_transportation', 'Lack of Transportation'),
                ('cultural_beliefs', 'Cultural Beliefs'),
                ('poor_quality', 'Poor Quality Services'),
                ('none', 'None'),
                ('other', 'Other'),
              ],
              selected: Set<String>.from(
                  (_sectionB['anc_barriers'] as List<dynamic>? ?? []).cast<String>()),
              onToggle: (val, checked) {
                setState(() {
                  final list =
                      List<String>.from(_sectionB['anc_barriers'] as List<dynamic>? ?? []);
                  if (checked) {
                    list.add(val);
                  } else {
                    list.remove(val);
                  }
                  _sectionB['anc_barriers'] = list;
                });
              },
            ),

            // ── Section C: Safe Delivery Practices ──────────────────────
            const SizedBox(height: 24),
            _SectionHeader('Section C: Safe Delivery Practices'),
            _SingleChoice(
              label: 'Where did you deliver your last baby?',
              options: const [
                ('government_hospital', 'Government Hospital'),
                ('community_health_center', 'Community Health Center'),
                ('home', 'Home'),
                ('private_clinic', 'Private Clinic'),
                ('other', 'Other'),
              ],
              value: _sectionC['delivery_location'] as String?,
              onChanged: (v) =>
                  setState(() => _sectionC['delivery_location'] = v),
            ),
            _SingleChoice(
              label: 'Who assisted during delivery?',
              options: const [
                ('skilled_birth_attendant', 'Skilled Birth Attendant'),
                ('nurse_midwife', 'Nurse/Midwife'),
                ('traditional_birth_attendant', 'Traditional Birth Attendant'),
                ('relative', 'Relative'),
                ('no_assistance', 'No Assistance'),
              ],
              value: _sectionC['delivery_assistant'] as String?,
              onChanged: (v) =>
                  setState(() => _sectionC['delivery_assistant'] = v),
            ),
            _SingleChoice(
              label: 'Did project interventions encourage facility-based delivery?',
              options: yesNoOptions,
              value: _sectionC['project_encouraged_facility_delivery'] as String?,
              onChanged: (v) => setState(
                  () => _sectionC['project_encouraged_facility_delivery'] = v),
            ),
            _SingleChoice(
              label: 'Did you experience any complications during pregnancy or delivery?',
              options: yesNoOptions,
              value: _sectionC['complications'] as String?,
              onChanged: (v) =>
                  setState(() => _sectionC['complications'] = v),
            ),
            _SingleChoice(
              label: 'If yes, were you able to receive timely medical care?',
              options: const [
                ('yes', 'Yes'),
                ('no', 'No'),
                ('partially', 'Partially'),
              ],
              value: _sectionC['timely_care_received'] as String?,
              onChanged: (v) =>
                  setState(() => _sectionC['timely_care_received'] = v),
            ),

            // ── Section D: Postnatal Care ────────────────────────────────
            const SizedBox(height: 24),
            _SectionHeader('Section D: Postnatal Care (PNC)'),
            _SingleChoice(
              label: 'Did you receive a postnatal check-up after delivery?',
              options: yesNoOptions,
              value: _sectionD['received_pnc'] as String?,
              onChanged: (v) => setState(() => _sectionD['received_pnc'] = v),
            ),
            _SingleChoice(
              label: 'How soon after delivery did you receive postnatal care?',
              options: const [
                ('within_24h', 'Within 24 Hours'),
                ('2_7_days', '2–7 Days'),
                ('after_one_week', 'After One Week'),
                ('no_pnc', 'Did Not Receive PNC'),
              ],
              value: _sectionD['pnc_timing'] as String?,
              onChanged: (v) => setState(() => _sectionD['pnc_timing'] = v),
            ),
            _SingleChoice(
              label: 'Were you educated on maternal danger signs during pregnancy?',
              options: yesNoOptions,
              value: _sectionD['educated_maternal_danger_signs'] as String?,
              onChanged: (v) => setState(
                  () => _sectionD['educated_maternal_danger_signs'] = v),
            ),
            _SingleChoice(
              label: 'Were you educated on newborn danger signs?',
              options: yesNoOptions,
              value: _sectionD['educated_newborn_danger_signs'] as String?,
              onChanged: (v) => setState(
                  () => _sectionD['educated_newborn_danger_signs'] = v),
            ),

            // ── Section E: Infant Health and Survival ────────────────────
            const SizedBox(height: 24),
            _SectionHeader('Section E: Infant Health and Survival'),
            _SingleChoice(
              label: 'Is your child fully immunized according to age?',
              options: const [
                ('yes', 'Yes'),
                ('no', 'No'),
                ('dont_know', "Don't Know"),
              ],
              value: _sectionE['child_immunized'] as String?,
              onChanged: (v) =>
                  setState(() => _sectionE['child_immunized'] = v),
            ),
            _SingleChoice(
              label: 'Was your child exclusively breastfed for the first six months?',
              options: yesNoOptions,
              value: _sectionE['exclusively_breastfed'] as String?,
              onChanged: (v) =>
                  setState(() => _sectionE['exclusively_breastfed'] = v),
            ),
            _MultiCheck(
              label: 'If No, why did you not breastfeed your child?',
              options: const [
                ('low_milk_supply', 'Low Milk Supply'),
                ('painful_letdown', 'Painful Let Down'),
                ('cracked_nipples', 'Cracked Nipples'),
                ('breast_cancer', 'Breast Cancer'),
                ('other', 'Other'),
              ],
              selected: Set<String>.from(
                  (_sectionE['no_breastfeed_reasons'] as List<dynamic>? ?? [])
                      .cast<String>()),
              onToggle: (val, checked) {
                setState(() {
                  final list = List<String>.from(
                      _sectionE['no_breastfeed_reasons'] as List<dynamic>? ?? []);
                  if (checked) {
                    list.add(val);
                  } else {
                    list.remove(val);
                  }
                  _sectionE['no_breastfeed_reasons'] = list;
                });
              },
            ),
            _SingleChoice(
              label: 'Has your child experienced any serious illness in the past 12 months?',
              options: yesNoOptions,
              value: _sectionE['child_serious_illness'] as String?,
              onChanged: (v) =>
                  setState(() => _sectionE['child_serious_illness'] = v),
            ),
            _MultiCheck(
              label: 'If yes, what was the illness?',
              options: const [
                ('malaria', 'Malaria'),
                ('pneumonia', 'Pneumonia'),
                ('diarrhea', 'Diarrhea'),
                ('malnutrition', 'Malnutrition'),
                ('other', 'Other'),
              ],
              selected: Set<String>.from(
                  (_sectionE['child_illnesses'] as List<dynamic>? ?? []).cast<String>()),
              onToggle: (val, checked) {
                setState(() {
                  final list = List<String>.from(
                      _sectionE['child_illnesses'] as List<dynamic>? ?? []);
                  if (checked) {
                    list.add(val);
                  } else {
                    list.remove(val);
                  }
                  _sectionE['child_illnesses'] = list;
                });
              },
            ),
            _SingleChoice(
              label: 'Were health services sought promptly when the child became ill?',
              options: yesNoOptions,
              value: _sectionE['prompt_care_sought'] as String?,
              onChanged: (v) =>
                  setState(() => _sectionE['prompt_care_sought'] = v),
            ),

            // ── Section F: Knowledge and Behavior Change ─────────────────
            const SizedBox(height: 24),
            _SectionHeader('Section F: Knowledge and Behavior Change'),
            const Padding(
              padding: EdgeInsets.only(bottom: 8),
              child: Text(
                '1 = Strongly Disagree … 5 = Strongly Agree',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
            ...[
              ('anc_importance', 'I understand the importance of ANC visits.'),
              ('danger_signs', 'I know the danger signs during pregnancy.'),
              ('skilled_birth', 'I understand the importance of skilled birth attendance.'),
              ('pnc_importance', 'I know the importance of postnatal care.'),
              ('immunization', 'I understand infant immunization schedules.'),
              ('infant_feeding', 'I practice recommended infant feeding methods.'),
            ].map(
              (item) => _LikertRow(
                statement: item.$2,
                value: _sectionF['likert_${item.$1}'] as int?,
                onChanged: (v) =>
                    setState(() => _sectionF['likert_${item.$1}'] = v),
              ),
            ),

            // ── Section G: Community Health Education ────────────────────
            const SizedBox(height: 24),
            _SectionHeader('Section G: Community Health Education'),
            _SingleChoice(
              label:
                  'Have you attended any maternal and child health education sessions supported by the project?',
              options: yesNoOptions,
              value: _sectionG['attended_sessions'] as String?,
              onChanged: (v) =>
                  setState(() => _sectionG['attended_sessions'] = v),
            ),
            _MultiCheck(
              label: 'Which topics were covered?',
              options: const [
                ('anc', 'ANC'),
                ('safe_delivery', 'Safe Delivery'),
                ('family_planning', 'Family Planning'),
                ('breastfeeding', 'Breastfeeding'),
                ('child_nutrition', 'Child Nutrition'),
                ('immunization', 'Immunization'),
                ('hygiene_sanitation', 'Hygiene and Sanitation'),
              ],
              selected: Set<String>.from(
                  (_sectionG['topics_covered'] as List<dynamic>? ?? []).cast<String>()),
              onToggle: (val, checked) {
                setState(() {
                  final list = List<String>.from(
                      _sectionG['topics_covered'] as List<dynamic>? ?? []);
                  if (checked) {
                    list.add(val);
                  } else {
                    list.remove(val);
                  }
                  _sectionG['topics_covered'] = list;
                });
              },
            ),
            _FormTextField(
              label: 'Which topic was most useful?',
              initialValue: _sectionG['most_useful_topic'] as String? ?? '',
              onSaved: (v) => _sectionG['most_useful_topic'] = v ?? '',
            ),
            _SingleChoice(
              label: 'Have you shared health information with any health practitioner?',
              options: yesNoOptions,
              value: _sectionG['shared_with_practitioner'] as String?,
              onChanged: (v) =>
                  setState(() => _sectionG['shared_with_practitioner'] = v),
            ),

            // ── Section H: Project Impact ────────────────────────────────
            const SizedBox(height: 24),
            _SectionHeader('Section H: Project Impact'),
            const Padding(
              padding: EdgeInsets.only(bottom: 8),
              child: Text(
                'Compared to before the project, how would you rate the following?',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
            ...[
              ('anc_attendance', 'ANC Attendance'),
              ('facility_deliveries', 'Facility Deliveries'),
              ('maternal_health_knowledge', 'Maternal Health Knowledge'),
              ('infant_immunization', 'Infant Immunization'),
              ('child_nutrition', 'Child Nutrition Practices'),
              ('community_awareness', 'Community Awareness'),
            ].map(
              (item) => _SingleChoice(
                label: item.$2,
                options: const [
                  ('improved_greatly', 'Improved Greatly'),
                  ('improved', 'Improved'),
                  ('no_change', 'No Change'),
                  ('declined', 'Declined'),
                ],
                value: _sectionH['impact_${item.$1}'] as String?,
                onChanged: (v) =>
                    setState(() => _sectionH['impact_${item.$1}'] = v),
              ),
            ),
            _SingleChoice(
              label:
                  'In your opinion, has maternal mortality reduced in your community?',
              options: const [
                ('yes', 'Yes'),
                ('no', 'No'),
                ('not_sure', 'Not Sure'),
              ],
              value: _sectionH['maternal_mortality_reduced'] as String?,
              onChanged: (v) =>
                  setState(() => _sectionH['maternal_mortality_reduced'] = v),
            ),
            _SingleChoice(
              label:
                  'In your opinion, has infant mortality reduced in your community?',
              options: const [
                ('yes', 'Yes'),
                ('no', 'No'),
                ('not_sure', 'Not Sure'),
              ],
              value: _sectionH['infant_mortality_reduced'] as String?,
              onChanged: (v) =>
                  setState(() => _sectionH['infant_mortality_reduced'] = v),
            ),
            _FormTextField(
              label: 'What factors contributed most to these changes?',
              initialValue: _sectionH['contributing_factors'] as String? ?? '',
              onSaved: (v) => _sectionH['contributing_factors'] = v ?? '',
              maxLines: 3,
            ),

            // ── Section I: Health Facility Assessment ────────────────────
            const SizedBox(height: 24),
            _SectionHeader('Section I: Health Facility Assessment (for health workers)'),
            _SingleChoice(
              label:
                  'Has the project improved availability of maternal and child health services?',
              options: yesNoOptions,
              value: _sectionI['services_improved'] as String?,
              onChanged: (v) =>
                  setState(() => _sectionI['services_improved'] = v),
            ),
            _SingleChoice(
              label: 'Have maternal health referrals improved?',
              options: yesNoOptions,
              value: _sectionI['referrals_improved'] as String?,
              onChanged: (v) =>
                  setState(() => _sectionI['referrals_improved'] = v),
            ),
            _SingleChoice(
              label:
                  'Has the project improved availability of essential medicines and supplies?',
              options: yesNoOptions,
              value: _sectionI['medicines_improved'] as String?,
              onChanged: (v) =>
                  setState(() => _sectionI['medicines_improved'] = v),
            ),
            _SingleChoice(
              label: 'Has staff capacity improved through training and mentorship?',
              options: yesNoOptions,
              value: _sectionI['staff_capacity_improved'] as String?,
              onChanged: (v) =>
                  setState(() => _sectionI['staff_capacity_improved'] = v),
            ),

            // ── Section J: Sustainability and Recommendations ─────────────
            const SizedBox(height: 24),
            _SectionHeader('Section J: Sustainability and Recommendations'),
            _SingleChoice(
              label:
                  'Do you believe project achievements will continue after project closure?',
              options: const [
                ('yes', 'Yes'),
                ('no', 'No'),
                ('not_sure', 'Not Sure'),
              ],
              value: _sectionJ['achievements_continue'] as String?,
              onChanged: (v) =>
                  setState(() => _sectionJ['achievements_continue'] = v),
            ),
            _FormTextField(
              label: 'What systems are in place to sustain project gains?',
              initialValue: _sectionJ['sustain_systems'] as String? ?? '',
              onSaved: (v) => _sectionJ['sustain_systems'] = v ?? '',
              maxLines: 3,
            ),
            _FormTextField(
              label:
                  'What additional support is needed to further reduce maternal and infant mortality?',
              initialValue: _sectionJ['additional_support'] as String? ?? '',
              onSaved: (v) => _sectionJ['additional_support'] = v ?? '',
              maxLines: 3,
            ),
            _FormTextField(
              label: 'Please share a success story resulting from this project.',
              initialValue: _sectionJ['success_story'] as String? ?? '',
              onSaved: (v) => _sectionJ['success_story'] = v ?? '',
              maxLines: 4,
            ),
            _FormTextField(
              label: 'Any additional comments or recommendations?',
              initialValue: _sectionJ['additional_comments'] as String? ?? '',
              onSaved: (v) => _sectionJ['additional_comments'] = v ?? '',
              maxLines: 3,
            ),

            if (_error != null) ...[
              const SizedBox(height: 16),
              Text(_error!, style: const TextStyle(color: FtColors.darkOrange)),
            ],
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _submitting ? null : _submit,
              child: _submitting
                  ? const SizedBox(
                      height: 18,
                      width: 18,
                      child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                    )
                  : const Text('Submit Survey'),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}

// ── Shared private widgets ──────────────────────────────────────────────────

class _SectionHeader extends StatelessWidget {
  const _SectionHeader(this.title);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(title, style: Theme.of(context).textTheme.titleLarge),
    );
  }
}

class _FormTextField extends StatelessWidget {
  const _FormTextField({
    required this.label,
    required this.initialValue,
    required this.onSaved,
    this.required = false,
    this.maxLines = 1,
    this.keyboardType,
  });

  final String label;
  final String initialValue;
  final void Function(String?) onSaved;
  final bool required;
  final int maxLines;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextFormField(
        initialValue: initialValue,
        maxLines: maxLines,
        keyboardType: keyboardType,
        decoration: InputDecoration(labelText: label),
        validator: required ? (v) => (v == null || v.isEmpty) ? 'Required' : null : null,
        onSaved: onSaved,
      ),
    );
  }
}

class _SingleChoice extends StatelessWidget {
  const _SingleChoice({
    required this.label,
    required this.options,
    required this.value,
    required this.onChanged,
  });

  final String label;
  final List<(String, String)> options;
  final String? value;
  final void Function(String?) onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(fontWeight: FontWeight.w600)),
          RadioGroup<String>(
            groupValue: value,
            onChanged: onChanged,
            child: Column(
              children: options.map(
                (opt) => RadioListTile<String>(
                  contentPadding: EdgeInsets.zero,
                  dense: true,
                  title: Text(opt.$2),
                  value: opt.$1,
                ),
              ).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class _MultiCheck extends StatelessWidget {
  const _MultiCheck({
    required this.label,
    required this.options,
    required this.selected,
    required this.onToggle,
  });

  final String label;
  final List<(String, String)> options;
  final Set<String> selected;
  final void Function(String, bool) onToggle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(fontWeight: FontWeight.w600)),
          ...options.map(
            (opt) => CheckboxListTile(
              contentPadding: EdgeInsets.zero,
              dense: true,
              title: Text(opt.$2),
              value: selected.contains(opt.$1),
              onChanged: (checked) => onToggle(opt.$1, checked ?? false),
            ),
          ),
        ],
      ),
    );
  }
}

class _LikertRow extends StatelessWidget {
  const _LikertRow({
    required this.statement,
    required this.value,
    required this.onChanged,
  });

  final String statement;
  final int? value;
  final void Function(int?) onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(statement, style: Theme.of(context).textTheme.bodyMedium),
          RadioGroup<int>(
            groupValue: value,
            onChanged: onChanged,
            child: Row(
              children: List.generate(
                5,
                (i) {
                  final n = i + 1;
                  return Expanded(
                    child: Column(
                      children: [
                        Radio<int>(
                          value: n,
                          visualDensity: VisualDensity.compact,
                        ),
                        Text('$n', style: const TextStyle(fontSize: 11)),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

extension on String {
  String slice(int start, int end) => substring(start, end > length ? length : end);
}
