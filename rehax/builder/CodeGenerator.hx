package rehax.builder;

using StringTools;

import haxe.macro.Context;
import haxe.macro.Expr;
import haxe.macro.TypeTools;

using rehax.builder.PartsGenerator;

typedef GenerateResult = {
  var variables:Array<Field>;
  var functions:Array<Field>;
}

typedef TaggedExpr = {
  var expr:Expr;
  var tags:Array<String>;
}

class CodeGenerator {
  public function new() {}

  function getTypeName(typeName:String) {
    switch (typeName) {
      case 'Variable':
        return 'Text';
      default:
        return typeName;
    }
  }

  public function generateCode(parts:Array<VariableDefinition>):GenerateResult {
    var result:GenerateResult = {
      variables: [],
      functions: [],
    };

    function compileVariableDef(parts:Array<VariableDefinition>):Array<Field> {
      return parts.map(part -> {
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
        }
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

    result.variables.push(_bodyDef);

    // function printBodyDef(def, parent = '') {
    // 	switch (def.kind) {
    // 		case FieldType.FVar(t, _):
    // 			switch (t) {
    // 				case TAnonymous(fields):
    // 					for (f in fields) printBodyDef(f, parent + '.' + def.name);
    // 				case TPath(t):
    // 					switch (t.name) {
    // 						case 'Array':
    // 							switch(t.params[0]) {
    // 								case TPType(t):
    // 									switch (t) {
    // 										case TAnonymous(fields):
    // 											for (f in fields) printBodyDef(f, parent + '.' + def.name + '[_]');
    // 										default:
    // 									}
    // 								default:
    // 							}
    // 							// trace(t.params[0]);
    // 							// printBodyDef(t.params[0], parent + '.' + def.name);
    // 						default:
    // 							trace(parent + '.' + def.name, t);
    // 					}
    // 				default:
    // 			}

    // 		default:
    // 	}
    // }

    // printBodyDef(_bodyDef);

    function compile(createExprs:Array<TaggedExpr>, mountExprs:Array<TaggedExpr>, updateExprs:Array<TaggedExpr>, unmountExprs:Array<TaggedExpr>,
        parts:Array<VariableDefinition>, parentPart:Null<VariableDefinition> = null, parentVarName:String, parentVarAccessor:String, depth = 0) {
      var isTopLevel = parentPart == null;
      var names:Array<Array<String>> = [];

      var incrMountIndex = {expr: Context.parse('mountIndices[mountIndices.length - 1]++;', Context.currentPos()), tags: ['MountIndex']};
      var pushMountIndex = {expr: Context.parse('mountIndices.push(0);', Context.currentPos()), tags: ['MountIndex']};
      var popMountIndex = {expr: Context.parse('mountIndices.pop();', Context.currentPos()), tags: ['MountIndex']};

      if (isTopLevel) {
        mountExprs.push({expr: Context.parse('this.parent = parent;', Context.currentPos()), tags: ['TopLevelVarDecl']});
        mountExprs.push({expr: Context.parse('var mountIndices:Array<Int> = [0];', Context.currentPos()), tags: ['TopLevelVarDecl']});
        updateExprs.push({expr: Context.parse('var mountIndices:Array<Int> = [0];', Context.currentPos()), tags: ['TopLevelVarDecl']});
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

        updateExprs.push({expr: Context.parse('var $varName = $varAccessor;', Context.currentPos()), tags: ['VarDecl']});
        for (_ in 0...part.pushMountIndexCount) {
          mountExprs.push(pushMountIndex);
          updateExprs.push(pushMountIndex);
        }

        if (part.typeName != null) {
          var typeName = getTypeName(part.typeName);
          createExprs.push({expr: Context.parse('var $varName = new $typeName();', Context.currentPos()), tags: ['VarDecl']});
          createExprs.push({expr: Context.parse('$varName.createFragment();', Context.currentPos()), tags: ['CreateFragment']});
          if (part.content != null) {
            var content = part.content;
            if (part.typeName == 'Variable') {
              createExprs.push({expr: Context.parse('$varName.text = \'$${${StringTools.trim(content)}}\';', Context.currentPos()), tags: ['PropAssignment']});
              updateExprs.push({expr: Context.parse('$varAccessor.text = \'$${${StringTools.trim(content)}}\';', Context.currentPos()), tags: ['PropAssignment']});
            } else if (part.typeName == 'Text') {
              createExprs.push({expr: Context.parse('$varName.text = \'${StringTools.trim(content)}\';', Context.currentPos()), tags: ['PropAssignment']});
            }
          }
          for (attr => value in part.attributes) {
            switch (value) {
              case Variable(content):
                createExprs.push({expr: Context.parse('$varName.$attr = $content;', Context.currentPos()), tags: ['PropAssignment']});
                updateExprs.push({expr: Context.parse('$varAccessor.$attr = $content;', Context.currentPos()), tags: ['PropAssignment']});
              case StringValue(content):
                var setExpr = {expr: Context.parse('$varName.$attr = $content;', Context.currentPos()), tags: ['PropAssignment']};
                createExprs.push(setExpr);
            }
          }

          mountExprs.push({
            expr: Context.parse('$varAccessor.mount(${part.mountPoint}, mountIndices[mountIndices.length - 1]);', Context.currentPos()),
            tags: ['Mount']
          });
          unmountExprs.push({expr: Context.parse('$varAccessor.unmount();', Context.currentPos()), tags: ['Unmount']});

          mountExprs.push(incrMountIndex);
          updateExprs.push(incrMountIndex);
        } else {
          if (part.isArray) {
            createExprs.push({expr: Context.parse('var __rehax_$depth = 0;', Context.currentPos()), tags: ['VarDecl']});
            mountExprs.push({expr: Context.parse('var __rehax_$depth = 0;', Context.currentPos()), tags: ['VarDecl']});
            updateExprs.push({expr: Context.parse('var __rehax_$depth = 0;', Context.currentPos()), tags: ['VarDecl']});
            createExprs.push({expr: Context.parse('var $varName = [];', Context.currentPos()), tags: ['VarDecl']});

            var childCreateExpressions:Array<TaggedExpr> = [];
            var childMountExpressions:Array<TaggedExpr> = [];
            var childUpdateExpressions:Array<TaggedExpr> = [];
            var childUnmountExpressions:Array<TaggedExpr> = [];

            compile(childCreateExpressions, childMountExpressions, childUpdateExpressions, childUnmountExpressions, part.children, part, varName,
              varAccessor, depth + 1);

            createExprs.push({
              expr: {
                expr: EFor(Context.parse(part.content, Context.currentPos()), macro $b{
                  childCreateExpressions.map(expr -> expr.expr).concat([Context.parse('__rehax_$depth++;', Context.currentPos())])
                }),
                pos: Context.currentPos()
              },
              tags: ['ForCreate']
            });
            mountExprs.push({
              expr: {
                expr: EFor(Context.parse('_ in $varAccessor', Context.currentPos()), macro $b{
                  childMountExpressions.map(expr -> expr.expr).concat([Context.parse('__rehax_$depth++;', Context.currentPos())])
                }),
                pos: Context.currentPos()
              },
              tags: ['ForMount']
            });
            updateExprs.push({
              expr: {
                expr: EFor(Context.parse(part.content, Context.currentPos()), {
                  expr: EBlock([
                    {
                      expr: EIf(Context.parse('__rehax_$depth >= $varAccessor.length', Context.currentPos()), macro $b{
                        childCreateExpressions.map(expr -> expr.expr).concat(childMountExpressions.map(expr -> expr.expr))
                      }, macro $b{childUpdateExpressions.map(expr -> expr.expr)}),
                      pos: Context.currentPos()
                    }
                  ].concat([Context.parse('__rehax_$depth++;', Context.currentPos())])),
                  pos: Context.currentPos()
                }),
                pos: Context.currentPos()
              },
              tags: ['ForCreate']
            });
            updateExprs.push({
              expr: {
                expr: EWhile(Context.parse('$varAccessor.length > __rehax_$depth', Context.currentPos()), {
                  expr: EBlock(childUnmountExpressions.map(expr -> expr.expr)),
                  pos: Context.currentPos()
                }, true),
                pos: Context.currentPos()
              },
              tags: ['ForUnmount']
            });
            unmountExprs.push({
              expr: {
                expr: EWhile(Context.parse('$varAccessor.length > 0', Context.currentPos()), macro $b{
                  [
                    Context.parse('var __rehax_$depth = $varAccessor.length - 1;', Context.currentPos()),
                  ].concat(childUnmountExpressions.map(expr -> expr.expr))
                }, true),
                pos: Context.currentPos()
              },
              tags: ['ForUnmount']
            });
          } else {
            createExprs.push({expr: Context.parse('var $varName = null;', Context.currentPos()), tags: ['VarDeclr']});

            var childCreateExpressions:Array<TaggedExpr> = [];
            var childMountExpressions:Array<TaggedExpr> = [];
            var childUnmountExpressions:Array<TaggedExpr> = [];
            var childUpdateExpressions:Array<TaggedExpr> = [];

            compile(childCreateExpressions, childMountExpressions, childUpdateExpressions, childUnmountExpressions, part.children, part, varName,
              varAccessor, depth + 1);

            createExprs.push({
              expr: {
                expr: EIf(Context.parse(part.content, Context.currentPos()), macro $b{childCreateExpressions.map(expr -> expr.expr)}, null),
                pos: Context.currentPos()
              },
              tags: ['IfCreate']
            });
            mountExprs.push({
              expr: {
                expr: EIf(Context.parse('$varAccessor != null', Context.currentPos()), macro $b{childMountExpressions.map(expr -> expr.expr)},
                  null),
                pos: Context.currentPos()
              },
              tags: ['IfMount']
            });
            updateExprs.push({expr: Context.parse('var cond = ${part.content};', Context.currentPos()), tags: ['IfUpdate']});
            updateExprs.push({
              expr: {
                expr: EIf(Context.parse('cond', Context.currentPos()), macro $b{
                  [
                    {
                      expr: EIf(Context.parse('$varAccessor == null', Context.currentPos()), macro $b{
                        childCreateExpressions.map(expr -> expr.expr)
                          .concat([Context.parse('$varAccessor = result;', Context.currentPos())])
                          .concat(childMountExpressions.map(expr -> expr.expr))}, macro $b{
                          childUpdateExpressions.map(expr -> expr.expr)
                        }),
                      pos: Context.currentPos()
                    }
                  ]
                }, {
                  expr: EIf(Context.parse('$varAccessor != null', Context.currentPos()), macro $b{
                    childUnmountExpressions.map(expr -> expr.expr).concat([Context.parse('$varAccessor = null', Context.currentPos())])
                  }, null),
                  pos: Context.currentPos()
                }),
                pos: Context.currentPos()
              },
              tags: ['IfUpdate']
            });
            unmountExprs.push({
              expr: {
                expr: EIf(Context.parse('$varAccessor != null', Context.currentPos()),
                  macro $b{childUnmountExpressions.map(expr -> expr.expr)}, null),
                pos: Context.currentPos()
              },
              tags: ['IfUnmount']
            });
            unmountExprs.push({expr: Context.parse('$varAccessor = null', Context.currentPos()), tags: ['IfUnmount']});
          }
        }

        for (_ in 0...part.popMountIndexCount) {
          mountExprs.push(popMountIndex);
          updateExprs.push(popMountIndex);
        }
      }

      var bodyResult = '{' + names.map(name -> name[0] + ':' + name[1]).join(',') + '}';
      createExprs.push({
        expr: Context.parse('var result = ' + bodyResult + ';', Context.currentPos()),
        tags: ['VarAssignment', 'Result']
      });
      if (isTopLevel) {
        createExprs.push({expr: Context.parse('_body = $bodyResult;', Context.currentPos()), tags: ['VarAssignment', 'Body']});
      } else if (parentPart != null && parentPart.isArray) {
        createExprs.push({expr: Context.parse('${parentVarName}.push($bodyResult);', Context.currentPos()), tags: ['VarAssignment']});
        unmountExprs.push({expr: Context.parse('${parentVarAccessor}.splice(__rehax_${depth - 1}, 1);', Context.currentPos()), tags: ['ForUnmount']});
      } else {
        createExprs.push({expr: Context.parse('${parentVarName} = $bodyResult;', Context.currentPos()), tags: ['VarAssignment']});
      }

      if (isTopLevel) {
        mountExprs.push({expr: Context.parse('this.componentDidMount();', Context.currentPos()), tags: ['Mount']});
        unmountExprs.push({expr: Context.parse('this.parent = null;', Context.currentPos()), tags: ['Unmount']});
      }
    }

    var createExprs = [];
    var mountExprs = [];
    var updateExprs = [];
    var unmountExprs = [];

    compile(createExprs, mountExprs, updateExprs, unmountExprs, parts, 'body', '_body');

    result.functions.push({
      name: 'createFragment',
      access: [Access.APublic, Access.AOverride],
      kind: FFun({
        params: [],
        args: [],
        expr: macro $b{createExprs.map(expr -> expr.expr)},
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
        expr: macro $b{mountExprs.map(expr -> expr.expr)},
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
        expr: macro $b{updateExprs.map(expr -> expr.expr)},
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
        expr: macro $b{unmountExprs.map(expr -> expr.expr)},
        ret: macro:Void,
      }),
      pos: Context.currentPos(),
    });

    return result;
  }
}
