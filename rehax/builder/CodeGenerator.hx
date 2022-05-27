package rehax.builder;

using StringTools;

import haxe.macro.Context;
import haxe.macro.Expr;
import haxe.macro.TypeTools;

using rehax.builder.PartsGenerator;

enum GeneratorExpression {
  DeclareMountIndex;
  PushMountIndex;
  PopMountIndex;
  IncrMountIndex;
  Mount(varAccessor:String, mountPoint:String);
  UnMount(varAccessor:String);
  ComponentDidMountSelf;
  AssignSelfParent;
  SetSelfParentNull;
  IncrIterator(varName:String);
  ResultBodyPush(varName:String, body:String);

  DeclareLocalVariable(varName:String, varAccessor:String);
  CreateNewComponent(varName:String, typeName:String);
  CreateComponentFragment(varName:String);
  ResultBodyDeclaration(varName:String, body:String);
  ResultBodyAssignment(body:String);
  SetItemToNull(varName:String);
  PopLast(varName:String);

  AssignText(varName:String, content:String);
  AssignVariableText(varName:String, content:String);
  AssignAttribute(varAccessor:String, attributeName:String, attributeContent:String);
  AssignVariable(varAccessor:String, varName:String);
  AssignSlot(slotName:String, varAccessor:String);
  CallRef(varAccessor:String, callback:String);

  Conditional(condition:String, ifExpressions:Array<GeneratorExpression>, elseExpressions:Array<GeneratorExpression>);
  Loop(iterator:String, expressions:Array<GeneratorExpression>);
  While(condition:String, expressions:Array<GeneratorExpression>);
}

#if macro

function checkVarAccessorPartForNull(varAccessor:String) {
  var parts = varAccessor.split('.');
  var current = parts[0];
  var checker = '$current != null';
  for (i in 1...parts.length) {
    checker += ' && $current.' + parts[i] + ' != null';
  }
  return checker;
}

/** Convert a GeneratorExpression into a haxe macro expression, used to actually create the code. **/
function convertExpression(expr:GeneratorExpression) {
  switch (expr) {
    case DeclareMountIndex:
      return Context.parse('var mountIndices:Array<Int> = [0];', Context.currentPos());
    case IncrMountIndex:
      return Context.parse('mountIndices[mountIndices.length - 1]++;', Context.currentPos());
    case PushMountIndex:
      return Context.parse('mountIndices.push(0);', Context.currentPos());
    case PopMountIndex:
      return Context.parse('mountIndices.pop();', Context.currentPos());
    case AssignSelfParent:
      return Context.parse('this.parent = parent;', Context.currentPos());
    case SetSelfParentNull:
      return Context.parse('this.parent = null;', Context.currentPos());
    case Mount(varAccessor, mountPoint):
      return Context.parse('$varAccessor.mount(${mountPoint}, mountIndices[mountIndices.length - 1]);', Context.currentPos());
    case UnMount(varAccessor):
      return Context.parse('$varAccessor.unmount();', Context.currentPos());
    case ComponentDidMountSelf:
      return Context.parse('this.componentDidMount();', Context.currentPos());
    case SetItemToNull(varName):
      return Context.parse('$varName = null', Context.currentPos());
    case PopLast(varName):
      // unmountExprs.push(Raw({expr: Context.parse('${parentVarAccessor}.splice(__rehax_${depth - 1}, 1);', Context.currentPos()), tags: ['ForUnmount']}));
      return Context.parse('$varName.pop()', Context.currentPos());
    case IncrIterator(varName):
      return Context.parse('$varName++;', Context.currentPos());

    case DeclareLocalVariable(varName, varAccessor):
        return Context.parse('var $varName = $varAccessor;', Context.currentPos());
    case CreateNewComponent(varName, typeName):
      return Context.parse('var $varName = new $typeName();', Context.currentPos());
    case CreateComponentFragment(varName):
      return Context.parse('$varName.createFragment();', Context.currentPos());
    case ResultBodyDeclaration(varName, body):
      return Context.parse('$varName = ' + body + ';', Context.currentPos());
    case ResultBodyAssignment(bodyResult):
      return Context.parse('_body = $bodyResult;', Context.currentPos());
    case AssignText(varName, content):
      return Context.parse('$varName.text = \'${StringTools.trim(content)}\';', Context.currentPos());
    case AssignVariableText(varName, content):
      return Context.parse('$varName.text = \'$${${StringTools.trim(content)}}\';', Context.currentPos());
    case AssignAttribute(varAccessor, attributeName, attributeContent):
      return Context.parse('$varAccessor.$attributeName = $attributeContent;', Context.currentPos());
    case AssignVariable(varAccessor, varName):
      return Context.parse('$varAccessor = $varName;', Context.currentPos());
    case AssignSlot(slotName, varAccessor):
      return Context.parse('slots["$slotName"] = $varAccessor;', Context.currentPos());
    case CallRef(varAccessor, callback):
      return macro $b{[
        Context.parse('var ref = $callback;', Context.currentPos()),
        Context.parse('ref(${checkVarAccessorPartForNull(varAccessor)} ? $varAccessor : null);', Context.currentPos()),
      ]};
    
    case Conditional(condition, ifExpressions, elseExpressions):
      return {
        expr: EIf(Context.parse(condition, Context.currentPos()), macro $b{ifExpressions.map(expr -> convertExpression(expr))}, elseExpressions == null ? null : macro $b{elseExpressions.map(expr -> convertExpression(expr))}),
        pos: Context.currentPos()
      };
    case Loop(iterator, expressions):
      return{
        expr: EFor(Context.parse(iterator, Context.currentPos()), macro $b{
          expressions.map(expr -> convertExpression(expr))
        }),
        pos: Context.currentPos()
      };
    case While(condition, expressions):
      return{
        expr: EWhile(Context.parse(condition, Context.currentPos()), macro $b{
          expressions.map(expr -> convertExpression(expr))
        }, true),
        pos: Context.currentPos()
      };
    case ResultBodyPush(varName, body):
      return Context.parse('${varName}.push($body);', Context.currentPos());
  }
}
#end

typedef GeneratedCode = {
  createExpressions: Array<GeneratorExpression>,
  updateExpressions: Array<GeneratorExpression>,
  mountExpressions: Array<GeneratorExpression>,
  unmountExpressions: Array<GeneratorExpression>,
}

typedef GenerateResult = {
  var variables:Array<Field>;
  var functions:Array<Field>;
}

class CodeGenerator {
  public function new() {}

  function getTypeName(typeName:String) {
    switch (typeName) {
      case 'Variable':
        return 'Text';
      case 'Slot':
        return 'Fragment';
      default:
        return typeName;
    }
  }

  public function generateCode(parts:Array<VariableDefinition>):GeneratedCode {

    var slotExprs:Array<GeneratorExpression> = [];
    var refExprs:Array<GeneratorExpression> = [];

		function compile(
      createExprs:Array<GeneratorExpression>,
      mountExprs:Array<GeneratorExpression>,
      updateExprs:Array<GeneratorExpression>,
			unmountExprs:Array<GeneratorExpression>,
      parts:Array<VariableDefinition>,
      parentPart:Null<VariableDefinition> = null,
      parentVarName:String,
			parentVarAccessor:String,
      depth = 0
    ) {

      var isTopLevel = parentPart == null;
      var names:Array<Array<String>> = [];

      if (isTopLevel) {
        mountExprs.push(AssignSelfParent);
        mountExprs.push(DeclareMountIndex);
        updateExprs.push(DeclareMountIndex);
      }

      for (part in parts) {
        var name = part.variableName;

        var varName = parentVarName + '_' + name;
        var varAccessor = parentVarAccessor + '.' + name;
        if (parentPart != null && parentPart.isArray) {
          varName = parentVarName + '__rehax_${depth - 1}_' + name;
          varAccessor = parentVarAccessor + '[__rehax_${depth - 1}].' + name;
        }

        names.push([name, varName]);

        for (_ in 0...part.pushMountIndexCount) {
          mountExprs.push(PushMountIndex);
          updateExprs.push(PushMountIndex);
        }

        var isSlot = part.typeName == 'Slot';

        updateExprs.push(DeclareLocalVariable(varName, varAccessor));

        if (part.typeName != null) {
          var typeName = getTypeName(part.typeName);

          if (isSlot) {
            slotExprs.push(CreateNewComponent(varName, typeName));
            slotExprs.push(CreateComponentFragment(varName));
            slotExprs.push(AssignSlot('default', varName));

            createExprs.push(DeclareLocalVariable(varName, 'cast slots["default"]'));
          } else {
            createExprs.push(CreateNewComponent(varName, typeName));
            createExprs.push(CreateComponentFragment(varName));
          }

          if (part.content != null) {
            var content = part.content;
            if (part.typeName == 'Variable') {
              createExprs.push(AssignVariableText(varName, content));
              updateExprs.push(AssignVariableText(varAccessor, content));
            } else if (part.typeName == 'Text') {
              createExprs.push(AssignText(varName, content));
            }
          }
          for (attr => value in part.attributes) {
            switch (value) {
              case Variable(content):
                if (attr == 'ref') {
                  refExprs.push(CallRef(varAccessor, content));
                } else {
                  createExprs.push(AssignAttribute(varName, attr, content));
                  updateExprs.push(AssignAttribute(varAccessor, attr, content));
                }
              case StringValue(content):
                createExprs.push(AssignAttribute(varName, attr, content));
            }
          }

          mountExprs.push(Mount(varAccessor, part.mountPoint));
          unmountExprs.unshift(UnMount(varAccessor));

          mountExprs.push(IncrMountIndex);
          updateExprs.push(IncrMountIndex);
        } else {
          if (part.isArray) {
            createExprs.push(DeclareLocalVariable('__rehax_$depth', '0'));
            createExprs.push(DeclareLocalVariable(varName, '[]'));
            mountExprs.push(DeclareLocalVariable('__rehax_$depth', '0'));
            updateExprs.push(DeclareLocalVariable('__rehax_$depth', '0'));

            var childCreateExpressions:Array<GeneratorExpression> = [];
            var childMountExpressions:Array<GeneratorExpression> = [];
            var childUpdateExpressions:Array<GeneratorExpression> = [];
            var childUnmountExpressions:Array<GeneratorExpression> = [];

            compile(
              childCreateExpressions,
              childMountExpressions,
              childUpdateExpressions,
              childUnmountExpressions,
              part.children,
              part,
              varName,
              varAccessor,
              depth + 1
            );

            createExprs.push(Loop(part.content, childCreateExpressions.concat([IncrIterator('__rehax_$depth')])));
            mountExprs.push(Loop('_ in $varAccessor', childMountExpressions.concat([IncrIterator('__rehax_$depth')])));
            updateExprs.push(Loop(part.content, [
              Conditional('__rehax_$depth >= $varAccessor.length', childCreateExpressions.concat(childMountExpressions), childUpdateExpressions),
            ].concat([IncrIterator('__rehax_$depth')])));

            updateExprs.push(While('$varAccessor.length > __rehax_$depth', childUnmountExpressions));
						unmountExprs.unshift(While('$varAccessor.length > 0', [DeclareLocalVariable('__rehax_$depth', '$varAccessor.length - 1')].concat(childUnmountExpressions)));
          } else {
            var childCreateExpressions:Array<GeneratorExpression> = [];
            var childMountExpressions:Array<GeneratorExpression> = [];
            var childUnmountExpressions:Array<GeneratorExpression> = [];
            var childUpdateExpressions:Array<GeneratorExpression> = [];

            compile(
              childCreateExpressions,
              childMountExpressions,
              childUpdateExpressions,
              childUnmountExpressions,
              part.children,
              part,
              varName,
              varAccessor,
              depth + 1
            );

            createExprs.push(DeclareLocalVariable(varName, 'null'));
            createExprs.push(Conditional(part.content, childCreateExpressions, null));

            updateExprs.push(
              Conditional(part.content, [
                Conditional('$varAccessor == null',
                  childCreateExpressions
                  .concat([AssignVariable(varAccessor, varName)])
                  .concat(childMountExpressions)
                  .concat(childUpdateExpressions),
                  null
                )
              ], [
                Conditional('$varAccessor != null', childUnmountExpressions.concat([
                  SetItemToNull(varAccessor),
                ]), null)
              ])
            );

            mountExprs.push(Conditional('$varAccessor != null && (${part.content})', childMountExpressions, null));
            unmountExprs.unshift(SetItemToNull(varAccessor));
            unmountExprs.unshift(Conditional('$varAccessor != null', childUnmountExpressions, null));
          }
        }

        for (_ in 0...part.popMountIndexCount) {
          mountExprs.push(PopMountIndex);
          updateExprs.push(PopMountIndex);
        }
      }

      var bodyResult = '{ ' + names.map(name -> name[0] + ': ' + name[1]).join(', ') + ' }';
      if (isTopLevel) {
        createExprs.push(ResultBodyAssignment(bodyResult));
      } else if (parentPart != null && parentPart.isArray) {
        createExprs.push(ResultBodyPush(parentVarName, bodyResult));
        unmountExprs.push(PopLast(parentVarAccessor));
      } else {
        createExprs.push(ResultBodyDeclaration(parentVarName, bodyResult));
      }

      if (isTopLevel) {
        mountExprs.push(ComponentDidMountSelf);
        unmountExprs.push(SetSelfParentNull);

        for (expr in refExprs) {
          mountExprs.push(expr);
        }
      }
    }

    var createExprs = [];
    var mountExprs = [];
    var updateExprs = [];
    var unmountExprs = [];

    compile(createExprs, mountExprs, updateExprs, unmountExprs, parts, 'body', '_body');

    slotExprs.reverse();
    for (expr in slotExprs) {
      createExprs.unshift(expr);
    }

    return {
      createExpressions: createExprs,
      mountExpressions: mountExprs,
      updateExpressions: updateExprs,
      unmountExpressions: unmountExprs,
    };
  }


#if macro
  public function convertGeneratedCodeToResult(parts:Array<VariableDefinition>, code:GeneratedCode):GenerateResult {
    var result:GenerateResult = {
      variables: [],
      functions: [],
    };

    function compileVariableDef(parts:Array<VariableDefinition>):Array<Field> {
      return parts
      .map(part -> {
        var kind = if (part.typeName != null) FieldType.FVar(TypeTools.toComplexType(Context.getType(getTypeName(part.typeName))),
          null) else if (part.isArray) FieldType.FVar(TPath({
          name: 'Array',
          params: [TPType(TAnonymous(compileVariableDef(part.children)))],
          pack: []
        }), null) else FieldType.FVar(TAnonymous(compileVariableDef(part.children)), null);

        return {
          name: part.variableName,
          access: [Access.APublic],
          kind: kind,
          pos: Context.currentPos(),
          doc: null,
          meta: null,
        };
      });
    }

    var _bodyDef = {
      name: '_body',
      access: [],
      kind: FieldType.FVar(TAnonymous(compileVariableDef(parts)), null),
      pos: Context.currentPos(),
      doc: null,
      meta: null,
    };

    function printBodyDef(def, parent = '') {
    	switch (def.kind) {
    		case FieldType.FVar(t, _):
    			switch (t) {
    				case TAnonymous(fields):
    					for (f in fields) printBodyDef(f, parent + '.' + def.name);
    				case TPath(t):
    					switch (t.name) {
    						case 'Array':
    							switch(t.params[0]) {
    								case TPType(t):
    									switch (t) {
    										case TAnonymous(fields):
    											for (f in fields) printBodyDef(f, parent + '.' + def.name + '[_]');
    										default:
    									}
    								default:
    							}
    							// trace(t.params[0]);
    							// printBodyDef(t.params[0], parent + '.' + def.name);
    						default:
    							trace(parent + '.' + def.name, t);
    					}
    				default:
    			}

    		default:
    	}
    }

    // Uncomment to debug the variable definition
    // printBodyDef(_bodyDef);

    result.variables.push(_bodyDef);

    result.functions.push({
      name: 'createFragment',
      access: [Access.APublic, Access.AOverride],
      kind: FFun({
        params: [],
        args: [],
        expr: macro $b{code.createExpressions.map(expr -> convertExpression(expr))},
        ret: macro:Void,
      }),
      pos: Context.currentPos(),
    });
    result.functions.push({
      name: 'mount',
      access: [Access.APublic, Access.AOverride],
      kind: FFun({
        params: [],
        args: [
          {
            name: "parent",
            opt: false,
            type: macro:rehax.components.view.View.View
          },
          {
            name: "atIndex",
            opt: true,
            type: macro:Null<Int>
          }
        ],
        expr: macro $b{code.mountExpressions.map(expr -> convertExpression(expr))},
        ret: macro:Void,
      }),
      pos: Context.currentPos(),
    });
    result.functions.push({
      name: 'updateViews',
      access: [Access.APublic],
      kind: FFun({
        params: [],
        args: [],
        expr: macro $b{code.updateExpressions.map(expr -> convertExpression(expr))},
        ret: macro:Void,
      }),
      pos: Context.currentPos(),
    });
    result.functions.push({
      name: 'unmount',
      access: [Access.APublic, Access.AOverride],
      kind: FFun({
        params: [],
        args: [],
        expr: macro $b{code.unmountExpressions.map(expr -> convertExpression(expr))},
        ret: macro:Void,
      }),
      pos: Context.currentPos(),
    });

    return result;
  }
#end

}
