package rehax.builder;

using StringTools;

import haxe.macro.Context;
import haxe.macro.Expr;
import haxe.macro.TypeTools;

using rehax.components.fragment.Fragment;
using rehax.builder.Tokenizer;

enum SYNTAX_NODE {
  OPEN_NODE(name:String);
  CLOSE_NODE(name:String);
  // OPEN_CLOSE_NODE(name: String);
  TEXT(content:String);
  // ATTR_(name: String);
  ATTR_VAR(attributeName:String, value:String);
  VARIABLE(name:String);
  OPEN_IF(condition:String);
  CLOSE_IF;
  OPEN_FOR(iterator:String);
  CLOSE_FOR;
}

enum PARSE_STATE {
  BEGIN;
  OPEN_TAG;
  CLOSE_TAG;
}

enum AstNodeType {
  Root;
  Node(name:String);
  Text(content:String);
  Variable(content:String);
  Condition(condition:String);
  Loop(iterator:String);
}

enum AstNodeAttribute {
  Variable(content:String);
  StringValue(content:String);
}

typedef AstNode = {
  var type:AstNodeType;
  var parent:Null<AstNode>;
  var children:Array<AstNode>;
  var attributes:Map<String, AstNodeAttribute>;
};

class Parser {
  public function new(tokens:Array<TOKEN>) {
    this.tokens = tokens;
  }

  public var tokens:Array<TOKEN> = [];

  var rootNode:AstNode;

  public function parse() {
    var simplified = simplifyTokens();
    rootNode = doParse(simplified);
    return rootNode;
  }

  public function simplifyTokens() {
    var nodes:Array<SYNTAX_NODE> = [];
    var remaining = tokens;

    while (remaining.length > 0) {
      var proceedBy = 0;
      switch (remaining) {
        case remaining.slice(0, 3) => [OPEN_ANGLE_BRACKET, WORD(name), CLOSE_ANGLE_BRACKET]:
          nodes.push(OPEN_NODE(name));
          proceedBy = 3;
        case remaining.slice(0, 4) => [OPEN_ANGLE_BRACKET, WORD(name), CLOSE_SLASH, CLOSE_ANGLE_BRACKET]:
          nodes.push(OPEN_NODE(name));
          nodes.push(CLOSE_NODE(name));
          proceedBy = 4;
        case remaining.slice(0, 4) => [OPEN_ANGLE_BRACKET, CLOSE_SLASH, WORD(name), CLOSE_ANGLE_BRACKET]:
          nodes.push(CLOSE_NODE(name));
          proceedBy = 4;
        case remaining.slice(0, 3) => [OPEN_ANGLE_BRACKET, WORD(name), WORD(_)]:
          var isClose = false;
          remaining.splice(0, 2);
          var attrs:Array<SYNTAX_NODE> = [];
          while (remaining[0] != CLOSE_ANGLE_BRACKET) {
            switch (remaining) {
              case remaining.slice(0, 5) => [WORD(attr), EQUALS, OPEN_VARIABLE, TEXT(variable), CLOSE_VARIABLE]:
                proceedBy = 5;
                attrs.push(ATTR_VAR(attr, variable));
              // case remaining.slice(0, 3) => [WORD(attr), EQUALS, WORD]:
              // proceedBy = 3;
              case remaining.slice(0, 1) => [WORD(attr)]:
                proceedBy = 1;
                attrs.push(ATTR_VAR(attr, 'true'));
              case remaining.slice(0, 1) => [CLOSE_SLASH]:
                isClose = true;
                proceedBy = 1;
              default:
            }
            remaining.splice(0, proceedBy);
          }
          proceedBy = 1;
          nodes.push(OPEN_NODE(name));
          for (attr in attrs) {
            nodes.push(attr);
          }
          if (isClose) {
            nodes.push(CLOSE_NODE(name));
          }
        case remaining.slice(0, 1) => [TEXT(content)]:
          nodes.push(TEXT(content));
          proceedBy = 1;
        case remaining.slice(0, 4) => [OPEN_VARIABLE, OPEN_IF, TEXT(content), CLOSE_VARIABLE]:
          nodes.push(OPEN_IF(content));
          proceedBy = 4;
        case remaining.slice(0, 3) => [OPEN_VARIABLE, CLOSE_IF, CLOSE_VARIABLE]:
          nodes.push(CLOSE_IF);
          proceedBy = 3;
        case remaining.slice(0, 4) => [OPEN_VARIABLE, OPEN_FOR, TEXT(content), CLOSE_VARIABLE]:
          nodes.push(OPEN_FOR(content));
          proceedBy = 4;
        case remaining.slice(0, 3) => [OPEN_VARIABLE, CLOSE_FOR, CLOSE_VARIABLE]:
          nodes.push(CLOSE_FOR);
          proceedBy = 3;
        case remaining.slice(0, 3) => [OPEN_VARIABLE, TEXT(content), CLOSE_VARIABLE]:
          nodes.push(VARIABLE(content));
          proceedBy = 3;
        default:
          // error
          proceedBy = 1;
      }

      remaining.splice(0, proceedBy);
    }
    // trace(nodes);
    return nodes;
  }

  public function doParse(nodes:Array<SYNTAX_NODE>):AstNode {
    var root:AstNode = {
      type: Root,
      parent: null,
      children: [],
      attributes: [],
    };
    var stack = [root];
    var remaining = nodes;
    function getParent() {
      var parent = stack[stack.length - 1];
      if (Type.enumEq(parent.type, Node('ForEach')) || Type.enumEq(parent.type, Node('If'))) {
        parent = stack[stack.length - 2];
      }
      return parent;
    }
    while (remaining.length > 0) {
      switch (remaining[0]) {
        case OPEN_NODE(name):
          var next:AstNode = {
            type: Node(name),
            children: [],
            attributes: [],
            parent: getParent(),
          };
          stack[stack.length - 1].children.push(next);
          stack.push(next);
        case ATTR_VAR(name, value):
          stack[stack.length - 1].attributes[name] = Variable(value);
        case TEXT(name):
          var next:AstNode = {
            type: Text(name),
            children: [],
            attributes: [],
            parent: getParent(),
          };
          stack[stack.length - 1].children.push(next);
        case VARIABLE(name):
          var next:AstNode = {
            type: Variable(name),
            children: [],
            attributes: [],
            parent: getParent(),
          };
          stack[stack.length - 1].children.push(next);
        case CLOSE_NODE(name):
          stack.pop();
        case OPEN_IF(condition):
          var next:AstNode = {
            type: Condition(condition),
            children: [],
            attributes: [],
            parent: getParent(),
          };
          stack[stack.length - 1].children.push(next);
          stack.push(next);
        case CLOSE_IF:
          stack.pop();
        case OPEN_FOR(iterator):
          var next:AstNode = {
            type: Loop(iterator),
            children: [],
            attributes: [],
            parent: getParent(),
          };
          stack[stack.length - 1].children.push(next);
          stack.push(next);
        case CLOSE_FOR:
          stack.pop();
      }

      remaining.shift();
    }
    return root;
  }
}
