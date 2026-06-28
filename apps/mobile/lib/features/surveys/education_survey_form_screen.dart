import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:freedomtree_mobile/app/theme.dart';
import 'package:freedomtree_mobile/core/storage/surveys_dao.dart';
import 'package:freedomtree_mobile/features/auth/auth_controller.dart';
import 'package:freedomtree_mobile/features/surveys/survey_enums.dart';

const _uuid = Uuid();

class EducationSurveyFormScreen extends StatefulWidget {
  const EducationSurveyFormScreen({
    super.key,
    required this.authController,
    required this.surveysDao,
  });

  final AuthController authController;
  final SurveysDao surveysDao;

  @override
  State<EducationSurveyFormScreen> createState() => _EducationSurveyFormScreenState();
}

class _EducationSurveyFormScreenState extends State<EducationSurveyFormScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _submitting = false;
  String? _error;

  // Metadata fields
  late String _enumeratorName;
  DateTime _surveyDate = DateTime.now();
  String _communityOrSchool = '';
  String _district = '';
  String _respondentName = '';
  String? _respondentCategory;
  String? _sex;

  // Section A extra
  String _age = '';
  String _schoolName = '';
  String _classLevel = '';

  // Section B — Scholarship
  final Map<String, dynamic> _sectionB = {};

  // Section C — BAM/GAM
  final Map<String, dynamic> _sectionC = {};

  // Section D — School Building
  final Map<String, dynamic> _sectionD = {};

  // Section E — Project Impact
  final Map<String, dynamic> _sectionE = {};

  // Section F — Sustainability
  final Map<String, dynamic> _sectionF = {};

  // Section G — Success Stories
  final Map<String, dynamic> _sectionG = {};

  @override
  void initState() {
    super.initState();
    final user = widget.authController.currentUser;
    _enumeratorName = user?.name ?? '';
    _communityOrSchool = user?.community ?? '';
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
          'school_name': _schoolName,
          'class_level': _classLevel,
        },
        'section_b_scholarship': _sectionB,
        'section_c_bam_gam': _sectionC,
        'section_d_school_building': _sectionD,
        'section_e_project_impact': _sectionE,
        'section_f_sustainability': _sectionF,
        'section_g_success_stories': _sectionG,
      };

      await widget.surveysDao.saveEducation(
        clientId: clientId,
        enumeratorName: _enumeratorName,
        surveyDate: _surveyDate,
        communityOrSchool: _communityOrSchool,
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
      appBar: AppBar(title: const Text('Education Survey')),
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
              label: 'Community / School',
              initialValue: _communityOrSchool,
              onSaved: (v) => _communityOrSchool = v ?? '',
              required: true,
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
              label: 'Category of Respondent',
              options: educationRespondentCategories,
              value: _respondentCategory,
              onChanged: (v) => setState(() => _respondentCategory = v),
            ),
            _FormTextField(
              label: 'Name of School',
              initialValue: _schoolName,
              onSaved: (v) => _schoolName = v ?? '',
            ),
            _FormTextField(
              label: 'Class / Grade Level',
              initialValue: _classLevel,
              onSaved: (v) => _classLevel = v ?? '',
            ),

            // ── Section B: Scholarship Program Evaluation ───────────────
            const SizedBox(height: 24),
            _SectionHeader('Section B: Scholarship Program Evaluation'),
            _SingleChoice(
              label: 'Did you receive scholarship support from the project?',
              options: yesNoOptions,
              value: _sectionB['received_scholarship'] as String?,
              onChanged: (v) => setState(() => _sectionB['received_scholarship'] = v),
            ),
            _MultiCheck(
              label: 'What type of support did you receive?',
              options: const [
                ('school_fees', 'School Fees'),
                ('learning_materials', 'Learning Materials'),
                ('uniform', 'Uniform'),
                ('examination_fees', 'Examination Fees'),
                ('transportation', 'Transportation Support'),
                ('other', 'Other'),
              ],
              selected: Set<String>.from(
                  (_sectionB['support_types'] as List<dynamic>? ?? []).cast<String>()),
              onToggle: (val, checked) {
                setState(() {
                  final list =
                      List<String>.from(_sectionB['support_types'] as List<dynamic>? ?? []);
                  if (checked) {
                    list.add(val);
                  } else {
                    list.remove(val);
                  }
                  _sectionB['support_types'] = list;
                });
              },
            ),
            _SingleChoice(
              label: 'How satisfied are you with the scholarship support provided?',
              options: const [
                ('very_satisfied', 'Very Satisfied'),
                ('satisfied', 'Satisfied'),
                ('neutral', 'Neutral'),
                ('dissatisfied', 'Dissatisfied'),
                ('very_dissatisfied', 'Very Dissatisfied'),
              ],
              value: _sectionB['scholarship_satisfaction'] as String?,
              onChanged: (v) =>
                  setState(() => _sectionB['scholarship_satisfaction'] = v),
            ),
            _SingleChoice(
              label: 'Has the scholarship support helped you remain in school?',
              options: yesNoOptions,
              value: _sectionB['helped_remain_in_school'] as String?,
              onChanged: (v) =>
                  setState(() => _sectionB['helped_remain_in_school'] = v),
            ),
            _SingleChoice(
              label: 'Since receiving the scholarship, how has your school attendance been?',
              options: const [
                ('improved_significantly', 'Improved Significantly'),
                ('improved_slightly', 'Improved Slightly'),
                ('remained_same', 'Remained the Same'),
                ('declined', 'Declined'),
              ],
              value: _sectionB['attendance_change'] as String?,
              onChanged: (v) => setState(() => _sectionB['attendance_change'] = v),
            ),
            _SingleChoice(
              label: 'To what extent has your academic performance improved?',
              options: const [
                ('greatly_improved', 'Greatly Improved'),
                ('improved', 'Improved'),
                ('no_change', 'No Change'),
                ('declined', 'Declined'),
              ],
              value: _sectionB['academic_performance'] as String?,
              onChanged: (v) =>
                  setState(() => _sectionB['academic_performance'] = v),
            ),
            _SingleChoice(
              label: 'To what extent did the scholarship reduce financial burdens on your family?',
              options: const [
                ('very_high', 'Very High Extent'),
                ('high', 'High Extent'),
                ('moderate', 'Moderate Extent'),
                ('low', 'Low Extent'),
                ('none', 'No Extent'),
              ],
              value: _sectionB['financial_burden_reduction'] as String?,
              onChanged: (v) =>
                  setState(() => _sectionB['financial_burden_reduction'] = v),
            ),
            _SingleChoice(
              label: 'What would likely have happened without the scholarship?',
              options: const [
                ('continued_schooling', 'Continued Schooling'),
                ('irregular_attendance', 'Irregular Attendance'),
                ('dropped_out', 'Dropped Out'),
                ('unsure', 'Unsure'),
              ],
              value: _sectionB['without_scholarship'] as String?,
              onChanged: (v) =>
                  setState(() => _sectionB['without_scholarship'] = v),
            ),
            _FormTextField(
              label: 'What positive changes have occurred because of the scholarship support?',
              initialValue: _sectionB['positive_changes'] as String? ?? '',
              onSaved: (v) => _sectionB['positive_changes'] = v ?? '',
              maxLines: 3,
            ),
            _FormTextField(
              label: 'What challenges still affect your education?',
              initialValue: _sectionB['remaining_challenges'] as String? ?? '',
              onSaved: (v) => _sectionB['remaining_challenges'] = v ?? '',
              maxLines: 3,
            ),

            // ── Section C: BAM & GAM Curriculum Evaluation ──────────────
            const SizedBox(height: 24),
            _SectionHeader('Section C: BAM & GAM Curriculum Evaluation'),
            _SingleChoice(
              label: 'Have you participated in BAM/GAM sessions?',
              options: yesNoOptions,
              value: _sectionC['participated'] as String?,
              onChanged: (v) => setState(() => _sectionC['participated'] = v),
            ),
            _MultiCheck(
              label: 'Which program did you participate in?',
              options: const [
                ('bam', 'BAM'),
                ('gam', 'GAM'),
              ],
              selected: Set<String>.from(
                  (_sectionC['programs'] as List<dynamic>? ?? []).cast<String>()),
              onToggle: (val, checked) {
                setState(() {
                  final list =
                      List<String>.from(_sectionC['programs'] as List<dynamic>? ?? []);
                  if (checked) {
                    list.add(val);
                  } else {
                    list.remove(val);
                  }
                  _sectionC['programs'] = list;
                });
              },
            ),
            _SingleChoice(
              label: 'How many sessions did you attend?',
              options: const [
                ('less_than_5', 'Less than 5'),
                ('5_10', '5–10'),
                ('10_12', '10–12'),
              ],
              value: _sectionC['sessions_attended'] as String?,
              onChanged: (v) =>
                  setState(() => _sectionC['sessions_attended'] = v),
            ),
            const Padding(
              padding: EdgeInsets.only(bottom: 8),
              child: Text(
                'Knowledge & Skills (1 = Strongly Disagree … 5 = Strongly Agree)',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
            ...[
              ('understand_rights', 'I understand my rights and responsibilities better.'),
              ('confident_views', 'I am more confident expressing my views.'),
              ('informed_decisions', 'I can make informed decisions about my future.'),
              ('gender_equality', 'I understand gender equality better.'),
              ('communication_skills', 'I have improved communication skills.'),
              ('manage_emotions', 'I can better manage emotions and conflicts.'),
              ('respect_gender', 'I respect people regardless of gender.'),
              ('seek_help', 'I know where to seek help for protection concerns.'),
            ].map(
              (item) => _LikertRow(
                statement: item.$2,
                value: _sectionC['likert_${item.$1}'] as int?,
                onChanged: (v) =>
                    setState(() => _sectionC['likert_${item.$1}'] = v),
              ),
            ),
            _SingleChoice(
              label: 'Have you changed any behaviors as a result of the BAM/GAM program?',
              options: yesNoOptions,
              value: _sectionC['behavior_changed'] as String?,
              onChanged: (v) =>
                  setState(() => _sectionC['behavior_changed'] = v),
            ),
            _FormTextField(
              label: 'If yes, what changes have you experienced?',
              initialValue: _sectionC['behavior_changes_detail'] as String? ?? '',
              onSaved: (v) => _sectionC['behavior_changes_detail'] = v ?? '',
              maxLines: 3,
            ),
            _SingleChoice(
              label: 'Have relationships between boys and girls improved in your school?',
              options: const [
                ('significantly_improved', 'Significantly Improved'),
                ('improved', 'Improved'),
                ('no_change', 'No Change'),
                ('worsened', 'Worsened'),
              ],
              value: _sectionC['gender_relations'] as String?,
              onChanged: (v) =>
                  setState(() => _sectionC['gender_relations'] = v),
            ),
            _SingleChoice(
              label: 'Have you shared lessons learned with others?',
              options: yesNoOptions,
              value: _sectionC['shared_lessons'] as String?,
              onChanged: (v) =>
                  setState(() => _sectionC['shared_lessons'] = v),
            ),
            _MultiCheck(
              label: 'If yes, who have you shared them with?',
              options: const [
                ('friends', 'Friends'),
                ('family', 'Family Members'),
                ('community', 'Community Members'),
                ('classmates', 'Classmates'),
                ('others', 'Others'),
              ],
              selected: Set<String>.from(
                  (_sectionC['shared_with'] as List<dynamic>? ?? []).cast<String>()),
              onToggle: (val, checked) {
                setState(() {
                  final list =
                      List<String>.from(_sectionC['shared_with'] as List<dynamic>? ?? []);
                  if (checked) {
                    list.add(val);
                  } else {
                    list.remove(val);
                  }
                  _sectionC['shared_with'] = list;
                });
              },
            ),
            _FormTextField(
              label: 'Which BAM/GAM topics were most useful?',
              initialValue: _sectionC['most_useful_topics'] as String? ?? '',
              onSaved: (v) => _sectionC['most_useful_topics'] = v ?? '',
              maxLines: 2,
            ),
            _FormTextField(
              label: 'Which topics need improvement?',
              initialValue: _sectionC['topics_needing_improvement'] as String? ?? '',
              onSaved: (v) => _sectionC['topics_needing_improvement'] = v ?? '',
              maxLines: 2,
            ),
            _SingleChoice(
              label: 'Overall satisfaction with BAM/GAM curriculum',
              options: const [
                ('very_satisfied', 'Very Satisfied'),
                ('satisfied', 'Satisfied'),
                ('neutral', 'Neutral'),
                ('dissatisfied', 'Dissatisfied'),
                ('very_dissatisfied', 'Very Dissatisfied'),
              ],
              value: _sectionC['overall_satisfaction'] as String?,
              onChanged: (v) =>
                  setState(() => _sectionC['overall_satisfaction'] = v),
            ),

            // ── Section D: School Building Project Evaluation ────────────
            const SizedBox(height: 24),
            _SectionHeader('Section D: School Building Project Evaluation'),
            _SingleChoice(
              label:
                  'Are you aware of the school building/facility constructed or rehabilitated by Freedom Tree?',
              options: yesNoOptions,
              value: _sectionD['aware_of_building'] as String?,
              onChanged: (v) =>
                  setState(() => _sectionD['aware_of_building'] = v),
            ),
            _SingleChoice(
              label: 'How would you rate the quality of the construction?',
              options: const [
                ('excellent', 'Excellent'),
                ('good', 'Good'),
                ('fair', 'Fair'),
                ('poor', 'Poor'),
              ],
              value: _sectionD['construction_quality'] as String?,
              onChanged: (v) =>
                  setState(() => _sectionD['construction_quality'] = v),
            ),
            _SingleChoice(
              label: 'Does the facility provide a safe learning environment?',
              options: yesNoOptions,
              value: _sectionD['safe_environment'] as String?,
              onChanged: (v) =>
                  setState(() => _sectionD['safe_environment'] = v),
            ),
            _SingleChoice(
              label: 'Has classroom overcrowding reduced?',
              options: const [
                ('significantly', 'Significantly'),
                ('moderately', 'Moderately'),
                ('slightly', 'Slightly'),
                ('not_at_all', 'Not at All'),
              ],
              value: _sectionD['overcrowding_reduced'] as String?,
              onChanged: (v) =>
                  setState(() => _sectionD['overcrowding_reduced'] = v),
            ),
            _SingleChoice(
              label: 'Has student attendance improved due to the improved facilities?',
              options: const [
                ('yes', 'Yes'),
                ('no', 'No'),
                ('unsure', 'Unsure'),
              ],
              value: _sectionD['attendance_improved'] as String?,
              onChanged: (v) =>
                  setState(() => _sectionD['attendance_improved'] = v),
            ),
            _FormTextField(
              label: 'How has the new infrastructure improved teaching and learning?',
              initialValue: _sectionD['infrastructure_impact'] as String? ?? '',
              onSaved: (v) => _sectionD['infrastructure_impact'] = v ?? '',
              maxLines: 3,
            ),
            _SingleChoice(
              label: 'Is the facility accessible to both boys and girls?',
              options: yesNoOptions,
              value: _sectionD['accessible_all_genders'] as String?,
              onChanged: (v) =>
                  setState(() => _sectionD['accessible_all_genders'] = v),
            ),
            _SingleChoice(
              label: 'Are there mechanisms in place for maintenance?',
              options: yesNoOptions,
              value: _sectionD['maintenance_mechanism'] as String?,
              onChanged: (v) =>
                  setState(() => _sectionD['maintenance_mechanism'] = v),
            ),
            _FormTextField(
              label: 'Who is responsible for maintenance?',
              initialValue: _sectionD['maintenance_responsible'] as String? ?? '',
              onSaved: (v) => _sectionD['maintenance_responsible'] = v ?? '',
            ),

            // ── Section E: Project Impact ────────────────────────────────
            const SizedBox(height: 24),
            _SectionHeader('Section E: Project Impact'),
            const Padding(
              padding: EdgeInsets.only(bottom: 8),
              child: Text(
                'Overall, how has the project affected the school community?',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
            ...[
              ('school_attendance', 'School Attendance'),
              ('academic_performance', 'Academic Performance'),
              ('gender_equality', 'Gender Equality'),
              ('student_confidence', 'Student Confidence'),
              ('child_protection_awareness', 'Child Protection Awareness'),
              ('community_involvement', 'Community Involvement in Education'),
            ].map(
              (item) => _SingleChoice(
                label: item.$2,
                options: const [
                  ('improved_greatly', 'Improved Greatly'),
                  ('improved', 'Improved'),
                  ('no_change', 'No Change'),
                  ('declined', 'Declined'),
                ],
                value: _sectionE['impact_${item.$1}'] as String?,
                onChanged: (v) =>
                    setState(() => _sectionE['impact_${item.$1}'] = v),
              ),
            ),
            _SingleChoice(
              label: 'Which project component had the greatest impact?',
              options: const [
                ('scholarship', 'Scholarship'),
                ('bam', 'BAM Curriculum'),
                ('gam', 'GAM Curriculum'),
                ('school_building', 'School Building Project'),
              ],
              value: _sectionE['greatest_impact_component'] as String?,
              onChanged: (v) =>
                  setState(() => _sectionE['greatest_impact_component'] = v),
            ),
            _FormTextField(
              label: 'Why?',
              initialValue: _sectionE['greatest_impact_reason'] as String? ?? '',
              onSaved: (v) => _sectionE['greatest_impact_reason'] = v ?? '',
              maxLines: 3,
            ),

            // ── Section F: Sustainability ────────────────────────────────
            const SizedBox(height: 24),
            _SectionHeader('Section F: Sustainability'),
            _SingleChoice(
              label: 'Do you believe the project benefits will continue after project closure?',
              options: const [
                ('yes', 'Yes'),
                ('no', 'No'),
                ('not_sure', 'Not Sure'),
              ],
              value: _sectionF['benefits_continue'] as String?,
              onChanged: (v) =>
                  setState(() => _sectionF['benefits_continue'] = v),
            ),
            _FormTextField(
              label: 'What measures are in place to sustain project achievements?',
              initialValue: _sectionF['sustain_measures'] as String? ?? '',
              onSaved: (v) => _sectionF['sustain_measures'] = v ?? '',
              maxLines: 3,
            ),
            _FormTextField(
              label: 'What additional support is needed?',
              initialValue: _sectionF['additional_support'] as String? ?? '',
              onSaved: (v) => _sectionF['additional_support'] = v ?? '',
              maxLines: 3,
            ),

            // ── Section G: Success Stories ───────────────────────────────
            const SizedBox(height: 24),
            _SectionHeader('Section G: Success Stories and Lessons Learned'),
            _FormTextField(
              label: 'Can you share a personal success story resulting from this project?',
              initialValue: _sectionG['success_story'] as String? ?? '',
              onSaved: (v) => _sectionG['success_story'] = v ?? '',
              maxLines: 4,
            ),
            _FormTextField(
              label: 'What was the most valuable aspect of the project?',
              initialValue: _sectionG['most_valuable'] as String? ?? '',
              onSaved: (v) => _sectionG['most_valuable'] = v ?? '',
              maxLines: 3,
            ),
            _FormTextField(
              label: 'What recommendations would you make for future projects?',
              initialValue: _sectionG['recommendations'] as String? ?? '',
              onSaved: (v) => _sectionG['recommendations'] = v ?? '',
              maxLines: 3,
            ),
            _FormTextField(
              label: 'Any additional comments?',
              initialValue: _sectionG['additional_comments'] as String? ?? '',
              onSaved: (v) => _sectionG['additional_comments'] = v ?? '',
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
          Text(label, style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600)),
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
          Text(label, style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600)),
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
