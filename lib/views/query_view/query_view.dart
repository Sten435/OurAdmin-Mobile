import 'package:another_flushbar/flushbar.dart';
import 'package:code_text_field/code_text_field.dart';
import 'package:flutter/material.dart';
import 'package:ouradmin_mobile/manager/query_manader.dart';
import 'package:ouradmin_mobile/views/query_view/widgets/results_popup.dart';

class QueryView extends StatefulWidget {
  String queryText = "";

  QueryView({super.key});

  @override
  _QueryViewState createState() => _QueryViewState();
}

class _QueryViewState extends State<QueryView> {
  CodeController? _codeController;

  @override
  void initState() {
    super.initState();

    var defaultStyle =
        TextStyle(color: Colors.brown.shade800, fontWeight: FontWeight.bold);

    _codeController = CodeController(text: widget.queryText, stringMap: {
      "'": defaultStyle,
      '"': defaultStyle,
      "ADD": defaultStyle,
      "ALL": defaultStyle,
      "ALTER": defaultStyle,
      "ANALYZE": defaultStyle,
      "AND": defaultStyle,
      "AS": defaultStyle,
      "ASC": defaultStyle,
      "AUTO_INCREMENT": defaultStyle,
      "BDB": defaultStyle,
      "BERKELEYDB": defaultStyle,
      "BETWEEN": defaultStyle,
      "BIGINT": defaultStyle,
      "BINARY": defaultStyle,
      "BLOB": defaultStyle,
      "BOTH": defaultStyle,
      "BTREE": defaultStyle,
      "BY": defaultStyle,
      "CASCADE": defaultStyle,
      "CASE": defaultStyle,
      "CHANGE": defaultStyle,
      "CHAR": defaultStyle,
      "CHARACTER": defaultStyle,
      "CHECK": defaultStyle,
      "COLLATE": defaultStyle,
      "COLUMN": defaultStyle,
      "COLUMNS": defaultStyle,
      "CONSTRAINT": defaultStyle,
      "CREATE": defaultStyle,
      "CROSS": defaultStyle,
      "CURRENT_DATE": defaultStyle,
      "CURRENT_TIME": defaultStyle,
      "CURRENT_TIMESTAMP": defaultStyle,
      "DATABASE": defaultStyle,
      "DATABASES": defaultStyle,
      "DAY_HOUR": defaultStyle,
      "DAY_MINUTE": defaultStyle,
      "DAY_SECOND": defaultStyle,
      "DEC": defaultStyle,
      "DECIMAL": defaultStyle,
      "DEFAULT": defaultStyle,
      "DELAYED": defaultStyle,
      "DELETE": defaultStyle,
      "DESC": defaultStyle,
      "DESCRIBE": defaultStyle,
      "DISTINCT": defaultStyle,
      "DISTINCTROW": defaultStyle,
      "DIV": defaultStyle,
      "DOUBLE": defaultStyle,
      "DROP": defaultStyle,
      "ELSE": defaultStyle,
      "ENCLOSED": defaultStyle,
      "ERRORS": defaultStyle,
      "ESCAPED": defaultStyle,
      "EXISTS": defaultStyle,
      "EXPLAIN": defaultStyle,
      "FALSE": defaultStyle,
      "FIELDS": defaultStyle,
      "FLOAT": defaultStyle,
      "FOR": defaultStyle,
      "FORCE": defaultStyle,
      "FOREIGN": defaultStyle,
      "FROM": defaultStyle,
      "FULLTEXT": defaultStyle,
      "FUNCTION": defaultStyle,
      "GEOMETRY": defaultStyle,
      "GRANT": defaultStyle,
      "GROUP": defaultStyle,
      "HASH": defaultStyle,
      "HAVING": defaultStyle,
      "HELP": defaultStyle,
      "HIGH_PRIORITY": defaultStyle,
      "HOUR_MINUTE": defaultStyle,
      "HOUR_SECOND": defaultStyle,
      "IF": defaultStyle,
      "IGNORE": defaultStyle,
      "IN": defaultStyle,
      "INDEX": defaultStyle,
      "INFILE": defaultStyle,
      "INNER": defaultStyle,
      "INNODB": defaultStyle,
      "INSERT": defaultStyle,
      "INT": defaultStyle,
      "INTEGER": defaultStyle,
      "INTERVAL": defaultStyle,
      "INTO": defaultStyle,
      "IS": defaultStyle,
      "JOIN": defaultStyle,
      "KEY": defaultStyle,
      "KEYS": defaultStyle,
      "KILL": defaultStyle,
      "LEADING": defaultStyle,
      "LEFT": defaultStyle,
      "LIKE": defaultStyle,
      "LIMIT": defaultStyle,
      "LINES": defaultStyle,
      "LOAD": defaultStyle,
      "LOCALTIME": defaultStyle,
      "LOCALTIMESTAMP": defaultStyle,
      "LOCK": defaultStyle,
      "LONG": defaultStyle,
      "LONGBLOB": defaultStyle,
      "LONGTEXT": defaultStyle,
      "LOW_PRIORITY": defaultStyle,
      "MASTER_SERVER_ID": defaultStyle,
      "MATCH": defaultStyle,
      "MEDIUMBLOB": defaultStyle,
      "MEDIUMINT": defaultStyle,
      "MEDIUMTEXT": defaultStyle,
      "MIDDLEINT": defaultStyle,
      "MINUTE_SECOND": defaultStyle,
      "MOD": defaultStyle,
      "MRG_MYISAM": defaultStyle,
      "NATURAL": defaultStyle,
      "NOT": defaultStyle,
      "NULL": defaultStyle,
      "NUMERIC": defaultStyle,
      "ON": defaultStyle,
      "OPTIMIZE": defaultStyle,
      "OPTION": defaultStyle,
      "OPTIONALLY": defaultStyle,
      "OR": defaultStyle,
      "ORDER": defaultStyle,
      "OUTER": defaultStyle,
      "OUTFILE": defaultStyle,
      "PRECISION": defaultStyle,
      "PRIMARY": defaultStyle,
      "PRIVILEGES": defaultStyle,
      "PROCEDURE": defaultStyle,
      "PURGE": defaultStyle,
      "READ": defaultStyle,
      "REAL": defaultStyle,
      "REFERENCES": defaultStyle,
      "REGEXP": defaultStyle,
      "RENAME": defaultStyle,
      "REPLACE": defaultStyle,
      "REQUIRE": defaultStyle,
      "RESTRICT": defaultStyle,
      "RETURNS": defaultStyle,
      "REVOKE": defaultStyle,
      "RIGHT": defaultStyle,
      "RLIKE": defaultStyle,
      "RTREE": defaultStyle,
      "SELECT": defaultStyle,
      "SET": defaultStyle,
      "SHOW": defaultStyle,
      "SMALLINT": defaultStyle,
      "SOME": defaultStyle,
      "SONAME": defaultStyle,
      "SPATIAL": defaultStyle,
      "SQL_BIG_RESULT": defaultStyle,
      "SQL_CALC_FOUND_ROWS": defaultStyle,
      "SQL_SMALL_RESULT": defaultStyle,
      "SSL": defaultStyle,
      "STARTING": defaultStyle,
      "STRAIGHT_JOIN": defaultStyle,
      "STRIPED": defaultStyle,
      "TABLE": defaultStyle,
      "TABLES": defaultStyle,
      "TERMINATED": defaultStyle,
      "THEN": defaultStyle,
      "TINYBLOB": defaultStyle,
      "TINYINT": defaultStyle,
      "TINYTEXT": defaultStyle,
      "TO": defaultStyle,
      "TRAILING": defaultStyle,
      "TRUE": defaultStyle,
      "TYPES": defaultStyle,
      "UNION": defaultStyle,
      "UNIQUE": defaultStyle,
      "UNLOCK": defaultStyle,
      "UNSIGNED": defaultStyle,
      "UPDATE": defaultStyle,
      "USAGE": defaultStyle,
      "USE": defaultStyle,
      "USER_RESOURCES": defaultStyle,
      "USING": defaultStyle,
      "VALUES": defaultStyle,
      "VARBINARY": defaultStyle,
      "VARCHAR": defaultStyle,
      "VARCHARACTER": defaultStyle,
      "VARYING": defaultStyle,
      "WARNINGS": defaultStyle,
      "WHEN": defaultStyle,
      "WHERE": defaultStyle,
      "WITH": defaultStyle,
      "WRITE": defaultStyle,
      "XOR": defaultStyle,
      "YEAR_MONTH": defaultStyle,
      "ZEROFILL": defaultStyle,
    });
  }

  @override
  void dispose() {
    _codeController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: Column(
          children: [
            Expanded(
              child: CodeField(
                background: Colors.transparent,
                textSelectionTheme: TextSelectionThemeData(
                  cursorColor: Colors.black,
                  selectionColor:
                      Theme.of(context).primaryColor.withOpacity(.5),
                  selectionHandleColor: Colors.black,
                ),
                textStyle: TextStyle(
                  color: Theme.of(context).primaryColorDark,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
                lineNumberStyle: LineNumberStyle(
                  textStyle: TextStyle(
                    color: Colors.black.withOpacity(.6),
                    fontSize: 16,
                  ),
                ),
                expands: true,
                focusNode: FocusNode(),
                controller: _codeController!,
                onChanged: (text) => setState(() => widget.queryText = text),
              ),
            ),
            const Divider(
              color: Colors.black,
              height: 0,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                  color: Colors.transparent,
                  width: double.infinity,
                  alignment: Alignment.center,
                  child: ElevatedButton(
                    onPressed: () => executeQuery(context),
                    child:
                        const Text("Execute", style: TextStyle(fontSize: 24)),
                  )),
            )
          ],
        ));
  }

  void executeQuery(context) {
    final text = widget.queryText;
    if (text.isEmpty) return;

    try {
      var queryResult = QueryManager.executeQuery(text);
      showBottomSheet(
          context: context,
          backgroundColor: Theme.of(context).colorScheme.background,
          builder: (context) {
            return ResultPopup(queryResult);
          });
    } catch (e) {
      print(e);
      Flushbar(
        messageText: Text(
          e.toString(),
          style: const TextStyle(
            fontSize: 18.0,
            color: Colors.red,
          ),
        ),
        icon: const Icon(
          Icons.info,
          size: 28.0,
          color: Colors.red,
        ),
        duration: const Duration(seconds: 5),
        showProgressIndicator: true,
        backgroundColor: Colors.black,
        leftBarIndicatorColor: Colors.red,
      ).show(context);
    }
  }
}
