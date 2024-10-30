import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class ServiceListPage extends StatelessWidget {
  const ServiceListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: ServiceListScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class ServiceListScreen extends StatefulWidget {
  const ServiceListScreen({super.key});

  @override
  _ServiceListScreenState createState() => _ServiceListScreenState();
}

class _ServiceListScreenState extends State<ServiceListScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  bool isAdmin = true;

  @override
  void initState() {
    super.initState();
    _checkAdminStatus();
  }

  Future<void> _checkAdminStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final userString = prefs.getString('flutter.user');
    if (userString != null) {
      final user = Map<String, dynamic>.from(await jsonDecode(userString));
      print(user);
      setState(() {
        isAdmin = user['admin'] ?? false;
      });
    }
  }

  void _navigateToServiceUpdatePage(String serviceId) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ServiceUpdatePage(serviceId: serviceId),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFB60000),
        toolbarHeight: 90,
        flexibleSpace: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
          ),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Text(
                'RP 156',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Buscar...',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: Colors.grey.shade200,
                    prefixIcon: const Icon(Icons.search),
                  ),
                ),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.person),
              onPressed: () {
                // Navegar para a página de perfil
                Navigator.pushNamed(context, '/user-profile');
              },
            ),
          ],
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFB60000),
              Color(0xFF290000),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Container(
            margin: const EdgeInsets.all(16.0),
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: const Color.fromRGBO(255, 255, 255, 0.81), // Branco com opacidade de 81%
              borderRadius: BorderRadius.circular(15), // Bordas arredondadas
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Center(
                  child: Text(
                    'Acompanhamento do serviço',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Expanded(
                  child: StreamBuilder<QuerySnapshot>(
                    stream: _firestore.collection('servicos').snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      final services = snapshot.data!.docs;

                      return SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: DataTable(
                            columns: const [
                              DataColumn(label: Text('Serviço')),
                              DataColumn(label: Text('Situação')),
                              DataColumn(label: Text('Data')),
                            ],
                            rows: services.map((service) {
                              final data = service.data() as Map<String, dynamic>;
                              final serviceTitle = data['description'] ?? 'Sem título';
                              final serviceStatus = data['status'] ?? 'Em andamento';
                              final timestamp = data['timestamp'] as Timestamp;
                              final date = DateFormat('dd/MM/yyyy').format(timestamp.toDate());
                              final imageUrl = data['imageUrl'];
                              final serviceId = service.id;

                              Color statusColor;
                              switch (serviceStatus) {
                                case 'Concluído':
                                  statusColor = Colors.green;
                                  break;
                                case 'Cancelado':
                                  statusColor = Colors.red;
                                  break;
                                default:
                                  statusColor = Colors.amber;
                              }

                              return DataRow(
                                cells: [
                                  DataCell(
                                    Row(
                                      children: [
                                        if (imageUrl != null && imageUrl.isNotEmpty)
                                          Image.network(
                                            imageUrl,
                                            width: 50,
                                            height: 50,
                                            fit: BoxFit.cover,
                                            errorBuilder: (context, error, stackTrace) {
                                              return const Icon(Icons.broken_image, size: 50);
                                            },
                                          ),
                                        const SizedBox(width: 8),
                                        Text(serviceTitle),
                                      ],
                                    ),
                                    onTap: isAdmin ? () => _navigateToServiceUpdatePage(serviceId) : null,
                                  ),
                                  DataCell(
                                    Container(
                                      padding: const EdgeInsets.all(8.0),
                                      decoration: BoxDecoration(
                                        color: statusColor,
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: Text(
                                        serviceStatus,
                                        style: const TextStyle(color: Colors.white),
                                      ),
                                    ),
                                    onTap: isAdmin ? () => _navigateToServiceUpdatePage(serviceId) : null,
                                  ),
                                  DataCell(
                                    Text(date),
                                    onTap: isAdmin ? () => _navigateToServiceUpdatePage(serviceId) : null,
                                  ),
                                ],
                              );
                            }).toList(),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


class ServiceUpdatePage extends StatefulWidget {
  final String serviceId;

  const ServiceUpdatePage({super.key, required this.serviceId});

  @override
  _ServiceUpdatePageState createState() => _ServiceUpdatePageState();
}

class _ServiceUpdatePageState extends State<ServiceUpdatePage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String? selectedStatus;

  Future<void> _updateService() async {
    try {
      // Atualizar dados no Firestore
      await _firestore.collection('servicos').doc(widget.serviceId).update({
        'status': selectedStatus,
        'timestamp': FieldValue.serverTimestamp(),
      });

      // Mostrar mensagem de sucesso
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Serviço atualizado com sucesso!'),
          backgroundColor: Colors.green,
        ),
      );

      // Limpar o status selecionado
      setState(() {
        selectedStatus = null;
      });
    } catch (e) {
      // Mostrar mensagem de erro
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erro ao atualizar serviço: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.serviceId),
      ),
      body: Center(
        child: Container(
          margin: const EdgeInsets.all(16.0),
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: const Color.fromRGBO(255, 255, 255, 0.81), // Branco com opacidade de 81%
            borderRadius: BorderRadius.circular(15), // Bordas arredondadas
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  widget.serviceId,
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Status',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        selectedStatus = 'Pendente';
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: selectedStatus == 'Pendente' ? Colors.red : Colors.grey,
                    ),
                    child: const Text('Pendente'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        selectedStatus = 'Em Andamento';
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: selectedStatus == 'Em Andamento' ? Colors.red : Colors.grey,
                    ),
                    child: const Text('Em Andamento'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        selectedStatus = 'Concluído';
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: selectedStatus == 'Concluído' ? Colors.red : Colors.grey,
                    ),
                    child: const Text('Concluído'),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                  ),
                  onPressed: selectedStatus == null ? null : _updateService,
                  child: const Text(
                    'Salvar',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}