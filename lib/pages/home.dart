import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import '../pages/sos_page.dart';

enum EmergencyType {
  theft,
  missing,
  alert,
}

void main() {
  runApp(TouristSafetyApp());
}

class EmergencyScreen extends StatelessWidget {
  const EmergencyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Emergency Services'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.crisis_alert, size: 100, color: Colors.red),
              SizedBox(height: 30),
              Text(
                'In Case of Emergency',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.redAccent,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              Text(
                'Press and hold the button below to alert emergency contacts and local authorities.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.grey[700]),
              ),
              SizedBox(height: 50),
              GestureDetector(
                onLongPress: () {
                  _triggerEmergency(context);
                },
                child: Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.red.withOpacity(0.5),
                        spreadRadius: 10,
                        blurRadius: 15,
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.call, color: Colors.white, size: 60),
                      SizedBox(height: 10),
                      Text(
                        'HOLD FOR EMERGENCY',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 40),
              Text(
                'Your safety is our top priority. Stay calm and press only when truly necessary.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  fontStyle: FontStyle.italic,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _triggerEmergency(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text('Emergency Alert Sent!'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.check_circle_outline, color: Colors.green, size: 50),
              SizedBox(height: 16),
              Text('Emergency services and your contacts have been notified.'),
              SizedBox(height: 16),
              LinearProgressIndicator(),
              SizedBox(height: 8),
              Text(
                'Authorities are being dispatched to your last known location.',
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();
                Navigator.pop(context);
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
    Future.delayed(Duration(seconds: 5), () {});
  }
}

class SafetyMonitorScreen extends StatefulWidget {
  const SafetyMonitorScreen({super.key});

  @override
  _SafetyMonitorScreenState createState() => _SafetyMonitorScreenState();
}

class _SafetyMonitorScreenState extends State<SafetyMonitorScreen> {
  String _currentLocation = 'Baga Beach, Goa';
  String _zoneStatus = 'Safe Zone';
  Color _zoneColor = Colors.green;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Location Monitoring',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),

          Card(
            elevation: 4,
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: _zoneColor.withOpacity(0.1),
                border: Border.all(color: _zoneColor, width: 2),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Current Location',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            _currentLocation,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Icon(Icons.location_on, size: 40, color: _zoneColor),
                    ],
                  ),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Zone Status:',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        _zoneStatus,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: _zoneColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  ElevatedButton.icon(
                    onPressed: () {
                      _simulateLocationChange();
                    },
                    icon: Icon(Icons.refresh),
                    label: Text('Update Location'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColor,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 20),

          Text(
            'Safety Tips',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 12),
          Card(
            elevation: 2,
            child: Column(
              children: [
                _buildSafetyTipItem(
                  'Stay aware of your surroundings.',
                  Icons.visibility,
                ),
                _buildSafetyTipItem(
                  'Keep valuables out of sight.',
                  Icons.backpack,
                ),
                _buildSafetyTipItem(
                  'Inform someone of your itinerary.',
                  Icons.share,
                ),
              ],
            ),
          ),
          SizedBox(height: 20),

          Text(
            'Local Emergency Contacts',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 12),
          Card(
            elevation: 2,
            child: Column(
              children: [
                _buildContactItem('Police', '100', Icons.local_police),
                _buildContactItem('Ambulance', '102', Icons.medical_services),
                _buildContactItem('Fire', '101', Icons.fire_extinguisher),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSafetyTipItem(String tip, IconData icon) {
    return ListTile(
      leading: Icon(icon, color: Theme.of(context).primaryColor),
      title: Text(tip),
    );
  }

  Widget _buildContactItem(String title, String number, IconData icon) {
    return ListTile(
      leading: Icon(icon, color: Colors.red),
      title: Text(title),
      subtitle: Text(number),
      trailing: IconButton(
        icon: Icon(Icons.call),
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Calling $title at $number...')),
          );
        },
      ),
    );
  }

  void _simulateLocationChange() {
    setState(() {
      if (_zoneStatus == 'Safe Zone') {
        _currentLocation = 'Anjuna Flea Market, Goa';
        _zoneStatus = 'Moderate Risk Zone';
        _zoneColor = Colors.orange;
      } else if (_zoneStatus == 'Moderate Risk Zone') {
        _currentLocation = 'Remote Village, Goa';
        _zoneStatus = 'High Risk Zone';
        _zoneColor = Colors.red;
      } else {
        _currentLocation = 'Baga Beach, Goa';
        _zoneStatus = 'Safe Zone';
        _zoneColor = Colors.green;
      }
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Location updated to $_currentLocation')),
    );
  }
}

class TouristSafetyApp extends StatelessWidget {
  const TouristSafetyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SafeTour - Tourist Safety App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: Color(0xFF1976D2),
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue)
            .copyWith(
              secondary: Color(0xFF03DAC6),
            ),
        fontFamily: 'Roboto',
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SplashScreen(),
      routes: {
        '/dashboard': (context) => DashboardScreen(),
        '/trip-generator': (context) => TripGeneratorScreen(),
        '/safety-monitor': (context) => SafetyMonitorScreen(),
        '/sos': (context) => SOSHomePage(
          emergencyContacts: [
            EmergencyContact(name: 'Police', phoneNumber: '100'),
            EmergencyContact(name: 'Ambulance', phoneNumber: '102'),
            EmergencyContact(name: 'Family Member', phoneNumber: '+91-9876543210'),
          ],
        ),
      },
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, '/dashboard');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF1976D2), Color(0xFF03DAC6)],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.security, size: 100, color: Colors.white),
              SizedBox(height: 20),
              Text(
                'SafeTour',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Your Safety, Our Priority',
                style: TextStyle(color: Colors.white70, fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _currentIndex = 0;
  final int _tss = 85;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SafeTour Dashboard'),
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {},
          ),
        ],
      ),
      body: _getSelectedScreen(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.location_on),
            label: 'Monitor',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.warning),
            label: 'Emergency',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.pushNamed(context, '/trip-generator');
        },
        icon: Icon(Icons.add_location),
        label: Text('Generate Trip'),
        backgroundColor: Theme.of(context).colorScheme.secondary,
      ),
    );
  }

  Widget _getSelectedScreen() {
    switch (_currentIndex) {
      case 0:
        return _buildHomeScreen();
      case 1:
        return SafetyMonitorScreen();
      case 2:
        return EmergencyScreen();
      case 3:
        return _buildProfileScreen();
      default:
        return _buildHomeScreen();
    }
  }

  Widget _buildHomeScreen() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            elevation: 4,
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                gradient: LinearGradient(
                  colors: _tss >= 70
                      ? [Colors.green, Colors.lightGreen]
                      : _tss >= 40
                      ? [Colors.orange, Colors.orangeAccent]
                      : [Colors.red, Colors.redAccent],
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Area Safety Score',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        '$_tss',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        _tss >= 70
                            ? 'Safe'
                            : _tss >= 40
                            ? 'Moderate'
                            : 'Unsafe',
                        style: TextStyle(color: Colors.white, fontSize: 14),
                      ),
                    ],
                  ),
                  Icon(
                    _tss >= 70 ? Icons.shield : Icons.warning,
                    size: 60,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 20),

          Text(
            'Current Trip Status',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 12),
          Card(
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.green,
                child: Icon(Icons.check, color: Colors.white),
              ),
              title: Text('Trip to Goa'),
              subtitle: Text(
                'Blockchain ID: #BT2025001\nExpires: 2 days remaining',
              ),
              trailing: Icon(Icons.arrow_forward_ios),
            ),
          ),

          SizedBox(height: 20),

          Text(
            'Quick Actions',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _buildActionCard(
                  icon: Icons.report_problem,
                  title: 'Report Issue',
                  color: Colors.orange,
                  onTap: () {
                    Navigator.pushNamed(context, '/sos');
                  },
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: _buildActionCard(
                  icon: Icons.emergency,
                  title: 'Emergency',
                  color: Colors.red,
                  onTap: () {
                    Navigator.pushNamed(context, '/sos');
                  },
                ),
              ),
            ],
          ),

          SizedBox(height: 20),

          Text(
            'Recent Activities',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 12),
          Card(
            child: Column(
              children: [
                ListTile(
                  leading: Icon(Icons.location_on, color: Colors.green),
                  title: Text('Entered Safe Zone'),
                  subtitle: Text('Baga Beach, Goa - 2 hours ago'),
                ),
                Divider(),
                ListTile(
                  leading: Icon(Icons.verified, color: Colors.blue),
                  title: Text('Documents Verified'),
                  subtitle: Text('Via DigiLocker - 1 day ago'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionCard({
    required IconData icon,
    required String title,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              Icon(icon, size: 40, color: color),
              SizedBox(height: 8),
              Text(
                title,
                style: TextStyle(fontWeight: FontWeight.w600),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileScreen() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          CircleAvatar(
            radius: 50,
            backgroundColor: Theme.of(context).primaryColor,
            child: Icon(Icons.person, size: 50, color: Colors.white),
          ),
          SizedBox(height: 16),
          Text(
            'John Doe',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          Text(
            'john.doe@email.com',
            style: TextStyle(color: Colors.grey[600], fontSize: 16),
          ),
          SizedBox(height: 30),
          Card(
            child: Column(
              children: [
                ListTile(
                  leading: Icon(Icons.history),
                  title: Text('Trip History'),
                  trailing: Icon(Icons.arrow_forward_ios),
                ),
                ListTile(
                  leading: Icon(Icons.settings),
                  title: Text('Settings'),
                  trailing: Icon(Icons.arrow_forward_ios),
                ),
                ListTile(
                  leading: Icon(Icons.help),
                  title: Text('Help & Support'),
                  trailing: Icon(Icons.arrow_forward_ios),
                ),
                ListTile(
                  leading: Icon(Icons.logout),
                  title: Text('Logout'),
                  trailing: Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    Navigator.pushReplacementNamed(context, '/dashboard');
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showReportDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Report Safety Issue'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(Icons.warning, color: Colors.orange),
                title: Text('Unsafe Area'),
                onTap: () {
                  Navigator.pop(context);
                  _showReportForm('Unsafe Area');
                },
              ),
              ListTile(
                leading: Icon(Icons.construction, color: Colors.red),
                title: Text('Infrastructure Issue'),
                onTap: () {
                  Navigator.pop(context);
                  _showReportForm('Infrastructure Issue');
                },
              ),
              ListTile(
                leading: Icon(Icons.people, color: Colors.purple),
                title: Text('Crowd Issues'),
                onTap: () {
                  Navigator.pop(context);
                  _showReportForm('Crowd Issues');
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _showReportForm(String issueType) {
    final reportController = TextEditingController();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Report: $issueType'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: reportController,
                maxLines: 4,
                decoration: InputDecoration(
                  hintText: 'Describe the issue...',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: () {},
                icon: Icon(Icons.camera_alt),
                label: Text('Add Photo'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Report submitted successfully!')),
                );
              },
              child: Text('Submit'),
            ),
          ],
        );
      },
    );
  }
}

class TripGeneratorScreen extends StatefulWidget {
  const TripGeneratorScreen({super.key});

  @override
  _TripGeneratorScreenState createState() => _TripGeneratorScreenState();
}

class _TripGeneratorScreenState extends State<TripGeneratorScreen> {
  final _formKey = GlobalKey<FormState>();
  String _destination = '';
  String _tripType = 'Individual';
  DateTime _startDate = DateTime.now();
  DateTime _endDate = DateTime.now().add(Duration(days: 1));
  final List<String> _uploadedDocs = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Generate Trip'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Trip Details',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),

              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Destination',
                  prefixIcon: Icon(Icons.location_on),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Please enter destination';
                  }
                  return null;
                },
                onChanged: (value) => _destination = value,
              ),

              SizedBox(height: 16),

              DropdownButtonFormField<String>(
                initialValue: _tripType,
                decoration: InputDecoration(
                  labelText: 'Trip Type',
                  prefixIcon: Icon(Icons.people),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                items: ['Individual', 'Group', 'Family']
                    .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    })
                    .toList(),
                onChanged: (String? value) {
                  setState(() {
                    _tripType = value!;
                  });
                },
              ),

              SizedBox(height: 16),

              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () async {
                        final date = await showDatePicker(
                          context: context,
                          initialDate: _startDate,
                          firstDate: DateTime.now(),
                          lastDate: DateTime.now().add(Duration(days: 365)),
                        );
                        if (date != null) {
                          setState(() {
                            _startDate = date;
                          });
                        }
                      },
                      child: InputDecorator(
                        decoration: InputDecoration(
                          labelText: 'Start Date',
                          prefixIcon: Icon(Icons.calendar_today),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text(
                          '${_startDate.day}/${_startDate.month}/${_startDate.year}',
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: InkWell(
                      onTap: () async {
                        final date = await showDatePicker(
                          context: context,
                          initialDate: _endDate,
                          firstDate: _startDate,
                          lastDate: DateTime.now().add(Duration(days: 365)),
                        );
                        if (date != null) {
                          setState(() {
                            _endDate = date;
                          });
                        }
                      },
                      child: InputDecorator(
                        decoration: InputDecoration(
                          labelText: 'End Date',
                          prefixIcon: Icon(Icons.calendar_today),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text(
                          '${_endDate.day}/${_endDate.month}/${_endDate.year}',
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 24),

              Text(
                'Required Documents',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 12),

              Card(
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    children: [
                      _buildDocumentItem('Aadhaar Card', Icons.credit_card),
                      _buildDocumentItem('PAN Card', Icons.account_box),
                      _buildDocumentItem('Travel Insurance', Icons.security),
                      SizedBox(height: 16),
                      ElevatedButton.icon(
                        onPressed: () {
                          _showDocumentUpload();
                        },
                        icon: Icon(Icons.upload_file),
                        label: Text('Upload Documents'),
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(double.infinity, 50),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 24),

              if (_uploadedDocs.isNotEmpty) ...<Widget>[
                Text(
                  'Uploaded Documents',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                ..._uploadedDocs
                    .map<Widget>(
                      (String doc) => ListTile(
                        leading: Icon(Icons.check_circle, color: Colors.green),
                        title: Text(doc),
                        subtitle: Text('Verified via DigiLocker'),
                      ),
                    )
                    ,
                SizedBox(height: 20),
              ],

              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      _generateTrip();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    'GENERATE TRIP',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDocumentItem(String title, IconData icon) {
    bool isUploaded = _uploadedDocs.contains(title);
    return ListTile(
      leading: Icon(icon, color: isUploaded ? Colors.green : Colors.grey),
      title: Text(title),
      trailing: Icon(
        isUploaded ? Icons.check_circle : Icons.circle_outlined,
        color: isUploaded ? Colors.green : Colors.grey,
      ),
    );
  }

  void _showDocumentUpload() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Upload Documents',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              ListTile(
                leading: Icon(Icons.camera_alt),
                title: Text('Take Photo'),
                onTap: () {
                  Navigator.pop(context);
                  _simulateUpload();
                },
              ),
              ListTile(
                leading: Icon(Icons.folder),
                title: Text('Choose from Gallery'),
                onTap: () {
                  Navigator.pop(context);
                  _simulateUpload();
                },
              ),
              ListTile(
                leading: Icon(Icons.account_balance_wallet),
                title: Text('DigiLocker'),
                onTap: () {
                  Navigator.pop(context);
                  _simulateDigiLockerVerification();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _simulateUpload() {
    setState(() {
      if (!_uploadedDocs.contains('Aadhaar Card')) {
        _uploadedDocs.add('Aadhaar Card');
      }
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Document uploaded successfully!')),
    );
  }

  void _simulateDigiLockerVerification() {
    setState(() {
      _uploadedDocs.clear();
      _uploadedDocs.addAll(['Aadhaar Card', 'PAN Card', 'Travel Insurance']);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('All documents verified via DigiLocker!'),
        backgroundColor: Colors.green,
      ),
    );
  }

  void _generateTrip() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 16),
              Text('Generating Blockchain ID...'),
            ],
          ),
        );
      },
    );

    Future.delayed(Duration(seconds: 3), () {
      Navigator.of(context, rootNavigator: true).pop();
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Trip Generated Successfully!'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.check_circle, color: Colors.green, size: 60),
                SizedBox(height: 16),
                Text('Blockchain ID: #BT2025001'),
                Text(
                  'Valid until: ${_endDate.day}/${_endDate.month}/${_endDate.year}',
                ),
              ],
            ),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    '/dashboard',
                    (route) => false,
                  );
                },
                child: Text('Start Monitoring'),
              ),
            ],
          );
        },
      );
    });
  }
}