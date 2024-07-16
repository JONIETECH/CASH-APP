import 'package:finance_tracker/features/ai_automation/presentation/bloc/ai_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Aipage extends StatefulWidget {
  static route() => MaterialPageRoute(builder: (context) => const Aipage());
  const Aipage({super.key});

  @override
  State<Aipage> createState() => _AipageState();
}

class _AipageState extends State<Aipage> {
  final TextEditingController _controller = TextEditingController();

  void _sendMessage() {
    final text = _controller.text;
    if (text.isNotEmpty) {
      print("Sending message: $text"); // Debug print
      context.read<AiBloc>().add(SendMessage(text));
      _controller.clear();
    }
  }

  void _startVoiceInput() {
    print('Starting voice input...');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fin Pal', textAlign: TextAlign.center),
        centerTitle: true,
      ),
      body: BlocConsumer<AiBloc, AiState>(
        listener: (context, state) {
          if (state is AiFailure) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(state.error),
              backgroundColor: Colors.red,
            ));
          }
        },
        builder: (context, state) {
          print('Current state: $state'); // Debug print
          return Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/dark.jpg"),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              children: [
                Container(
                  height: 120,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(16),
                  child: const Text(
                    "Fin Pal",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 34,
                      color: Colors.white,
                    ),
                  ),
                ),
                Expanded(
                  child: state is AiLoading
                      ? const Center(child: CircularProgressIndicator())
                      : state is AiSuccess
                          ? ListView(
                              children: [
                                ListTile(
                                  title: Text(state.response),
                                ),
                              ],
                            )
                          : const SizedBox.shrink(),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                      vertical: 12, horizontal: 16),
                  height: 120,
                  color: Colors.blue,
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _controller,
                          style: const TextStyle(color: Colors.black),
                          cursorColor: Theme.of(context).primaryColor,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(100),
                            ),
                            fillColor: Colors.white,
                            filled: true,
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(100),
                              borderSide: BorderSide(
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      GestureDetector(
                        onTap: _sendMessage,
                        child: CircleAvatar(
                          radius: 30,
                          backgroundColor: Theme.of(context).primaryColor,
                          child: const Center(
                            child: Icon(Icons.send, color: Colors.white),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      GestureDetector(
                        onTap: _startVoiceInput,
                        child: CircleAvatar(
                          radius: 30,
                          backgroundColor: Theme.of(context).primaryColor,
                          child: const Center(
                            child: Icon(Icons.mic, color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
