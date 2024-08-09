import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:timberr/constants.dart';
import 'package:timberr/screens/search_delegate/favorite_search_delegate.dart';
import 'package:timberr/widgets/tabbed/bottom_navbar.dart';

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
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Эхлэх'),
                    SizedBox(width: 10),
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

class UploadedImage extends StatelessWidget {
  final File image;
  final VoidCallback removeImage;
  final String fileName;
  final String fileSize;

  UploadedImage({
    required this.image,
    required this.removeImage,
    required this.fileName,
    required this.fileSize,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: 200,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey[300]!),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Image.file(
            image,
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          top: 8,
          right: 8,
          child: GestureDetector(
            onTap: removeImage,
            child: Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.yellow[500],
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.delete, color: Colors.black),
            ),
          ),
        ),
        Positioned(
          bottom: 8,
          left: 8,
          child: Container(
            color: Colors.black54,
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: Text(
              '$fileName ($fileSize)',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}

class ImageOutput extends StatelessWidget {
  final bool loading;
  final String? outputImage;
  final VoidCallback downloadOutputImage;

  ImageOutput({
    required this.loading,
    required this.outputImage,
    required this.downloadOutputImage,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(8),
      ),
      child: loading
          ? Center(child: CircularProgressIndicator())
          : outputImage != null
              ? Stack(
                  children: [
                    Image.network(
                      outputImage!,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: double.infinity,
                    ),
                    Positioned(
                      top: 8,
                      right: 8,
                      child: GestureDetector(
                        onTap: downloadOutputImage,
                        child: Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.yellow[500],
                            shape: BoxShape.circle,
                          ),
                          child: Icon(Icons.download, color: Colors.black),
                        ),
                      ),
                    ),
                  ],
                )
              : Center(child: Text('AI-ээр үүсгэгдсэн гаралт энд гарна')),
    );
  }
}

class ImageDropzone extends StatelessWidget {
  final VoidCallback onImagePick;
  final String title;

  ImageDropzone({required this.onImagePick, required this.title});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onImagePick,
      child: Container(
        height: 200,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey[300]!),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.image, color: Colors.grey[400], size: 50),
              SizedBox(height: 10),
              Text(
                title,
                style: TextStyle(color: Colors.grey[600]),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ReplicateApi {
  final String _replicateApiToken;
  final String _model;

  ReplicateApi(this._replicateApiToken, this._model);

  Future<Map<String, dynamic>> runModel(
      String image, String theme, String room) async {
    final url = 'https://api.replicate.com/v1/predictions';
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $_replicateApiToken',
    };

    final input = {
      'image': image,
      'prompt':
          'A $theme $room Editorial Style Photo, Symmetry, Straight On, Modern Living Room, Large Window, Leather, Glass, Metal, Wood Paneling, Neutral Palette, Ikea, Natural Light, Apartment, Afternoon, Serene, Contemporary, 4k',
      'a_prompt':
          'best quality, extremely detailed, photo from Pinterest, interior, cinematic photo, ultra-detailed, ultra-realistic, award-winning',
      'n_prompt':
          'longbody, lowres, bad anatomy, bad hands, missing fingers, extra digit, fewer digits, cropped, worst quality, low quality',
      'ddim_steps': 20,
      'num_samples': '1',
      'value_threshold': 0.1,
      'image_resolution': '512',
      'detect_resolution': 512,
      'distance_threshold': 0.1,
    };

    final response = await http.post(Uri.parse(url),
        headers: headers, body: jsonEncode({'input': input}));

    if (response.statusCode == 201) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to run model');
    }
  }
}

class AiPage extends StatefulWidget {
  @override
  _AiPageState createState() => _AiPageState();
}

class _AiPageState extends State<AiPage> {
  String? outputImage;
  String? base64Image;
  String theme = "Modern";
  String room = "Living Room";
  bool loading = false;
  String? error;
  File? file;

  @override
  Widget build(BuildContext context) {
    return PopScope(
        canPop: false,
        onPopInvoked: (_) => kOnExitConfirmation(),
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                showSearch(
                    context: context, delegate: FavoriteSearchDelegate());
              },
              icon: SvgPicture.asset("assets/icons/search_icon.svg"),
            ),
            title: const Text(
              "AI page",
              style: kMerriweatherBold16,
            ),
            centerTitle: true,
          ),
          bottomNavigationBar: const BottomNavBar(selectedPos: 2),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (error != null) ErrorNotification(errorMessage: error!),
                ActionPanel(isLoading: loading, submitImage: submitImage),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: DropdownButton<String>(
                    value: theme,
                    onChanged: (String? newValue) {
                      setState(() {
                        theme = newValue!;
                      });
                    },
                    items: <String>[
                      'Modern',
                      'Vintage',
                      'Minimalist',
                      'Professional'
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: DropdownButton<String>(
                    value: room,
                    onChanged: (String? newValue) {
                      setState(() {
                        room = newValue!;
                      });
                    },
                    items: <String>[
                      'Living Room',
                      'Dining Room',
                      'Bedroom',
                      'Bathroom',
                      'Office'
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: file == null
                      ? ImageDropzone(
                          onImagePick: pickImage,
                          title:
                              'Зургаа энд чирж буулгах эсвэл байршуулахын тулд дарна уу',
                        )
                      : UploadedImage(
                          image: file!,
                          removeImage: removeImage,
                          fileName: file!.path.split('/').last,
                          fileSize: fileSize(file!.lengthSync()),
                        ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ImageOutput(
                    loading: loading,
                    outputImage: outputImage,
                    downloadOutputImage: downloadOutputImage,
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  void pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      final file = File(pickedFile.path);
      setState(() {
        this.file = file;
      });
      convertImageToBase64(file);
    }
  }

  void convertImageToBase64(File file) async {
    final bytes = await file.readAsBytes();
    final base64Image = base64Encode(bytes);
    setState(() {
      this.base64Image = base64Image;
    });
  }

  String fileSize(int bytes) {
    if (bytes <= 0) return "0 Bytes";
    const suffixes = ["Bytes", "KB", "MB", "GB", "TB"];
    var i = (log(bytes) / log(1024)).floor();
    return ((bytes / pow(1024, i)).toStringAsFixed(2)) + ' ' + suffixes[i];
  }

  void removeImage() {
    setState(() {
      file = null;
      outputImage = null;
    });
  }

  Future<void> downloadOutputImage() async {
    if (outputImage != null) {
      final response = await http.get(Uri.parse(outputImage!));
      final documentDirectory = (await getApplicationDocumentsDirectory()).path;
      File imgFile = new File('$documentDirectory/output.png');
      imgFile.writeAsBytesSync(response.bodyBytes);
    }
  }

  void submitImage() async {
    setState(() {
      loading = true;
      error = null;
    });

    try {
      final _replicateApi = ReplicateApi(
          'r8_OCvhfFIer0of1xYU070oRfG2K2ZvYNb26TQg9',
          'jagilley/controlnet-hough:854e8727697a057c525cdb45ab037f64ecca770a1769cc52287c2e56472a247b');

      final response = await _replicateApi.runModel(file!.path, theme, room);

      if (response['error'] != null) {
        setState(() {
          error = response['error'];
        });
      } else {
        setState(() {
          outputImage = response['output'][1];
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

void main() {
  runApp(MaterialApp(
    home: AiPage(),
  ));
}
