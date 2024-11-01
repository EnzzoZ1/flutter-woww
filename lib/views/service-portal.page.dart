import 'package:flutter/material.dart';

class ServicePortalPage extends StatelessWidget {
  const ServicePortalPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
          children: [
          // Background gradient
          Container(
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
            ),
            Column( 
              children: [ 
                // Header
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),   
                    ),
                  ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [ 
                    // Left section with red box
                    Container(
                      padding:
                          const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Text(
                        'RP 156',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                    // Center search input
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
                    // Right profile icon
                    IconButton(
                      icon: const Icon(Icons.person),
                      onPressed: () {
                        Navigator.pushNamed(
                          context, '/user-profile'); // Ensure this matches your routes
                      },
                    ),
                  ],
                ),
              ),              
              const SizedBox(height: 20), // Space between header and content
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      // Title
                      const Padding(
                        padding: EdgeInsets.all(20),
                        child: Text(
                          'Portal de Atendimento',
                          style: TextStyle(
                              color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),
                        ),
                      ),
                      // White square with opacity
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.8),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          children: [ 
                            const Text(
                              'Principais Serviços',
                              style: TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 20),
                            // Service icons
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                _buildServiceIcon(Icons.add_road_rounded, 'Bairro', () {
                                  Navigator.pushNamed(context, '/service');
                                }),
                                _buildServiceIcon(Icons.house, 'IPVA', () {
                                  Navigator.pushNamed(context, '/service');
                                }),
                                _buildServiceIcon(Icons.trending_neutral, 'Árvore', () {
                                  Navigator.pushNamed(context, '/service');
                                }),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                _buildServiceIcon(Icons.cleaning_services, 'Coleta', () {
                                  Navigator.pushNamed(context, '/service');
                                }),
                                _buildServiceIcon(Icons.pets, 'Animais', () {
                                  Navigator.pushNamed(context, '/service');
                                }),
                                _buildServiceIcon(Icons.roofing, 'IPTU', () {
                                  Navigator.pushNamed(context, '/service');
                                }),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                _buildServiceIcon(Icons.traffic, 'Esgoto', () {
                                  Navigator.pushNamed(context, '/service');
                                }),
                                _buildServiceIcon(Icons.traffic, 'Trânsito', () {
                                  Navigator.pushNamed(context, '/service');
                                }),
                                _buildServiceIcon(Icons.directions_bus, 'Ônibus', () {
                                  Navigator.pushNamed(context, '/service');
                                }),
                              ],
                            ),
                         const SizedBox(height: 20),
                            // const SizedBox(height: 20),
                            // ElevatedButton(
                            //   onPressed: () {
                            //     // Service page action
                            //     Navigator.pushNamed(
                            //         context, '/service-register'); // Ensure this matches your routes
                            //   },
                            //   child: const Text('Cadastro do Serviços'),
                            // ),
                            // const SizedBox(height: 20),
                            // ElevatedButton(
                            //   onPressed: () {
                            //     Navigator.pushNamed(
                            //         context, '/service'); // Ensure this matches your routes
                            //   },
                            //   child: const Text('Opções de Serviços'),
                            // ),
                            // const SizedBox(height: 20),
                            // ElevatedButton(
                            //   onPressed: () {
                            //     Navigator.pushNamed(
                            //         context, '/list'); // Ensure this matches your routes
                            //   },
                            //   child: const Text('Lista de Serviços'),
                            // ),   // 
                            // SizedBox(height: 20),
                            // ElevatedButton(
                            //   onPressed: () {
                            //     Navigator.pushNamed(
                            //         context, '/notices'); // Ensure this matches your routes
                            //   },
                            //   child: const Text('Notícias Sobre Serviços'),
                            // ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Widget for service icons
  Widget _buildServiceIcon(IconData icon, String label, [VoidCallback? onTap]) {
  return Center(
    child: Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: CircleAvatar(
            radius: 25,
            backgroundColor: Colors.red.shade200,
            child: Icon(icon, color: Colors.white),
          ),
        ),
        const SizedBox(height: 10),
        Text(label),
      ],
    ),
  );
}



}

// void main() {
//   runApp(MaterialApp(
//     home: ServicePortalPage(),
//   ));
// }
