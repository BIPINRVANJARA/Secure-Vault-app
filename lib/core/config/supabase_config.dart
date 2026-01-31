import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseConfig {
  static const String supabaseUrl = 'https://rifxdvelawraootfvwst.supabase.co';
  static const String supabaseAnonKey = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InJpZnhkdmVsYXdyYW9vdGZ2d3N0Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3Njk2NDg1NDQsImV4cCI6MjA4NTIyNDU0NH0.86b_jjIkg7g_ERaAPxv807tBazWL-Uu4e91QmJi6DCE';
  
  static Future<void> initialize() async {
    await Supabase.initialize(
      url: supabaseUrl,
      anonKey: supabaseAnonKey,
      authOptions: const FlutterAuthClientOptions(
        authFlowType: AuthFlowType.pkce,
        // Enable automatic token refresh to keep session alive
        autoRefreshToken: true,
      ),
    );
  }
  
  static SupabaseClient get client => Supabase.instance.client;
}
