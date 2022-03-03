package rehax.builder;

using StringTools;

import haxe.macro.Context;
import haxe.macro.Expr;
import haxe.macro.TypeTools;

using rehax.components.fragment.Fragment;
using rehax.components.view.View;
using rehax.builder.Tokenizer;
using rehax.builder.Parser;
using rehax.builder.PartsGenerator;
using rehax.builder.CodeGenerator;

class Builder {
  public static function build():Array<Field> {
    var fields = Context.getBuildFields();

    for (f in fields) {
      if (f.name == 'body') {
        switch f.kind {
          case FVar(null, {expr: EMeta(_, {expr: EConst(CString(body))})}):
            var tokenizer = new Tokenizer(body);
            tokenizer.tokenize();
            var parser = new Parser(tokenizer.tokens);
            var simplifiedTokens = parser.simplifyTokens();
            var parsed = parser.doParse(simplifiedTokens);
            var partsGenerator = new PartsGenerator();
            var genPartsResult = partsGenerator.generateVariableDefinitions(parsed);
            var codeGenerator = new CodeGenerator();
            var code = codeGenerator.generateCode(genPartsResult);

            fields.remove(f);

            addGeneratedCodeToFields(fields, code, f.pos);

          case _:
            trace('Not an inline template');
        }
      }
    }

    return fields;
  }

  static function addGeneratedCodeToFields(fields:Array<Field>, generated:GenerateResult, pos:Position) {
    for (field in generated.variables) {
      fields.push({
        name: field.name,
        access: [Access.APublic],
        kind: field.kind,
        pos: pos,
      });
    }

    for (fn in generated.functions) {
      fields.push(fn);
    }
  }
}
