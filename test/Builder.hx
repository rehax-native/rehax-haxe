package test;

import tink.unit.Assert.*;

using rehax.builder.Tokenizer;
using rehax.builder.Parser;
using rehax.builder.PartsGenerator;
using rehax.builder.CodeGenerator;

@:asserts
class Builder {
  public function new() {}

  @:variant('<View></View>', {
    createExpressions: [
        CreateNewComponent('body_v_0', 'View'),
        CreateComponentFragment('body_v_0'),
        ResultBodyAssignment('{ v_0: body_v_0 }'),
    ],
    mountExpressions: [
        AssignSelfParent,
        DeclareMountIndex,
        Mount('_body.v_0', 'this.parent'),
        IncrMountIndex,
        ComponentDidMountSelf,
    ],
    updateExpressions: [
        DeclareMountIndex,
        DeclareLocalVariable('body_v_0', '_body.v_0'),
        IncrMountIndex,
    ],
    unmountExpressions: [
        UnMount('_body.v_0'),
        SetSelfParentNull,
    ],
  })

  @:variant('<View attr={"henlo"}> My Text {"Yes"}</View>', {
    createExpressions: [
        CreateNewComponent('body_v_0', 'View'),
        CreateComponentFragment('body_v_0'),
        AssignAttribute('body_v_0', 'attr', '"henlo"'),
        CreateNewComponent('body_v_1', 'Text'),
        CreateComponentFragment('body_v_1'),
        AssignText('body_v_1', ' My Text '),
        CreateNewComponent('body_v_2', 'Text'),
        CreateComponentFragment('body_v_2'),
        AssignVariableText('body_v_2', '"Yes"'),
        ResultBodyAssignment('{ v_0: body_v_0, v_1: body_v_1, v_2: body_v_2 }'),
    ],
    mountExpressions: [
        AssignSelfParent,
        DeclareMountIndex,
        Mount('_body.v_0', 'this.parent'),
        IncrMountIndex,
        PushMountIndex,
        Mount('_body.v_1', '_body.v_0'),
        IncrMountIndex,
        Mount('_body.v_2', '_body.v_0'),
        IncrMountIndex,
        PopMountIndex,
        ComponentDidMountSelf,
    ],
    updateExpressions: [
        DeclareMountIndex,
        DeclareLocalVariable('body_v_0', '_body.v_0'),
        AssignAttribute('_body.v_0', 'attr', '"henlo"'),
        IncrMountIndex,
        PushMountIndex,
        DeclareLocalVariable('body_v_1', '_body.v_1'),
        IncrMountIndex,
        DeclareLocalVariable('body_v_2', '_body.v_2'),
        AssignVariableText('_body.v_2','"Yes"'),
        IncrMountIndex,
        PopMountIndex,
    ],
    unmountExpressions: [
        UnMount('_body.v_2'),
        UnMount('_body.v_1'),
        UnMount('_body.v_0'),
        SetSelfParentNull,
    ],
  })

  @:variant('<View> My Text {if iTellTheTruth} This doesn\'t show {/if}</View>', {
    createExpressions: [
        CreateNewComponent('body_v_0', 'View'),
        CreateComponentFragment('body_v_0'),

        CreateNewComponent('body_v_1', 'Text'),
        CreateComponentFragment('body_v_1'),
        AssignText('body_v_1', ' My Text '),

        DeclareLocalVariable('body_v_2', 'null'),
        Conditional('iTellTheTruth', [
            CreateNewComponent('body_v_2_v_0', 'Text'),
            CreateComponentFragment('body_v_2_v_0'),
            AssignText('body_v_2_v_0', ' This doesn\'t show '),
            ResultBodyDeclaration('body_v_2', '{ v_0: body_v_2_v_0 }'),
        ], null),

        ResultBodyAssignment('{ v_0: body_v_0, v_1: body_v_1, v_2: body_v_2 }'),
    ],
    mountExpressions: [
        AssignSelfParent,
        DeclareMountIndex,
        Mount('_body.v_0', 'this.parent'),
        IncrMountIndex,
        PushMountIndex,
        Mount('_body.v_1', '_body.v_0'),
        IncrMountIndex,
        Conditional('_body.v_2 != null', [
          Mount('_body.v_2.v_0', '_body.v_0'),
          IncrMountIndex,
        ], null),
        PopMountIndex,
        ComponentDidMountSelf,
    ],
    updateExpressions: [
        DeclareMountIndex,
        DeclareLocalVariable('body_v_0', '_body.v_0'),
        IncrMountIndex,
        PushMountIndex,
        DeclareLocalVariable('body_v_1', '_body.v_1'),
        IncrMountIndex,
        DeclareLocalVariable('body_v_2', '_body.v_2'),
        Conditional('iTellTheTruth', [
          Conditional('_body.v_2 == null', [
            CreateNewComponent('body_v_2_v_0', 'Text'),
            CreateComponentFragment('body_v_2_v_0'),
            AssignText('body_v_2_v_0', ' This doesn\'t show '),
            ResultBodyDeclaration('body_v_2', '{ v_0: body_v_2_v_0 }'),
            AssignVariable('_body.v_2', 'body_v_2'),
            Mount('_body.v_2.v_0', '_body.v_0'),
            IncrMountIndex,
            DeclareLocalVariable('body_v_2_v_0', '_body.v_2.v_0'),
            IncrMountIndex,
          ], null),
        ], [
          Conditional('_body.v_2 != null', [
            UnMount('_body.v_2.v_0'),
            SetItemToNull('_body.v_2'),
          ], null)
        ]),
        PopMountIndex,
    ],
    unmountExpressions: [
        Conditional('_body.v_2 != null', [
          UnMount('_body.v_2.v_0'),
        ], null),
        SetItemToNull('_body.v_2'),
        UnMount('_body.v_1'),
        UnMount('_body.v_0'),
        SetSelfParentNull,
    ],
  })

  @:variant('<View> My Text {for i in 0...4} Part {i} {/for}</View>', {
    createExpressions: [
        CreateNewComponent('body_v_0', 'View'),
        CreateComponentFragment('body_v_0'),

        CreateNewComponent('body_v_1', 'Text'),
        CreateComponentFragment('body_v_1'),
        AssignText('body_v_1', ' My Text '),

        DeclareLocalVariable('__rehax_0', '0'),
        DeclareLocalVariable('body_v_2', '[]'),
        Loop('i in 0...4', [
            CreateNewComponent('body_v_2__rehax_0_v_0', 'Text'),
            CreateComponentFragment('body_v_2__rehax_0_v_0'),
            AssignText('body_v_2__rehax_0_v_0', ' Part '),

            CreateNewComponent('body_v_2__rehax_0_v_1', 'Text'),
            CreateComponentFragment('body_v_2__rehax_0_v_1'),
            AssignVariableText('body_v_2__rehax_0_v_1', 'i'),

            ResultBodyPush('body_v_2', '{ v_0: body_v_2__rehax_0_v_0, v_1: body_v_2__rehax_0_v_1 }'),
            IncrIterator('__rehax_0'),
        ]),

        ResultBodyAssignment('{ v_0: body_v_0, v_1: body_v_1, v_2: body_v_2 }'),
    ],
    mountExpressions: [
        AssignSelfParent,
        DeclareMountIndex,
        Mount('_body.v_0', 'this.parent'),
        IncrMountIndex,
        PushMountIndex,
        Mount('_body.v_1', '_body.v_0'),
        IncrMountIndex,
        DeclareLocalVariable('__rehax_0', '0'),
        Loop('_ in _body.v_2', [
          Mount('_body.v_2[__rehax_0].v_0', '_body.v_0'),
          IncrMountIndex,
          Mount('_body.v_2[__rehax_0].v_1', '_body.v_0'),
          IncrMountIndex,
          IncrIterator('__rehax_0'),
        ]),
        PopMountIndex,
        ComponentDidMountSelf,
    ],
    updateExpressions: [
        DeclareMountIndex,
        DeclareLocalVariable('body_v_0', '_body.v_0'),
        IncrMountIndex,
        PushMountIndex,
        DeclareLocalVariable('body_v_1', '_body.v_1'),
        IncrMountIndex,
        DeclareLocalVariable('body_v_2', '_body.v_2'),
        DeclareLocalVariable('__rehax_0', '0'),
        Loop('i in 0...4', [
          Conditional('__rehax_0 >= _body.v_2.length', [
            CreateNewComponent('body_v_2__rehax_0_v_0', 'Text'),
            CreateComponentFragment('body_v_2__rehax_0_v_0'),
            AssignText('body_v_2__rehax_0_v_0', ' Part '),
            CreateNewComponent('body_v_2__rehax_0_v_1', 'Text'),
            CreateComponentFragment('body_v_2__rehax_0_v_1'),
            AssignVariableText('body_v_2__rehax_0_v_1', 'i'),
            ResultBodyPush('body_v_2', '{ v_0: body_v_2__rehax_0_v_0, v_1: body_v_2__rehax_0_v_1 }'),
            Mount('_body.v_2[__rehax_0].v_0', '_body.v_0'),
            IncrMountIndex,
            Mount('_body.v_2[__rehax_0].v_1', '_body.v_0'),
            IncrMountIndex,
          ], [
            DeclareLocalVariable('body_v_2__rehax_0_v_0', '_body.v_2[__rehax_0].v_0'),
            IncrMountIndex,
            DeclareLocalVariable('body_v_2__rehax_0_v_1', '_body.v_2[__rehax_0].v_1'),
            AssignVariableText('_body.v_2[__rehax_0].v_1', 'i'),
            IncrMountIndex,
          ]),
          IncrIterator('__rehax_0'),
        ]),
        While('_body.v_2.length > __rehax_0', [
          UnMount('_body.v_2[__rehax_0].v_1'),
          UnMount('_body.v_2[__rehax_0].v_0'),
          PopLast('_body.v_2'),
        ]),
        PopMountIndex,
    ],
    unmountExpressions: [
        While('_body.v_2.length > 0', [
          DeclareLocalVariable('__rehax_0', '_body.v_2.length - 1'),
          UnMount('_body.v_2[__rehax_0].v_1'),
          UnMount('_body.v_2[__rehax_0].v_0'),
          PopLast('_body.v_2'),
        ]),
        UnMount('_body.v_1'),
        UnMount('_body.v_0'),
        SetSelfParentNull,
    ],
  })

  public function testSuccessfulBuilder(body:String, expected:GeneratedCode) {
    var tokenizer = new Tokenizer(body);
    tokenizer.tokenize();
    var parser = new Parser(tokenizer.tokens);
    var simplifiedTokens = parser.simplifyTokens();
    var parsed = parser.doParse(simplifiedTokens);
    var partsGenerator = new PartsGenerator();
    var genPartsResult = partsGenerator.generateVariableDefinitions(parsed);
    var codeGenerator = new CodeGenerator();
    var code = codeGenerator.generateCode(genPartsResult);

    function checkEqualityRecursive(result:Array<GeneratorExpression>, expected:Array<GeneratorExpression>) {
        asserts.assert(result.length == expected.length);

        for (i in 0...expected.length) {
          switch (expected[i]) {
            case Conditional(expectedCondition, expectedIfs, expectedElses):
              switch (result[i]) {
                case Conditional(resultCondition, resultIfs, resultElses):
                  asserts.assert(expectedCondition == resultCondition);
                  checkEqualityRecursive(resultIfs, expectedIfs);
                  asserts.assert((expectedElses != null && resultElses != null) || (expectedElses == null && resultElses == null));
                  if (expectedElses != null) {
                    checkEqualityRecursive(resultElses, expectedElses);
                  }
                default:
                  asserts.assert(false, 'Expected Conditional');
              }
            case Loop(expectedIterator, expectedLoop):
              switch (result[i]) {
                case Loop(resultIterator, resultLoop):
                  asserts.assert(expectedIterator == resultIterator);
                  checkEqualityRecursive(resultLoop, expectedLoop);
                default:
                  asserts.assert(false, 'Expected Loop');
              }
            case While(expectedCondition, expectedLoop):
              switch (result[i]) {
                case While(resultCondition, resultLoop):
                  asserts.assert(expectedCondition == resultCondition);
                  checkEqualityRecursive(resultLoop, expectedLoop);
                default:
                  asserts.assert(false, 'Expected While');
              }
            default:
              asserts.assert(Type.enumEq(result[i], expected[i]), Std.string(result[i]) + ' == ' + Std.string(expected[i]));
          }
        }
    }

    checkEqualityRecursive(code.createExpressions, expected.createExpressions);
    checkEqualityRecursive(code.mountExpressions, expected.mountExpressions);
    checkEqualityRecursive(code.updateExpressions, expected.updateExpressions);
    checkEqualityRecursive(code.unmountExpressions, expected.unmountExpressions);

    return asserts.done();
  }
}
