package test;

import tink.unit.Assert.*;

using rehax.builder.Tokenizer;

@:asserts
class Tokenize {
  public function new() {}

  @:variant('<View></View>', [
    OPEN_ANGLE_BRACKET,
    WORD('View'),
    CLOSE_ANGLE_BRACKET,
    OPEN_ANGLE_BRACKET,
    CLOSE_SLASH,
    WORD('View'),
    CLOSE_ANGLE_BRACKET
  ])
  @:variant('<View attr={x}></View>', [
    OPEN_ANGLE_BRACKET, WORD('View'), WORD('attr'), EQUALS, OPEN_VARIABLE, TEXT('x'), CLOSE_VARIABLE, CLOSE_ANGLE_BRACKET, OPEN_ANGLE_BRACKET,
    CLOSE_SLASH, WORD('View'), CLOSE_ANGLE_BRACKET
  ])
  @:variant('<View attr={x}><Child /></View>', [
    OPEN_ANGLE_BRACKET, WORD('View'), WORD('attr'), EQUALS, OPEN_VARIABLE, TEXT('x'), CLOSE_VARIABLE, CLOSE_ANGLE_BRACKET, OPEN_ANGLE_BRACKET,
    WORD('Child'), CLOSE_SLASH, CLOSE_ANGLE_BRACKET, OPEN_ANGLE_BRACKET, CLOSE_SLASH, WORD('View'), CLOSE_ANGLE_BRACKET
  ])
  @:variant('<View attr={x}><Child attr1={g} attr2={h} /></View>', [
    OPEN_ANGLE_BRACKET, WORD('View'), WORD('attr'), EQUALS, OPEN_VARIABLE, TEXT('x'), CLOSE_VARIABLE, CLOSE_ANGLE_BRACKET, OPEN_ANGLE_BRACKET,
    WORD('Child'), WORD('attr1'), EQUALS, OPEN_VARIABLE, TEXT('g'), CLOSE_VARIABLE, WORD('attr2'), EQUALS, OPEN_VARIABLE, TEXT('h'), CLOSE_VARIABLE,
    CLOSE_SLASH, CLOSE_ANGLE_BRACKET, OPEN_ANGLE_BRACKET, CLOSE_SLASH, WORD('View'), CLOSE_ANGLE_BRACKET
  ])
  @:variant('<View attr={x}><Child >Text A </Child>  Text B    </View>', [
    OPEN_ANGLE_BRACKET, WORD('View'), WORD('attr'), EQUALS, OPEN_VARIABLE, TEXT('x'), CLOSE_VARIABLE, CLOSE_ANGLE_BRACKET, OPEN_ANGLE_BRACKET,
    WORD('Child'), CLOSE_ANGLE_BRACKET, TEXT('Text A '), OPEN_ANGLE_BRACKET, CLOSE_SLASH, WORD('Child'), CLOSE_ANGLE_BRACKET, TEXT('  Text B    '),
    OPEN_ANGLE_BRACKET, CLOSE_SLASH, WORD('View'), CLOSE_ANGLE_BRACKET
  ])
  @:variant('<  View  attr =  {x} >< Child >Text A {var1  }</Child>  Text B {var bb = {} ?}   </View>', [
    OPEN_ANGLE_BRACKET, WORD('View'), WORD('attr'), EQUALS, OPEN_VARIABLE, TEXT('x'), CLOSE_VARIABLE, CLOSE_ANGLE_BRACKET, OPEN_ANGLE_BRACKET,
    WORD('Child'), CLOSE_ANGLE_BRACKET, TEXT('Text A '), OPEN_VARIABLE, TEXT('var1  '), CLOSE_VARIABLE, OPEN_ANGLE_BRACKET, CLOSE_SLASH, WORD('Child'),
    CLOSE_ANGLE_BRACKET, TEXT('  Text B '), OPEN_VARIABLE, TEXT('var bb = {} ?'), CLOSE_VARIABLE, TEXT('   '), OPEN_ANGLE_BRACKET, CLOSE_SLASH,
    WORD('View'), CLOSE_ANGLE_BRACKET
  ])
  @:variant('<View>{if prop.condition}<Child />{/if}</View>', [
    OPEN_ANGLE_BRACKET, WORD('View'), CLOSE_ANGLE_BRACKET, OPEN_VARIABLE, OPEN_IF, TEXT('prop.condition'), CLOSE_VARIABLE, OPEN_ANGLE_BRACKET,
    WORD('Child'), CLOSE_SLASH, CLOSE_ANGLE_BRACKET, OPEN_VARIABLE, CLOSE_IF, CLOSE_VARIABLE, OPEN_ANGLE_BRACKET, CLOSE_SLASH, WORD('View'),
    CLOSE_ANGLE_BRACKET
  ])
  @:variant('<View>{for item in items}<Child />{/for}</View>', [
    OPEN_ANGLE_BRACKET, WORD('View'), CLOSE_ANGLE_BRACKET, OPEN_VARIABLE, OPEN_FOR, TEXT('item in items'), CLOSE_VARIABLE, OPEN_ANGLE_BRACKET,
    WORD('Child'), CLOSE_SLASH, CLOSE_ANGLE_BRACKET, OPEN_VARIABLE, CLOSE_FOR, CLOSE_VARIABLE, OPEN_ANGLE_BRACKET, CLOSE_SLASH, WORD('View'),
    CLOSE_ANGLE_BRACKET
  ])
  @:variant('<View>{for item in items}{for i in 0...3}<Child />{/for}{/for}</View>', [
    OPEN_ANGLE_BRACKET, WORD('View'), CLOSE_ANGLE_BRACKET, OPEN_VARIABLE, OPEN_FOR, TEXT('item in items'), CLOSE_VARIABLE, OPEN_VARIABLE, OPEN_FOR,
    TEXT('i in 0...3'), CLOSE_VARIABLE, OPEN_ANGLE_BRACKET, WORD('Child'), CLOSE_SLASH, CLOSE_ANGLE_BRACKET, OPEN_VARIABLE, CLOSE_FOR, CLOSE_VARIABLE,
    OPEN_VARIABLE, CLOSE_FOR, CLOSE_VARIABLE, OPEN_ANGLE_BRACKET, CLOSE_SLASH, WORD('View'), CLOSE_ANGLE_BRACKET
  ])
  public function testSuccessfulTokenization(body:String, expectedTokens:Array<TOKEN>) {
    var rehax = new Tokenizer(body);
    rehax.tokenize();
    asserts.assert(rehax.tokens.length == expectedTokens.length);
    for (i in 0...expectedTokens.length) {
      asserts.assert(Type.enumEq(rehax.tokens[i], expectedTokens[i]), Std.string(rehax.tokens[i]) + ' == ' + Std.string(expectedTokens[i]));
    }
    return asserts.done();
  }

  @:variant('<View</View>', new rehax.builder.Tokenizer.TokenizeError('Unexpected token "<"', 0, 5))
  @:variant('<View><</View>', new rehax.builder.Tokenizer.TokenizeError('Expected node name', 0, 7))
  public function testFaultyTokenization(body:String, expectedError:rehax.builder.Tokenizer.TokenizeError) {
    var rehax = new Tokenizer(body);
    var err:Null<TokenizeError> = null;
    try {
      rehax.tokenize();
    } catch (e:TokenizeError) {
      err = e;
    }

    asserts.assert(err != null);
    asserts.assert(err.msg == expectedError.msg);
    asserts.assert(err.line == expectedError.line);
    asserts.assert(err.col == expectedError.col);
    return asserts.done();
  }
}
