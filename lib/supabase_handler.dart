// ignore_for_file: avoid_print
import 'package:supabase/supabase.dart';

class SupaBaseHandler {
  static String supabaseUrl = "https://iczjxqdyqsujlklhhryn.supabase.co";
  static String supabaseKey =
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imljemp4cWR5cXN1amxrbGhocnluIiwicm9sZSI6ImFub24iLCJpYXQiOjE2NjIyNjQyOTksImV4cCI6MTk3Nzg0MDI5OX0.P9_lpuNYDSmykQlDK-GcpySupS5z7gPtmm-crjHnfWM";
  final client = SupabaseClient(supabaseUrl, supabaseKey);

  addData(String taskValue, bool statusValue) {
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
    print(response.data);
    final dataList = response.data as List;
    return dataList;
  }

  updateData(int id, bool statusValue) async {
    var response = await client
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
