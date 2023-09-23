import 'dart:convert';
import 'package:http/http.dart' as http;

Future<String> generateResponse(String prompt) async {
  const apiKey = "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";

  var url = Uri.https("api.openai.com", "/v1/completions");
  final response = await http.post(
    url,
    headers: {
      'Content-Type': 'application/json',
      "Authorization": "Bearer $apiKey"
    },
    body: json.encode({
      "model": "text-davinci-003",
      "prompt": prompt,
      'temperature': 0.5,
      'max_tokens': 2000,
      'top_p': 1,
      'frequency_penalty': 0.0,
      'presence_penalty': 0.0,
    }),
  );

  // Print the response for debugging
  print("API Response: ${response.body}");

  // Do something with the response
  Map<String, dynamic> newResponse = jsonDecode(response.body);

  // Handle the response or return it
  if (newResponse.containsKey('choices')) {
    return newResponse['choices'][0]['text'];
  } else {
    // Handle the case where 'choices' is not present in the response
    return "Response structure does not match expectations.";
  }
}
