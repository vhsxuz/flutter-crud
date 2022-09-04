// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:supabase/supabase.dart';

class SupaBaseHandler {
  static String supabaseUrl = "";
  static String supabaseKey = "";

  final client = SupabaseClient(supabaseUrl, supabaseKey);

  addData(String taskValue, bool statusValue) async {
    var response = client.from("todo").insert({
      'task': taskValue,
      'status': statusValue,
    }).execute();
    print(response);
  }

  readData() async {
    var response = await client
        .from("todo")
        .select()
        .order('task', ascending: true)
        .execute();
    final dataList = response.data as List;
    return dataList;
  }

  updateData(int id, bool statusValue) async {
    var response = client
        .from("todo")
        .update({
          'status': statusValue,
        })
        .eq('id', id)
        .execute();
    print(response);
  }

  deleteData(int id) {
    var response = client.from("todo").delete().eq('id', id).execute();
    print(response);
  }
}
