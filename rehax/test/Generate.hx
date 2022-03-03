package test;

import tink.unit.Assert.*;

using rehax.builder.Parser;
using rehax.builder.PartsGenerator;

@:asserts
class Generate {
  public function new() {}

  // <View></View>

  @:variant({
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
  }, [
    {
      variableName: 'v_0',
      typeName: 'View',
      mountPoint: 'this.parent',
      pushMountIndexCount: 0,
      popMountIndexCount: 0,
      isArray: false,
      children: null,
      content: null,
      attributes: [],
    }
  ])
  // <View attr={x}></View>
  @:variant({
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
  }, [
    {
      variableName: 'v_0',
      typeName: 'View',
      mountPoint: 'this.parent',
      pushMountIndexCount: 0,
      popMountIndexCount: 0,
      isArray: false,
      children: null,
      content: null,
      attributes: [],
    }
  ])
  // <View attr={x}><Child /></View>
  @:variant({
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
  }, [
    {
      variableName: 'v_0',
      typeName: 'View',
      mountPoint: 'this.parent',
      pushMountIndexCount: 0,
      popMountIndexCount: 0,
      isArray: false,
      children: null,
      content: null,
      attributes: [],
    },
    {
      variableName: 'v_1',
      typeName: 'Child',
      mountPoint: '_body.v_0',
      pushMountIndexCount: 1,
      popMountIndexCount: 1,
      isArray: false,
      children: null,
      content: null,
      attributes: [],
    }
  ])
  // <View attr={x}><Child attr1={g} attr2={h} /></View>
  @:variant({
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
  }, [
    {
      variableName: 'v_0',
      typeName: 'View',
      mountPoint: 'this.parent',
      pushMountIndexCount: 0,
      popMountIndexCount: 0,
      isArray: false,
      children: null,
      content: null,
      attributes: [],
    },
    {
      variableName: 'v_1',
      typeName: 'Child',
      mountPoint: '_body.v_0',
      pushMountIndexCount: 1,
      popMountIndexCount: 1,
      isArray: false,
      children: null,
      content: null,
      attributes: [],
    }
  ])
  // <View attr={x}><Child >Text A </Child>  Text B    </View>
  @:variant({
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
  }, [
    {
      variableName: 'v_0',
      typeName: 'View',
      mountPoint: 'this.parent',
      pushMountIndexCount: 0,
      popMountIndexCount: 0,
      isArray: false,
      children: null,
      content: null,
      attributes: [],
    },
    {
      variableName: 'v_1',
      typeName: 'Child',
      mountPoint: '_body.v_0',
      pushMountIndexCount: 1,
      popMountIndexCount: 0,
      isArray: false,
      children: null,
      content: null,
      attributes: [],
    },
    {
      variableName: 'v_2',
      typeName: 'Text',
      mountPoint: '_body.v_1',
      pushMountIndexCount: 1,
      popMountIndexCount: 1,
      isArray: false,
      children: null,
      content: 'Text A ',
      attributes: [],
    },
    {
      variableName: 'v_3',
      typeName: 'Text',
      mountPoint: '_body.v_0',
      pushMountIndexCount: 0,
      popMountIndexCount: 1,
      isArray: false,
      children: null,
      content: '  Text B    ',
      attributes: [],
    }
  ])
  // <  View  attr =  {x} >< Child >Text A {var1  }</Child>  Text B {var bb = {} ?}   </View>
  @:variant({
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
  }, [
    {
      variableName: 'v_0',
      typeName: 'View',
      mountPoint: 'this.parent',
      pushMountIndexCount: 0,
      popMountIndexCount: 0,
      isArray: false,
      children: null,
      content: null,
      attributes: [],
    },
    {
      variableName: 'v_1',
      typeName: 'Child',
      mountPoint: '_body.v_0',
      pushMountIndexCount: 1,
      popMountIndexCount: 0,
      isArray: false,
      children: null,
      content: null,
      attributes: [],
    },
    {
      variableName: 'v_2',
      typeName: 'Text',
      mountPoint: '_body.v_1',
      pushMountIndexCount: 1,
      popMountIndexCount: 0,
      isArray: false,
      children: null,
      content: 'Text A ',
      attributes: [],
    },
    {
      variableName: 'v_3',
      typeName: 'Variable',
      mountPoint: '_body.v_1',
      pushMountIndexCount: 0,
      popMountIndexCount: 1,
      isArray: false,
      children: null,
      content: 'var1  ',
      attributes: [],
    },
    {
      variableName: 'v_4',
      typeName: 'Text',
      mountPoint: '_body.v_0',
      pushMountIndexCount: 0,
      popMountIndexCount: 0,
      isArray: false,
      children: null,
      content: '  Text B ',
      attributes: [],
    },
    {
      variableName: 'v_5',
      typeName: 'Variable',
      mountPoint: '_body.v_0',
      pushMountIndexCount: 0,
      popMountIndexCount: 1,
      isArray: false,
      children: null,
      content: 'var bb = {} ?',
      attributes: [],
    },
  ])
  // <View>{if prop.condition}<Child />{/if}</View>
  @:variant({
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
  }, [
    {
      variableName: 'v_0',
      typeName: 'View',
      mountPoint: 'this.parent',
      pushMountIndexCount: 0,
      popMountIndexCount: 0,
      isArray: false,
      children: null,
      content: null,
      attributes: [],
    },
    {
      variableName: 'v_1',
      mountPoint: '_body.v_0',
      pushMountIndexCount: 1,
      popMountIndexCount: 1,
      typeName: null,
      isArray: false,
      children: [
        {
          variableName: 'v_0',
          typeName: 'Child',
          mountPoint: '_body.v_0',
          pushMountIndexCount: 0,
          popMountIndexCount: 0,
          isArray: false,
          children: null,
          content: null,
          attributes: [],
        }
      ],
      content: 'prop.condition',
      attributes: [],
    },
  ])
  // <View><Child /><Child />{if prop.condition}<Child />{/if}<Child /></View>
  @:variant({
    type: Root,
    parent: null,
    children: [
      {
        type: Node('View'),
        parent: null,
        attributes: [],
        children: [
          {
            type: Node('Child'),
            parent: null,
            attributes: [],
            children: [],
          },
          {
            type: Node('Child'),
            parent: null,
            attributes: [],
            children: [],
          },
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
          },
          {
            type: Node('Child'),
            parent: null,
            attributes: [],
            children: [],
          }
        ]
      }
    ],
    attributes: [],
  }, [
    {
      variableName: 'v_0',
      typeName: 'View',
      mountPoint: 'this.parent',
      pushMountIndexCount: 0,
      popMountIndexCount: 0,
      isArray: false,
      children: null,
      content: null,
      attributes: [],
    },
    {
      variableName: 'v_1',
      typeName: 'Child',
      mountPoint: '_body.v_0',
      pushMountIndexCount: 1,
      popMountIndexCount: 0,
      isArray: false,
      children: null,
      content: null,
      attributes: [],
    },
    {
      variableName: 'v_2',
      typeName: 'Child',
      mountPoint: '_body.v_0',
      pushMountIndexCount: 0,
      popMountIndexCount: 0,
      isArray: false,
      children: null,
      content: null,
      attributes: [],
    },
    {
      variableName: 'v_3',
      mountPoint: '_body.v_0',
      pushMountIndexCount: 0,
      popMountIndexCount: 0,
      typeName: null,
      isArray: false,
      children: [
        {
          variableName: 'v_0',
          typeName: 'Child',
          mountPoint: '_body.v_0',
          pushMountIndexCount: 0,
          popMountIndexCount: 0,
          isArray: false,
          children: null,
          content: null,
          attributes: [],
        }
      ],
      content: 'prop.condition',
      attributes: [],
    },
    {
      variableName: 'v_4',
      typeName: 'Child',
      mountPoint: '_body.v_0',
      pushMountIndexCount: 0,
      popMountIndexCount: 1,
      isArray: false,
      children: null,
      content: null,
      attributes: [],
    }
  ])
  // <View>{if prop.condition}<Child>{if cond2}Inner{/if}</Child>{/if}</View>
  @:variant({
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
                children: [
                  {
                    type: Condition('cond2'),
                    parent: null,
                    attributes: [],
                    children: [
                      {
                        type: Text('Inner'),
                        parent: null,
                        attributes: [],
                        children: [],
                      }
                    ],
                  }
                ],
              }
            ]
          }
        ]
      }
    ],
    attributes: [],
  }, [
    {
      variableName: 'v_0',
      typeName: 'View',
      mountPoint: 'this.parent',
      pushMountIndexCount: 0,
      popMountIndexCount: 0,
      isArray: false,
      children: null,
      content: null,
      attributes: [],
    },
    {
      variableName: 'v_1',
      typeName: null,
      mountPoint: '_body.v_0',
      pushMountIndexCount: 1,
      popMountIndexCount: 1,
      isArray: false,
      children: [
        {
          variableName: 'v_0',
          typeName: 'Child',
          mountPoint: '_body.v_0',
          pushMountIndexCount: 0,
          popMountIndexCount: 0,
          isArray: false,
          children: null,
          content: null,
          attributes: [],
        },
        {
          variableName: 'v_1',
          typeName: null,
          mountPoint: '_body.v_1.v_0',
          pushMountIndexCount: 1,
          popMountIndexCount: 1,
          isArray: false,
          children: [
            {
              variableName: 'v_0',
              typeName: 'Text',
              mountPoint: '_body.v_1.v_0',
              pushMountIndexCount: 0,
              popMountIndexCount: 0,
              isArray: false,
              children: null,
              content: 'Inner',
              attributes: [],
            }
          ],
          content: 'cond2',
          attributes: [],
        }
      ],
      content: 'prop.condition',
      attributes: [],
    },
  ])
  // <View>{for item in items}<Child />{/for}</View>
  @:variant({
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
  }, [
    {
      variableName: 'v_0',
      typeName: 'View',
      mountPoint: 'this.parent',
      pushMountIndexCount: 0,
      popMountIndexCount: 0,
      isArray: false,
      children: null,
      content: null,
      attributes: [],
    },
    {
      variableName: 'v_1',
      typeName: null,
      mountPoint: '_body.v_0',
      pushMountIndexCount: 1,
      popMountIndexCount: 1,
      isArray: true,
      children: [
        {
          variableName: 'v_0',
          typeName: 'Child',
          mountPoint: '_body.v_0',
          pushMountIndexCount: 0,
          popMountIndexCount: 0,
          isArray: false,
          children: null,
          content: null,
          attributes: [],
        }
      ],
      content: 'item in items',
      attributes: [],
    },
  ])
  // <View>{for item in items}{for i in 0...3}<Child />{/for}{/for}</View>
  @:variant({
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
  }, [
    {
      variableName: 'v_0',
      typeName: 'View',
      mountPoint: 'this.parent',
      pushMountIndexCount: 0,
      popMountIndexCount: 0,
      isArray: false,
      children: null,
      content: null,
      attributes: [],
    },
    {
      variableName: 'v_1',
      typeName: null,
      mountPoint: '_body.v_0',
      pushMountIndexCount: 1,
      popMountIndexCount: 1,
      isArray: true,
      children: [
        {
          variableName: 'v_0',
          typeName: null,
          mountPoint: '_body.v_0',
          pushMountIndexCount: 0,
          popMountIndexCount: 0,
          isArray: true,
          children: [
            {
              variableName: 'v_0',
              typeName: 'Child',
              mountPoint: '_body.v_0',
              pushMountIndexCount: 0,
              popMountIndexCount: 0,
              isArray: false,
              children: null,
              content: null,
              attributes: [],
            }
          ],
          content: 'i in 0...3',
          attributes: [],
        }
      ],
      content: 'item in items',
      attributes: [],
    },
  ])
  // <View>{for item in items}<Child>Hello</Child>{/for}</View>
  @:variant({
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
                children: [
                  {
                    type: Text('Hello'),
                    parent: null,
                    attributes: [],
                    children: [],
                  }
                ],
              }
            ]
          }
        ]
      }
    ],
    attributes: [],
  }, [
    {
      variableName: 'v_0',
      typeName: 'View',
      mountPoint: 'this.parent',
      pushMountIndexCount: 0,
      popMountIndexCount: 0,
      isArray: false,
      children: null,
      content: null,
      attributes: [],
    },
    {
      variableName: 'v_1',
      typeName: null,
      mountPoint: '_body.v_0',
      pushMountIndexCount: 1,
      popMountIndexCount: 1,
      isArray: true,
      children: [
        {
          variableName: 'v_0',
          typeName: 'Child',
          mountPoint: '_body.v_0',
          pushMountIndexCount: 0,
          popMountIndexCount: 0,
          isArray: false,
          children: null,
          content: null,
          attributes: [],
        },
        {
          variableName: 'v_1',
          typeName: 'Text',
          mountPoint: '_body.v_1[__rehax_0].v_0',
          pushMountIndexCount: 1,
          popMountIndexCount: 1,
          isArray: false,
          children: null,
          content: 'Hello',
          attributes: [],
        }
      ],
      content: 'item in items',
      attributes: [],
    },
  ])
  // <View>{for item in items}{if items.length > 2}<Child /><Child>Hello</Child>{/if}{/for}</View>
  @:variant({
    type: Root,
    parent: null,
    children: [
      {
        type: Node('View'),
        // va v_0
        // mp this.parent
        parent: null,
        attributes: [],
        children: [
          {
            type: Loop('item in items'),
            // va v_1
            parent: null,
            attributes: [],
            children: [
              {
                type: Condition('items.length > 2'),
                // va v_1[__rehax_0].v_0
                parent: null,
                attributes: [],
                children: [
                  {
                    type: Node('Child'),
                    // va v_1[__rehax_0].v_0.v_0
                    // mp _body.v_0
                    parent: null,
                    attributes: [],
                    children: []
                  },
                  {
                    type: Node('Child'),
                    // va v_1[__rehax_0].v_0.v_1
                    // mp _body.v_0
                    parent: null,
                    attributes: [],
                    children: [
                      {
                        type: Text('Hello'),
                        // va v_1[__rehax_0].v_0.v_3
                        // mp _body.v_1[__rehax_0].v_0.v_1
                        parent: null,
                        attributes: [],
                        children: [],
                      }
                    ],
                  }
                ]
              }
            ]
          }
        ]
      }
    ],
    attributes: [],
  }, [
    {
      variableName: 'v_0',
      typeName: 'View',
      mountPoint: 'this.parent',
      pushMountIndexCount: 0,
      popMountIndexCount: 0,
      isArray: false,
      children: null,
      content: null,
      attributes: [],
    },
    {
      variableName: 'v_1',
      typeName: null,
      mountPoint: '_body.v_0',
      pushMountIndexCount: 1,
      popMountIndexCount: 1,
      isArray: true,
      children: [
        {
          variableName: 'v_0',
          typeName: null,
          mountPoint: '_body.v_0',
          pushMountIndexCount: 0,
          popMountIndexCount: 0,
          isArray: false,
          content: 'items.length > 2',
          attributes: [],
          children: [
            {
              variableName: 'v_0',
              typeName: 'Child',
              mountPoint: '_body.v_0',
              pushMountIndexCount: 0,
              popMountIndexCount: 0,
              isArray: false,
              children: null,
              content: null,
              attributes: [],
            },
            {
              variableName: 'v_1',
              typeName: 'Child',
              mountPoint: '_body.v_0',
              pushMountIndexCount: 0,
              popMountIndexCount: 0,
              isArray: false,
              children: null,
              content: null,
              attributes: [],
            },
            {
              variableName: 'v_2',
              typeName: 'Text',
              mountPoint: '_body.v_1[__rehax_0].v_0.v_1',
              pushMountIndexCount: 1,
              popMountIndexCount: 1,
              isArray: false,
              children: null,
              content: 'Hello',
              attributes: [],
            }
          ]
        }
      ],
      content: 'item in items',
      attributes: [],
    },
  ])
  // <View>t1<Child />t2{t3}{for item in items}<Child2 />{if items.length > 2}<Child3 /><Child4>Hello</Child4>{/if}{/for}</View>
  @:variant({
    type: Root,
    parent: null,
    children: [
      {
        type: Node('View'),
        // va v_0
        // mp this.parent
        parent: null,
        attributes: [],
        children: [
          {
            type: Text('t1'),
            // va v_1
            // mp _body.v_0
            parent: null,
            attributes: [],
            children: [],
          },
          {
            type: Node('Child'),
            // va v_2
            // mp _body.v_0
            parent: null,
            attributes: [],
            children: [],
          },
          {
            type: Text('t2'),
            // va v_3
            // mp _body.v_0
            parent: null,
            attributes: [],
            children: [],
          },
          {
            type: Text('t3'),
            // va v_4
            // mp _body.v_0
            parent: null,
            attributes: [],
            children: [],
          },
          {
            type: Loop('item in items'),
            // va v_5
            // mp _body.v_0
            parent: null,
            attributes: [],
            children: [
              {
                type: Node('Child2'),
                // va v_5[__rehax_0].v_0
                // mp _body.v_0
                parent: null,
                attributes: [],
                children: [],
              },
              {
                type: Condition('items.length > 2'),
                // va v_5[__rehax_0].v_1
                // mp _body.v_0
                parent: null,
                attributes: [],
                children: [
                  {
                    type: Node('Child3'),
                    // va v_5[__rehax_0].v_1.v_0
                    // mp _body.v_0
                    parent: null,
                    attributes: [],
                    children: []
                  },
                  {
                    type: Node('Child4'),
                    // va v_5[__rehax_0].v_1.v_1
                    // mp _body.v_0
                    parent: null,
                    attributes: [],
                    children: [
                      {
                        type: Text('Hello'),
                        // va v_5[__rehax_0].v_1.v_2
                        // mp v_5[__rehax_0].v_1.v_1
                        parent: null,
                        attributes: [],
                        children: [],
                      }
                    ],
                  }
                ]
              }
            ]
          }
        ]
      }
    ],
    attributes: [],
  }, [
    {
      variableName: 'v_0',
      typeName: 'View',
      mountPoint: 'this.parent',
      pushMountIndexCount: 0,
      popMountIndexCount: 0,
      isArray: false,
      children: null,
      content: null,
      attributes: [],
    },
    {
      variableName: 'v_1',
      typeName: 'Text',
      mountPoint: '_body.v_0',
      pushMountIndexCount: 1,
      popMountIndexCount: 0,
      isArray: false,
      children: null,
      content: 't1',
      attributes: [],
    },
    {
      variableName: 'v_2',
      typeName: 'Child',
      mountPoint: '_body.v_0',
      pushMountIndexCount: 0,
      popMountIndexCount: 0,
      isArray: false,
      children: null,
      content: null,
      attributes: [],
    },
    {
      variableName: 'v_3',
      typeName: 'Text',
      mountPoint: '_body.v_0',
      pushMountIndexCount: 0,
      popMountIndexCount: 0,
      isArray: false,
      children: [],
      content: 't2',
      attributes: [],
    },
    {
      variableName: 'v_4',
      typeName: 'Text',
      mountPoint: '_body.v_0',
      pushMountIndexCount: 0,
      popMountIndexCount: 0,
      isArray: false,
      children: [],
      content: 't3',
      attributes: [],
    },
    {
      variableName: 'v_5',
      typeName: null,
      mountPoint: '_body.v_0',
      pushMountIndexCount: 0,
      popMountIndexCount: 1,
      isArray: true,
      children: [
        {
          variableName: 'v_0',
          typeName: 'Child2',
          mountPoint: '_body.v_0',
          pushMountIndexCount: 0,
          popMountIndexCount: 0,
          isArray: false,
          children: [],
          content: null,
          attributes: [],
        },
        {
          variableName: 'v_1',
          typeName: null,
          mountPoint: '_body.v_0',
          pushMountIndexCount: 0,
          popMountIndexCount: 0,
          isArray: false,
          content: 'items.length > 2',
          attributes: [],
          children: [
            {
              variableName: 'v_0',
              typeName: 'Child3',
              mountPoint: '_body.v_0',
              pushMountIndexCount: 0,
              popMountIndexCount: 0,
              isArray: false,
              children: null,
              content: null,
              attributes: [],
            },
            {
              variableName: 'v_1',
              typeName: 'Child4',
              mountPoint: '_body.v_0',
              pushMountIndexCount: 0,
              popMountIndexCount: 0,
              isArray: false,
              children: null,
              content: null,
              attributes: [],
            },
            {
              variableName: 'v_2',
              typeName: 'Text',
              mountPoint: '_body.v_5[__rehax_0].v_1.v_1',
              pushMountIndexCount: 1,
              popMountIndexCount: 1,
              isArray: false,
              children: null,
              content: 'Hello',
              attributes: [],
            }
          ]
        }
      ],
      content: 'item in items',
      attributes: [],
    },
  ])
  public function testSuccessfulGenerateVariableDefinitions(root:AstNode, expected:Array<VariableDefinition>) {
    var generator = new PartsGenerator();
    var result = generator.generateVariableDefinitions(root);

    function compareParts(lhs:Array<VariableDefinition>, rhs:Array<VariableDefinition>) {
      asserts.assert(lhs.length == rhs.length);
      for (i in 0...rhs.length) {
        asserts.assert((lhs[i] == null && rhs[i] == null) || (lhs[i] != null && rhs[i] != null));
        if (i >= lhs.length || i >= rhs.length || lhs[i] == null || rhs[i] == null) {
          break;
        }

        asserts.assert(lhs[i].variableName == rhs[i].variableName);
        asserts.assert(lhs[i].typeName == rhs[i].typeName);
        asserts.assert(lhs[i].isArray == rhs[i].isArray);
        asserts.assert(lhs[i].content == rhs[i].content);
        asserts.assert(lhs[i].mountPoint == rhs[i].mountPoint);
        asserts.assert(lhs[i].pushMountIndexCount == rhs[i].pushMountIndexCount);
        asserts.assert(lhs[i].popMountIndexCount == rhs[i].popMountIndexCount);
        if (lhs[i].children != null && rhs[i].children != null) {
          compareParts(lhs[i].children, rhs[i].children);
        }
        // for (key => val in rhs[i].attributes) {
        //     asserts.assert(Type.enumEq(lhs[i].attributes[key], rhs[i].attributes[key]), Std.string(lhs[i].attributes[key]) + ' == ' + Std.string(rhs[i].attributes[key]));
        // }
      }
    }

    compareParts(result, expected);
    return asserts.done();
  }

  public function testScopes() {
    var i = 0;
    i++;
    {
      var i = 10;
      i += 3;
      {
        var i = 100;
        i -= 10;
        asserts.assert(i == 90);
      }
      asserts.assert(i == 13);
    }
    asserts.assert(i == 1);

    return asserts.done();
  }

  public function testReference() {
    var x = {a: {b: 0}};
    var c = x.a;
    c.b = 1;
    asserts.assert(x.a.b == 1);

    return asserts.done();
  }
}
