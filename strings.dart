import 'dart:io';

String eof = "}//EOF";

Future<void> main(List<String> args) async {
  if (args == null || args.isEmpty) {
    print("ERROR! pelase check -h or --h to see the formatting argument");
    return;
  } else if (args[0] == "-h" || args[0] == "--help") {
    print(
        "dart strings.dart --help\n"
            "dart strings.dart -h\n"
            "dart strings.dart --file [file_name]\n"
            "dart strings.dart -f [file_name]\n"
            "dart strings.dart [variable_name] [String of Locale.EN] [String of Locale.ID]");
    return;
  } else if (args[0] == '-f' || args[0] == '--file'){
    File f = File(args[1]);
    final value = await f.readAsLines();
    print("here");
    for(int i = 0; i < value.length ; i++){
      if(value[i] != '\n'){
        await main([value[i++], value[i++], value[i++]]);
      }
    }
  } else if (args.length == 1) {
    File f = File("lib/app/constants/strings.dart");
    final value = await f.readAsLines();
    bool reader = false;
    for (var element in value) {
      if (element.contains("}") && reader) {
        reader = false;
        break;
      }
      if (reader && element != '\n')
        stdout.write(element.trim().replaceAll(',', '\n'));
      else if (element.contains("String " + args[0])) reader = true;
    }
    print("");
  } else if (args.length == 3) {
    File f = File("lib/app/constants/strings.dart");
    final value = await f.readAsLines();
    if (value.contains("  static String ${args[0]} = {")) {
      print("ERROR! ${args[0]} is already defined");
      return;
    } else if (value.indexOf(eof) == -1) {
      print(
          'ERROR! make sure strings.dart hash "}//EOF" in the end of the line');
      return;
    }
    value.removeAt(value.indexOf(eof));
    value.add('\n  static String ${args[0]} = {\n' +
        '    Locale.EN: "${args[1]}",\n' +
        '    Locale.ID: "${args[2]}"\n' +
        '  }[lang];\n' +
        eof);
    f
        .writeAsString(value.join('\n'))
        .then((value) => print("SUCCESS! ${args[0]} is append to Strings"));
  } else {
    print("ERROR! pelase check -h or --h to see the formatting argument");
  }
}
