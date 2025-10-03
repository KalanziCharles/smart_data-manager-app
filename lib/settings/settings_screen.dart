// ignore_for_file: prefer_final_fields

import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  // Notification Settings
  bool _enableNotifications = true;
  bool _lowDataAlerts = true;
  bool _expiryAlerts = true;
  bool _usageAlerts = true;

  // Data Tracking Settings
  bool _autoTrackData = true;
  double _alertThreshold = 80.0;
  bool _wifiOnlyUpdates = false;

  // App Preferences
  bool _darkMode = false;
  String _dataUnit = 'GB';
  String _language = 'English';

  // Account Settings
  String _dataPlan = 'Monthly';
  String _billingCycle = '1st of every month';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Settings',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        backgroundColor: Colors.blue.shade700,
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: _saveSettings,
            tooltip: 'Save Settings',
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Profile Section
          _buildProfileSection(),
          const SizedBox(height: 24),

          // Notification Settings
          _buildSectionHeader('Notifications', Icons.notifications),
          _buildNotificationSettings(),
          const SizedBox(height: 24),

          // Data Tracking Settings
          _buildSectionHeader('Data Tracking', Icons.data_usage),
          _buildDataTrackingSettings(),
          const SizedBox(height: 24),

          // App Preferences
          _buildSectionHeader('App Preferences', Icons.settings),
          _buildAppPreferences(),
          const SizedBox(height: 24),

          // Account Settings
          _buildSectionHeader('Account', Icons.person),
          _buildAccountSettings(),
          const SizedBox(height: 24),

          // Actions Section
          _buildSectionHeader('Actions', Icons.build),
          _buildActionButtons(),
          const SizedBox(height: 40),
        ],
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildProfileSection() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: Colors.blue.shade100,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.person, size: 30, color: Colors.blue),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'User Profile',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Manage your data preferences',
                    style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
                  ),
                ],
              ),
            ),
            IconButton(icon: const Icon(Icons.edit), onPressed: _editProfile),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Icon(icon, size: 20, color: Colors.blue),
          const SizedBox(width: 8),
          Text(
            title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationSettings() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildSettingSwitch(
              'Enable Notifications',
              'Receive alerts and reminders',
              _enableNotifications,
              (value) => setState(() => _enableNotifications = value),
            ),
            _buildDivider(),
            _buildSettingSwitch(
              'Low Data Alerts',
              'Warn when data is running low',
              _lowDataAlerts,
              (value) => setState(() => _lowDataAlerts = value),
              enabled: _enableNotifications,
            ),
            _buildDivider(),
            _buildSettingSwitch(
              'Expiry Alerts',
              'Notify before data bundle expires',
              _expiryAlerts,
              (value) => setState(() => _expiryAlerts = value),
              enabled: _enableNotifications,
            ),
            _buildDivider(),
            _buildSettingSwitch(
              'Usage Alerts',
              'Daily/weekly usage reports',
              _usageAlerts,
              (value) => setState(() => _usageAlerts = value),
              enabled: _enableNotifications,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDataTrackingSettings() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildSettingSwitch(
              'Auto Track Data',
              'Automatically monitor data usage',
              _autoTrackData,
              (value) => setState(() => _autoTrackData = value),
            ),
            _buildDivider(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Alert Threshold',
                        style: TextStyle(fontSize: 16),
                      ),
                      Text(
                        '${_alertThreshold.toInt()}%',
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.blue,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Get alerts when data usage reaches this level',
                    style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
                  ),
                  const SizedBox(height: 12),
                  Slider(
                    value: _alertThreshold,
                    min: 50,
                    max: 95,
                    divisions: 9,
                    onChanged: (value) =>
                        setState(() => _alertThreshold = value),
                    activeColor: Colors.blue,
                  ),
                ],
              ),
            ),
            _buildDivider(),
            _buildSettingSwitch(
              'Wi-Fi Only Updates',
              'Check for updates only on Wi-Fi',
              _wifiOnlyUpdates,
              (value) => setState(() => _wifiOnlyUpdates = value),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAppPreferences() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildSettingSwitch(
              'Dark Mode',
              'Use dark theme in the app',
              _darkMode,
              (value) => setState(() => _darkMode = value),
            ),
            _buildDivider(),
            _buildSettingDropdown(
              'Data Unit',
              'Preferred unit for data display',
              _dataUnit,
              ['GB', 'MB', 'KB'],
              (value) => setState(() => _dataUnit = value!),
            ),
            _buildDivider(),
            _buildSettingDropdown(
              'Language',
              'App language preference',
              _language,
              ['English', 'Spanish', 'French', 'German'],
              (value) => setState(() => _language = value!),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAccountSettings() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildSettingInfo(
              'Data Plan',
              'Current subscription plan',
              _dataPlan,
            ),
            _buildDivider(),
            _buildSettingInfo(
              'Billing Cycle',
              'Next billing date',
              _billingCycle,
            ),
            _buildDivider(),
            ListTile(
              leading: const Icon(Icons.payment, color: Colors.blue),
              title: const Text('Manage Subscription'),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: _manageSubscription,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButtons() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildActionButton(
              Icons.refresh,
              'Reset Data Tracking',
              'Start fresh data monitoring',
              _resetDataTracking,
            ),
            _buildDivider(),
            _buildActionButton(
              Icons.help_outline,
              'Help & Support',
              'Get help using the app',
              _showHelpSupport,
            ),
            _buildDivider(),
            _buildActionButton(
              Icons.share,
              'Share App',
              'Share with friends and family',
              _shareApp,
            ),
            _buildDivider(),
            _buildActionButton(
              Icons.star,
              'Rate App',
              'Rate us on the app store',
              _rateApp,
            ),
            _buildDivider(),
            _buildActionButton(
              Icons.privacy_tip,
              'Privacy Policy',
              'View our privacy practices',
              _showPrivacyPolicy,
            ),
            _buildDivider(),
            _buildActionButton(
              Icons.description,
              'Terms of Service',
              'Read terms and conditions',
              _showTermsOfService,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingSwitch(
    String title,
    String subtitle,
    bool value,
    Function(bool) onChanged, {
    bool enabled = true,
  }) {
    return ListTile(
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: enabled ? Colors.blue.shade50 : Colors.grey.shade200,
          shape: BoxShape.circle,
        ),
        child: Icon(
          Icons.notifications,
          color: enabled ? Colors.blue : Colors.grey,
          size: 20,
        ),
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          color: enabled ? Colors.black : Colors.grey,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(
          fontSize: 14,
          color: enabled ? Colors.grey.shade600 : Colors.grey,
        ),
      ),
      trailing: Switch.adaptive(
        value: value,
        onChanged: enabled ? onChanged : null,
        // Non-deprecated color properties
        activeThumbColor: Colors.blue,
        activeTrackColor: Colors.blue.shade100,
        inactiveThumbColor: Colors.grey.shade400,
        inactiveTrackColor: Colors.grey.shade300,
      ),
      onTap: enabled ? () => onChanged(!value) : null,
    );
  }

  Widget _buildSettingDropdown(
    String title,
    String subtitle,
    String value,
    List<String> options,
    Function(String?) onChanged,
  ) {
    return ListTile(
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: Colors.blue.shade50,
          shape: BoxShape.circle,
        ),
        child: const Icon(Icons.language, color: Colors.blue, size: 20),
      ),
      title: Text(title, style: const TextStyle(fontSize: 16)),
      subtitle: Text(
        subtitle,
        style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
      ),
      trailing: DropdownButton<String>(
        value: value,
        onChanged: onChanged,
        items: options.map((String option) {
          return DropdownMenuItem<String>(value: option, child: Text(option));
        }).toList(),
        underline: Container(),
      ),
    );
  }

  Widget _buildSettingInfo(String title, String subtitle, String value) {
    return ListTile(
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: Colors.green.shade50,
          shape: BoxShape.circle,
        ),
        child: const Icon(Icons.credit_card, color: Colors.green, size: 20),
      ),
      title: Text(title, style: const TextStyle(fontSize: 16)),
      subtitle: Text(
        subtitle,
        style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
      ),
      trailing: Text(
        value,
        style: const TextStyle(fontWeight: FontWeight.w600, color: Colors.blue),
      ),
    );
  }

  Widget _buildActionButton(
    IconData icon,
    String title,
    String subtitle,
    VoidCallback onTap,
  ) {
    return ListTile(
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: Colors.blue.shade50,
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: Colors.blue, size: 20),
      ),
      title: Text(title, style: const TextStyle(fontSize: 16)),
      subtitle: Text(
        subtitle,
        style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
      ),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: onTap,
    );
  }

  Widget _buildDivider() {
    return Divider(color: Colors.grey.shade300, height: 1);
  }

  Widget _buildBottomNavigationBar() {
    return BottomNavigationBar(
      currentIndex: 3,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.blue.shade700,
      unselectedItemColor: Colors.grey,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.dashboard),
          label: 'Dashboard',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.notifications),
          label: 'Alerts',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.lightbulb_outline),
          label: 'Suggestions',
        ),
        BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
      ],
      onTap: (index) {
        switch (index) {
          case 0:
            Navigator.pushReplacementNamed(context, '/dashboard');
            break;
          case 1:
            Navigator.pushReplacementNamed(context, '/alerts');
            break;
          case 2:
            Navigator.pushReplacementNamed(context, '/suggestions');
            break;
          case 3:
            // Already on settings
            break;
        }
      },
    );
  }

  // Action Methods
  void _saveSettings() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Settings saved successfully!'),
        backgroundColor: Colors.green,
      ),
    );
  }

  void _editProfile() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Profile'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Profile editing feature coming soon!'),
            SizedBox(height: 16),
            Text(
              'You will be able to update your personal information and preferences.',
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _manageSubscription() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Manage Subscription'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Subscription management coming soon!'),
            SizedBox(height: 16),
            Text(
              'You will be able to upgrade, downgrade, or cancel your data plan.',
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _resetDataTracking() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Reset Data Tracking'),
        content: const Text(
          'This will clear all your current data usage history and start fresh. This action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Data tracking reset successfully!'),
                  backgroundColor: Colors.green,
                ),
              );
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Reset'),
          ),
        ],
      ),
    );
  }

  void _showHelpSupport() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Help & Support',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            _buildSupportOption(
              Icons.email,
              'Email Support',
              'contact@smartdatamanager.com',
            ),
            _buildSupportOption(Icons.chat, 'Live Chat', 'Available 24/7'),
            _buildSupportOption(
              Icons.help,
              'FAQ',
              'Frequently asked questions',
            ),
            _buildSupportOption(
              Icons.video_library,
              'Tutorials',
              'How-to guides',
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Close'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSupportOption(IconData icon, String title, String subtitle) {
    return ListTile(
      leading: Icon(icon, color: Colors.blue),
      title: Text(title),
      subtitle: Text(subtitle),
      onTap: () {
        Navigator.of(context).pop();
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Opening: $title')));
      },
    );
  }

  void _shareApp() {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Sharing app...')));
  }

  void _rateApp() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Redirecting to app store...')),
    );
  }

  void _showPrivacyPolicy() {
    _showLegalDocument('Privacy Policy', 'Your privacy is important to us...');
  }

  void _showTermsOfService() {
    _showLegalDocument('Terms of Service', 'By using our app, you agree to...');
  }

  void _showLegalDocument(String title, String content) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: SingleChildScrollView(child: Text(content)),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}
