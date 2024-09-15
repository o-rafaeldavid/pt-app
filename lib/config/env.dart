class Env {
  // Call all stored Keys on initialization
  static const Map<String, String> _keys = {
    'SUPABASE_URL': String.fromEnvironment('SUPABASE_URL'),
    'SUPABASE_ANON_KEY': String.fromEnvironment('SUPABASE_ANON_KEY'),
  };

  // Global Getter for Keys
  static String _getKey(String key) {
    final value = _keys[key] ?? '';
    if (value.isEmpty) {
      throw Exception('Key $key not found');
    }
    return value;
  }

  // Custom Getters
  static String get supabaseUrl => _getKey('SUPABASE_URL');
  static String get supabaseAnonKey => _getKey('SUPABASE_ANON_KEY');
}
