import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

class ThreatIntelligencePage extends StatefulWidget {
  const ThreatIntelligencePage({Key? key}) : super(key: key);

  @override
  _ThreatIntelligencePageState createState() => _ThreatIntelligencePageState();
}

class _ThreatIntelligencePageState extends State<ThreatIntelligencePage> {
  List<Map<String, dynamic>> threats = [
    {
      'name': 'SQL Injection Attack',
      'image': 'assets/sql_injection.png',
      'time': '2024-02-14 10:30 AM',
      'losses': '10,000 USD',
    },
    {
      'name': 'Cross-Site Scripting (XSS)',
      'image': 'assets/xss_attack.png',
      'time': '2024-02-13 2:45 PM',
      'losses': '5,000 USD',
    },
    {
      'name': 'Brute Force Attack',
      'image': 'assets/brute_force.png',
      'time': '2024-02-12 9:15 AM',
      'losses': '7,500 USD',
    },
    {
      'name': 'Phishing Attack',
      'image': 'assets/phishing.png',
      'time': '2024-02-11 3:20 PM',
      'losses': '12,000 USD',
    },
    {
      'name': 'Malware Infection',
      'image': 'assets/malware.png',
      'time': '2024-02-10 11:00 AM',
      'losses': '15,000 USD',
    },
    // Add more threat data as needed
  ];
  List<charts.Series<ThreatData, String>> _createSampleData() {
    final data = [
      ThreatData('SQL Injection', 10000),
      ThreatData('XSS', 5000),
      ThreatData('Brute Force', 7500),
      ThreatData('Phishing', 12000),
      ThreatData('Malware', 15000),
    ];

    return [
      charts.Series<ThreatData, String>(
        id: 'Threats',
        domainFn: (ThreatData threat, _) => threat.name,
        measureFn: (ThreatData threat, _) => threat.losses,
        data: data,
        labelAccessorFn: (ThreatData threat, _) => '${threat.losses}',
      ),
    ];
  }

  List<Map<String, dynamic>> filteredThreats = [];

  @override
  void initState() {
    super.initState();
    filteredThreats = List.from(threats);
  }

  void filterThreats(String query) {
    setState(() {
      filteredThreats = threats
          .where((threat) =>
              threat['name'].toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0XFFEEE9DA),
      appBar: AppBar(
        backgroundColor: Color(0XFF93BFCF),
        title: Text('Threat Intelligence'),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (value) => filterThreats(value),
              decoration: InputDecoration(
                labelText: 'Search Threats',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredThreats.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: AssetImage(
                      filteredThreats[index]['image'],
                    ),
                  ),
                  title: Text(filteredThreats[index]['name']),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Time of Attack: ${filteredThreats[index]['time']}'),
                      Text('Losses: ${filteredThreats[index]['losses']}'),
                    ],
                  ),
                );
              },
            ),
          ),
          // Inside your build method after the ListView.builder

          Container(
            height: 300,
            padding: EdgeInsets.all(16.0),
            child: charts.BarChart(
              _createSampleData(),
              animate: true,
            ),
          ),
        ],
      ),
    );
  }
}

class ThreatData {
  final String name;
  final int losses;

  ThreatData(this.name, this.losses);
}
