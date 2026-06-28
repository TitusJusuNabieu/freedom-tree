import 'package:flutter/material.dart';
import 'package:freedomtree_mobile/app/theme.dart';
import 'package:freedomtree_mobile/features/auth/auth_controller.dart';
import 'package:freedomtree_mobile/features/reports/report_draft.dart';
import 'package:freedomtree_mobile/features/reports/report_enums.dart';
import 'package:freedomtree_mobile/features/reports/reports_repository.dart';

class ReportFormScreen extends StatefulWidget {
  const ReportFormScreen({super.key, required this.authController, required this.reportsRepository});

  final AuthController authController;
  final ReportsRepository reportsRepository;

  @override
  State<ReportFormScreen> createState() => _ReportFormScreenState();
}

class _ReportFormScreenState extends State<ReportFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late final ReportDraft _draft;
  bool _submitting = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    final user = widget.authController.currentUser;
    _draft = ReportDraft()
      ..submittedByName = user?.name ?? ''
      ..submittedByPosition = user?.position ?? ''
      ..community = user?.community ?? '';
  }

  Future<void> _pickReportingMonth() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: _draft.reportingMonth ?? DateTime(now.year, now.month),
      firstDate: DateTime(now.year - 2),
      lastDate: DateTime(now.year, now.month),
      helpText: 'Select reporting month',
    );
    if (picked != null) {
      setState(() => _draft.reportingMonth = DateTime(picked.year, picked.month));
    }
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    if (_draft.reportingMonth == null) {
      setState(() => _error = 'Please select a reporting month.');
      return;
    }
    _formKey.currentState!.save();
    setState(() {
      _submitting = true;
      _error = null;
    });

    try {
      // Check for a local duplicate before saving.
      final duplicate = await widget.reportsRepository.existsForCommunityMonth(
        _draft.community,
        _draft.reportingMonth!,
      );
      if (duplicate) {
        setState(() => _error = 'A report for this community and month is already saved.');
        return;
      }
      // Local-first save — instantly visible, sync engine delivers it when online.
      await widget.reportsRepository.save(_draft);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Report saved. It will sync automatically when online.'),
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
      appBar: AppBar(title: const Text('Monthly Report')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _SectionHeader('General Information'),
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(_draft.reportingMonth == null
                  ? 'Select reporting month'
                  : '${reportingMonths[_draft.reportingMonth!.month - 1]} ${_draft.reportingMonth!.year}'),
              trailing: const Icon(Icons.calendar_month, color: FtColors.orange),
              onTap: _pickReportingMonth,
            ),
            _TextField(
              label: 'Community/District',
              initialValue: _draft.community,
              onSaved: (v) => _draft.community = v ?? '',
              required: true,
            ),
            _TextField(
              label: 'Submitted by (Name)',
              initialValue: _draft.submittedByName,
              onSaved: (v) => _draft.submittedByName = v ?? '',
              required: true,
            ),
            _TextField(
              label: 'Position',
              initialValue: _draft.submittedByPosition,
              onSaved: (v) => _draft.submittedByPosition = v ?? '',
              required: true,
            ),
            const SizedBox(height: 24),
            _SectionHeader('Maternal Health'),
            _NumberField(
              label: 'Total pregnant women this month',
              initialValue: _draft.pregnantWomenCount,
              onSaved: (v) => _draft.pregnantWomenCount = v,
            ),
            _NumberField(
              label: 'Total deliveries conducted this month',
              initialValue: _draft.deliveriesTotal,
              onSaved: (v) => _draft.deliveriesTotal = v,
            ),
            _NumberField(
              label: 'At Health Facility',
              initialValue: _draft.deliveriesAtFacility,
              onSaved: (v) => _draft.deliveriesAtFacility = v,
            ),
            _NumberField(
              label: 'At Home',
              initialValue: _draft.deliveriesAtHome,
              onSaved: (v) => _draft.deliveriesAtHome = v,
            ),
            _NumberField(
              label: 'Total maternal deaths this month',
              initialValue: _draft.maternalDeaths,
              onSaved: (v) => _draft.maternalDeaths = v,
            ),
            const SizedBox(height: 8),
            Text('Place of Death', style: Theme.of(context).textTheme.titleMedium),
            ...PlaceOfDeath.values.map(
              (v) => CheckboxListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(v.label),
                value: _draft.placeOfDeath.contains(v),
                onChanged: (checked) => setState(() {
                  if (checked == true) {
                    _draft.placeOfDeath.add(v);
                  } else {
                    _draft.placeOfDeath.remove(v);
                  }
                }),
              ),
            ),
            _TextField(
              label: 'Place of death — other note',
              initialValue: _draft.placeOfDeathOtherNote,
              onSaved: (v) => _draft.placeOfDeathOtherNote = v ?? '',
            ),
            _TextField(
              label: 'Suspected Cause(s)',
              initialValue: _draft.suspectedMaternalCause,
              onSaved: (v) => _draft.suspectedMaternalCause = v ?? '',
            ),
            const SizedBox(height: 24),
            _SectionHeader('Infant Health'),
            _NumberField(
              label: 'Total live births this month',
              initialValue: _draft.liveBirths,
              onSaved: (v) => _draft.liveBirths = v,
            ),
            _NumberField(
              label: 'Total infant deaths (0-12 months)',
              initialValue: _draft.infantDeathsTotal,
              onSaved: (v) => _draft.infantDeathsTotal = v,
            ),
            _NumberField(
              label: 'A. Within 24 hours',
              initialValue: _draft.infantDeathsWithin24h,
              onSaved: (v) => _draft.infantDeathsWithin24h = v,
            ),
            _NumberField(
              label: 'B. Within 1 month',
              initialValue: _draft.infantDeathsWithin1Month,
              onSaved: (v) => _draft.infantDeathsWithin1Month = v,
            ),
            _NumberField(
              label: 'C. Within 0-12 months',
              initialValue: _draft.infantDeathsWithin12Months,
              onSaved: (v) => _draft.infantDeathsWithin12Months = v,
            ),
            const SizedBox(height: 24),
            _SectionHeader('Contributing Factors (tick all that apply)'),
            ...InfantDeathCause.values.map(
              (v) => CheckboxListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(v.label),
                value: _draft.infantDeathCauses.contains(v),
                onChanged: (checked) => setState(() {
                  if (checked == true) {
                    _draft.infantDeathCauses.add(v);
                  } else {
                    _draft.infantDeathCauses.remove(v);
                  }
                }),
              ),
            ),
            _TextField(
              label: 'Infant death cause — other note',
              initialValue: _draft.infantDeathCausesOtherNote,
              onSaved: (v) => _draft.infantDeathCausesOtherNote = v ?? '',
            ),
            const SizedBox(height: 24),
            _SectionHeader('Community Actions & Recommendations'),
            _TextField(
              label: 'A. Key challenges faced this month',
              initialValue: _draft.keyChallenges,
              onSaved: (v) => _draft.keyChallenges = v ?? '',
              maxLines: 3,
            ),
            _TextField(
              label: 'B. Actions taken/planned',
              initialValue: _draft.actionsTaken,
              onSaved: (v) => _draft.actionsTaken = v ?? '',
              maxLines: 3,
            ),
            _TextField(
              label: 'C. Additional comments/suggestions',
              initialValue: _draft.additionalComments,
              onSaved: (v) => _draft.additionalComments = v ?? '',
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
                  ? const SizedBox(height: 18, width: 18, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                  : const Text('Submit report'),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}

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

class _TextField extends StatelessWidget {
  const _TextField({required this.label, required this.initialValue, required this.onSaved, this.required = false, this.maxLines = 1});

  final String label;
  final String initialValue;
  final void Function(String?) onSaved;
  final bool required;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextFormField(
        initialValue: initialValue,
        maxLines: maxLines,
        decoration: InputDecoration(labelText: label),
        validator: required ? (v) => (v == null || v.isEmpty) ? 'Required' : null : null,
        onSaved: onSaved,
      ),
    );
  }
}

class _NumberField extends StatelessWidget {
  const _NumberField({required this.label, required this.initialValue, required this.onSaved});

  final String label;
  final int initialValue;
  final void Function(int) onSaved;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextFormField(
        initialValue: initialValue.toString(),
        keyboardType: TextInputType.number,
        decoration: InputDecoration(labelText: label),
        validator: (v) {
          if (v == null || v.isEmpty) return 'Required';
          if (int.tryParse(v) == null) return 'Must be a number';
          return null;
        },
        onSaved: (v) => onSaved(int.tryParse(v ?? '') ?? 0),
      ),
    );
  }
}
