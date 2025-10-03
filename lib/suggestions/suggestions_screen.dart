import 'package:flutter/material.dart';

class SuggestionItem {
  final String id;
  final String title;
  final String description;
  final String dataSize;
  final String emoji;
  final bool isActionable;

  SuggestionItem({
    required this.id,
    required this.title,
    required this.description,
    required this.dataSize,
    required this.emoji,
    this.isActionable = true,
  });
}

class SuggestionsScreen extends StatefulWidget {
  const SuggestionsScreen({super.key});

  @override
  State<SuggestionsScreen> createState() => _SuggestionsScreenState();
}

class _SuggestionsScreenState extends State<SuggestionsScreen> {
  final List<SuggestionItem> suggestions = [
    SuggestionItem(
      id: '1',
      title: 'Backup your photos to Google Drive',
      description: 'Free up space and secure your memories',
      dataSize: '500MB',
      emoji: '💡',
    ),
    SuggestionItem(
      id: '2',
      title: 'Download movies for offline viewing',
      description: 'Watch without using mobile data',
      dataSize: 'Approx. 1.2 GB',
      emoji: '🎬',
    ),
    SuggestionItem(
      id: '3',
      title: 'Update your mobile apps',
      description: 'Get the latest features and security updates',
      dataSize: '300MB',
      emoji: '📱',
    ),
    SuggestionItem(
      id: '4',
      title: 'Stream high-quality music',
      description: 'Enjoy your favorite songs in better quality',
      dataSize: '250MB',
      emoji: '🎵',
    ),
    SuggestionItem(
      id: '5',
      title: 'Download podcasts for your commute',
      description: 'Listen offline during travel',
      dataSize: '150MB',
      emoji: '🎧',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Suggestions',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        backgroundColor: Colors.blue.shade700,
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _refreshSuggestions,
            tooltip: 'Refresh Suggestions',
          ),
        ],
      ),
      body: Column(
        children: [
          // Header with summary
          _buildHeader(),

          // Suggestions List
          Expanded(child: _buildSuggestionsList()),

          // Take Action Button
          _buildActionButton(),
        ],
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildHeader() {
    final totalSuggestedUsage = suggestions.fold<double>(0, (sum, item) {
      final size =
          double.tryParse(item.dataSize.replaceAll(RegExp(r'[^0-9.]'), '')) ??
          0;
      return sum + size;
    });

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        border: Border(bottom: BorderSide(color: Colors.grey.shade300)),
      ),
      child: Row(
        children: [
          const Icon(Icons.lightbulb_outline, color: Colors.amber, size: 24),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Smart Data Suggestions',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.blue,
                  ),
                ),
                Text(
                  'Use ${totalSuggestedUsage.toStringAsFixed(1)} GB before expiry',
                  style: const TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSuggestionsList() {
    if (suggestions.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.auto_awesome, size: 64, color: Colors.grey),
            SizedBox(height: 16),
            Text(
              'No Suggestions',
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
            SizedBox(height: 8),
            Text(
              'Your data usage is optimized!',
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: suggestions.length,
      separatorBuilder: (context, index) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        return _buildSuggestionCard(suggestions[index]);
      },
    );
  }

  Widget _buildSuggestionCard(SuggestionItem suggestion) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Emoji Icon
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.blue.shade100,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  suggestion.emoji,
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ),
            const SizedBox(width: 12),

            // Suggestion Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    suggestion.title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    suggestion.description,
                    style: TextStyle(fontSize: 14, color: Colors.grey.shade700),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.blue.shade50,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      suggestion.dataSize,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Colors.blue.shade700,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Action Icon
            if (suggestion.isActionable)
              IconButton(
                icon: const Icon(Icons.arrow_forward_ios, size: 16),
                onPressed: () => _showSuggestionDetails(suggestion),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Colors.grey.shade300)),
      ),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: _showQuickActions,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue.shade700,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: const Text(
            'Take Action',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  Widget _buildBottomNavigationBar() {
    return BottomNavigationBar(
      currentIndex: 2,
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
            // Already on suggestions
            break;
          case 3:
            Navigator.pushReplacementNamed(context, '/settings');
            break;
        }
      },
    );
  }

  void _refreshSuggestions() {
    setState(() {
      // Shuffle suggestions to simulate new suggestions
      suggestions.shuffle();
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Suggestions refreshed!'),
        duration: Duration(seconds: 1),
      ),
    );
  }

  void _showSuggestionDetails(SuggestionItem suggestion) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: Colors.blue.shade100,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      suggestion.emoji,
                      style: const TextStyle(fontSize: 20),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    suggestion.title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              suggestion.description,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey.shade700,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 16),
            _buildDetailItem('Data Required', suggestion.dataSize),
            _buildDetailItem('Time Required', '5-10 minutes'),
            _buildDetailItem('Wi-Fi Recommended', 'Yes'),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  _executeSuggestion(suggestion);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue.shade700,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text(
                  'Start Now',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Maybe Later'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Text('$label: ', style: const TextStyle(fontWeight: FontWeight.w500)),
          Text(value, style: TextStyle(color: Colors.grey.shade700)),
        ],
      ),
    );
  }

  void _executeSuggestion(SuggestionItem suggestion) {
    // Show starting snackbar
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Starting: ${suggestion.title}'),
        backgroundColor: Colors.green,
        duration: const Duration(seconds: 2),
      ),
    );

    // Simulate action completion after delay
    Future.delayed(const Duration(seconds: 2), () {
      // Check if widget is still mounted before updating state
      if (!mounted) return;

      setState(() {
        suggestions.removeWhere((item) => item.id == suggestion.id);
      });

      // Show completion snackbar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Completed: ${suggestion.title}'),
          backgroundColor: Colors.green,
        ),
      );
    });
  }

  void _showQuickActions() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Quick Actions',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            _buildQuickActionItem(
              Icons.cloud_upload,
              'Backup Photos Now',
              'Upload 500MB to cloud storage',
              () => _executeQuickAction('Photo Backup'),
            ),
            _buildQuickActionItem(
              Icons.download,
              'Download Content',
              'Get videos/music for offline use',
              () => _executeQuickAction('Content Download'),
            ),
            _buildQuickActionItem(
              Icons.update,
              'Update Apps',
              'Install pending app updates',
              () => _executeQuickAction('App Updates'),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Close'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickActionItem(
    IconData icon,
    String title,
    String subtitle,
    VoidCallback onTap,
  ) {
    return ListTile(
      leading: Icon(icon, color: Colors.blue),
      title: Text(title),
      subtitle: Text(subtitle),
      onTap: onTap,
    );
  }

  void _executeQuickAction(String action) {
    Navigator.of(context).pop();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Starting: $action'),
        backgroundColor: Colors.blue,
      ),
    );
  }
} // TODO Implement this library.
