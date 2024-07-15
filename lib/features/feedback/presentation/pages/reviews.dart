import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ReviewPage extends StatelessWidget {
  static route() => MaterialPageRoute(builder: (context) => const ReviewPage());
  const ReviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'Submit a review',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: const FeedbackPage(),
    );
  }
}

class FeedbackPage extends StatefulWidget {
  const FeedbackPage({super.key});

  @override
  _FeedbackPageState createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  final _formKey = GlobalKey<FormState>();
  final _feedbackController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  List<File> _images = [];

  @override
  void dispose() {
    _feedbackController.dispose();
    super.dispose();
  }

  void _submitFeedback() {
    if (_formKey.currentState?.validate() ?? false) {
      // Handle the feedback submission here
      String feedback = _feedbackController.text;
      print('Feedback submitted: $feedback');
      print('Images submitted: ${_images.length}');

      // Show a snackbar or dialog to inform the user
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Thank you for your feedback!')),
      );

      // Clear the form
      _feedbackController.clear();
      setState(() {
        _images.clear();
      });
    }
  }

  Future<void> _pickImage() async {
    final List<XFile>? pickedFiles = await _picker.pickMultiImage();
    if (pickedFiles != null) {
      setState(() {
        _images = pickedFiles.map((file) => File(file.path)).toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Feedback'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'We value your feedback!',
                  style: TextStyle(fontSize: 18),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _feedbackController,
                  maxLines: 5,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Type your feedback Here...',
                    alignLabelWithHint: true,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your feedback';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: _pickImage,
                  child: const Text('Pick Images'),
                ),
                const SizedBox(height: 16),
                _images.isEmpty
                    ? const Text('No images selected.')
                    : Wrap(
                        spacing: 10,
                        runSpacing: 10,
                        children: _images.map((image) {
                          return Image.file(
                            image,
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                          );
                        }).toList(),
                      ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: _submitFeedback,
                  child: const Text('Submit'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
