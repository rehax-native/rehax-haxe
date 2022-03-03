package rehax.builder;

using StringTools;

enum TOKEN {
  OPEN_ANGLE_BRACKET;
  CLOSE_ANGLE_BRACKET;
  CLOSE_SLASH;
  OPEN_VARIABLE;
  CLOSE_VARIABLE;
  OPEN_IF;
  CLOSE_IF;
  OPEN_FOR;
  CLOSE_FOR;
  EQUALS;
  WORD(content:String);
  TEXT(content:String);
}

enum abstract TOKENIZE_STATE(Int) {
  var BEGIN;
  var IGNORE_WHITESPACE;
  var OPEN_NODE;
  var BODY;
  var BODY_VARIABLE;
  var TAG_NAME;
  var OPEN_NODE_AFTER_TAG_NAME;
  var CLOSE_NODE;
  var CLOSE_NODE_AFTER_TAG_NAME;
  var ATTRIBUTE_NAME;
  var ATTRIBUTE_NAME_DONE;
  var ATTRIBUTE_VALUE;
  var ATTRIBUTE_VALUE_VARIABLE;
}

class TokenizeError {
  public var msg:String;
  public var line:Int;
  public var col:Int;

  public function new(msg:String, line:Int, col:Int) {
    this.msg = msg;
    this.line = line;
    this.col = col;
  }
}

class Tokenizer {
  var body:String;
  var pos = 0;

  public var tokens:Array<TOKEN> = [];

  public function new(body:String) {
    this.body = body;
  }

  public function tokenize() {
    var start = 0;
    var state:TOKENIZE_STATE = BEGIN;
    var next:TOKENIZE_STATE = BEGIN;

    var c = body.fastCodeAt(pos);

    var isWhitespace = c == '\n'.code || c == '\r'.code || c == '\t'.code || c == ' '.code;
    var varDepth = 0;

    while (!StringTools.isEof(c)) {
      switch (state) {
        case IGNORE_WHITESPACE:
          switch (c) {
            case '\n'.code, '\r'.code, '\t'.code, ' '.code:
            default:
              state = next;
              continue;
          }
        case BEGIN:
          switch (c) {
            case '<'.code:
              state = IGNORE_WHITESPACE;
              next = OPEN_NODE;
              addToken(OPEN_ANGLE_BRACKET);
            default:
          }
        case OPEN_NODE:
          switch (c) {
            case '/'.code:
              start = pos + 1;
              state = IGNORE_WHITESPACE;
              next = CLOSE_NODE;
              addToken(CLOSE_SLASH);
            default:
              state = TAG_NAME;
              start = pos;
              continue;
          }
        case TAG_NAME:
          if (!isValidChar(c)) {
            if (pos == start)
              error("Expected node name", pos);
            var tagName = body.substr(start, pos - start);
            addToken(WORD(tagName));
            state = IGNORE_WHITESPACE;
            next = OPEN_NODE_AFTER_TAG_NAME;
            continue;
          }
        case OPEN_NODE_AFTER_TAG_NAME:
          switch (c) {
            case '<'.code:
              error('Unexpected token "<"', pos);
            case '/'.code:
              addToken(CLOSE_SLASH);
              state = CLOSE_NODE_AFTER_TAG_NAME;
              next = IGNORE_WHITESPACE;
              start = pos + 1;
              continue;
            case '>'.code:
              addToken(CLOSE_ANGLE_BRACKET);
              state = IGNORE_WHITESPACE;
              next = BODY;
              start = pos + 1;
              continue;
            default:
              state = ATTRIBUTE_NAME;
              next = OPEN_NODE_AFTER_TAG_NAME;
              start = pos;
              continue;
          }
        case ATTRIBUTE_NAME:
          if (!isValidChar(c)) {
            var attrName = body.substr(start, pos - start);
            addToken(WORD(attrName));
            state = IGNORE_WHITESPACE;
            next = ATTRIBUTE_NAME_DONE;
            continue;
          }
        case ATTRIBUTE_NAME_DONE:
          switch (c) {
            case '='.code:
              addToken(EQUALS);
              state = ATTRIBUTE_VALUE;
              next = OPEN_NODE_AFTER_TAG_NAME;
            default:
              state = IGNORE_WHITESPACE;
              next = OPEN_NODE_AFTER_TAG_NAME;
          }
          continue;
        case ATTRIBUTE_VALUE:
          switch (c) {
            case '{'.code:
              addToken(OPEN_VARIABLE);
              start = pos + 1;
              state = ATTRIBUTE_VALUE_VARIABLE;
              varDepth = 0;
          }
        case ATTRIBUTE_VALUE_VARIABLE:
          switch (c) {
            case '{'.code:
              varDepth += 1;
            case '}'.code:
              varDepth -= 1;
              if (varDepth < 0) {
                var content = body.substr(start, pos - start);
                addToken(TEXT(content));
                addToken(CLOSE_VARIABLE);
                state = IGNORE_WHITESPACE;
                next = OPEN_NODE_AFTER_TAG_NAME;
                start = pos + 1;
              }
          }
        case CLOSE_NODE_AFTER_TAG_NAME:
          switch (c) {
            case '>'.code:
              addToken(CLOSE_ANGLE_BRACKET);
              state = IGNORE_WHITESPACE;
              next = BODY;
              start = pos + 1;
              continue;
          }
        case CLOSE_NODE:
          if (!isValidChar(c)) {
            if (pos == start)
              error("Expected node name", pos);
            var tagName = body.substr(start, pos - start);
            addToken(WORD(tagName));
            state = IGNORE_WHITESPACE;
            next = CLOSE_NODE_AFTER_TAG_NAME;
            continue;
          }
        case BODY:
          switch (c) {
            case '<'.code:
              var content = body.substr(start, pos - start);
              if (content.length > 0) {
                addToken(TEXT(content));
              }
              addToken(OPEN_ANGLE_BRACKET);

              state = IGNORE_WHITESPACE;
              next = OPEN_NODE;
              c = body.fastCodeAt(++pos);
              continue;
            case '{'.code:
              var content = body.substr(start, pos - start);
              if (StringTools.trim(content).length > 0) {
                addToken(TEXT(content));
              }
              addToken(OPEN_VARIABLE);
              start = pos + 1;
              state = BODY_VARIABLE;
              varDepth = 0;
            default:
          }
        case BODY_VARIABLE:
          if (start == pos && body.substr(start, 3) == 'if ') {
            addToken(OPEN_IF);
            start = pos + 3;
          } else if (start == pos && c == '/'.code && body.substr(start, 3) == '/if') {
            addToken(CLOSE_IF);
            start = pos + 4;
          } else if (start == pos && body.substr(start, 4) == 'for ') {
            addToken(OPEN_FOR);
            start = pos + 4;
          } else if (start == pos && c == '/'.code && body.substr(start, 4) == '/for') {
            addToken(CLOSE_FOR);
            start = pos + 5;
          }
          switch (c) {
            case '{'.code:
              varDepth += 1;
            case '}'.code:
              varDepth -= 1;
              if (varDepth < 0) {
                var content = body.substr(start, pos - start);
                if (pos - start > 0) {
                  addToken(TEXT(content));
                }
                addToken(CLOSE_VARIABLE);
                state = BODY;
                start = pos + 1;
              }
            default:
          }
      }

      c = body.fastCodeAt(++pos);
    }
  }

  function addToken(token:TOKEN) {
    tokens.push(token);
  }

  static inline function isValidChar(c) {
    return (c >= 'a'.code && c <= 'z'.code) || (c >= 'A'.code && c <= 'Z'.code) || (c >= '0'.code && c <= '9'.code) || c == ':'.code || c == '.'.code
      || c == '_'.code || c == '-'.code;
  }

  function error(msg:String, position:Int, pmax = -1):Dynamic {
    var lines = body.substr(0, pos).split('\n');
    var line = lines.length - 1;
    var col = lines.pop().length;
    throw new TokenizeError(msg, line, col);
    return null;
  }
}
