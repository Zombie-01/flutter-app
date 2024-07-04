import 'package:flutter/material.dart';

class ErrorNotification extends StatelessWidget {
  final String errorMessage;

  ErrorNotification({required this.errorMessage});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.red[50],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(Icons.close, color: Colors.red),
          SizedBox(width: 10),
          Text(errorMessage, style: TextStyle(color: Colors.red[800])),
        ],
      ),
    );
  }
}

class ActionPanel extends StatelessWidget {
  final bool isLoading;
  final VoidCallback submitImage;

  ActionPanel({required this.isLoading, required this.submitImage});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Card(
        elevation: 4,
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Та өөрийн зураг аа байршуулна уу.',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              SizedBox(height: 10),
              Text(
                'Өрөөний зургийг байршуулж, манай хиймэл оюун ухаанд шинэ дизайн гаргах боломжийг олго.',
                style: TextStyle(fontSize: 14, color: Colors.grey[600]),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: isLoading ? null : submitImage,
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                      isLoading ? Colors.indigo[300] : Colors.black),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Эхлэх'),
                    Icon(Icons.star, color: Colors.grey[300]),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Convert other components similarly: ImageOutput, UploadedImage, ImageDropzone, SelectMenu, Header, Footer

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? outputImage;
  String? base64Image;
  String theme = "Modern";
  String room = "Living Room";
  bool loading = false;
  String? error;
  File? file;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Flutter Home Page')),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (error != null) ErrorNotification(errorMessage: error!),
            ActionPanel(isLoading: loading, submitImage: submitImage),
            // Add other components here using Flutter widgets
          ],
        ),
      ),
    );
  }

  void submitImage() async {
    // Implement image submission logic using Flutter's HTTP client or other libraries
    setState(() {
      loading = true;
      error = null;
    });

    try {
      // Replace this with your actual API call logic in Flutter
      // Example using http package:
      // final response = await http.post(Uri.parse("/api/replicate/generator"), body: {...});

      // Mock response handling:
      final Map<String, dynamic> result = {
        'output': ['output1.png', 'output2.png']
      };

      if (result['error'] != null) {
        setState(() {
          error = result['error'];
        });
      } else {
        setState(() {
          outputImage = result['output'][1];
        });
      }
    } catch (e) {
      setState(() {
        error = "Failed to submit image. Please try again later.";
      });
    } finally {
      setState(() {
        loading = false;
      });
    }
  }
}
