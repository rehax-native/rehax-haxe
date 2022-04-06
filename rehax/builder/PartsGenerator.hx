package rehax.builder;

using StringTools;

import haxe.macro.Context;
import haxe.macro.Expr;
import haxe.macro.TypeTools;

using rehax.builder.Parser;

typedef VariableDefinition = {
  var variableName:String;
  var typeName:Null<String>;
  var mountPoint:String;
  var pushMountIndexCount:Int;
  var popMountIndexCount:Int;
  var content:Null<String>;
  var isArray:Bool;
  var children:Null<Array<VariableDefinition>>;
  var attributes:Map<String, AstNodeAttribute>;
}

class PartsGenerator {
  public function new() {}

  public function generateVariableDefinitions(root:AstNode):Array<VariableDefinition> {
    var result:Array<VariableDefinition> = [];
    varPaths = [{n: 0, nArray: null}];
    mountPoints = ['this.parent'];
    generateVariableDefinitionsRecursive(root, result);

    return result;
  }

  var varPaths:Array<{n:Int, nArray:Null<Int>}> = [];
  var mountPoints:Array<String> = [];

  function generateVariableDefinitionsRecursive(root:AstNode, result:Array<VariableDefinition>, isParentArray = false, arraysCount = 0) {
    var part:Null<VariableDefinition> = null;
    var nextChildren = root.children;
    var varName = 'v_' + Std.string(result.length);

    var varAccessor = '_body.' + varPaths.map(p -> 'v_' + p.n + (p.nArray != null ? '[__rehax_${p.nArray}]' : '')).join('.');
    var mountPointPath = mountPoints[mountPoints.length - 1];

    switch (root.type) {
      case Root:
        varAccessor = 'this.parent';
      case Node(name):
        varPaths[varPaths.length - 1].n++;
        part = {
          variableName: varName,
          content: null,
          typeName: name,
          mountPoint: mountPointPath,
          pushMountIndexCount: 0,
          popMountIndexCount: 0,
          isArray: false,
          children: null,
          attributes: root.attributes,
        };
      case Text(content):
        varPaths[varPaths.length - 1].n++;
        part = {
          variableName: varName,
          typeName: 'Text',
          mountPoint: mountPointPath,
          pushMountIndexCount: 0,
          popMountIndexCount: 0,
          content: content,
          isArray: false,
          children: null,
          attributes: root.attributes,
        };
        if (content.trim().length == 0) {
          part = null;
          varPaths[varPaths.length - 1].n--;
        }
      case Variable(content):
        varPaths[varPaths.length - 1].n++;
        part = {
          variableName: varName,
          typeName: 'Variable',
          mountPoint: mountPointPath,
          pushMountIndexCount: 0,
          popMountIndexCount: 0,
          content: content,
          isArray: false,
          children: null,
          attributes: root.attributes,
        };
      case Condition(condition):
        part = {
          variableName: varName,
          typeName: null,
          mountPoint: mountPointPath,
          pushMountIndexCount: 0,
          popMountIndexCount: 0,
          content: condition,
          isArray: false,
          children: [],
          attributes: root.attributes,
        }

        varPaths.push({n: 0, nArray: null});
        for (child in root.children) {
          generateVariableDefinitionsRecursive(child, part.children, isParentArray, arraysCount);
        }
        varPaths.pop();

        nextChildren = [];
      case Loop(iterator):
        part = {
          variableName: varName,
          typeName: null,
          mountPoint: mountPointPath,
          pushMountIndexCount: 0,
          popMountIndexCount: 0,
          content: iterator,
          isArray: true,
          children: [],
          attributes: root.attributes,
        }

        varPaths[varPaths.length - 1].nArray = arraysCount;
        varPaths.push({n: 0, nArray: null});
        for (child in root.children) {
          generateVariableDefinitionsRecursive(child, part.children, true, arraysCount + 1);
        }
        varPaths.pop();
        varPaths[varPaths.length - 1].nArray = null;

        nextChildren = [];
    }
    if (part != null) {
      result.push(part);
    }

    var i = 0;
    var len = result.length;
    mountPoints.push(varAccessor);
    for (child in nextChildren) {
      generateVariableDefinitionsRecursive(child, result);
      if (root.type != Root && result.length > len && i == 0) {
        result[len].pushMountIndexCount++;
      }
      if (root.type != Root && result.length > len && i == nextChildren.length - 1) {
        result[result.length - 1].popMountIndexCount++;
      }
      i++;
    }
    mountPoints.pop();
  }
}
