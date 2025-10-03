import 'package:flutter/material.dart';

class AlertItem {
  final String id;
  final String title;
  final String description;
  final String timestamp;
  final AlertType type;
  final bool isRead;

  AlertItem({
    required this.id,
    required this.title,
    required this.description,
    required this.timestamp,
    required this.type,
    this.isRead = false,
  });
}

enum AlertType { warning, info, success, reminder }

class AlertsScreen extends StatefulWidget {
  const AlertsScreen({super.key}); // Make sure this is const

  @override
  State<AlertsScreen> createState() => _AlertsScreenState();
}

class _AlertsScreenState extends State<AlertsScreen> {
  final List<AlertItem> alerts = [
    AlertItem(
      id: '1',
      title: 'Bundle Expiry Warning',
      description: 'Your 1.0 GB bundle will expire in 2 days',
      timestamp: '2 hours ago',
      type: AlertType.warning,
    ),
    AlertItem(
      id: '2',
      title: 'Low Usage Alert',
      description:
          'You are using less data than usual. Predicted leftover: 800 MB',
      timestamp: '5 hours ago',
      type: AlertType.info,
    ),
    AlertItem(
      id: '3',
      title: 'Backup Recommended',
      description: 'Backup recommended yesterday',
      timestamp: '1 day ago',
      type: AlertType.success,
    ),
    AlertItem(
      id: '4',
      title: 'Data Saving Tip',
      description: 'Consider updating apps over Wi-Fi to save mobile data',
      timestamp: '2 days ago',
      type: AlertType.reminder,
      isRead: true,
    ),
    AlertItem(
      id: '5',
      title: 'Weekly Usage Report',
      description: 'You used 2.3 GB this week. 1.2 GB remaining until reset',
      timestamp: '3 days ago',
      type: AlertType.info,
      isRead: true,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Alerts',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        backgroundColor: Colors.blue.shade700,
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: _showMoreOptions,
          ),
        ],
      ),
      body: Column(
        children: [
          // Quick Stats Header
          _buildStatsHeader(),

          // Alerts List
          Expanded(child: _buildAlertsList()),
        ],
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildStatsHeader() {
    final unreadCount = alerts.where((alert) => !alert.isRead).length;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        border: Border(bottom: BorderSide(color: Colors.grey.shade300)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Alerts ($unreadCount unread)',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.blue,
            ),
          ),
          if (unreadCount > 0)
            TextButton(
              onPressed: _markAllAsRead,
              child: const Text(
                'Mark all read',
                style: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildAlertsList() {
    if (alerts.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.notifications_off_outlined,
              size: 64,
              color: Colors.grey,
            ),
            SizedBox(height: 16),
            Text(
              'No Alerts',
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
            SizedBox(height: 8),
            Text(
              'You\'re all caught up!',
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: alerts.length,
      separatorBuilder: (context, index) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        return _buildAlertCard(alerts[index]);
      },
    );
  }

  Widget _buildAlertCard(AlertItem alert) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: alert.isRead ? Colors.transparent : Colors.blue.shade200,
          width: alert.isRead ? 0 : 1,
        ),
      ),
      color: alert.isRead ? Colors.white : Colors.blue.shade50,
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () => _showAlertDetails(alert),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Alert Icon
              _buildAlertIcon(alert.type),
              const SizedBox(width: 12),

              // Alert Content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title and Timestamp
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            alert.title,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: alert.isRead
                                  ? FontWeight.normal
                                  : FontWeight.bold,
                              color: alert.isRead
                                  ? Colors.grey.shade700
                                  : Colors.black,
                            ),
                          ),
                        ),
                        Text(
                          alert.timestamp,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey.shade500,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),

                    // Description
                    Text(
                      alert.description,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade700,
                        height: 1.3,
                      ),
                    ),

                    // Actions (for specific alert types)
                    if (alert.type == AlertType.warning) ...[
                      const SizedBox(height: 12),
                      _buildActionButtons(alert),
                    ],
                  ],
                ),
              ),

              // Unread indicator
              if (!alert.isRead)
                Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: Colors.blue,
                    shape: BoxShape.circle,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAlertIcon(AlertType type) {
    switch (type) {
      case AlertType.warning:
        return Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.orange.shade100,
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.warning_amber_rounded,
            color: Colors.orange,
            size: 20,
          ),
        );
      case AlertType.info:
        return Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.blue.shade100,
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.info_outlined, color: Colors.blue, size: 20),
        );
      case AlertType.success:
        return Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.green.shade100,
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.check_circle_outlined,
            color: Colors.green,
            size: 20,
          ),
        );
      case AlertType.reminder:
        return Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.purple.shade100,
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.schedule_outlined,
            color: Colors.purple,
            size: 20,
          ),
        );
    }
  }

  Widget _buildActionButtons(AlertItem alert) {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
            onPressed: () => _handleAction(alert, 'extend'),
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.blue,
              side: const BorderSide(color: Colors.blue),
              padding: const EdgeInsets.symmetric(vertical: 8),
            ),
            child: const Text('Extend Bundle', style: TextStyle(fontSize: 12)),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: ElevatedButton(
            onPressed: () => _handleAction(alert, 'use'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 8),
            ),
            child: const Text('Use Now', style: TextStyle(fontSize: 12)),
          ),
        ),
      ],
    );
  }

  Widget _buildBottomNavigationBar() {
    return BottomNavigationBar(
      currentIndex: 1,
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
            // Already on alerts
            break;
          case 2:
            Navigator.pushReplacementNamed(context, '/suggestions');
            break;
          case 3:
            Navigator.pushReplacementNamed(context, '/settings');
            break;
        }
      },
    );
  }

  void _showAlertDetails(AlertItem alert) {
    setState(() {
      // Mark as read when tapped
      final index = alerts.indexWhere((a) => a.id == alert.id);
      if (index != -1) {
        alerts[index] = alerts[index].copyWith(isRead: true);
      }
    });

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            _buildAlertIcon(alert.type),
            const SizedBox(width: 12),
            Expanded(child: Text(alert.title)),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(alert.description),
            const SizedBox(height: 16),
            Text(
              'Time: ${alert.timestamp}',
              style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
          if (alert.type == AlertType.warning)
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _handleAction(alert, 'extend');
              },
              child: const Text('Take Action'),
            ),
        ],
      ),
    );
  }

  void _markAllAsRead() {
    setState(() {
      for (int i = 0; i < alerts.length; i++) {
        alerts[i] = alerts[i].copyWith(isRead: true);
      }
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('All alerts marked as read'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  void _handleAction(AlertItem alert, String action) {
    switch (action) {
      case 'extend':
        _showExtendBundleDialog(alert);
        break;
      case 'use':
        _showUsageSuggestions(alert);
        break;
    }
  }

  void _showExtendBundleDialog(AlertItem alert) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Extend Data Bundle'),
        content: const Text(
          'Would you like to extend your expiring data bundle? '
          'This will prevent data loss and maintain your current usage patterns.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              _confirmBundleExtension(alert);
            },
            child: const Text('Extend Bundle'),
          ),
        ],
      ),
    );
  }

  void _confirmBundleExtension(AlertItem alert) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Bundle extension request sent successfully'),
        backgroundColor: Colors.green,
      ),
    );

    // Remove the alert after action
    setState(() {
      alerts.removeWhere((a) => a.id == alert.id);
    });
  }

  void _showUsageSuggestions(AlertItem alert) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Quick Data Usage Ideas',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            _buildSuggestionItem('📱 Update your mobile apps'),
            _buildSuggestionItem('🎵 Stream high-quality music'),
            _buildSuggestionItem('📥 Download videos for offline viewing'),
            _buildSuggestionItem('🔄 Backup photos to cloud storage'),
            _buildSuggestionItem('🎮 Download games or large files'),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Got it!'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSuggestionItem(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          const Icon(Icons.arrow_forward_ios, size: 12, color: Colors.grey),
          const SizedBox(width: 8),
          Text(text),
        ],
      ),
    );
  }

  void _showMoreOptions() {
    showModalBottomSheet(
      context: context,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.delete_outline),
              title: const Text('Clear All Alerts'),
              onTap: () {
                Navigator.of(context).pop();
                _clearAllAlerts();
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Alert Settings'),
              onTap: () {
                Navigator.of(context).pop();
                _navigateToAlertSettings();
              },
            ),
            ListTile(
              leading: const Icon(Icons.help_outline),
              title: const Text('About Alerts'),
              onTap: () {
                Navigator.of(context).pop();
                _showAboutAlerts();
              },
            ),
          ],
        ),
      ),
    );
  }

  void _clearAllAlerts() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Clear All Alerts?'),
        content: const Text(
          'This will remove all alerts. This action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              setState(() {
                alerts.clear();
              });
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('All alerts cleared')),
              );
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Clear All'),
          ),
        ],
      ),
    );
  }

  void _navigateToAlertSettings() {
    // Navigate to settings screen
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Navigating to Alert Settings')),
    );
  }

  void _showAboutAlerts() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('About Alerts'),
        content: const Text(
          'Smart Data Manager sends you alerts to help optimize your data usage:\n\n'
          '• Bundle expiry warnings\n'
          '• Usage pattern insights\n'
          '• Data saving suggestions\n'
          '• System recommendations\n\n'
          'You can customize these alerts in Settings.',
        ),
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

// Extension method for copying AlertItem
extension AlertItemCopyWith on AlertItem {
  AlertItem copyWith({
    String? id,
    String? title,
    String? description,
    String? timestamp,
    AlertType? type,
    bool? isRead,
  }) {
    return AlertItem(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      timestamp: timestamp ?? this.timestamp,
      type: type ?? this.type,
      isRead: isRead ?? this.isRead,
    );
  }
} // TODO Implement this library.
