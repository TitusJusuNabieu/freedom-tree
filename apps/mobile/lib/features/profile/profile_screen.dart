import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:freedomtree_mobile/app/theme.dart';
import 'package:freedomtree_mobile/core/network/api_config.dart';
import 'package:freedomtree_mobile/features/auth/auth_controller.dart';
import 'package:freedomtree_mobile/features/auth/auth_models.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({
    super.key,
    required this.authController,
    required this.apiDio,
  });

  final AuthController authController;
  final Dio apiDio;

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late final TextEditingController _nameCtrl;
  late final TextEditingController _positionCtrl;
  late final TextEditingController _communityCtrl;

  final _currentPwCtrl = TextEditingController();
  final _newPwCtrl = TextEditingController();
  final _confirmPwCtrl = TextEditingController();

  bool _profileLoading = false;
  bool _pwLoading = false;
  String? _profileMsg;
  String? _profileError;
  String? _pwMsg;
  String? _pwError;

  CurrentUser get _user => widget.authController.currentUser!;

  @override
  void initState() {
    super.initState();
    _nameCtrl = TextEditingController(text: _user.name);
    _positionCtrl = TextEditingController(text: _user.position);
    _communityCtrl = TextEditingController(text: _user.community ?? '');
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _positionCtrl.dispose();
    _communityCtrl.dispose();
    _currentPwCtrl.dispose();
    _newPwCtrl.dispose();
    _confirmPwCtrl.dispose();
    super.dispose();
  }

  Future<void> _saveProfile() async {
    setState(() {
      _profileLoading = true;
      _profileMsg = null;
      _profileError = null;
    });

    try {
      final res = await widget.apiDio.put('/profile', data: {
        'name': _nameCtrl.text.trim(),
        'position': _positionCtrl.text.trim(),
        'community': _communityCtrl.text.trim().isEmpty ? null : _communityCtrl.text.trim(),
      });
      // Update the local controller state
      final updatedUser = widget.authController.currentUser!.copyWith(
        name: res.data['name'] as String?,
        position: res.data['position'] as String?,
        community: res.data['community'] as String?,
      );
      widget.authController.updateUser(updatedUser);
      setState(() => _profileMsg = 'Profile updated successfully!');
    } on DioException catch (e) {
      final msg = (e.response?.data as Map<String, dynamic>?)?['error'] as String? ?? 'Update failed';
      setState(() => _profileError = msg);
    } catch (_) {
      setState(() => _profileError = 'An unexpected error occurred');
    } finally {
      setState(() => _profileLoading = false);
    }
  }

  Future<void> _changePassword() async {
    if (_newPwCtrl.text != _confirmPwCtrl.text) {
      setState(() => _pwError = 'New passwords do not match');
      return;
    }

    setState(() {
      _pwLoading = true;
      _pwMsg = null;
      _pwError = null;
    });

    try {
      await widget.apiDio.put('/profile/password', data: {
        'currentPassword': _currentPwCtrl.text,
        'newPassword': _newPwCtrl.text,
      });
      _currentPwCtrl.clear();
      _newPwCtrl.clear();
      _confirmPwCtrl.clear();
      setState(() => _pwMsg = 'Password updated successfully!');
    } on DioException catch (e) {
      final msg = (e.response?.data as Map<String, dynamic>?)?['error'] as String? ?? 'Failed to update password';
      setState(() => _pwError = msg);
    } catch (_) {
      setState(() => _pwError = 'An unexpected error occurred');
    } finally {
      setState(() => _pwLoading = false);
    }
  }

  Widget _buildAvatar() {
    final avatarUrl = _user.avatarUrl;
    const size = 80.0;

    if (avatarUrl != null && avatarUrl.isNotEmpty) {
      final fullUrl = avatarUrl.startsWith('http') ? avatarUrl : '$apiBaseUrl$avatarUrl'.replaceFirst('/api', '');
      return CircleAvatar(
        radius: size / 2,
        backgroundImage: NetworkImage(fullUrl),
        backgroundColor: FtColors.greyLight,
      );
    }

    final initial = _user.name.isNotEmpty ? _user.name[0].toUpperCase() : '?';
    return CircleAvatar(
      radius: size / 2,
      backgroundColor: FtColors.orange,
      child: Text(
        initial,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 30,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Profile'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Avatar section
            Center(child: _buildAvatar()),
            const SizedBox(height: 8),
            Center(
              child: Text(
                _user.name,
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            Center(
              child: Text(
                _user.position,
                style: const TextStyle(color: FtColors.greyMedium),
              ),
            ),
            const SizedBox(height: 24),

            // Profile info section
            _SectionCard(
              title: 'Profile Information',
              child: Column(
                children: [
                  _buildField('Full Name', _nameCtrl),
                  const SizedBox(height: 12),
                  _buildField('Position', _positionCtrl),
                  const SizedBox(height: 12),
                  _buildField('Community (optional)', _communityCtrl),
                  const SizedBox(height: 16),
                  if (_profileMsg != null)
                    _StatusBanner(message: _profileMsg!, isError: false),
                  if (_profileError != null)
                    _StatusBanner(message: _profileError!, isError: true),
                  const SizedBox(height: 8),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _profileLoading ? null : _saveProfile,
                      child: _profileLoading
                          ? const SizedBox(
                              height: 18,
                              width: 18,
                              child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                            )
                          : const Text('Save Profile'),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Change password section
            _SectionCard(
              title: 'Change Password',
              child: Column(
                children: [
                  _buildField('Current Password', _currentPwCtrl, obscure: true),
                  const SizedBox(height: 12),
                  _buildField('New Password', _newPwCtrl, obscure: true),
                  const SizedBox(height: 12),
                  _buildField('Confirm New Password', _confirmPwCtrl, obscure: true),
                  const SizedBox(height: 16),
                  if (_pwMsg != null)
                    _StatusBanner(message: _pwMsg!, isError: false),
                  if (_pwError != null)
                    _StatusBanner(message: _pwError!, isError: true),
                  const SizedBox(height: 8),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _pwLoading ? null : _changePassword,
                      child: _pwLoading
                          ? const SizedBox(
                              height: 18,
                              width: 18,
                              child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                            )
                          : const Text('Update Password'),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildField(String label, TextEditingController ctrl, {bool obscure = false}) {
    return TextField(
      controller: ctrl,
      obscureText: obscure,
      decoration: InputDecoration(labelText: label),
    );
  }
}

class _SectionCard extends StatelessWidget {
  const _SectionCard({required this.title, required this.child});

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: FtColors.greyLight),
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 16),
          child,
        ],
      ),
    );
  }
}

class _StatusBanner extends StatelessWidget {
  const _StatusBanner({required this.message, required this.isError});

  final String message;
  final bool isError;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: isError ? FtColors.darkOrange.withAlpha(20) : FtColors.green.withAlpha(30),
        border: Border.all(color: isError ? FtColors.darkOrange : FtColors.green),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        message,
        style: TextStyle(
          color: isError ? FtColors.darkOrange : FtColors.green,
          fontSize: 13,
        ),
      ),
    );
  }
}
