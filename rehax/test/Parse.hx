package test;

import tink.unit.Assert.*;

using rehax.builder.Parser;
using rehax.builder.Tokenizer;

@:asserts
class Parse {
  public function new() {}

  // <View></View>

  @:variant([
    OPEN_ANGLE_BRACKET,
    WORD('View'),
    CLOSE_ANGLE_BRACKET,
    OPEN_ANGLE_BRACKET,
    CLOSE_SLASH,
    WORD('View'),
    CLOSE_ANGLE_BRACKET
  ], [OPEN_NODE('View'), CLOSE_NODE('View')])
  // <View attr={x}></View>
  @:variant([
    OPEN_ANGLE_BRACKET, WORD('View'), WORD('attr'), EQUALS, OPEN_VARIABLE, TEXT('x'), CLOSE_VARIABLE, CLOSE_ANGLE_BRACKET, OPEN_ANGLE_BRACKET,
    CLOSE_SLASH, WORD('View'), CLOSE_ANGLE_BRACKET
  ], [OPEN_NODE('View'), ATTR_VAR('attr', 'x'), CLOSE_NODE('View'),])
  // <View attr={x}><Child /></View>
  @:variant([
    OPEN_ANGLE_BRACKET, WORD('View'), WORD('attr'), EQUALS, OPEN_VARIABLE, TEXT('x'), CLOSE_VARIABLE, CLOSE_ANGLE_BRACKET, OPEN_ANGLE_BRACKET,
    WORD('Child'), CLOSE_SLASH, CLOSE_ANGLE_BRACKET, OPEN_ANGLE_BRACKET, CLOSE_SLASH, WORD('View'), CLOSE_ANGLE_BRACKET
  ], [
    OPEN_NODE('View'),
    ATTR_VAR('attr', 'x'),
    OPEN_NODE('Child'),
    CLOSE_NODE('Child'),
    CLOSE_NODE('View'),
  ])
  // <View attr={x}><Child attr1={g} attr2={h} /></View>
  @:variant([
    OPEN_ANGLE_BRACKET, WORD('View'), WORD('attr'), EQUALS, OPEN_VARIABLE, TEXT('x'), CLOSE_VARIABLE, CLOSE_ANGLE_BRACKET, OPEN_ANGLE_BRACKET,
    WORD('Child'), WORD('attr1'), EQUALS, OPEN_VARIABLE, TEXT('g'), CLOSE_VARIABLE, WORD('attr2'), EQUALS, OPEN_VARIABLE, TEXT('h'), CLOSE_VARIABLE,
    CLOSE_SLASH, CLOSE_ANGLE_BRACKET, OPEN_ANGLE_BRACKET, CLOSE_SLASH, WORD('View'), CLOSE_ANGLE_BRACKET
  ], [
    OPEN_NODE('View'),
    ATTR_VAR('attr', 'x'),
    OPEN_NODE('Child'),
    ATTR_VAR('attr1', 'g'),
    ATTR_VAR('attr2', 'h'),
    CLOSE_NODE('Child'),
    CLOSE_NODE('View'),
  ])
  // <View attr={x}><Child >Text A </Child>  Text B    </View>
  @:variant([
    OPEN_ANGLE_BRACKET, WORD('View'), WORD('attr'), EQUALS, OPEN_VARIABLE, TEXT('x'), CLOSE_VARIABLE, CLOSE_ANGLE_BRACKET, OPEN_ANGLE_BRACKET,
    WORD('Child'), CLOSE_ANGLE_BRACKET, TEXT('Text A '), OPEN_ANGLE_BRACKET, CLOSE_SLASH, WORD('Child'), CLOSE_ANGLE_BRACKET, TEXT('  Text B    '),
    OPEN_ANGLE_BRACKET, CLOSE_SLASH, WORD('View'), CLOSE_ANGLE_BRACKET
  ], [
    OPEN_NODE('View'),
    ATTR_VAR('attr', 'x'),
    OPEN_NODE('Child'),
    TEXT('Text A '),
    CLOSE_NODE('Child'),
    TEXT('  Text B    '),
    CLOSE_NODE('View'),
  ])
  // <  View  attr =  {x} >< Child >Text A {var1  }</Child>  Text B {var bb = {} ?}   </View>
  @:variant([
    OPEN_ANGLE_BRACKET, WORD('View'), WORD('attr'), EQUALS, OPEN_VARIABLE, TEXT('x'), CLOSE_VARIABLE, CLOSE_ANGLE_BRACKET, OPEN_ANGLE_BRACKET,
    WORD('Child'), CLOSE_ANGLE_BRACKET, TEXT('Text A '), OPEN_VARIABLE, TEXT('var1  '), CLOSE_VARIABLE, OPEN_ANGLE_BRACKET, CLOSE_SLASH, WORD('Child'),
    CLOSE_ANGLE_BRACKET, TEXT('  Text B '), OPEN_VARIABLE, TEXT('var bb = {} ?'), CLOSE_VARIABLE, TEXT('   '), OPEN_ANGLE_BRACKET, CLOSE_SLASH,
    WORD('View'), CLOSE_ANGLE_BRACKET
  ], [
    OPEN_NODE('View'), ATTR_VAR('attr', 'x'), OPEN_NODE('Child'), TEXT('Text A '), VARIABLE('var1  '), CLOSE_NODE('Child'), TEXT('  Text B '),
    VARIABLE('var bb = {} ?'), TEXT('   '), CLOSE_NODE('View'),
  ])
  // <View>{if prop.condition}<Child />{/if}</View>
  @:variant([
    OPEN_ANGLE_BRACKET, WORD('View'), CLOSE_ANGLE_BRACKET, OPEN_VARIABLE, OPEN_IF, TEXT('prop.condition'), CLOSE_VARIABLE, OPEN_ANGLE_BRACKET,
    WORD('Child'), CLOSE_SLASH, CLOSE_ANGLE_BRACKET, OPEN_VARIABLE, CLOSE_IF, CLOSE_VARIABLE, OPEN_ANGLE_BRACKET, CLOSE_SLASH, WORD('View'),
    CLOSE_ANGLE_BRACKET
  ], [
    OPEN_NODE('View'),
    OPEN_IF('prop.condition'),
    OPEN_NODE('Child'),
    CLOSE_NODE('Child'),
    CLOSE_IF,
    CLOSE_NODE('View'),
  ])
  // <View>{for item in items}<Child />{/for}</View>
  @:variant([
    OPEN_ANGLE_BRACKET, WORD('View'), CLOSE_ANGLE_BRACKET, OPEN_VARIABLE, OPEN_FOR, TEXT('item in items'), CLOSE_VARIABLE, OPEN_ANGLE_BRACKET,
    WORD('Child'), CLOSE_SLASH, CLOSE_ANGLE_BRACKET, OPEN_VARIABLE, CLOSE_FOR, CLOSE_VARIABLE, OPEN_ANGLE_BRACKET, CLOSE_SLASH, WORD('View'),
    CLOSE_ANGLE_BRACKET
  ], [
    OPEN_NODE('View'),
    OPEN_FOR('item in items'),
    OPEN_NODE('Child'),
    CLOSE_NODE('Child'),
    CLOSE_FOR,
    CLOSE_NODE('View'),
  ])
  // <View>{for item in items}{for i in 0...3}<Child />{/for}{/for}</View>
  @:variant([
    OPEN_ANGLE_BRACKET, WORD('View'), CLOSE_ANGLE_BRACKET, OPEN_VARIABLE, OPEN_FOR, TEXT('item in items'), CLOSE_VARIABLE, OPEN_VARIABLE, OPEN_FOR,
    TEXT('i in 0...3'), CLOSE_VARIABLE, OPEN_ANGLE_BRACKET, WORD('Child'), CLOSE_SLASH, CLOSE_ANGLE_BRACKET, OPEN_VARIABLE, CLOSE_FOR, CLOSE_VARIABLE,
    OPEN_VARIABLE, CLOSE_FOR, CLOSE_VARIABLE, OPEN_ANGLE_BRACKET, CLOSE_SLASH, WORD('View'), CLOSE_ANGLE_BRACKET
  ], [
    OPEN_NODE('View'),
    OPEN_FOR('item in items'),
    OPEN_FOR('i in 0...3'),
    OPEN_NODE('Child'),
    CLOSE_NODE('Child'),
    CLOSE_FOR,
    CLOSE_FOR,
    CLOSE_NODE('View'),
  ])
  public function testSuccessfulParseSimplification(tokens:Array<TOKEN>, expected:Array<SYNTAX_NODE>) {
    var parser = new Parser(tokens);
    var result = parser.simplifyTokens();
    asserts.assert(result.length == expected.length);
    for (i in 0...expected.length) {
      asserts.assert(Type.enumEq(result[i], expected[i]), Std.string(result[i]) + ' == ' + Std.string(expected[i]));
    }
    return asserts.done();
  }

  // <View></View>

  @:variant([OPEN_NODE('View'), CLOSE_NODE('View')], {
    type: Root,
    parent: null,
    children: [
      {
        type: Node('View'),
        parent: null,
        attributes: [],
        children: []
      }
    ],
    attributes: [],
  })
  // <View attr={x}></View>
  @:variant([OPEN_NODE('View'), ATTR_VAR('attr', 'x'), CLOSE_NODE('View'),], {
    type: Root,
    parent: null,
    children: [
      {
        type: Node('View'),
        parent: null,
        attributes: ['attr' => Variable('x')],
        children: []
      }
    ],
    attributes: [],
  })
  // <View attr={x}><Child /></View>
  @:variant([
    OPEN_NODE('View'),
    ATTR_VAR('attr', 'x'),
    OPEN_NODE('Child'),
    CLOSE_NODE('Child'),
    CLOSE_NODE('View'),
  ], {
    type: Root,
    parent: null,
    children: [
      {
        type: Node('View'),
        parent: null,
        attributes: ['attr' => Variable('x')],
        children: [
          {
            type: Node('Child'),
            parent: null,
            attributes: [],
            children: []
          }
        ]
      }
    ],
    attributes: [],
  })
  // <View attr={x}><Child attr1={g} attr2={h} /></View>
  @:variant([
    OPEN_NODE('View'),
    ATTR_VAR('attr', 'x'),
    OPEN_NODE('Child'),
    ATTR_VAR('attr1', 'g'),
    ATTR_VAR('attr2', 'h'),
    CLOSE_NODE('Child'),
    CLOSE_NODE('View'),
  ], {
    type: Root,
    parent: null,
    children: [
      {
        type: Node('View'),
        parent: null,
        attributes: ['attr' => Variable('x')],
        children: [
          {
            type: Node('Child'),
            parent: null,
            attributes: ['attr1' => Variable('g'), 'attr2' => Variable('h')],
            children: []
          }
        ]
      }
    ],
    attributes: [],
  })
  // <View attr={x}><Child >Text A </Child>  Text B    </View>
  @:variant([
    OPEN_NODE('View'),
    ATTR_VAR('attr', 'x'),
    OPEN_NODE('Child'),
    TEXT('Text A '),
    CLOSE_NODE('Child'),
    TEXT('  Text B    '),
    CLOSE_NODE('View'),
  ], {
    type: Root,
    parent: null,
    children: [
      {
        type: Node('View'),
        parent: null,
        attributes: ['attr' => Variable('x')],
        children: [
          {
            type: Node('Child'),
            parent: null,
            attributes: [],
            children: [
              {
                type: Text('Text A '),
                parent: null,
                attributes: [],
                children: [],
              }
            ]
          },
          {
            type: Text('  Text B    '),
            parent: null,
            attributes: [],
            children: [],
          }
        ]
      }
    ],
    attributes: [],
  })
  // <  View  attr =  {x} >< Child >Text A {var1  }</Child>  Text B {var bb = {} ?}   </View>
  @:variant([
    OPEN_NODE('View'), ATTR_VAR('attr', 'x'), OPEN_NODE('Child'), TEXT('Text A '), VARIABLE('var1  '), CLOSE_NODE('Child'), TEXT('  Text B '),
    VARIABLE('var bb = {} ?'), TEXT('   '), CLOSE_NODE('View'),
  ], {
    type: Root,
    parent: null,
    children: [
      {
        type: Node('View'),
        parent: null,
        attributes: ['attr' => Variable('x')],
        children: [
          {
            type: Node('Child'),
            parent: null,
            attributes: [],
            children: [
              {
                type: Text('Text A '),
                parent: null,
                attributes: [],
                children: [],
              },
              {
                type: Variable('var1  '),
                parent: null,
                attributes: [],
                children: [],
              }
            ]
          },
          {
            type: Text('  Text B '),
            parent: null,
            attributes: [],
            children: [],
          },
          {
            type: Variable('var bb = {} ?'),
            parent: null,
            attributes: [],
            children: [],
          },
          {
            type: Text('   '),
            parent: null,
            attributes: [],
            children: [],
          }
        ]
      }
    ],
    attributes: [],
  })
  // <View>{#if prop.condition}<Child />{/if}</View>
  @:variant([
    OPEN_NODE('View'),
    OPEN_IF('prop.condition'),
    OPEN_NODE('Child'),
    CLOSE_NODE('Child'),
    CLOSE_IF,
    CLOSE_NODE('View'),
  ], {
    type: Root,
    parent: null,
    children: [
      {
        type: Node('View'),
        parent: null,
        attributes: [],
        children: [
          {
            type: Condition('prop.condition'),
            parent: null,
            attributes: [],
            children: [
              {
                type: Node('Child'),
                parent: null,
                attributes: [],
                children: [],
              }
            ]
          }
        ]
      }
    ],
    attributes: [],
  })
  // <View>{for item in items}<Child />{/for}</View>
  @:variant([
    OPEN_NODE('View'),
    OPEN_FOR('item in items'),
    OPEN_NODE('Child'),
    CLOSE_NODE('Child'),
    CLOSE_FOR,
    CLOSE_NODE('View'),
  ], {
    type: Root,
    parent: null,
    children: [
      {
        type: Node('View'),
        parent: null,
        attributes: [],
        children: [
          {
            type: Loop('item in items'),
            parent: null,
            attributes: [],
            children: [
              {
                type: Node('Child'),
                parent: null,
                attributes: [],
                children: [],
              }
            ]
          }
        ]
      }
    ],
    attributes: [],
  })
  // <View>{for item in items}{for i in 0...3}<Child />{/for}{/for}</View>
  @:variant([
    OPEN_NODE('View'),
    OPEN_FOR('item in items'),
    OPEN_FOR('i in 0...3'),
    OPEN_NODE('Child'),
    CLOSE_NODE('Child'),
    CLOSE_FOR,
    CLOSE_FOR,
    CLOSE_NODE('View'),
  ], {
    type: Root,
    parent: null,
    children: [
      {
        type: Node('View'),
        parent: null,
        attributes: [],
        children: [
          {
            type: Loop('item in items'),
            parent: null,
            attributes: [],
            children: [
              {
                type: Loop('i in 0...3'),
                parent: null,
                attributes: [],
                children: [
                  {
                    type: Node('Child'),
                    parent: null,
                    attributes: [],
                    children: [],
                  }
                ]
              }
            ]
          }
        ]
      }
    ],
    attributes: [],
  })
  public function testSuccessfulParse(tokens:Array<SYNTAX_NODE>, expected:AstNode) {
    var parser = new Parser([]);
    var result = parser.doParse(tokens);

    function compareRecursive(lhs:AstNode, rhs:AstNode) {
      asserts.assert(Type.enumEq(lhs.type, rhs.type), Std.string(lhs.type) + ' == ' + Std.string(rhs.type));
      for (key => val in rhs.attributes) {
        asserts.assert(Type.enumEq(lhs.attributes[key], rhs.attributes[key]),
          Std.string(lhs.attributes[key]) + ' == ' + Std.string(rhs.attributes[key]));
      }
      asserts.assert(lhs.children.length == rhs.children.length);
      for (i in 0...lhs.children.length) {
        var childLhs = lhs.children[i];
        var childRhs = rhs.children[i];
        compareRecursive(childLhs, childRhs);
      }
    }
    compareRecursive(result, expected);
    return asserts.done();
  }

  // @:variant('<View</View>', new rehax.builder.Tokenizer.TokenizeError('Unexpected token "<"', 0, 5))
  // @:variant('<View><</View>', new rehax.builder.Tokenizer.TokenizeError('Expected node name', 0, 7))
  // public function testFaultyTokenization(body:String, expectedError:rehax.builder.Tokenizer.TokenizeError) {
  //     var rehax = new Tokenizer(body);
  //     var err:Null<TokenizeError> = null;
  //     try { rehax.tokenize(); }
  //     catch (e:TokenizeError) {
  //         err = e;
  //     }
  //     asserts.assert(err != null);
  //     asserts.assert(err.msg == expectedError.msg);
  //     asserts.assert(err.line == expectedError.line);
  //     asserts.assert(err.col == expectedError.col);
  //     return asserts.done();
  // }
}
