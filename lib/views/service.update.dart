import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class ServiceUpdatePage extends StatelessWidget {
  final String item;

  const ServiceUpdatePage({super.key, this.item = 'Outro'});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ServiceUpdateScreen(item: item),
      debugShowCheckedModeBanner: false,
    );
  }
}

class ServiceUpdateScreen extends StatefulWidget {
  final String item;

  const ServiceUpdateScreen({super.key, required this.item});

  @override
  _ServiceUpdateScreenState createState() => _ServiceUpdateScreenState();
}

class _ServiceUpdateScreenState extends State<ServiceUpdateScreen> {
  File? selectedFile;
  Uint8List? selectedFileBytes;
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String? selectedStatus;

  // Função para escolher arquivo
  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'jpeg', 'png'],
    );

    if (result != null) {
      if (kIsWeb) {
        if (result.files.single.size > 25 * 1024 * 1024) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('O arquivo selecionado é muito grande. O tamanho máximo é 25 MB.'),
              backgroundColor: Colors.red,
            ),
          );
          return;
        }
        setState(() {
          selectedFileBytes = result.files.single.bytes;
        });
      } else {
        File file = File(result.files.single.path!);
        if (file.lengthSync() > 25 * 1024 * 1024) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('O arquivo selecionado é muito grande. O tamanho máximo é 25 MB.'),
              backgroundColor: Colors.red,
            ),
          );
          return;
        }
        setState(() {
          selectedFile = file;
        });
      }
    } else {
      // O usuário cancelou a seleção
    }
  }

  Future<void> _updateService() async {
    try {
      String? imageUrl;
      if (selectedFile != null || selectedFileBytes != null) {
        // Upload da imagem para o Firebase Storage
        final storageRef = FirebaseStorage.instance
            .ref()
            .child('service_images/${DateTime.now().millisecondsSinceEpoch}.jpg');
        
        if (kIsWeb) {
          await storageRef.putData(selectedFileBytes!);
        } else {
          await storageRef.putFile(selectedFile!);
        }
        
        imageUrl = await storageRef.getDownloadURL();
      }

      // Atualizar dados no Firestore
      await _firestore.collection('servicos').doc(widget.item).update({
        'status': selectedStatus,
        'location': _locationController.text,
        'description': _descriptionController.text,
        'imageUrl': imageUrl,
        'timestamp': FieldValue.serverTimestamp(),
      });

      // Mostrar mensagem de sucesso
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Serviço atualizado com sucesso!'),
          backgroundColor: Colors.green,
        ),
      );

      // Limpar os campos
      _locationController.clear();
      _descriptionController.clear();
      setState(() {
        selectedFile = null;
        selectedFileBytes = null;
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
                Center(
                  child: Text(
                    widget.item,
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                const Center(
                  child: Text(
                    'Preencha os campos abaixo com os dados referente ao serviço de "nome do serviço". Após isso, aperte em finalizar e seu serviço será encaminhado para a nossa central de atendimento.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black54,
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                const Text(
                  'Localização',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _locationController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Descrição',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _descriptionController,
                  maxLines: 3,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Imagem da ocorrência',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: _pickFile,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey.shade400,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.upload_file),
                      SizedBox(width: 8),
                      Text('Escolher Arquivo'),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                if (selectedFile != null || selectedFileBytes != null)
                  Column(
                    children: [
                      const Text("Arquivo selecionado:"),
                      const SizedBox(height: 8),
                      Text(
                        selectedFile != null
                            ? selectedFile!.path.split('/').last
                            : 'Arquivo selecionado na web',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 16),
                      if (selectedFile != null)
                        Image.file(
                          selectedFile!,
                          height: 150,
                          fit: BoxFit.cover,
                        )
                      else if (selectedFileBytes != null)
                        Image.memory(
                          selectedFileBytes!,
                          height: 150,
                          fit: BoxFit.cover,
                        ),
                    ],
                  )
                else
                  const Text("Nenhum arquivo selecionado."),
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
      ),
    );
  }
}