// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:health_care_app/widgets/message.dart';
import 'package:http/http.dart' as http;

const String url = 'https://api.openai.com/v1/chat/completions';

Future<String> getApiKey() async {
  try {
    final String response = await rootBundle.loadString('assets/secrets.json');
    final configData = await json.decode(response);
    return configData['api_key'];
  } catch (e) {
    return "";
  }
}

Future<String> fetchChatGPTResponse(String prompt, BuildContext context) async {
  try {
    String apiKey = await getApiKey();

    var requestBody = jsonEncode({
      'model': 'gpt-3.5-turbo', // gpt-3.5-turbo, gpt-4, gpt-3.5-turbo-0125
      "messages": [
        {
          "role": "user",
          "content": 'Summarize the following text impersonal: \n\n$prompt'
        }
      ],
      'max_tokens': 1000
    });

    var response = await http.post(Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $apiKey',
        },
        body: requestBody);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return data['choices'][0]['message']['content'];
    } else {
      displayErrorMotionToast('Failed to get reponse', context);
      return "";
    }
  } catch (e) {
    displayErrorMotionToast('Error occurred. Failed to get reponse', context);
    return "";
  }
}

Future<String> sendPrompt(String prompt, BuildContext context) async {
  try {
    String apiKey = await getApiKey();

    var requestBody = jsonEncode({
      'model': 'gpt-3.5-turbo',
      "messages": [
        {"role": "user", "content": prompt}
      ],
      'max_tokens': 1000,
      'temperature': 0.7
    });

    var response = await http.post(Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $apiKey',
        },
        body: requestBody);

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      return data['choices'][0]['message']['content'];
    } else {
      displayErrorMotionToast('Failed to fetch data', context);
      return "";
    }
  } catch (e) {
    displayErrorMotionToast('Error occurred', context);
    return "";
  }
}

String expampleResponse =
    "The patient, 56-year-old Pamela Rogers, presented with chest pain for the past week. The pain is dull and aching, located in the left para-sternal area, and radiates up to her neck. She had three episodes of pain in total, the most recent being 30 minutes long and prompting her visit to the Emergency Department. She has a history of hypertension but no other significant medical issues. On examination, she has normal vital signs and physical findings, including crackles in her lungs and a systolic murmur. Initial assessment indicates angina pectoris as the likely diagnosis, considering her risk factors. A detailed plan includes hospitalization for monitoring, starting medications, monitoring cholesterol levels, and scheduling a cardiac catheterization. She will also be started on diuretics for her dyspnea and further diagnostic tests will be ordered. The overall approach is to address the immediate symptoms and provide long-term care for her conditions.";
