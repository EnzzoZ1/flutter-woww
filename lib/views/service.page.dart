import 'package:flutter/material.dart';
import 'service.register.dart'; // Importe a página de registro de serviço

class ServicePage extends StatelessWidget {
  const ServicePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: ServicePageContent(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class ServicePageContent extends StatefulWidget {
  const ServicePageContent({super.key});

  @override
  _ServicePageContentState createState() => _ServicePageContentState();
}

class _ServicePageContentState extends State<ServicePageContent> {
  String _selectedCategory = 'Categorias';
  List<String> _items = [];
  bool _showCategories = true;

  final Map<String, List<String>> _categories = {
    "Água": [
      "Falta de água frequente",
      "Vazamento de água nas ruas",
      "Baixa pressão da água",
      "Água com cor ou cheiro estranho",
      "Problemas na medição de consumo",
      "Excesso de cloro na água",
      "Conta de água muito alta",
      "Canos quebrados ou expostos"
    ],
    "Luz e Energia": [
      "Queda de energia recorrente",
      "Oscilação de energia elétrica",
      "Poste de luz quebrado",
      "Fios elétricos soltos",
      "Demora no religamento após queda",
      "Falta de manutenção nos postes",
      "Iluminação pública insuficiente",
      "Conta de luz inesperadamente alta"
    ],
    "Lixo e Limpeza": [
      "Atraso na coleta de lixo",
      "Lixo acumulado nas ruas",
      "Falta de lixeiras públicas",
      "Vazamento de líquidos do caminhão de lixo",
      "Resíduos volumosos sem recolhimento",
      "Acúmulo de lixo em terrenos baldios",
      "Excesso de entulho nas calçadas",
      "Infestação de animais devido ao lixo"
    ],
    "Animais": [
      "Animais de rua sem cuidado",
      "Infestação de ratos ou pombos",
      "Ataque de cães ou gatos abandonados",
      "Maus-tratos a animais",
      "Falta de castração gratuita",
      "Problemas com animais peçonhentos",
      "Falta de abrigo para animais de rua",
      "Ruídos de animais em horários noturnos"
    ],
    "Saúde e Hospital": [
      "Falta de médicos na unidade",
      "Demora no atendimento de emergência",
      "Fila longa para exames",
      "Ambulância indisponível",
      "Falta de remédios no posto",
      "Demora na realização de consultas",
      "Estrutura do hospital precária",
      "Ausência de especialidades médicas"
    ],
    "Horário de Ônibus": [
      "Atraso constante dos ônibus",
      "Pouca frequência de ônibus em horários de pico",
      "Paradas de ônibus sem cobertura",
      "Superlotação dos ônibus",
      "Ônibus em más condições",
      "Ausência de informações sobre horários",
      "Falta de fiscalização no transporte público",
      "Mudança de itinerário sem aviso"
    ],
    "Segurança": [
      "Assaltos frequentes na região",
      "Iluminação pública insuficiente",
      "Falta de policiamento ostensivo",
      "Agressões em espaços públicos",
      "Violência doméstica não assistida",
      "Pontos de tráfico de drogas",
      "Depredação de espaços públicos",
      "Arrombamentos em casas e comércios"
    ],
    "Rua e Bairro": [
      "Buracos nas ruas",
      "Calçadas danificadas",
      "Esgoto a céu aberto",
      "Mau cheiro de esgoto",
      "Falta de sinalização nas vias",
      "Falta de pavimentação",
      "Obras inacabadas",
      "Alagamento em dias de chuva"
    ]
  };

  void _updateCategory(String category) {
    setState(() {
      _selectedCategory = category;
      _items = _categories[category]!;
      _showCategories = false;
    });
  }

  void _goBack() {
    setState(() {
      _selectedCategory = 'Categorias';
      _items = [];
      _showCategories = true;
    });
  }

  void _navigateToServiceRegister(String item) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ServiceRegisterPage(item: item),
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
          child: Row(
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
                  Navigator.pushNamed(context, '/user-profile');
                },
              ),
            ],
          ),
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
              color: const Color.fromRGBO(255, 255, 255, 0.81),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    _selectedCategory,
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                if (!_showCategories)
                  TextButton(
                    onPressed: _goBack,
                    child: const Text('Voltar', style: TextStyle(color: Colors.red)),
                  ),
                const SizedBox(height: 8),
             Expanded(
  child: GridView.count(
    crossAxisCount: 2,
    crossAxisSpacing: 10,
    mainAxisSpacing: 10,
    padding: const EdgeInsets.all(16),
    children: _showCategories
        ? _categories.keys.map((category) {
            return SizedBox(
              width: 200,
              height: 100,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.black,
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  textStyle: const TextStyle(fontWeight: FontWeight.bold),
                ),
                onPressed: () => _updateCategory(category),
                child: Text(category, textAlign: TextAlign.center),
              ),
            );
          }).toList()
        : _items.map((item) {
            return SizedBox(
              width: 200,
              height: 100,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.black,
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  textStyle: const TextStyle(fontWeight: FontWeight.bold),
                ),
                onPressed: () => _navigateToServiceRegister(item),
                child: Text(item, textAlign: TextAlign.center),
              ),
            );
          }).toList(),
  ),
), ],
            ),
          ),
        ),
      ),
    );
  }
}