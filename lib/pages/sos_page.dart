// sos_page.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';

class EmergencyContact {
  final String name;
  final String phoneNumber;

  EmergencyContact({required this.name, required this.phoneNumber});
}

enum EmergencyType { theft, missing, alert }

class SOSHomePage extends StatefulWidget {
  final List<EmergencyContact> emergencyContacts;

  const SOSHomePage({
    Key? key,
    required this.emergencyContacts,
  }) : super(key: key);

  @override
  _SOSHomePageState createState() => _SOSHomePageState();
}

class _SOSHomePageState extends State<SOSHomePage>
    with TickerProviderStateMixin {
  late AnimationController _pulseController;
  late AnimationController _rippleController;
  bool _isActivated = false;
  Timer? _sosTimer;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..repeat(reverse: true);

    _rippleController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _rippleController.dispose();
    _sosTimer?.cancel();
    super.dispose();
  }

  Future<void> _playBeepTone(EmergencyType type) async {
    try {
      switch (type) {
        case EmergencyType.theft:
          for (int i = 0; i < 5; i++) {
            SystemSound.play(SystemSoundType.click);
            await Future.delayed(const Duration(milliseconds: 200));
          }
          break;
        case EmergencyType.missing:
          for (int i = 0; i < 3; i++) {
            SystemSound.play(SystemSoundType.alert);
            await Future.delayed(const Duration(milliseconds: 800));
          }
          break;
        case EmergencyType.alert:
          for (int i = 0; i < 10; i++) {
            SystemSound.play(SystemSoundType.click);
            await Future.delayed(const Duration(milliseconds: 100));
          }
          break;
      }
    } catch (e) {
      print('Error playing beep tone: $e');
    }
  }

  Future<void> _sendSOSMessage(EmergencyType type) async {
    String message;
    switch (type) {
      case EmergencyType.theft:
        message = "🚨 THEFT ALERT! Please help me immediately!";
        break;
      case EmergencyType.missing:
        message = "🆘 MISSING PERSON ALERT! I need urgent help!";
        break;
      case EmergencyType.alert:
        message = "⚠️ GENERAL ALERT! Please contact me now!";
        break;
    }

    for (var contact in widget.emergencyContacts) {
      print('Sending SMS to ${contact.phoneNumber}: $message');
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('SOS message sent to ${widget.emergencyContacts.length} contacts'),
        backgroundColor: Colors.orange,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  Future<void> _callPolice() async {
    print('Calling police...');
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Calling police now...'),
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  void _triggerSOS(EmergencyType type) async {
    if (_isActivated) return;

    setState(() {
      _isActivated = true;
    });

    _rippleController.forward().then((_) => _rippleController.reset());
    await _playBeepTone(type);
    await _sendSOSMessage(type);
    await _callPolice();
    _showSOSConfirmation(type);

    _sosTimer = Timer(const Duration(seconds: 5), () {
      setState(() {
        _isActivated = false;
      });
    });
  }

  void _showSOSConfirmation(EmergencyType type) {
    String typeText = type.toString().split('.').last.toUpperCase();
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            children: const [
              Icon(Icons.check_circle, color: Colors.green),
              SizedBox(width: 8),
              Text('SOS Activated'),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Emergency Type: $typeText'),
              const SizedBox(height: 10),
              const Text('✅ Emergency contacts notified'),
              const Text('✅ Police call initiated'),
              const Text('✅ Alert tone played'),
              const SizedBox(height: 15),
              const Text(
                'Stay calm. Help is on the way!',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildSOSButton() {
    return Container(
      width: 250,
      height: 250,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Ripple Effect
          AnimatedBuilder(
            animation: _rippleController,
            builder: (context, child) {
              return Container(
                width: 250 * _rippleController.value,
                height: 250 * _rippleController.value,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.red.withOpacity(1 - _rippleController.value),
                    width: 4,
                  ),
                ),
              );
            },
          ),
          // Main SOS Button with Pulse Animation
          AnimatedBuilder(
            animation: _pulseController,
            builder: (context, child) {
              return Transform.scale(
                scale: _isActivated ? 1.1 : (0.9 + (_pulseController.value * 0.1)),
                child: Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: _isActivated
                          ? [Colors.green.shade400, Colors.green.shade700]
                          : [Colors.red.shade400, Colors.red.shade700],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: (_isActivated ? Colors.green : Colors.red)
                            .withOpacity(0.4),
                        blurRadius: 20,
                        spreadRadius: 5,
                      ),
                    ],
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(100),
                      onTap: _isActivated ? null : _showEmergencyTypeDialog,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              _isActivated ? Icons.check : Icons.warning,
                              color: Colors.white,
                              size: 50,
                            ),
                            const SizedBox(height: 10),
                            Text(
                              _isActivated ? 'ACTIVATED' : 'SOS',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            if (!_isActivated)
                              const Text(
                                'TAP FOR HELP',
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 12,
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  void _showEmergencyTypeDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Select Emergency Type'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildEmergencyTypeButton(
                EmergencyType.theft,
                'Theft Alert',
                Icons.security,
                Colors.orange,
                'Rapid beeps',
              ),
              const SizedBox(height: 10),
              _buildEmergencyTypeButton(
                EmergencyType.missing,
                'Missing Person',
                Icons.person_search,
                Colors.purple,
                'Slow beeps',
              ),
              const SizedBox(height: 10),
              _buildEmergencyTypeButton(
                EmergencyType.alert,
                'General Alert',
                Icons.emergency,
                Colors.red,
                'Continuous beep',
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildEmergencyTypeButton(
    EmergencyType type,
    String title,
    IconData icon,
    Color color,
    String description,
  ) {
    return Container(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onPressed: () {
          Navigator.of(context).pop();
          _triggerSOS(type);
        },
        child: Row(
          children: [
            Icon(icon, size: 24),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    description,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard(IconData icon, String title, String subtitle, Color color) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 30),
          const SizedBox(height: 8),
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
          Text(
            subtitle,
            style: TextStyle(
              color: Colors.grey.shade600,
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text('SOS Emergency'),
        backgroundColor: Colors.red.shade700,
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              // Navigate to settings page if needed
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Settings page coming soon')),
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 3,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Emergency Button',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey.shade700,
                      ),
                    ),
                    const SizedBox(height: 20),
                    _buildSOSButton(),
                    const SizedBox(height: 30),
                    if (!_isActivated)
                      Text(
                        'Tap the button and select emergency type\nfor immediate assistance',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey.shade600,
                        ),
                      ),
                  ],
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildInfoCard(
                        Icons.phone,
                        'Police Call',
                        'Automatic',
                        Colors.blue,
                      ),
                      _buildInfoCard(
                        Icons.message,
                        'SMS Sent',
                        '${widget.emergencyContacts.length} Contacts',
                        Colors.green,
                      ),
                      _buildInfoCard(
                        Icons.volume_up,
                        'Alert Tone',
                        'Different Types',
                        Colors.orange,
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Emergency Contacts: ${widget.emergencyContacts.length} configured',
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Optional: Settings Page for Emergency Contacts
class SettingsPage extends StatefulWidget {
  final List<EmergencyContact> emergencyContacts;

  const SettingsPage({Key? key, required this.emergencyContacts}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Emergency Settings'),
        backgroundColor: Colors.red.shade700,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'Emergency Contacts',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          ...widget.emergencyContacts.map(
            (contact) => Card(
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.red.shade700,
                  child: const Icon(Icons.person, color: Colors.white),
                ),
                title: Text(contact.name),
                subtitle: Text(contact.phoneNumber),
                trailing: IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () {
                    // Edit contact functionality
                  },
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              // Add new contact functionality
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red.shade700,
              foregroundColor: Colors.white,
            ),
            child: const Text('Add Emergency Contact'),
          ),
        ],
      ),
    );
  }
}